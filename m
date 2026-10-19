Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5AC424D57;
	Mon, 19 Oct 2026 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792402214; cv=none; b=ez20cYLQkZyUtBLkvQ8p2ioLTMzSHZAaRsDOBbT7EHyY1n8ZxJHwkjAk82SPZmjwPIs2AWkmhLsvp1xwyN0cZYzHuGCWg6ps4zEBck5VzUMyXyAa+yvPR6C+n6tEcVHehSnZQQNXoF8bvNW+Pnzs+lrBcIPIIhB6kLN6tD6Ceto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792402214; c=relaxed/simple;
	bh=8fBAGo4l/9XbYvwi9LyJpj3fBw8t2XOPo3O+d8F89k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQKVrw8XdpvwwEGTabsJchKNt2zWbmLs1GP6ajZ75gotPh02K869IZqseiw5inkFQY3VJTHA360RyBcvXg1IFozEzRcmFEsZyiqNEXA1BwUUTzL4P7LYHoJjRjK0ZAmZ67dRmi+W9MgYFQS7op1r/41zAwVObEJP2F0aBiskifE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1xIjh3-000000007Hk-0bIc;
	Mon, 19 Oct 2026 09:30:09 +0000
Date: Mon, 19 Oct 2026 10:30:06 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Nikolay Bryskin <nbryskin@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Hans de Goede <hansg@kernel.org>, linux-bluetooth@vger.kernel.org,
	Bartosz Golaszewski <brgl@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Rocky Liao <quic_rjliao@quicinc.com>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_qca: Reprobe QCA6390 after hibernation
Message-ID: <atXiYxot6UZ3MDrp@makrotopia.org>
References: <20261017174310.22484-1-nbryskin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017174310.22484-1-nbryskin@gmail.com>

Hi Nikolay,

On Sat, Oct 17, 2026 at 08:43:10PM +0300, Nikolay Bryskin wrote:
> +static void qca_reprobe_work(struct work_struct *work)
> +{
> +	struct qca_reprobe *reprobe = container_of(work, struct qca_reprobe,
> +						   work);
> +	int ret;
> +
> +	ret = device_reprobe(reprobe->dev);
> +	if (ret && ret != -EPROBE_DEFER)
> +		dev_err(reprobe->dev, "Failed to reprobe device (error %d)\n",
> +			ret);
> +
> +	put_device(reprobe->dev);
> +	kfree(reprobe);
> +}

This is the pattern hci_h5 and iwlwifi use today, and it has the same
two problems, which the series at [1] addresses with a driver core
helper, device_schedule_reprobe():

- qca_reprobe_work() lives in hci_uart.ko and nothing pins the module.
  The work runs from thaw for the whole re-probe, firmware download
  included, and an rmmod of hci_uart in that time frees the text it is
  executing as well as the lock class key INIT_WORK() placed in module
  data. On a lockdep kernel the latter ends in an oops; we reproduced
  that with the equivalent iwlwifi work.

- device_reprobe() runs whatever is bound by then, so an unbind between
  thaw and the work starting is undone.

With the helper the work item goes away entirely, and qca_restore()
becomes:

static int __maybe_unused qca_restore(struct device *dev)
{
	struct serdev_device *serdev = to_serdev_device(dev);
	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
	struct hci_uart *hu = &qcadev->serdev_hu;

	qca_resume(dev);

	if (hci_test_quirk(hu->hdev, HCI_QUIRK_NON_PERSISTENT_SETUP))
		return 0;

	return device_schedule_reprobe(dev, 0);
}

It may be called from .restore with the device lock held, runs on
system_freezable_wq as yours does, and its request is cancelled if the
device is unbound, removed or its module unloaded before it runs.

Would you be fine basing your patch on it once it has landed?


[1] https://lore.kernel.org/all/cover.1792203271.git.daniel@makrotopia.org/


Cheers,


Daniel

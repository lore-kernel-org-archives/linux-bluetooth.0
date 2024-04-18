Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F5B16F839
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713455959; cv=none; b=dcNiBwxYH+q0xjIl3v9eBtCbiDUeT6VYiz+sLEis37O4Q0cYlVbhydL3S+K1CZc+CWz8iqkozB+RXKJLHf37MdvetIgBSY/mwo4sDl/VWtfnQZkbADQVlkapDYySZo4jNRYlnhcQJUtdO+yGIk2tJgaquRI1hfQ6MMl6Vaf/DfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713455959; c=relaxed/simple;
	bh=7lcdRi3SkfYZjE2ybp13epjbo/9enzcVAYVuX/amv7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHc0KPBpQddkiIttMEU+8PPAlgXGeZQVGayvLTmVhtMcXrY/kY0gQZ1McXZ0ElP3zFWdrc4bs3syGGRs92spVVy72aMgnjKJ2WAfMAtUjypklJaCoFtIoieOP0mmXIRu+CnhL2z9EGsnto0LD6LU0qo86+eu2QEnbocAuTSU2tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+d9ybPv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+d9ybPv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B22FC113CC;
	Thu, 18 Apr 2024 15:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713455959;
	bh=7lcdRi3SkfYZjE2ybp13epjbo/9enzcVAYVuX/amv7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b+d9ybPv4Nvq4mUN0adhhkhsy9PZZgautyG0miUCYT2E3zSPlDtyWBPJt4XBvaH7l
	 VWoOY9rHdAzF5Eiv+iidCEyYLXWFGJ/mgsqx1cqjk9vCOC+XoQCJrKpZqeE3J3Kofm
	 w/MpmkUycyOqn5GLbijhVE7kOCm+fpvrnsS5qPadW9qfOY+QA8vdmHbqYV+Mi5i6Z3
	 77nWDpgkWVLHx8VNmhyKEUfZKd4FflPUyVVLBqR9EY2NfOHOxQquaVSkUmAXtWKuMP
	 SvMCObGQiEdD4oZQfgs+2S5R6GI3sy6Jxf8d+ix5+M8QzpAUBKglDt2Uez2uVnaFJ0
	 Wa5ZDmd+ncMYA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rxUAT-000000002tF-2P6a;
	Thu, 18 Apr 2024 17:59:22 +0200
Date: Thu, 18 Apr 2024 17:59:21 +0200
From: Johan Hovold <johan@kernel.org>
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org, johan+linaro@kernel.org
Subject: Re: [PATCH] Bluetooth: qca: Fix nullptr dereference for non-serdev
 devices
Message-ID: <ZiFDWeW_-PpI38GQ@hovoldconsulting.com>
References: <1713325792-17181-1-git-send-email-quic_zijuhu@quicinc.com>
 <Zh9saGbOl-fXP6SD@hovoldconsulting.com>
 <5e4e62c8-d17f-45fd-9212-088eb026dc7b@quicinc.com>
 <Zh91zq13nZvH3-Yj@hovoldconsulting.com>
 <4dac0caa-629d-4b4d-ad54-f6ab15268524@quicinc.com>
 <Zh-JNzlskY6ZvsSm@hovoldconsulting.com>
 <4313bcc9-8fbf-477d-90f2-013681cdebb9@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4313bcc9-8fbf-477d-90f2-013681cdebb9@quicinc.com>

For the third time, wrap your replies at 72 cols.

I've reflown your reply below manually again, but you need to fix mail
setup and habits so you can communicate with upstream using the mailing
lists.

On Wed, Apr 17, 2024 at 05:38:59PM +0800, quic_zijuhu wrote:
> On 4/17/2024 4:32 PM, Johan Hovold wrote:

> >>>> https://patchwork.kernel.org/project/bluetooth/list/?series=844120

> > In it's current form it's a vendor specific hack that is never going to
> > make it upstream.

> 1)
> ioctl()'s designed purpose is to complete such non-standard config.

That's irrelevant.

> 2) present ioctl HCIUARTGETPROTO which is not exported is used to
> specify which vendor protocol is used is it a a vendor specific hack?

That's an existing interface, that's ABI and has clearly defined
semantics, unlike what you are proposing.

Those protocol values can never change once they've been added.
 
> 3)
> hci_ldisc driver don't touch user specified settings and pass it into
> vendor driver directly does it has any problem?

No, because the protocol values will never change, unlike the random
data you're shuffling into the driver.
 
> 4) for tool btattach. it does NOT get any board config info from
> DT|ACPI compared with formal BT driver. so i introduce a new ioctl to
> supplement such info when possible to make btattach work.

I understand why you want this. I still think it's the wrong approach
and in any case the interface in it's current form is not acceptable.

> > For a start, you don't even make sure that the types becomes part of the
> > ABI, which means that passing, say, type 5 can mean different things
> > depending on the kernel version.

> it is specified by user and ONLY be parsed by vendor device driver.
> it is user's responsibility to specify the right value. 
> so i also don't check and care about its value and it don't need to
> change any code for further added any new soc_types.

That's not how Linux works, sorry. We never break user space so your
type data would have to be well-defined and can never change (you can
only add new types).

> moreover, tool attach is mainly used before the final product phase.
> namely, its is mainly used by developer and customer's evaluation.

Also irrelevant. You still don't get to add random new ioctl() that
violates the Linux ABI contract.

> > Can't you just retrieve the device type from the device itself? If it's
> > already powered, you should not need to know this beforehand

> 1) it is the simplest and lowest risk fix

No, it's a quick and dirty hack.

> 2) different soc_types have different responses when read its IDS as
> shown by qca_read_soc_version().

I'm sure that can be managed. You claim that these device have a common
protocol (qca) so it should be possible to probe for such differences.

> 3) the way you mentioned will involve many changes and it also means
> high risks for many current soc types.

There's no risk as hardly anyone uses the line discipline interface
anymore and it can currently only be used for the old ROME devices.
Just make sure ROME still works after your change.

Probing the device type should result in a better user experience, which
I'm sure your customers will appreciate.

Johan

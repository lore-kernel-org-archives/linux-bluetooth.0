Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685396BB39;
	Tue,  6 Aug 2024 22:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722984275; cv=fail; b=IUJln9qqfZOtRyDFKACjbjXzp7uj+F/TE9efOT9L12m2m8GW9Q5/pX6x+PTEWa9dWJUs7P/u2szsZxNaIuOvYEbku4rMluDqPn6uZO7phHKEHlcCSPD9mfMvu4hmSvMsfvoBvSoOdpNlE9sZM12TAVjUbVmKn5+GVlRz4lzTF18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722984275; c=relaxed/simple;
	bh=Xu4DzLtoKgAZG2alv6tAowlN2kPeD/xB+lvfOJ3kL+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPeFhxX3W6B9t63gJct/Ik/m49Wp6HA1IbInPd2JwSIHORqXTVZbkz5RtWmEVoDIROvO3TNvtmeyx4J3dgZ/GiVpNxiOtbY0i9HEHxjbDDGXUuPN9Xhzzxc5+G+58DUHE3bDs1JIFUw1vKXFVgbb/J94iuq0Kxe+3cx8OzJ283g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=fail (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b=U+eZqkfs reason="signature verification failed"; arc=fail smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b="U+eZqkfs"
ARC-Seal: i=1; a=rsa-sha256; t=1722984262; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JA/SrSLOcnwcUCKFfrFwnGE1YbvGhCcrLxJeW8r78qnF/x6ARpy0WXU3MwFYzUZizhwBxv3g5aK6iFSVPvsrYusD4KqeOln/7kpGQZzXokpskUOXpSNcmSKTOI1dCATf2phVhOOld8x6C3TtoSKPuacDpMcQgWoXHEFm8i3r+TA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1722984262; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2DeYFOLt4YpqNZkU+QrGDdxNc8FVFJ477fjrwZdudGg=; 
	b=PZbXLdNPFJQWzXelRMmK4FUA8kv4wrgLdZRQv3PrjdwXJeD7Yca5ezB8PAJRwRSA7dVsr3TecnQS3AUBXcdMU8EbXS6c60w4R8aorCeDSGB8u1uF4cGvmKx1z4aRqRu861V2KpOWdHJvSS2c6OoL+TtVwgSY7y7iOV7cdCXzAWk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nfraprado@collabora.com;
	dmarc=pass header.from=<nfraprado@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1722984262;
	s=zohomail; d=collabora.com; i=nfraprado@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=2DeYFOLt4YpqNZkU+QrGDdxNc8FVFJ477fjrwZdudGg=;
	b=U+eZqkfsgzfVLGaXxanEEpGmiw6sgRJ3ts8bvooqqQ/bEDaNMrvAuiKYo+8zeSIw
	0bAYNi6GporgUhg9MNEEoXiRhnONf1nWx55e/TjHIMgid0Yr60B4DUC5VgCcY5xyD3m
	vlqGAAv4MqL2zkA7feHGfXEXuV22iS4Hf5krQ2tQ=
Received: by mx.zohomail.com with SMTPS id 1722984260135977.7539156361697;
	Tue, 6 Aug 2024 15:44:20 -0700 (PDT)
Date: Tue, 6 Aug 2024 18:44:17 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Wren Turkal <wt@penguintechs.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 3/3] Bluetooth: hci_qca: fix a NULL-pointer derefence at
 shutdown
Message-ID: <1723fdc3-33b9-4518-8f25-161ab59ecf21@notapiano>
References: <20240731-hci_qca_fixes-v1-0-59dad830b243@linaro.org>
 <20240731-hci_qca_fixes-v1-3-59dad830b243@linaro.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240731-hci_qca_fixes-v1-3-59dad830b243@linaro.org>
X-ZohoMailClient: External

On Wed, Jul 31, 2024 at 05:20:50PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Unlike qca_regulator_init(), qca_power_shutdown() may be called for
> QCA_ROME which does not have qcadev->bt_power assigned. Add a
> NULL-pointer check before dereferencing the struct qca_power pointer.
> 
> Fixes: eba1718717b0 ("Bluetooth: hci_qca: make pwrseq calls the default if available")
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Closes: https://lore.kernel.org/linux-bluetooth/su3wp6s44hrxf4ijvsdfzbvv4unu4ycb7kkvwbx6ltdafkldir@4g7ydqm2ap5j/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Hi,

I just noticed we're still hitting this issue in mainline (saw it on the
mt8183-juniper platform in KernelCI). I see this commit was merged 6 days ago to
bluetooth-next, but it seems there wasn't a pull request with this fix yet to
include it in 6.11. I'm wondering if it's still going to be sent.

Thanks,
Nícolas

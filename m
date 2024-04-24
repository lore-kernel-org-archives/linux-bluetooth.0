Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B3986254;
	Wed, 24 Apr 2024 03:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713928935; cv=none; b=D5QgK3f4iYFRtEaMAwLtkFyAa/o8075bphASvcXEjlu3Z9yx18KuhXEs5IG4AHYYFrX7x1TssA6GCYPkSW6+hD9e3ewS7cgsNX+AVAlMEa0SyrKpzEvR3ieW7U9VH9ZQKPVh9iRrXZ3Vey0zhP8xHPz3Yn1FKXM+5lbhVqVjMxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713928935; c=relaxed/simple;
	bh=0nPc4th4OCKsGmBC1BniPFMmEc4gKsx1p8zUTGJfvbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvOHPXZSivGGpAhDrgVqbG+yAXe6/0woQCleSXWskqo4HbcWmpowZPg0oGhJh5nu4Fa7u2WCMWHwgOiHEXZ1GY8cB4RbLjUrhMTlMnpSiCsHVXQee6ZfRkCoHWPrKuJhlsN6qdf8SnEll8t7VhV2rtVhrMts6PkyLG+h6KjlIgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dyEaeI0k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dyEaeI0k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5693C116B1;
	Wed, 24 Apr 2024 03:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713928935;
	bh=0nPc4th4OCKsGmBC1BniPFMmEc4gKsx1p8zUTGJfvbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dyEaeI0knqACCzPrFXNMxMDUUAroi+d8mK6ZhtzjpylD3kh4nMaO6CJTYnE+nyA0v
	 2YKUY8OuZCuKU9nEp8PCCjciwb4RVkMiq7G/xPH9G/2hmIFxpYV2BhF631VyI7yU4q
	 NTbkJ4Dc+4ZbZrypnU02PBjx20tN5HiKLPvxJPDc=
Date: Tue, 23 Apr 2024 20:22:05 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org, bartosz.golaszewski@linaro.org,
	krzysztof.kozlowski@linaro.org, wt@penguintechs.org,
	regressions@lists.linux.dev, kernel@quicinc.com
Subject: Re: [PATCH v6 2/2] Bluetooth: qca: Fix BT enable failure for QCA6390
 after disable then warm reboot
Message-ID: <2024042357-nanometer-importer-9e89@gregkh>
References: <1713919602-5812-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713919602-5812-3-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1713919602-5812-3-git-send-email-quic_zijuhu@quicinc.com>

On Wed, Apr 24, 2024 at 08:46:42AM +0800, Zijun Hu wrote:
> From: Zijun Hu <zijuhu@qti.qualcomm.com>
> 
> Commit 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed
> serdev") will cause below regression issue:
> 
> BT can't be enabled after below steps:
> cold boot -> enable BT -> disable BT -> warm reboot -> BT enable failure
> if property enable-gpios is not configured within DT|ACPI for QCA6390.
> 
> The commit is to fix a use-after-free issue within qca_serdev_shutdown()
> during reboot, but also introduces this regression issue regarding above
> steps since the VSC is not sent to reset controller during warm reboot.
> 
> Fixed by sending the VSC to reset controller within qca_serdev_shutdown()
> once BT was ever enabled, and the use-after-free issue is also be fixed
> by this change since serdev is still opened when send to serdev.
> 
> Fixes: 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed serdev")
> Reported-by: Wren Turkal <wt@penguintechs.org>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218726
> Signed-off-by: Zijun Hu <zijuhu@qti.qualcomm.com>
> Tested-by: Wren Turkal <wt@penguintechs.org>
> ---
> Changes:
> V3 -> V6: Correct title and commit message
> V1 -> V3: Remove debugging logs
> 
>  drivers/bluetooth/hci_qca.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 4079254fb1c8..fc027da98297 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2439,13 +2439,12 @@ static void qca_serdev_shutdown(struct device *dev)
>  	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
>  	struct hci_uart *hu = &qcadev->serdev_hu;
>  	struct hci_dev *hdev = hu->hdev;
> -	struct qca_data *qca = hu->priv;
>  	const u8 ibs_wake_cmd[] = { 0xFD };
>  	const u8 edl_reset_soc_cmd[] = { 0x01, 0x00, 0xFC, 0x01, 0x05 };
>  
>  	if (qcadev->btsoc_type == QCA_QCA6390) {
> -		if (test_bit(QCA_BT_OFF, &qca->flags) ||
> -		    !test_bit(HCI_RUNNING, &hdev->flags))
> +		if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks) ||
> +		    hci_dev_test_flag(hdev, HCI_SETUP))
>  			return;
>  
>  		serdev_device_write_flush(serdev);
> -- 
> 2.7.4
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

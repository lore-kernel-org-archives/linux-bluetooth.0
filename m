Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F64947E;
	Wed, 24 Apr 2024 03:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713928924; cv=none; b=SmS0Mrxs2DeKek4oPeEsNOhZJgWmLGNRu+6kRtTUZrmpVitc1VaEXTDUBrMyohB3RdLcVO0OeJXRNPq7ALBJb9Kxy3X5MJyV6Zv4RadvkBtZ2nagG/MKgKwlRARmTuz3uO5aC+15QI8Xes6KkUBbFKAp1Y91Ex+6ZGtzKVu46VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713928924; c=relaxed/simple;
	bh=yYfX7JBnFQAQEzsUGCwzFnufqUdPptWb73fT4X9NhJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txMQkea3ou9dLURIpwHm3nJdAoIJB+V6KB0P1XrxvFU3EqDAdecPzm2YaLz/HiFrt7PifKMk4caYK5gs7mvftcUms0scDwTcTfBsMeDjD3Q51g9oT3mjHdaLlGTVygmvI+cSB1kJ4+EWE3ghqdzh7cvEgVa1dtaFVYanQe8BysI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IMcaLCqP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IMcaLCqP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F073C32781;
	Wed, 24 Apr 2024 03:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713928924;
	bh=yYfX7JBnFQAQEzsUGCwzFnufqUdPptWb73fT4X9NhJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IMcaLCqPEmrv5xGBijo1myaEOyg7gMx1txLziBUp2sBUlepUsJA5htyKl/EP+8+PC
	 XEB4VGo4fRljOZFu+9aN3a3IsSZBiUslSyD3l+upe7wXRPgrSwVfenO4pneTc+QdXe
	 N56iuPs205I4Kd9WU5KBsxlXj9CedKGNQPzrOCpk=
Date: Tue, 23 Apr 2024 20:21:54 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org, bartosz.golaszewski@linaro.org,
	krzysztof.kozlowski@linaro.org, wt@penguintechs.org,
	regressions@lists.linux.dev, kernel@quicinc.com
Subject: Re: [PATCH v6 1/2] Bluetooth: qca: Fix BT enable failure for QCA6390
Message-ID: <2024042328-evacuee-prewar-1132@gregkh>
References: <1713919602-5812-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713919602-5812-2-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1713919602-5812-2-git-send-email-quic_zijuhu@quicinc.com>

On Wed, Apr 24, 2024 at 08:46:41AM +0800, Zijun Hu wrote:
> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
> with gpiod_get_optional()") will cause below serious regression issue:
> 
> BT can't be enabled any more after below steps:
> cold boot -> enable BT -> disable BT -> BT enable failure
> if property enable-gpios is not configured within DT|ACPI for QCA6390.
> 
> The commit wrongly changes flag @power_ctrl_enabled set logic for this
> case as shown by its below code applet and causes this serious issue.
> qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>                                                GPIOD_OUT_LOW);
> - if (IS_ERR_OR_NULL(qcadev->bt_en)) {
> + if (IS_ERR(qcadev->bt_en)) {
>   	dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
> 	power_ctrl_enabled = false;
>   }
> 
> Fixed by reverting the mentioned commit for QCA6390.
> 
> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
> Reported-by: Wren Turkal <wt@penguintechs.org>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726
> Link: https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> Tested-by: Wren Turkal <wt@penguintechs.org>
> ---
> Changes:
> V3 -> V6: Correct code stype and title and commit message
> V1 -> V3: Don't revert the whole wrong commit but focus on impacted device 

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

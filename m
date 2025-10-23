Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC50242D70;
	Thu, 23 Oct 2025 05:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761197267; cv=none; b=EjgNX+ju2ybK0oYGtcde4EP0qstsMvwvHrqv92e7FuD0pu3imb5LFbg1cqOrE0KxZ22a0f6/cqrcg2q1Qh784VVQ4JIgPx7jLTTHSA6gCjPXs8YqDSvZRW1T5OHdEvhD8/ecnMTgfnmlQyc53KUoa4TTUCJVO0dz9nc/+oqIsmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761197267; c=relaxed/simple;
	bh=aiwbxwHPtjAGXkZym9GSo7vFIP/SVAmN+sjMmeRKakY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlAmPEW8BEcNOGQa6oEbG6JAXYA4d6FPdorWe0ES/qIEhWiX7xmmF7WnEe7AUVZlJZzIxTLXKYt5HaTK7Adde2034lTaZrW33gN5wyTa76YBNM9vpsUs0MS7YEisDiV850G/2WQzgdjQAvfzDqpYmfDrm7MAztaoa6nz8OApOfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NbQBN8NZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NbQBN8NZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E490C4CEE7;
	Thu, 23 Oct 2025 05:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761197266;
	bh=aiwbxwHPtjAGXkZym9GSo7vFIP/SVAmN+sjMmeRKakY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NbQBN8NZ5uEZ7gyXUxgzT8v2up/CFXuDsFOdLplFJyX5mpqEoMi+n9TpFQLyWhO/p
	 i+Ql4IZUubm6iRu2orCpjtU4mO9btqYej5h3XMwz5mNsAWAEg4pR4SdCMjjxqQEfZr
	 T5dYL1IUg+l10VeMz/TqTmNwv/J8uHhWdySaeg9Q=
Date: Thu, 23 Oct 2025 07:27:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+a9a4bedfca6aa9d7fa24@syzkaller.appspotmail.com,
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org
Subject: Re: [PATCH] Bluetooth: hci_event: validate HCI event packet
 Parameter Total Length
Message-ID: <2025102329-rimmed-jailhouse-3d39@gregkh>
References: <20251022223417.139332-2-rpthibeault@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251022223417.139332-2-rpthibeault@gmail.com>

On Wed, Oct 22, 2025 at 06:34:16PM -0400, Raphael Pinsonneault-Thibeault wrote:
> There is a BUG: KMSAN: uninit-value in hci_cmd_complete_evt() due to a
> malformed HCI event packet received from userspace.
> 
> The existing code in hci_event_packet() checks that the buffer is large
> enough to contain the event header, and checks that the hdr's Event Code
> is valid, but does not check the hdr's Parameter Total Length. So,
> syzbot’s event packet passes through and uses the un-init values in
> hci_event_func() => hci_cmd_complete_evt().
> 
> Reported-by: syzbot+a9a4bedfca6aa9d7fa24@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=a9a4bedfca6aa9d7fa24
> Tested-by: syzbot+a9a4bedfca6aa9d7fa24@syzkaller.appspotmail.com
> Fixes: a9de9248064bf ("[Bluetooth] Switch from OGF+OCF to using only opcodes")
> Signed-off-by: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
> ---
>  net/bluetooth/hci_event.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index d790b0d4eb9a..5e1498cc04cd 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -7565,7 +7565,7 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
>  	hci_req_complete_t req_complete = NULL;
>  	hci_req_complete_skb_t req_complete_skb = NULL;
>  	struct sk_buff *orig_skb = NULL;
> -	u8 status = 0, event, req_evt = 0;
> +	u8 status = 0, event, req_evt = 0, len;
>  	u16 opcode = HCI_OP_NOP;
>  
>  	if (skb->len < sizeof(*hdr)) {
> @@ -7585,6 +7585,13 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
>  		goto done;
>  	}
>  
> +	len = hdr->plen;
> +	if (len != skb->len - HCI_EVENT_HDR_SIZE) {
> +		bt_dev_warn(hdev, "Unexpected HCI Parameter Length 0x%2.2x",
> +			    len);
> +		goto done;
> +	}
> +
>  	/* Only match event if command OGF is not for LE */
>  	if (hdev->req_skb &&
>  	    hci_opcode_ogf(hci_skb_opcode(hdev->req_skb)) != 0x08 &&
> -- 
> 2.43.0
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

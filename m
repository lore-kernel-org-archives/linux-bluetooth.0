Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD226C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Oct 2022 19:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiJSTXa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Oct 2022 15:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiJSTX3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Oct 2022 15:23:29 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E49E1B76E2
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Oct 2022 12:23:28 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id p8so3611276lfu.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Oct 2022 12:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LGNGt25q9+Ig+OMybMF9csBabjNI4IpmxQXunm74J0g=;
        b=H1oWODYhuBlYSPb8EU3GAMzbO3kRhpefdeeknsNo3xC6FUNvZGA4bZGYWShv2iad0i
         hZSkK59/3goO103nob7d05pClxAMRFCUpLMsxx2YHKrWRbhRWC0zxDfReRw09lZfrnbv
         ivMcY2baMbcGnA07Tjf/KrWbFTS208Gq5gpLsmH9baycqPw1DjbS7kAjmpfQL9DPEgjH
         KB65E8/w5pcUB0FBsvuBOdYZPHmLEsoWikU1Rq08AIbXa4zVjEXb2t+TZzpglGevbONS
         uP7X6AnstTXqMwwHe9W7UjN0gQNXsuXjRsszzbCEppcaSGJsnncZafyMug8I3U039nwp
         8lAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LGNGt25q9+Ig+OMybMF9csBabjNI4IpmxQXunm74J0g=;
        b=yBipkAEt+dC4At5L8bKBUBi/2IrqyQXMjcTzpG58V2T8ehzYNE/I7OphwaM127s5g/
         gByp4qEw8rOpzlSPMDHM3NS+WU6+aPHOBw3mKjltf1GHI2F+LSkQUlOc8djpvd7tZ6W5
         2uaXzWOOi0EawfVGcy5Mr549CaJ1aJIHyb52BVjcfqMpPEemflXDvjRu8BnVs3KrFNVq
         fGkt+S3lb12wZo6CZiewfA9cep6AHWiyBX5ofU75PdV419QVvbf9IqhvzioI+U8z9uSw
         adVDDMzCQP8i1ZMaDS43xHQoRNWJ/JPs0BN433kzDGLXxJuUfUBrgRsHltb/D/WsQEe5
         Vy5Q==
X-Gm-Message-State: ACrzQf1ckZWXYG/7dv3DJoTKJ5KUDWmd0ZcrRg7TnykstT0PYWn51ikx
        NKhDnMaAu4JlE6WJXwDw6Smx89/HIuUG9e6HWno11wh26uKdLg==
X-Google-Smtp-Source: AMsMyM6j+nPC8ur8JmF3H1EH7M39K03+F2qtM9dwHOPE5e2G+6mLIfG1iTbYTS9vD5sD9Papw5OM9YCxXMftF46n4rc=
X-Received: by 2002:ac2:592c:0:b0:4a2:3cde:ef7d with SMTP id
 v12-20020ac2592c000000b004a23cdeef7dmr3138262lfi.251.1666207406603; Wed, 19
 Oct 2022 12:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <BYAPR03MB3701856C7F525A261D9F3D14872B9@BYAPR03MB3701.namprd03.prod.outlook.com>
In-Reply-To: <BYAPR03MB3701856C7F525A261D9F3D14872B9@BYAPR03MB3701.namprd03.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 19 Oct 2022 12:23:14 -0700
Message-ID: <CABBYNZLZuL9XUX014i7dMAL9Wd4Na-1K8thx+w74ZO-dE8Tc3w@mail.gmail.com>
Subject: Re: Forcing MITM protection
To:     Tom Unbehau <Tom.Unbehau@verifone.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tom,

On Wed, Oct 19, 2022 at 7:19 AM Tom Unbehau <Tom.Unbehau@verifone.com> wrote:
>
> Hi everyone,
>
> could anyone give me advice on how to disable SSP "Just Works" pairing
> via userspace? Due to regulatory requirements I am not allowed to
> support BT pairing without MITM protection.
> However when I pair (outgoing -- i am the initiator) with a device
> which has IOCaps set to NoKeyboardNoDisplay and mitm to 0,
> the "automatic" pairing is triggered in the kernel, without me
> having the chance to cancel this.
>
> The automatic accepting happens in event.c:
>
> -------------------
> static void hci_user_confirm_request_evt(struct hci_dev *hdev, void *data,
>                                          struct sk_buff *skb)
>
> [...]
>
> /* If we require MITM but the remote device can't provide that
>          * (it has NoInputNoOutput) then reject the confirmation
>          * request. We check the security level here since it doesn't
>          * necessarily match conn->auth_type.
>          */
>         if (conn->pending_sec_level > BT_SECURITY_MEDIUM &&
>                 conn->remote_cap == HCI_IO_NO_INPUT_OUTPUT) {
>                 bt_dev_dbg(hdev, "Rejecting request: remote device can't provide MITM");
>                 hci_send_cmd(hdev, HCI_OP_USER_CONFIRM_NEG_REPLY,
>                              sizeof(ev->bdaddr), &ev->bdaddr);
>                 goto unlock;
>         }

I guess you actually want to force BT_SECURITY_HIGH then, which is
something we currently don't support when doing MGMT Pair command,

>         /* If no side requires MITM protection; auto-accept */
>         if ((!loc_mitm || conn->remote_cap == HCI_IO_NO_INPUT_OUTPUT) &&
>                 (!rem_mitm || conn->io_capability == HCI_IO_NO_INPUT_OUTPUT)) {
> -------------------
>
> In my scenario the following happens:
>
> -------------------
> if ((!loc_mitm || conn->remote_cap == HCI_IO_NO_INPUT_OUTPUT) &&
> -------------------
>
> conn->remote_cap is HCI_IO_NO_INPUT_OUTPUT, loc_mitm is 1,
> the check passes (right side of the logical OR).
>
> -------------------
> (!rem_mitm || conn->io_capability == HCI_IO_NO_INPUT_OUTPUT)) {
> -------------------
>
> rem_mitm is not on,
> the check passes as well (left side of the logical OR).
>
> However, in the example here even the check before on conn could prevent
> this, however conn seems to be the ACL connection,
> which is set hard to BT_SECURITY_MEDIUM when doing outgoing pairing:
>
> mgmt.c:
>
> ------------------
> static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
>                        u16 len)
>
> [...]
>         sec_level = BT_SECURITY_MEDIUM;
>         auth_type = HCI_AT_DEDICATED_BONDING;
>
>         if (cp->addr.type == BDADDR_BREDR) {
>                 conn = hci_connect_acl(hdev, &cp->addr.bdaddr, sec_level,
>                                        auth_type, CONN_REASON_PAIR_DEVICE);
> ------------------
>
> After some modifications to the kernel source I can get it to cancel,
> but I really do not want to modify the kernel in order to do disable
> "Just Works" handling.
> Is there a way to force MITM protection in all cases (via IOCTL, or HCI
> user socket or whatever). I would be very appreciative of anyone
> who could point me in the right direction.

It might be possible to force via socket connect using setsockopt to
set the sec_level to BT_SECURITY_HIGH, that said I think we would need
some entry on main.conf like MinSecurityLevel=high and then use it in
the line bellow:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/device.c#n5436

We also need to change btd_le_connect_before_pairing to make it return
true whenever MinSecurityLevel is higher than medium so we use the
socket to connect instead Pair.

> Thank you for your time.
>
> Best regards,
> Tom Unbehau



-- 
Luiz Augusto von Dentz

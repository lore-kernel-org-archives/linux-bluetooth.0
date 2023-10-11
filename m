Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447DCCDB460
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Oct 2023 16:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjJKQUu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Oct 2023 12:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbjJKQUr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Oct 2023 12:20:47 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3C7BA
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 09:20:43 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-27d18475ed4so142510a91.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 09:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697041243; x=1697646043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j9lJljhG7J0NRk5jXquLEzmz4kKiNkfUkpiLpvv0v7g=;
        b=H98WJaL5RfVoiaalQKFNSgD07kq9V2RvVV0fx+6MFZ2fwuvqP7ctj4r8HYXc0swock
         ruSVU0YrcEJdryMYf4joPZ8F078hcQz7vF8R2cVwCeyaHRGLEOK4290BQb3cfu5WXOYB
         WkZCM+kPzD0yeMQOYBs/J7NrAT8J+2kfGfaVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697041243; x=1697646043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9lJljhG7J0NRk5jXquLEzmz4kKiNkfUkpiLpvv0v7g=;
        b=LtiQH7EAxM8KQVzhzkToDHzfk2UR7LXoMAWJ/s5KFK/X41aCZz73ghTHRlF1o3/z0r
         lUAltal+XEiZUeO6ShnfWrbdR/f3nvJb3cpCje7iTyEXiHFh7vMKobXwuO3mt2mLbtLj
         dRLsBJwAjRgQrZwT6a+9A2VfxD006uXUv8JCmfp0SyCFROcuif7s7x7+UV+DpZ0wxFNx
         CNXc0YAgWmPBTZnmxn6BjFyKQx8o99Nv2UOeyR7EJ0fagI41rVKkqTdNBYeHeGJMUyVr
         Mc2kxIbm3un8tn2BS51t7DgCgGYlf0xSADLOqqubMUTicXKdVj5o4YOc1wLiBfWgYbvy
         EicA==
X-Gm-Message-State: AOJu0YwUw0/I6GV4nkzOW8jr2sp0MQQnuW+js1swj0OYJPHlDPxfViFf
        Oa1PS0K1I9+DOJCeXQGgzwsFDA==
X-Google-Smtp-Source: AGHT+IFBkkzjfqUFPw2LHU/WJiBG51hkvc97uk8G4hhO5uBiGO2zJPFVWSMOQulsb16+hJ+LUaknmw==
X-Received: by 2002:a17:90a:7541:b0:27c:eb7f:cd00 with SMTP id q59-20020a17090a754100b0027ceb7fcd00mr4432651pjk.22.1697041243325;
        Wed, 11 Oct 2023 09:20:43 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090a178700b0027cf4c554dasm125627pja.11.2023.10.11.09.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 09:20:42 -0700 (PDT)
Date:   Wed, 11 Oct 2023 09:20:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Edward AD <twuufnxlz@gmail.com>
Cc:     syzbot+c90849c50ed209d77689@syzkaller.appspotmail.com,
        davem@davemloft.net, edumazet@google.com, johan.hedberg@gmail.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        luiz.von.dentz@intel.com, marcel@holtmann.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] Bluetooth: hci_sock: fix slab oob read in
 create_monitor_event
Message-ID: <202310110908.F2639D3276@keescook>
References: <000000000000ae9ff70607461186@google.com>
 <20231010053656.2034368-2-twuufnxlz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010053656.2034368-2-twuufnxlz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Oct 10, 2023 at 01:36:57PM +0800, Edward AD wrote:
> When accessing hdev->name, the actual string length should prevail
> 
> Reported-by: syzbot+c90849c50ed209d77689@syzkaller.appspotmail.com
> Fixes: dcda165706b9 ("Bluetooth: hci_core: Fix build warnings")
> Signed-off-by: Edward AD <twuufnxlz@gmail.com>
> ---
>  net/bluetooth/hci_sock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> index 5e4f718073b7..72abe54c45dd 100644
> --- a/net/bluetooth/hci_sock.c
> +++ b/net/bluetooth/hci_sock.c
> @@ -488,7 +488,7 @@ static struct sk_buff *create_monitor_event(struct hci_dev *hdev, int event)
>  		ni->type = hdev->dev_type;
>  		ni->bus = hdev->bus;
>  		bacpy(&ni->bdaddr, &hdev->bdaddr);
> -		memcpy(ni->name, hdev->name, 8);
> +		memcpy(ni->name, hdev->name, strlen(hdev->name));

Uh, what's going on here?

hdev is:

struct hci_dev {
	...
        const char      *name;

ni is:

struct hci_mon_new_index {
        char            name[8];

You can't use "strlen" here in the case that "hdev->name" is larger than
8 bytes.

Also, why memcpy() and not strscpy()? Is this supposed to be padded out
with %NUL bytes? It appears to be sent over the network, so "yes" seems
to be the safe answer.

Should ni->name be always %NUL terminated? That I can't tell for sure,
but I assume "no", because the solution was to explicitly copy all the
bytes _except_ the %NUL byte (using strlen).

struct hci_mon_new_index's "name" should be marked __nonstring, and
instead strtomem_pad() should be used instead of memcpy.

-Kees

>  
>  		opcode = cpu_to_le16(HCI_MON_NEW_INDEX);
>  		break;
> -- 
> 2.25.1
> 

-- 
Kees Cook

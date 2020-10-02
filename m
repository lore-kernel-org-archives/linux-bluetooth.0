Return-Path: <SRS0=UfNv=DJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B14DC4363D
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Oct 2020 10:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DB352074B
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Oct 2020 10:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E9R8qX5W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387733AbgJBKWz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Oct 2020 06:22:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60784 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725993AbgJBKWx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Oct 2020 06:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601634171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1xq6PdAlFtb82Oyf/HTK7koITUOMihvvyNRrB1vT+OU=;
        b=E9R8qX5Wejqsxoj1S2JrAoGIomZa34SMuwzifKvhwnqEHLujhqV7pmhBKtLl6jyg+CHkag
        evpR8KA9zGxX11/JVk+WPvS1TGFCP80962eFsZnJOkwccQ2NftxDPDvNE77k6N1Tsk/5v5
        OA8EeS/VccZ08vF7CrYVukysia+jsY4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-WTLkr7D3ONarBvQDfEMMJg-1; Fri, 02 Oct 2020 06:22:46 -0400
X-MC-Unique: WTLkr7D3ONarBvQDfEMMJg-1
Received: by mail-ej1-f71.google.com with SMTP id ml20so484537ejb.23
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Oct 2020 03:22:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1xq6PdAlFtb82Oyf/HTK7koITUOMihvvyNRrB1vT+OU=;
        b=uO870tqx0k7fbDM2CG0a0SIbGxAw61kYGFmsPdDRrSHNUw+SsLiUu/QsYCRBd+94+1
         Ifg2Y7sH+LNyF75LL95z1nrCe9IZ7PcN7RcRbzizC72kX00pmA8d2B13Do+k5S9ma5E0
         tnybjZTDSb5VYog7SwNxe7U3AK7Fl51CUGlzZykpheLV025Crn6BCHCBSp6r5BD1NHRJ
         08CjIRjwj0afZ592AqQjAk0ADPV4TJ1VZDQDGoz92AAmwhBLC1rHBFlKnsfyLtubXFfj
         KyYOfrCjc9I0BOcVg418r5XtPjej6oWbH3vAJRCTOjG+w7maM8IHIXGLymw6z952gveq
         SoGA==
X-Gm-Message-State: AOAM530EPPUieo4oTqoDii40Ek80Zxdx9rtN5h4gPQBT0wxXm13pV1Ke
        oXIJ496Y/QmTftEc1Ka0d/rjJIYTXh2p1IHto3Npkwg4Svlf7pdOIYdSiVX3SGRsRrEvrPod//b
        jzB5QrDKDNSLsEg6cDqWoxR+d9HvE
X-Received: by 2002:a17:906:a841:: with SMTP id dx1mr1538948ejb.520.1601634165178;
        Fri, 02 Oct 2020 03:22:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4HuvnOcBD6DICM9z/IMauYSG45w0g9vyVtyC7HcfWDB8Jdwd/2/aCDu1Kl4wl2RZzVHt+FA==
X-Received: by 2002:a17:906:a841:: with SMTP id dx1mr1538918ejb.520.1601634164922;
        Fri, 02 Oct 2020 03:22:44 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id t4sm854790ejj.6.2020.10.02.03.22.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 03:22:44 -0700 (PDT)
Subject: Re: [Linux-kernel-mentees][PATCH v2] bluetooth: hci_h5: close serdev
 device and free hu in h5_close
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201001194329.9328-1-anant.thazhemadam@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <33d8c103-0c24-3ad7-2a3c-ffeb625521ee@redhat.com>
Date:   Fri, 2 Oct 2020 12:22:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201001194329.9328-1-anant.thazhemadam@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On 10/1/20 9:43 PM, Anant Thazhemadam wrote:
> When h5_close() gets called, the memory allocated for the hu gets
> freed only if hu->serdev doesn't exist. This leads to a memory leak.
> So when h5_close() is requested, close the serdev device instance and
> free the memory allocated to the hu entirely instead.
> 
> Fixes: ce945552fde4 ("Bluetooth: hci_h5: Add support for serdev enumerated devices")
> Reported-by: syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
> Tested-by: syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>

So 2 comments to this:

1. You claim this change fixes a memory-leak, but in the serdev case
the memory is allocated in h5_serdev_probe() like this:

        h5 = devm_kzalloc(dev, sizeof(*h5), GFP_KERNEL);

So its lifetime is tied to the lifetime of the driver being bound
to the serdev and it is automatically freed when the driver gets
unbound. If you had looked at where the h5 struct gets allocated
in h5_close()-s counterpart, h5_open() then you could have seen
this there:

         if (hu->serdev) {
                 h5 = serdev_device_get_drvdata(hu->serdev);
         } else {
                 h5 = kzalloc(sizeof(*h5), GFP_KERNEL);
                 if (!h5)
                         return -ENOMEM;
         }

So it is very clear here, that the kzalloc only happens in the
if (!hu->serdev) which clearly makes the kfree() have the same
condition the right thing todo. In the hu->serdev the data which
was allocated by h5_serdev_probe() is used instead and no alloc
happens inside h5_open()

In general when looking at resource teardown you should also look
at where they are allocated in the mirror function
and the teardown should mirror the alloc code.

So the main change of your commit is wrong:

NACK.


2. You are making multiple changes in a single commit here, I count at
least 3. When ever you are making multiple changes like this, you should really
split the commit up in 1 commit per change and explain in each commit
message why that change is being made (why it is necessary). Writing
commit messages like this also leads to you double-checking your own
work by carefully considering why you are making the changes.

So about the 3 different changes:

2a) Make the kfree(h5) call unconditionally, which as mentioned above
is wrong.

2b) Introduce a call to kfree_skb(h5->rx_skb); which is not mentioned in
the commit message at all.  This looks like it would actually be a sensible
change, at least in the "if (!hu->serdev)" case.  When using the serdev
interface then just freeing it will leave a dangling pointer, so it
would be better (for both the hu->serdev and the !hu->serdev cases)
to call h5_reset_rx() on close instead which does:

         if (h5->rx_skb) {
                 kfree_skb(h5->rx_skb);
                 h5->rx_skb = NULL;
         }

2c) Introduce a call to serdev_device_close(), without really explaining
why in the commit message. Again if you would have looked at the mirror
h5_close() function then you see no serdev_device_open() there.
Actually serdev_device_open() is not called anywhere in the hci_h5.c code.

Digging a little deeper (using grep) shows that hci_uart_register_device()
calls serdev_device_open() and hci_uart_register_device() gets called from:
h5_serdev_probe(), likewise hci_uart_unregister_device() calls
serdev_device_close() for us and that gets called from h5_serdev_remove(),
so there is no need to call serdev_device_close() from h5_close() and doing
so will actually break things, because then the serdev will be left closed
on a subsequent h5_open() call.

Regards,

Hans



> ---
> Changes in v2:
> 	* Fixed the Fixes tag
> 
>   drivers/bluetooth/hci_h5.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index e41854e0d79a..3d1585add572 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -248,8 +248,12 @@ static int h5_close(struct hci_uart *hu)
>   	if (h5->vnd && h5->vnd->close)
>   		h5->vnd->close(h5);
>   
> -	if (!hu->serdev)
> -		kfree(h5);
> +	if (hu->serdev)
> +		serdev_device_close(hu->serdev);
> +
> +	kfree_skb(h5->rx_skb);
> +	kfree(h5);
> +	h5 = NULL;
>   
>   	return 0;
>   }
> 


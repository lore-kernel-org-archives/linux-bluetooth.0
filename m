Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC9AC56202
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Nov 2020 10:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 248122074B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Nov 2020 10:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENgZqSFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgKWKWY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Nov 2020 05:22:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23970 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727984AbgKWKWX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Nov 2020 05:22:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606126942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SIJNGQlGNU34Rl4jOqGXcRqaQo4bDchYzoZChPlgOCI=;
        b=ENgZqSFh+6BSiiDYiTugRZ8QbnlrTt0FTa7h6Zb8kvU/ALkWP6z4bgh3PizQBKe42fS1L+
        ibMb5PCAA1htAZaCFi1zXae4A6lTPSVsluGCioOUdTUAqYn43x7K6iEgZfqaofClJLxwII
        ttoeWDQvxIQ00kQ7wUqkyWY+qHVsxXU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-qVggoKVjNi2WR_QJIGYOoQ-1; Mon, 23 Nov 2020 05:22:20 -0500
X-MC-Unique: qVggoKVjNi2WR_QJIGYOoQ-1
Received: by mail-ed1-f69.google.com with SMTP id d3so6421304eds.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2020 02:22:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SIJNGQlGNU34Rl4jOqGXcRqaQo4bDchYzoZChPlgOCI=;
        b=D7rIRh2ZQNTMTUNf0VeJJH9NmsZmIPmVWUeUgz/MOHnPNPXYs2zRB6uz3tbolHMqxU
         hEaxJE28i1NZIDkCf/K+I6NSuCN0Q51eN7fQQ7XX4TQ/sDUY/Lfe8s/8eKluMuHsohVX
         QBYjZPinRxudUcaWw2UlbFSSK12R+9loBysRfMJhiz8WIQC4lrxENG2ovoDQxxaRg0jl
         foAuwyuu9N4EGRd3kQgcQJmkocLUatE6kscMfRuxBW2Do+NIhduBtjEWEfg2CZgdk5uW
         67b9ISY1Al/Poj3I54RKdTtqwLgCKs+uH2AHRePXlli9f5lCgMRXRjDFMyEG1UIjZLIp
         OJXg==
X-Gm-Message-State: AOAM531eqiiNwtV6UrqXECJY2ekjIxQAfwM8AtXpkzO9msib6DBKYiKK
        yklBRD+wDs+S4ycUi514fBvYIYfW6qfeQqvMB17NWRv1jE678toE9XKTzIsamGEetlLMWGMUqsK
        um1YphDuZGcb1M+urQzMFl37K0vU1vDEq6QIJ5AD+ELPk8IuUOAXV+HgieRaenexPTF1F8dwtOC
        24B5rU
X-Received: by 2002:a17:906:2756:: with SMTP id a22mr30291976ejd.81.1606126938808;
        Mon, 23 Nov 2020 02:22:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxJnZxVz4c++CoevtgbweT9IOP4Qu1/VS1JR2cjWL1zE/6xW9ErPXji+UEycp9wimtDlkZFyw==
X-Received: by 2002:a17:906:2756:: with SMTP id a22mr30291961ejd.81.1606126938553;
        Mon, 23 Nov 2020 02:22:18 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id u7sm4715308ejf.83.2020.11.23.02.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 02:22:17 -0800 (PST)
Subject: Re: [PATCH v2 2/2] Bluetooth: btusb: Add workaround for remote-wakeup
 issues with some fake CSR controllers
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
References: <20201123101308.7291-1-hdegoede@redhat.com>
 <20201123101308.7291-3-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <55f5b125-eef1-a957-7b40-1f01ea571f2c@redhat.com>
Date:   Mon, 23 Nov 2020 11:22:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201123101308.7291-3-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On 11/23/20 11:13 AM, Hans de Goede wrote:
> With the recent btusb change to detect and deal with more fake CSR
> controllers, I decided to see if one of the fakes which I have
> lying around would now work.
> 
> After much experimentation I came to the conclusion that it works, if I
> have autosuspend enabled initially and then disable it after the device
> has suspended at least once. Yes this is very weird, but I've tried many
> things, like manually clearing the remote-wakeup feature. Doing a
> runtime-resume + runtime suspend is the only way to get the receiver
> to actually report received data (and/or pairing info) through its
> bulk rx endpoint.
> 
> But the funkyness of the bulk-endpoint does not stop there, I mainly
> found out about this problem, because with autosuspend enabled
> (which usually ensures the suspend at least once condition is met),
> the receiver stops reporting received data through its bulk rx endpoint
> as soon as autosuspend kicks in. So I initially just disabled
> autosuspend, but then the receiver does not work at all.
> 
> This was with a fake CSR receiver with a bcdDevice value of 0x8891,
> a lmp_subver of 0x0x1012, a hci_rev of 0x0810 and a hci_ver of
> BLUETOOTH_VER_4_0.

I just realized that I should have opened this one and add the
chipmarkings to the commit msg here too. So I've just opened it
and took a look.

This one has a Barrot 8041a02 chip and searching for 8041a92 shows that
the internet is full of reports of how crappy it is.

I guess this patch probably will get some review remarks anyways,
but let me know if you want a v3 with just the chip added to the
commit msg.

Regards,

Hans


> 
> Summarizing this specific fake CSR receiver has the following 2 issues:
> 
> 1. The bulk rx endpoint will never report any data unless
> the device was suspended at least once.
> 
> 2. They will not wakeup when autosuspended and receiving data on their
> bulk rx endpoint from e.g. a keyboard or mouse (IOW remote-wakeup support
> is broken for the bulk endpoint).
> 
> Add a workaround for 1. which enables runtime-suspend, force-suspends
> the hci and then wakes-it up by disabling runtime-suspend again.
> 
> Add a workaround for 2. which clears the hci's can_wake flag, this way
> the hci will still be autosuspended when it is not open.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/bluetooth/btusb.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index ac7fede4f951..48e404dfa246 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1768,6 +1768,7 @@ static int btusb_setup_csr(struct hci_dev *hdev)
>  	struct hci_rp_read_local_version *rp;
>  	struct sk_buff *skb;
>  	bool is_fake = false;
> +	int ret;
>  
>  	BT_DBG("%s", hdev->name);
>  
> @@ -1856,6 +1857,37 @@ static int btusb_setup_csr(struct hci_dev *hdev)
>  		 */
>  		clear_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
>  		clear_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
> +
> +		/*
> +		 * Some of these clones are really messed-up:
> +		 * 1. Their bulk rx endpoint will never report any data unless
> +		 * the device was suspended at least once (yes really).
> +		 * 2. They will not wakeup when autosuspended and receiving data
> +		 * on their bulk rx endpoint from e.g. a keyboard or mouse
> +		 * (IOW remote-wakeup support is broken for the bulk endpoint).
> +		 *
> +		 * To fix 1. enable runtime-suspend, force-suspend the
> +		 * hci and then wake-it up by disabling runtime-suspend.
> +		 *
> +		 * To fix 2. clear the hci's can_wake flag, this way the hci
> +		 * will still be autosuspended when it is not open.
> +		 */
> +		if (device_can_wakeup(&data->udev->dev)) {
> +			pm_runtime_allow(&data->udev->dev);
> +
> +			ret = pm_runtime_suspend(&data->udev->dev);
> +			if (ret >= 0)
> +				msleep(200);
> +			else
> +				bt_dev_warn(hdev, "Failed to suspend the device for CSR clone receive-issue workaround\n");
> +
> +			pm_runtime_forbid(&data->udev->dev);
> +
> +			device_set_wakeup_capable(&data->udev->dev, false);
> +			/* Re-enable autosuspend if this was requested */
> +			if (enable_autosuspend)
> +				usb_enable_autosuspend(data->udev);
> +		}
>  	}
>  
>  	kfree_skb(skb);
> 


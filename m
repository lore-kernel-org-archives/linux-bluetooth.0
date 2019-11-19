Return-Path: <SRS0=5+i7=ZL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2B7C432C0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 07:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D434C2230C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 07:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1XKPeYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfKSHoO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Nov 2019 02:44:14 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53372 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfKSHoO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Nov 2019 02:44:14 -0500
Received: by mail-wm1-f65.google.com with SMTP id u18so2021465wmc.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2019 23:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RKtwHBRY4GY5kx5h/FXOSmgjvoDJEJdyQ4l9ZMzMdLI=;
        b=I1XKPeYlI16+g0DARkW+4Wk7Ihrrvdp6c3TkzXob/fj10X2M/P8Nt6ZaUXRRq7NgeY
         nUiE4bJFFD0fFmjS8Yp6/b0jeBaPN7Qodw4P94zAy8spq2wJ8GEcOX73Xg80CHlnwy1e
         nhwUtkSLkkRnhbCcPClInxqH4s43Kd5z5vWl3apnMvh11wjX6tfxUV/mLR4twGeTPHKy
         Glj4OhgWPfOnlX2H8uE/M5sNu3lLYGOz/5MlrteLVaWN1Etc/l2kM/2dSH00UP2+b3/k
         RUoVLexXsicZgGdS6RH3b/e1f0lR/f8r5gLe1eIubNmWdwJ1/QdLKc62sgayEIm0XF4e
         J9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RKtwHBRY4GY5kx5h/FXOSmgjvoDJEJdyQ4l9ZMzMdLI=;
        b=AlaL60vPb+9Y8cYpYFUwyuRcAba2vWwLvt6AYhs4XlktXdAjUOT+/xuhiZg8TmwXU5
         iEgyAEnaki2jGLwyWSTcpY9TmSYZEMhkB4jB8p6PeXVO0g9dcLdc6LVND3c06lHtVL6J
         aK2Jo5AijxF6blZXzdZsfEFzKPkzCjXx4l5ZIYw+1Qpw0icSiKMpS1JOgNmeE11pD6zT
         s/UNLKsz47HjPONvImpP5pG60zcZ52+X/nd/iIh0Zw2gzk1IgF0UKAlowX7ms/E+GtRB
         vMorNIHXMR01rIMZn/JLJMOAWt3la760+peZ6TwrnlHChzT9WS/nWYnXx1Teo+7czAQK
         i4uw==
X-Gm-Message-State: APjAAAXcBL4Fpnf13yWu8iF48KntSdcGOX9xGoGKe8e6JiYh5ARu/xI4
        ObX9/TCg2NvQGEiDiicEyk8=
X-Google-Smtp-Source: APXvYqyTqoEu5JmagPhtOG8PzVRIWQw6OxxrjPnI2jIcdLZkb6eSWfSJAtK/+lNkHtmrNSv9KCijRw==
X-Received: by 2002:a05:600c:c3:: with SMTP id u3mr3542608wmm.35.1574149450050;
        Mon, 18 Nov 2019 23:44:10 -0800 (PST)
Received: from mamamia.internal (a89-183-91-150.net-htp.de. [89.183.91.150])
        by smtp.gmail.com with ESMTPSA id w7sm25470252wru.62.2019.11.18.23.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2019 23:44:09 -0800 (PST)
Subject: Re: [PATCH v2] bluetooth: bcm: Use HCI_QUIRK_USE_BDADDR_PROPERTY
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, Ondrej Jirman <megous@megous.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
References: <20191119060221.3297340-1-a.heider@gmail.com>
 <4DB6C9B7-8454-449C-90B4-4A1B3AD82495@holtmann.org>
From:   Andre Heider <a.heider@gmail.com>
Message-ID: <e813a126-f0fc-afe8-ad4c-5296f0a2dc06@gmail.com>
Date:   Tue, 19 Nov 2019 08:44:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <4DB6C9B7-8454-449C-90B4-4A1B3AD82495@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On 19/11/2019 07:16, Marcel Holtmann wrote:
> Hi Andre,
> 
>> Some devices ship with the controller default address, like the
>> Orange Pi 3 (BCM4345C5).
>>
>> Allow the bootloader to set a valid address through the device tree.
>>
>> Signed-off-by: Andre Heider <a.heider@gmail.com>
>> ---
>> drivers/bluetooth/btbcm.c | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
>> index 2d2e6d862068..9d16162d01ea 100644
>> --- a/drivers/bluetooth/btbcm.c
>> +++ b/drivers/bluetooth/btbcm.c
>> @@ -439,6 +439,7 @@ int btbcm_finalize(struct hci_dev *hdev)
>> 	btbcm_check_bdaddr(hdev);
>>
>> 	set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
>> +	set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
>>
>> 	return 0;
>> }
> 
> have you actually tested this? I might be mistaken, but the code that I read in hci_dev_do_open() would drop this into unconfigured state since HCI_QURIK_INVALID_BDADDR is still set.

I thought so, but double-checking something obviously failed...

What would be an acceptable solution to this 
HCI_QUIRK_USE_BDADDR_PROPERTY|HCI_QUIRK_INVALID_BDADDR situation?

Getting rid of the quirk in the driver in e.g. set_bdaddr() doesn't 
sound right.

How about:

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 04bc79359a17..7bc384be89f8 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1470,7 +1470,8 @@ static int hci_dev_do_open(struct hci_dev *hdev)
          * start up as unconfigured.
          */
         if (test_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks) ||
-           test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks))
+           (test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks) &&
+            !test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks)))
             hci_dev_set_flag(hdev, HCI_UNCONFIGURED);

         /* For an unconfigured controller it is required to

That works for me (double-checked this time ;)

Thanks,
Andre

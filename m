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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC5EC432C0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 05:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E0FD2084D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 05:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doa1m6Qa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfKSFze (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:55:34 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52420 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731359AbfKSFz2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Nov 2019 00:55:28 -0500
Received: by mail-wm1-f66.google.com with SMTP id l1so1755737wme.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2019 21:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=doijmZ707prcu5MSNI7PVZQ+wkSDhjtaYJHKYA5bf6o=;
        b=doa1m6QaFiYG0OylxzcowX5g60uPHJbLXDlVi0MZ5lP/Ar+wvW0izGEwO1Lq5nqs79
         uh2iL+zs9OvhdfuBh1qGtKMsXtFG3b5gXANjiZF1IXvS+fyqV3L7fQ00HMCnzwGOLZ6n
         DItbGHK6yzMUy5OZ5pYOHQIbuDTDFBEAgPHidw1t7RQDBOPMbb582ZKgE/P5fIoDK54I
         sdg7uSeoeZW0OuybuF0QeGLGy1TtC1VpYIJbSqtETMxmBHQl7NhaqVHOHiW0Lf9bG5JO
         S0XqP2aBIdMa4EgrXAQo/HbIK4eqjLPGMDG1cUF17y6cT+5ospo0ZY/IUwGXB0Dnof1v
         ldPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=doijmZ707prcu5MSNI7PVZQ+wkSDhjtaYJHKYA5bf6o=;
        b=KhQy4+ANr7Nsa6qWm/UvT9GPIFxyg9d4ykVvwkO4wG3eu+ul6V/o4ob1ysz/N8CHYH
         IadEpLoSesBzQMAWogO0BQHAev3g1Tz5cgxRTBtkGRAZ+9mXrIDqwkrLC3U3/JLgnxKT
         dPaffPFqxlEhlzRzp/8KwFK0FX5LLTZEXgeh16Cg2zmUJPC+XofIRPZV48WjIMWQVrZ8
         RrHobXe3EpONJ2Jme5dbxsll/JjvCdaw/NNRV1t85iiZokb1gSNFgqRK+93kd8Kkztvj
         mtGXFeWgyhiNRcik11gbi5KbvZx+GIKDc1WVSIJkRbdxAOZY4HTq2nj7zglyFJTA486h
         U0Ow==
X-Gm-Message-State: APjAAAXRGrZvizL3b8o/uKWwLLxsxJK/GOLyhaOoM+LlCfdo8vbTARkc
        YnmGI2omNYBJ6zfFA92hg9Us8eYh
X-Google-Smtp-Source: APXvYqxZHeISDyMwymvRwxfzXzxPNg/juAgSE83rudTJuE3fPQaQdNhVqpnw9JUP4bikRB5Ut69vUg==
X-Received: by 2002:a1c:dd45:: with SMTP id u66mr3304656wmg.12.1574142926680;
        Mon, 18 Nov 2019 21:55:26 -0800 (PST)
Received: from mamamia.internal (a89-183-91-150.net-htp.de. [89.183.91.150])
        by smtp.gmail.com with ESMTPSA id w19sm1809363wmk.36.2019.11.18.21.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2019 21:55:26 -0800 (PST)
Subject: Re: [PATCH] bluetooth: bcm: Set HCI_QUIRK_USE_BDADDR_PROPERTY for
 default addresses
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, Ondrej Jirman <megous@megous.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
References: <20191118124930.2138112-1-a.heider@gmail.com>
 <C93EA7BC-7CCF-48B1-80DA-FD8DF8F5AF53@holtmann.org>
From:   Andre Heider <a.heider@gmail.com>
Message-ID: <7d81ea5d-2c78-bf6b-e665-17c774785564@gmail.com>
Date:   Tue, 19 Nov 2019 06:55:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <C93EA7BC-7CCF-48B1-80DA-FD8DF8F5AF53@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On 19/11/2019 06:17, Marcel Holtmann wrote:
> Hi Andre,
> 
>> Some devices ship with the controller default address, like the
>> Orange Pi 3 (BCM4345C5).
>>
>> Allow the bootloader to set a valid address through the device tree.
>>
>> Signed-off-by: Andre Heider <a.heider@gmail.com>
>> ---
>> drivers/bluetooth/btbcm.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
>> index 2d2e6d862068..e1471777486e 100644
>> --- a/drivers/bluetooth/btbcm.c
>> +++ b/drivers/bluetooth/btbcm.c
>> @@ -79,7 +79,7 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
>> 	    !bacmp(&bda->bdaddr, BDADDR_BCM43341B)) {
>> 		bt_dev_info(hdev, "BCM: Using default device address (%pMR)",
>> 			    &bda->bdaddr);
>> -		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
>> +		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
>> 	}
> 
> I am not sure the change is this simple. What happens if you run on a boot-loader that doesn’t provide the address and has an invalid address.
> 
> When I allowed HCI_QUIRK_USE_BDADDR_PROPERTY to be added, I stated clearly that the intent was that userspace can handle the address setup and this was pretty much just for the existing hardware where we have some magic boot-loader to do this.
> 
> Anyhow, I am fine allowing this here as well. However the HCI_QUIRK_USE_BDADDR_PROPERTY needs to be set unconditionally in the hdev->setup routine. And in case there still is an invalid address we need to stick with invalid address. Right now the code in hci_dev_do_open() operates differently.

Okay, will send a v2 with the quirk set in btbcm_finalize() (like 
HCI_QUIRK_STRICT_DUPLICATE_FILTER).

Thanks!
Andre

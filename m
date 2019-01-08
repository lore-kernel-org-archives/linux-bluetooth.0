Return-Path: <SRS0=sr2f=PQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBE0C43387
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jan 2019 16:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7BCB2087F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jan 2019 16:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=invoxia-com.20150623.gappssmtp.com header.i=@invoxia-com.20150623.gappssmtp.com header.b="uxKiQ7UZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfAHQDd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:03:33 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:41630 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbfAHQDd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Jan 2019 11:03:33 -0500
Received: by mail-ed1-f44.google.com with SMTP id a20so4713596edc.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jan 2019 08:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=invoxia-com.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=NS7UrKjKfB39uXz2TonhfMQ9EE6OP1WyZLo2R5juDnw=;
        b=uxKiQ7UZ43NhtS8/oJwGPVjeZw/yTug6wq01ru64Lgj+U8UmhZxNXOI8iLDdr1a7Ah
         9ud+LB9/cM+X5nm5Qq2DrWT5bXJPRlw0UlwjBh05l0V5VaZCJngl45bN7tTQPBlJamts
         KH4edxaUw+FiCizfzwCC31imnivB3hlJ0dixkb5XBn9zZO7tLZhxQ4UPI6QlWRMayNYm
         Aj0LFRQ2onHBOmJGatv0fJgzIVs96VKIN55TtbG8Qz31PeN5sSnOgLd3nBEJyBGB/rgk
         gGU2fbsevEDcS1E03hHW7NYoIk3K1Na4CsFKN6CZ3rDHtP88xiEc1Wt0icI5N1VOrhUf
         CHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=NS7UrKjKfB39uXz2TonhfMQ9EE6OP1WyZLo2R5juDnw=;
        b=C2tmAPeK/zb2BR16cEJg9FTJDsX5V0nUjdnuS4nhRHE0xn0IeJrEkfeuEttZwAIi/9
         xAnTzQRyNmbO2xo7Ue1jiXgHjuMOt5Ruc1GwMBw69R0i8EuWlQCW/QmMP3xsO1fieqZf
         3TAlaZBBTgnnLZqsoDGI16ZRaTy6YCptOKZI20ff6bCM7LMmXOu8SXwImzst8zudsPxK
         zZfE615mhOyHrmp/8OTfdjVRR+HzVbLLjeeWp9qy5xrwWsBvEjFzIukcrED9+fLI44HJ
         1a/QazraDZKk4tUSrxUFFVwcoEqnXqGR79NlLkICbTVyS8l2oTDFQkmpNq4XK42CBET2
         KQsQ==
X-Gm-Message-State: AJcUukeGYI7RBPL/5Zh6awgZYfPDRQ9m/RbuVwBBo9/UQUbOYGBYULKg
        +WvGnpUZi4ag60ZJgvquXhMkU243+Lg=
X-Google-Smtp-Source: ALg8bN4SCVM2mYfrpnhzVu4/EP4VpS8u6ziJAfPGvpI+KW8FZrh5YFxxGewSkDJ+DC5aiXVfZTd4eg==
X-Received: by 2002:a50:b006:: with SMTP id i6mr2697273edd.84.1546963411595;
        Tue, 08 Jan 2019 08:03:31 -0800 (PST)
Received: from [172.16.46.1] (89-158-71-12.rev.numericable.fr. [89.158.71.12])
        by smtp.gmail.com with ESMTPSA id x58sm102253edm.10.2019.01.08.08.03.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 08:03:30 -0800 (PST)
To:     linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
From:   Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Subject: Bug: no PropertiesChanged signal for
 org.bluez.Device1.AdvertisingData
Message-ID: <c23a8986-5654-275c-26a8-9f9a4bf5d005@invoxia.com>
Date:   Tue, 8 Jan 2019 17:03:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Luiz,

I was playing with latest sources (git) and experimental features 
enabled in order to:
- perform a BLE scan
- find AdvertisingData (in particularly the BT_AD_INDOOR_POSITIONING (0x25))

I found that:
- once scanning is done org.bluez.Device1.AdvertisingData is correctly 
set to the expected value (the one advertised)
- yet, there was no PropertiesChanged signal corresponding to this 
AdvertisingData property update (despite I received PropertiesChanged 
for RSSI)


Indeed src/device.c:: add_data() performs a particular filtering to only 
signal EIR_TRANSPORT_DISCOVERY data.

> static void add_data(void *data, void *user_data)
> {
>     struct eir_ad *ad = data;
>     struct btd_device *dev = user_data;
>
>     if (!bt_ad_add_data(dev->ad, ad->type, ad->data, ad->len))
>         return;
>
>     if (ad->type == EIR_TRANSPORT_DISCOVERY)
>         g_dbus_emit_property_changed(dbus_conn, dev->path,
>                         DEVICE_INTERFACE,
>                         "AdvertisingData");
> }

Is there a particular reason for this behavior ?

Regards,
Arnaud


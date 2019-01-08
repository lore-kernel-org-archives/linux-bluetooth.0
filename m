Return-Path: <SRS0=sr2f=PQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB9AC43387
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jan 2019 19:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1EB6206BB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jan 2019 19:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=invoxia-com.20150623.gappssmtp.com header.i=@invoxia-com.20150623.gappssmtp.com header.b="kfuDG1gu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfAHTAy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:00:54 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44044 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbfAHTAy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Jan 2019 14:00:54 -0500
Received: by mail-ed1-f67.google.com with SMTP id y56so5236157edd.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jan 2019 11:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=invoxia-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=FXusNeX+OL7MINuxmxZ4My+lLZkytxxB+Ly4dEJ3sOw=;
        b=kfuDG1gu7gOE+oyWDQgQQAXEvWkyKBLFHhIl9Nudil8ccGmClZ2jwsmQHwdiJsDSmx
         AJfZHbbkt130eI4zziyNH8BZpVbGdonz+fACnaBZh0p5hD/j6Ckcr9r0RJyyzlAKZnGe
         0FcoQ009YT7FWw3PWINNX4Ipa11FDbocY6YGgER45vDaP44w/vL6r1iPWJJaijklBPv4
         MDzy/PatO2tdognp+XJxkniYKsbYU0eJSSHkQ3/T2gTeXuJ1EGDiqr0H0OonvhSnkw//
         PPnoFlg7O40V2Kw3HE4eRou6bYtO5uDkNRDKyUkTIqYtxeFD+NxbB2jJ8k7fAiXtlhYs
         TMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FXusNeX+OL7MINuxmxZ4My+lLZkytxxB+Ly4dEJ3sOw=;
        b=Kohkz1yf9ZNNcB06Ctt8SeXknFVKhVotn2EkEgXYryztDqfOJJoIZ411gg75GSixzR
         w2X7yn6Zu1+ruzgRjEOj3BXqaluJcmnXrIBXG4TiOr48Tu24aoCXPpjW0yvsDVKFT94H
         uKA4Ham/mCyd5QYtMd1z+rrV++iOYnetmt1H6DIeUSr+ievvJzwkYQFyxr/8jGZSQ85j
         UvdgnFlKhAwgGcNsSpRptbR4KfMK6WMvdFnQG/psRLdVZbPFOxGQKU4GJ5UTUGSlUXYi
         crIAOgMmdt8l+T573JeIyaa+X96XUmF/ErRR4w26PJz1nOTYJRVI7lAYI33yIZ+tQZ9+
         Ciew==
X-Gm-Message-State: AJcUukeOKux8Tx3FhePFqzT+KV8NkqefCgZGZiNHxV1EebpdZ9+jnouE
        om5D7hJ9HR/SxvYEhjysWS7Kd+L9R4Q=
X-Google-Smtp-Source: ALg8bN7mabo+3h+gQ3OfPAZ86EZ/hoTUMNdv5XtF6IeqCWsYjr8d8pAq9r62yEwRct9AShGfpnCOyA==
X-Received: by 2002:a50:bb2c:: with SMTP id y41mr3230509ede.147.1546974052115;
        Tue, 08 Jan 2019 11:00:52 -0800 (PST)
Received: from [172.20.10.5] ([92.184.96.146])
        by smtp.gmail.com with ESMTPSA id r8-v6sm541195ejb.52.2019.01.08.11.00.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 11:00:51 -0800 (PST)
Subject: Re: Bug: no PropertiesChanged signal for
 org.bluez.Device1.AdvertisingData
To:     "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
References: <c23a8986-5654-275c-26a8-9f9a4bf5d005@invoxia.com>
 <CACumGOJrN1LFBb6uuH1T92eirzQyUMuai1qQ8SeipzJb=bvHUg@mail.gmail.com>
From:   Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Message-ID: <5161f3b4-1c6b-6c53-4e6f-6f57ba12d3e5@invoxia.com>
Date:   Tue, 8 Jan 2019 20:00:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CACumGOJrN1LFBb6uuH1T92eirzQyUMuai1qQ8SeipzJb=bvHUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Luiz,

On 08/01/2019 17:12, Von Dentz, Luiz wrote:
> Hi Arnaud,
>
> On Tue, Jan 8, 2019 at 1:03 PM Arnaud Mouiche
> <arnaud.mouiche@invoxia.com> wrote:
>> Hello Luiz,
>>
>> I was playing with latest sources (git) and experimental features
>> enabled in order to:
>> - perform a BLE scan
>> - find AdvertisingData (in particularly the BT_AD_INDOOR_POSITIONING (0x25))
>>
>> I found that:
>> - once scanning is done org.bluez.Device1.AdvertisingData is correctly
>> set to the expected value (the one advertised)
>> - yet, there was no PropertiesChanged signal corresponding to this
>> AdvertisingData property update (despite I received PropertiesChanged
>> for RSSI)
> Is the Data changing? If you want to get informed of each
> advertisement regardless if it has changed you should set
> DuplicateData filter:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/adapter-api.txt#n107
>
> If that doesn't work then perhaps we have a bug somewhere.

Yes "duplicate" is true

>
>> Indeed src/device.c:: add_data() performs a particular filtering to only
>> signal EIR_TRANSPORT_DISCOVERY data.
>>
>>> static void add_data(void *data, void *user_data)
>>> {
>>>      struct eir_ad *ad = data;
>>>      struct btd_device *dev = user_data;
>>>
>>>      if (!bt_ad_add_data(dev->ad, ad->type, ad->data, ad->len))
>>>          return;
>>>
>>>      if (ad->type == EIR_TRANSPORT_DISCOVERY)
>>>          g_dbus_emit_property_changed(dbus_conn, dev->path,
>>>                          DEVICE_INTERFACE,
>>>                          "AdvertisingData");
>>> }
>> Is there a particular reason for this behavior ?
> If I recall this is not to spam the bus if we are not actively discovery.

I did some tracing and the "ad->type == EIR_TRANSPORT_DISCOVERY" test is 
the one filtering the property change signal.

Should we set a white/black list for this kind of filtering ? or 
something else... ?

Regards,
Arnaud


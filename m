Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74108C432BE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Aug 2021 15:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56D0E60E90
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Aug 2021 15:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbhH0PUR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Aug 2021 11:20:17 -0400
Received: from vern.gendns.com ([98.142.107.122]:44336 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233884AbhH0PUQ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Aug 2021 11:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xyugD9XURWHEhBQOcK+S4YvMM0JA0+in/JFI9XRRUvw=; b=h97k+AyL8/zP8t40UAqbZEP8yX
        +rDxGs03Xpf7O8FJ4Dxv4CKUw/nt59r6s6jvz6O09EezS1LDg4cmwZDvK6oZ7KkWXhZCm+uJUtAZq
        BmSSDs27q113Dbq84pteaUAM8OeZM/QqdHot12zBG2J23CojlJHm+Z8aS/pj1Myf2wTEEYzF9LXpx
        WLXMwIzZ7B82PG9xYTC0NzluO1GnX0WNmMTYW3fiobm4vCEyKpulXYOaY4+MwOcFqbNbHfAMgV+WZ
        2Ro6rpmQNjR+vGY6K6wo1PB5KfpL3+A0itjGmgk/vOIBYBykZQ/BukOcAFv3wO1lEVaHUiqlowqaZ
        vc0ime2w==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:53942 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1mJddR-00020D-8q; Fri, 27 Aug 2021 11:19:26 -0400
Subject: Re: [PATCH BlueZ] device: add MTU D-Bus property
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20210826164211.2936133-1-david@lechnology.com>
 <CABBYNZK9-0b0O_FOzYQ8+iB-dDqC0RHxLCBkN8TibR2opJoD=A@mail.gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <d2341c21-eb1f-5e14-5420-eae5b0a872c6@lechnology.com>
Date:   Fri, 27 Aug 2021 10:19:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CABBYNZK9-0b0O_FOzYQ8+iB-dDqC0RHxLCBkN8TibR2opJoD=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 8/26/21 8:17 PM, Luiz Augusto von Dentz wrote:
> Hi David,
> 
> On Thu, Aug 26, 2021 at 9:45 AM David Lechner <david@lechnology.com> wrote:
>>
>> When using GATT write without response, it is useful to know how much
>> data can be sent in a single write. This value is the negotiated MTU
>> minus 3 bytes.
>>
>> The D-bus method org.bluez.GattCharacteristic1.AcquireWrite returns the
>> MTU exactly for this reason. However, when using the alternate API
>> org.bluez.GattCharacteristic1.WriteValue with the options dictionary
>> { "type": "command" }, there is no current way to get the MTU value.
>> If the value is too large, then the method returns "Failed to initiate
>> write" [org.bluez.Error.Failed].
> 
> In most cases the MTU is not that useful since each attribute has a

Access to the MTU has been a highly requested feature in
WebBluetooth[1] with reasonable use cases.

[1]: https://github.com/WebBluetoothCG/web-bluetooth/issues/383

> maximum length of just a few bytes, the MTU is only really useful for
> control points which I rather have using Acquire* variants. Note that
> for long values the attribute must support Write Long Procedure and
> afaik WriteValue does support that so it can fragment the data and
> send according to the MTU.

I'm coming at this from the cross-platform point of view. Windows,
Apple and Android don't have an equivalent of AcquireWrite. They have
device-level methods/properties to get the MTU [2][3][4]. So instead
of forcing WebBluetooth to have an API compatible with AcquireWrite
it would be very nice to be able to get the required information
in a different way that is similar to the existing methods on other
platforms.

Maybe there are better alternatives to get the same information?
For example, the Apple API doesn't actually mention MTU, but rather
allows you to get the maximum write size for Write Without Response,
which I think is the value most use cases need (it just happens to
be MTU - 3).

[2]: https://docs.microsoft.com/en-us/uwp/api/windows.devices.bluetooth.genericattributeprofile.gattsession.maxpdusize?view=winrt-19041
[3]: https://developer.apple.com/documentation/corebluetooth/cbperipheral/1620312-maximumwritevaluelength
[4]: https://developer.android.com/reference/android/bluetooth/BluetoothGattCallback.html#onMtuChanged(android.bluetooth.BluetoothGatt,%20int,%20int)

> 
>> This adds an "MTU" property to the org.bluez.Device1 interface that
>> is emitted in gatt_client_ready_cb() which is after the MTU exchange
>> has taken place.
> 
> This would not work for the likes of EATT which don't require rx and
> tx MTU to be symmetric, with the likes of Acquire we could in theory
> even assign a dedicated EATT channel if we have to.
> 



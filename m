Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64826C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Nov 2021 07:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45AF560EDF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Nov 2021 07:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhKBH5a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Nov 2021 03:57:30 -0400
Received: from tropek.jajcus.net ([31.179.132.94]:42842 "EHLO
        tropek.jajcus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbhKBH52 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Nov 2021 03:57:28 -0400
Received: from [192.168.15.1] (jajo.eggsoft.pl [84.10.21.138])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by tropek.jajcus.net (Postfix) with ESMTPSA id 0CA1685059;
        Tue,  2 Nov 2021 08:54:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jajcus.net; s=mail;
        t=1635839693; bh=luftr/ReTW+wI0UxwvT9/09UWbEDC+V9OnwqOWB8eJY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kxreQi3r5Qev2M+qBo4g1lJY+wx/aCvbS+kkm/qkUXuwOhgobY25IyICeMb9dGPVS
         ClMMR1D2EDzthpGlqIhcBgTf+XEtT9udH9djqQ3okFEZInInjomh9fQRKhZAIW0GAx
         xEkK6CoY78uY/0jpukBPpIb+2Be80WTYnMh5rCsd+LHXLEht+yqopbRPQfsFTzmeOy
         6vLzMFUa/M+TdnnqhDjFdHoYgWYPxfU/bhFMR0SJY1p99mIpSsZWBB0j0SVDP6ht4e
         pX/bSwsDIKiTHK34rE+XXKXQnIcMqjA273M01Mbnw/J30aglwWUbC6DGculnyUctKG
         CWCYmr+x+KoPg==
Subject: Re: Is there a way to force legacy LE pairing for a device
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <585f70ee-e8f0-dfbc-6d61-f5082a1c18aa@jajcus.net>
 <CABBYNZ+fffyc-wmbHn+Ecy-y3mqOgXVn2xbQARyaXnVras6tBw@mail.gmail.com>
From:   Jacek Konieczny <jajcus@jajcus.net>
Message-ID: <243d971d-54fd-f00f-ec14-8e58b03e635c@jajcus.net>
Date:   Tue, 2 Nov 2021 08:54:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+fffyc-wmbHn+Ecy-y3mqOgXVn2xbQARyaXnVras6tBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On 01/11/2021 21:21, Luiz Augusto von Dentz wrote:
> 
> On Mon, Nov 1, 2021 at 10:26 AM Jacek Konieczny <jajcus@jajcus.net> wrote:
>> So it looks like 'Bonding, MITM, Legacy, No Keypresses' used by Android
>> works and 'Bonding, No MITM, SC, No Keypresses, CT2' used by the desktop
>> Linux (bluez 5.62, kernel '5.6.2-050602-lowlatency' from Ubuntu) does
>> not (note: I am still quite ignorant about Bluetooth stuff).
> 
> What android version are we talking about here?

Android 11 on Samsung Galaxy S10 with current software.

>> So my question is: is there any way to force using legacy pairing? Even
>> if that requires bluez or kernel patching (though, I would rather avoid
>> that).
> 
> So Invalid Parameter is normally used when the stack doesn't
> understand something in the request:
> 
> 'x0A Invalid Parameters The Invalid Parameters error code indicates
> that the command length is invalid or that a
> parameter is outside of the specified range.'
> 
>  From the looks of it Android doesn't set SC nor CT2, which were bits
> introduced after 4.0, so perhaps with this version of Android we
> cannot use one of these bits (CT2 most likely).

The problem is not the Android, but the device I am trying to pair with 
(VOX Adio Air GT guitar amplifier). The Bluetooth implementation in the 
device is most probably outdated or/and broken and definitely insecure, 
but I still need to connect to it. Android can do that, I wonder how I 
can do it from a regular Linux machine with recent kernel and Bluez.

Jacek

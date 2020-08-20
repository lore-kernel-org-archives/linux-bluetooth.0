Return-Path: <SRS0=lMkY=B6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620B7C433E1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Aug 2020 11:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32F46204EA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Aug 2020 11:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbgHTLjQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:39:16 -0400
Received: from s01.spamexperts.axc.nl ([185.182.56.9]:44457 "EHLO
        s01.spamexperts.axc.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729248AbgHTLis (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Aug 2020 07:38:48 -0400
Received: from vserver85.axc.nl ([185.182.56.185])
        by s01.spamexperts.axc.nl with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <dave@daveborghuis.nl>)
        id 1k8iu0-000184-Ov; Thu, 20 Aug 2020 13:38:44 +0200
Received: from mail.axc.nl ([185.182.56.42])
        by vserver85.axc.nl with esmtp (Exim 4.94)
        (envelope-from <dave@daveborghuis.nl>)
        id 1k8itz-00Dzqn-4h; Thu, 20 Aug 2020 13:38:39 +0200
Subject: Re: Cant see Android Covid Exposure notification beacon (no problem
 with iPhone beacons)
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <b39b3395-ad80-bf76-caea-490666cea671@daveborghuis.nl>
 <CABBYNZJysyOYZPWVd1Cpq7C055G2Pwdu+x_9WaFfZUzDb-4_YQ@mail.gmail.com>
From:   Dave Borghuis <dave@daveborghuis.nl>
Autocrypt: addr=dave@daveborghuis.nl; prefer-encrypt=mutual; keydata=
 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 0G/D
Message-ID: <db7877d0-0a9e-f855-bd18-89ce353e9499@daveborghuis.nl>
Date:   Thu, 20 Aug 2020 13:38:38 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CABBYNZJysyOYZPWVd1Cpq7C055G2Pwdu+x_9WaFfZUzDb-4_YQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: nl
PrimaryMX: Accepted email from trusted host.  Hint: This skips spam scanning so make sure other host is not vulnerable
X-Relay-Host: 185.182.56.42
SpamTally: Final spam score: -63
X-AuthUser: 
X-Originating-IP: 185.182.56.185
X-SpamExperts-Domain: vserver85.axc.nl
X-SpamExperts-Username: 185.182.56.185
Authentication-Results: spamexperts.axc.nl; auth=pass smtp.auth=185.182.56.185@vserver85.axc.nl
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.16)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0Uc1Z+hCSaILZIw3vLzlsGSpSDasLI4SayDByyq9LIhVy72u9v+dq/hO
 wcZEck9qmkTNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3KbXsLA0HlioK7txFnPQvbtbLk
 8R5mlgIwJEelNeTC3y0tOnqq+qab2kdwzh4p3GS5O5cjn8T7dzW71VxAlAoGW3D8zY6MLb0C+wr8
 sSGhK4Naa40DxZPJuLUk3zkVKd8p4CuEXwMMCcu55/Z5CMTXnK0Y7LCaYwq5D2n+PKAHF2SHOoHk
 jMut1ww/VHX1ly+ajz2jsX3korpGxdnK+ek4CMztdQUSqk/AeLi65+4s/LrywTM2yEHEhvC9Izsy
 /NENTMQ3Kg3hL2oXz5A5E5R/dS4GkJ5hfB+qWugfDEytZYqsHHT1RBQQLep6oz6Esv5JPZ42IfQH
 uktp5FTyHYGk267On8qMjxGbEIr+mFEcSBgsZIsLqaY1UeS+5B0bzsw6rMNJRrRpQSU11Ur/Gkm4
 amRc11xjO4+/snCCXc1RuVYFnr74N+RNWUFaxHlAaSW5eQX2hj4u3ZszoJwAxH6lxrR1IoyVcpAX
 xfUeXJw8PSKZyxi/aFboTUAaA09dklP/aIfVaCHpEB6cFH6WJxE4Zn+QHsYhW4W1sTO58EglJ5WC
 dveE7Y243Xbui/edkaGx5r2tx94jvSB0QQoIKsEAe1d/+NO4YR0A5YIZlsSkH5eOlWoOfH3PRLfk
 +7v5u57EGlTMCNh/GVYg/nv+z8zJJOeURvP7468+f+EGtWkSZL30hAicGM9TsPk6o5pKicqhH6gt
 CBe9JhEFklSFD9M9pPvNWU8BvYorU4xuHEB26rPImfuctUHJ3IWIjmuymvwK3R1W5CR9pPgnkojE
 nIFUcf8Fys7PofM8bqcKCam/1/U3ClTXlSfQV8rvfnHgqk4U9IQInBjPU7D5OqOaSonKoUnIqv6a
 nXFjYar+fT2UxK+2mhKsoikQ3v+3MBjtrLsOJk4KMrD/VUxugdxDLVa2jg40M5gm6TR9mEGRUtCa
 fc6PptSRQ17SSMcjhqOgGhuvxypUhWZ7DV/QthUn4wTjFg==
X-Report-Abuse-To: spam@s01.spamexperts.axc.nl
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,
>> So is there something I can do to enable to see Android Covid exposure
>> notification ? Do I something wrong or is there a bug in the bluez stack?
> You probably will need to set some filtering since the advertisement
> may not be 'visible', you can try with:
>
> bluetoothctl> scan.transport le
> bluetoothctl> scan on

I scan now with the filters :

> scan.transport le
> scan.uuids 0xfd6f

This gives the expected result. So the bluetoothstack itself seems to
work ok. Thanks for the tips.

Good, now I know I have look at the python layers. I think something in
the beacontools is going wrong, I will check there of find a
alternative. already have a plan B, using a external ESP32 that show all
the beacons.

> Is there any specification available for such beacons?

Sure there is, see :
https://covid19-static.cdn-apple.com/applications/covid19/current/static/contact-tracing/pdf/ExposureNotification-BluetoothSpecificationv1.2.pdf

Regards,

Dave






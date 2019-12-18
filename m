Return-Path: <SRS0=1j7M=2I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71587C43603
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Dec 2019 20:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E06218AC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Dec 2019 20:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="og+p++J3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfLRU56 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:57:58 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42873 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbfLRU55 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Dec 2019 15:57:57 -0500
Received: by mail-oi1-f196.google.com with SMTP id 18so1185644oin.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Dec 2019 12:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GBfCGFscXS+CO2F2wci1nvx0B9N8Rd80qSc9P9QOqTQ=;
        b=og+p++J3t+/FJtMbpH282MsHdcHBMc0jWnhy/0Cl2WadR7c6EYX8HAvczUl9DAzXrD
         o4/xh95zBln2ZD1M0oSvP0Vp41BIotzrzUigDhnbV3blFEZ8g9JBpHzI7/uwURhPSOs8
         6fE6vdvwocS/P+KgRM2fdOxcBJqj/68qFbZbZOFDlKqdXPskZ5byRItiyF5nqBGGFzsa
         DVyENgcnLjwqAEfmYbxHKghDvTbVQqxL2+K2fMPk3FttSkLOqRKJssneNWQsA4vvIaEx
         7aO9ZTEdvwQj+lEvwXcNBySGzPLGIWbFXvYKmO/DUw6nA+ucDCAk8KAr9archLr2C2dS
         6I8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GBfCGFscXS+CO2F2wci1nvx0B9N8Rd80qSc9P9QOqTQ=;
        b=rdviKLXRuDDINvAzqeiQ9YFOyKymztk5m80GhGD9bsprjtvJX4CJ1/beNmM0nxLOIU
         7cXSuxLvLb5HL6tMNIW+7BXsilhYRUfsijneZS7i5VWsUxFqnDq3AfZHUKdIaa88GO57
         F54gqrXULyl2DwkvqYcoXUtFQ7yQH9Hq/WX7YNk4jmuvthz5XPpPraUQnCf/U67v4JOM
         09nWL6t+ajnA9t2b5n/+mEjoEeX9vuuKLgYWO/p5J3dRaPm2pIVT6gi9skQMeBjevnJK
         lRo4KqkGP/OdV/VVFqAygHUrPAazFpIcRI1U1lm1o9g4kPsHg0nw3M2b82Ff45NEQ1RO
         Sx4w==
X-Gm-Message-State: APjAAAV+kY7RdWJBXvre34IDqtG/oZ7DdHv74jqAl1UpRSkActzbQca0
        +zjbih68EkqHrg5rhuxLH0A=
X-Google-Smtp-Source: APXvYqwZgmddI4kqElYPOIj7x9BKmwX8yf+qGUGhOCSWklcpsFQt/eYdMKzr30wkvoNrilkrjOy0GA==
X-Received: by 2002:a05:6808:a8e:: with SMTP id q14mr1344021oij.173.1576702675853;
        Wed, 18 Dec 2019 12:57:55 -0800 (PST)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id u11sm1198817oie.53.2019.12.18.12.57.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 12:57:55 -0800 (PST)
Subject: Re: [pulseaudio-discuss] Proposal for a new API and usage of
 Bluetooth HSP and HFP profiles on Linux
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Tanu Kaskinen <tanuk@iki.fi>,
        General PulseAudio Discussion 
        <pulseaudio-discuss@lists.freedesktop.org>, ofono@ofono.org,
        devkit-devel@lists.freedesktop.org,
        Bastien Nocera <hadess@hadess.net>,
        Georg Chini <georg@chini.tk>,
        Russell Treleaven <rtreleaven@bunnykick.ca>,
        Arun Raghavan <arun@arunraghavan.net>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sre@ring0.de>, Pavel Machek <pavel@ucw.cz>
References: <20191201185740.uot7zb2s53p5gu7z@pali>
 <508d35f29c2abc26af15e232a38d3ca53eb33706.camel@iki.fi>
 <20191202184512.rx6p63c6axztnwrw@pali> <20191205093200.x47npi5sxtcphr2o@pali>
 <CABBYNZKi7UUg7kASKadGr7sDJH0-tfuuZr9rd4Xu8ZUA9LqTMA@mail.gmail.com>
 <20191216091521.reh2urr25husschv@pali>
 <3ca53c66-1df0-41bf-710e-dea709906234@gmail.com>
 <20191218172828.vfie4su2whts2fqh@pali> <20191218173632.aqdmdhutu3ruezck@pali>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <06eb7e98-1357-afd1-40a5-2ccb139d8dec@gmail.com>
Date:   Wed, 18 Dec 2019 14:53:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191218173632.aqdmdhutu3ruezck@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

>>> I'm not sure what logic around HSP you really care about.  It is just a
>>> single button press in the end.
>>
>> CSR features (battery status level, ...) and CSR codec selection (e.g.
>> AuriStream). Also some apple extensions are used in HSP profile.

Since HFP can do everything that HSP can and more, I view HSP as 
deprecated and not to be used.  If these are also available in HFP, then 
I'd just use HFP instead.  But HSP was never my focus, so if you feel 
there's a need for better HSP support, then fair enough.

>>
>>> For HFP, oFono can already support all sorts of extensions.  See for example
>>> how we handled Siri for HFP support in oFono here:
>>> https://git.kernel.org/pub/scm/network/ofono/ofono.git/tree/doc/siri-api.txt.
> 
> About Siri: In hsphfpd API it is delegated to Telephony Agent. So
> hsphfpd is not going to (re)implement it.
> 
>> I saw. But it does not support usage of vendor codecs, like CSR
>> AuriStream and it does not support CSR extensions, like displaying text
>> on embedded display.

But that's my point, you can easily accomplish this by creating another 
oFono API / atom for HFP CSR extensions and expose this information / 
functionality.  Similar to how Siri was done.  I see no need for a 
completely new external daemon.

>>
>>> Many of the extensions you talked about are also relevant for real modems as
>>> well (like battery reporting, call volume, etc).  Some of these APIs are
>>> already defined in fact.
>>>
>>> Given the above, oFono upstream has no interest in adding or maintaining
>>> support this new framework.
> 
> Maybe better question: Do you mean that you do not want to maintain
> hsphfpd, or that you completely do not want to see that ofono would be
> "Telepony Agent" for hsphfpd?

The latter.

> 
>> Denis, if you are not interested in my proposed hsphfpd daemon, how you
>> want to solve problem with other extensions and other vendor codecs?
>>

See above..

>> Also in my proposed solution it is possible to use HFP profile without
>> Telephony Agent (ofono). Do you think it is really a good idea to have
>> strong dependency on ofono just for bluetooth HFP headset?
>>

Why not?  The main purpose of HFP is telephony; whether it is classic 
phone calls or skype/facetime.  oFono seems a natural fit.

>> Also for using ofono with HFP profile is not possible on desktop
>> computer which do not have any modem as it is hooked to some active
>> modem.

This statement is not true at all.  You can use oFono without any 'real' 
modems attached.  It can happily manage only HFP devices (or modems as 
we call them.)

>>
>> There is a way to use ofono sim simulator which provide fake modem, but
>> its setup is hard on desktop and it not automated.
>>

You must be thinking of the oFono HFP AG implementation...

>> So connecting bluetooth headset in HFP profile with ofono is something
>> not so easy and not an obvious way.
>>

Again, not true.  As I said above, you can use oFono for this use case 
just fine.  Certainly the main driver for the development of oFono was 
to drive real modem hardware, but it isn't limited to that.  So if you 
want to use it only for HFP, you can.

Regards,
-Denis

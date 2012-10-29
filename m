Return-Path: <cyrus@holtmann.org>
Message-id: <BEF31D2DB68849E182704E6741C8D435@sisodomain.com>
From: Syam Sidhardhan <s.syam@samsung.com>
To: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
References: <1350999140-7481-1-git-send-email-s.syam@samsung.com>
 <1350999140-7481-2-git-send-email-s.syam@samsung.com>
 <1351003482.1785.28.camel@aeonflux>
Subject: Re: [PATCH 2/5] Bluetooth: Remove unnecessary include export.h
Date: Mon, 29 Oct 2012 20:33:47 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=utf-8; reply-type=original
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

----- Original Message ----- 
From: "Marcel Holtmann" <marcel@holtmann.org>
To: "Syam Sidhardhan" <s.syam@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>
Sent: Tuesday, October 23, 2012 8:14 PM
Subject: Re: [PATCH 2/5] Bluetooth: Remove unnecessary include export.h


> Hi Syam,
>
>> For files only using THIS_MODULE and/or EXPORT_SYMBOL, map
>> them onto including export.h -- or if the file isn't even
>> using those, then just delete the include.
>
> have you actually check this on other architectures like PowerPC or
> Sparc?
>

I have checked it only for Arm and i686 arch. I do not have other 
environment to check.
If any one has other architectures environment ready, kindly do the build 
and ack for it. Apart from
build, I have cross checked the code once gain to make sure that nothing 
breaks.


> commit 8c520a59927a5600973782505dbb750d985057c4
> Author: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> Date:   Wed May 23 04:04:22 2012 -0300
>
>    Bluetooth: Remove unnecessary headers include
>
>    Most of the include were unnecessary or already included by some other
>    header.
>    Replace module.h by export.h where possible.
>

Padovan,  In the above commit, you have explicitly added the
export.h in that commit. Did you face any error or warning
while building with out export.h?
Commit Reference: 
http://git.kernel.org/?p=linux/kernel/git/bluetooth/bluetooth-next.git;a=commitdiff;h=8c520a59927a5600973782505dbb750d985057c4#patch11

Thanks,
Syam 

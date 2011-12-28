Return-Path: <cyrus@holtmann.org>
Message-ID: <4EFAD4FB.4030909@visionsystems.de>
Date: Wed, 28 Dec 2011 09:36:11 +0100
From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Reply-To: yegor_sub1@visionsystems.de
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com
Subject: Re: bluez-4.97: check dependnecy
References: <4EF4582E.6020308@visionsystems.de> <1324659935.1965.259.camel@aeonflux>
In-Reply-To: <1324659935.1965.259.camel@aeonflux>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>> I was cross compiling bluez-4.97 under Buildroot and with the same configuration as for 4.96 configure failed by not being able to find check framework. Could this dependency be dropped if I don't want to compile tests? I mean it doesn't make much sense using check on x86 build host for arm binaries.
> yes, it can be dropped. We only need that for development. Care to send
> a patch for it.

I've seen and tested your commit regarding this issue. It work perfectly. Thanks.

Yegor

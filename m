Return-Path: <cyrus@holtmann.org>
Message-ID: <1324659935.1965.259.camel@aeonflux>
Subject: Re: bluez-4.97: check dependnecy
From: Marcel Holtmann <marcel@holtmann.org>
To: yegor_sub1@visionsystems.de
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com
Date: Fri, 23 Dec 2011 09:05:35 -0800
In-Reply-To: <4EF4582E.6020308@visionsystems.de>
References: <4EF4582E.6020308@visionsystems.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yegor,

> I was cross compiling bluez-4.97 under Buildroot and with the same configuration as for 4.96 configure failed by not being able to find check framework. Could this dependency be dropped if I don't want to compile tests? I mean it doesn't make much sense using check on x86 build host for arm binaries.

yes, it can be dropped. We only need that for development. Care to send
a patch for it.

Regards

Marcel



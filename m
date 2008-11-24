Return-Path: <cyrus@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <226D5095-C45F-49D8-8001-9D62F17D8122@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: Stefan Seyfried <seife@suse.de>
In-Reply-To: <20081110092009.GD11057@suse.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: compat/Makefile.am manpages fix / pand/dund question
Date: Mon, 24 Nov 2008 03:58:11 +0100
References: <20081110092009.GD11057@suse.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stefan,

> pand.1 and dund.1 are always installed. Fix below.

I fixed that already. Thanks for reporting.

> Then some kind of packaging question:
> I got users that request pand and dund. I am under the impression
> that this should be handled by the networking service, however was
> unable to find anything understandable on the WIKI where I can point
> them to.
>
> Am I still "allowed" to package pand and dund, e.g. in a "bluez- 
> compat"
> package? I guess that I should not package hidd, no matter how much
> users would like it, though ;-)

You can put hidd in bluez-compat if you like. It is useful for  
debugging since it can show the actual kernel state of the hidp.ko  
module.

Regards

Marcel


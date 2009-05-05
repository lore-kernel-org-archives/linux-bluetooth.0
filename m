Return-Path: <cyrus@holtmann.org>
Subject: Re: BT git version triggers BUG: scheduling while atomic:
 swapper/0/0x10000100
From: Marcel Holtmann <marcel@holtmann.org>
To: Hugo Mildenberger <Hugo.Mildenberger@namir.de>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <200905050301.37528.Hugo.Mildenberger@namir.de>
References: <200905050301.37528.Hugo.Mildenberger@namir.de>
Content-Type: text/plain
Date: Mon, 04 May 2009 18:12:53 -0700
Message-Id: <1241485973.3319.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hugo,

> When I tried to get a mobile phone connected to asterisk via bluetooth, the 
> current git version of the linux bluetooth stack triggers a kernel bug:
> 
> 	BUG: scheduling while atomic: swapper/0/0x10000100
> 
> This is triggered the moment when asterisk tries to pair the phone and leaves 
> at least the BT subsystem in an unusable state. 

are you running Linus' tree or bluetooth-testing.git? If your are not
running bluetooth-testing.git, then please try that one since it
includes a fix for it.

Regards

Marcel



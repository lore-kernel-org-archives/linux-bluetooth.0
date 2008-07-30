Return-Path: <cyrus@holtmann.org>
Cc: <linux-bluetooth@vger.kernel.org>
Message-Id: <DD9EC22E-3BA0-4D69-A17A-FA781C66E1B6@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: Roland Aigner <Roland.Aigner@orderman.com>
In-Reply-To: <6A4EB330DD166248AA1B8AFB38D26471019C26C8@exchange.orderman.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v928.1)
Subject: Re: BlueZ and Bluetooth Qualification
Date: Wed, 30 Jul 2008 08:57:16 +0200
References: <6A4EB330DD166248AA1B8AFB38D26471019C26C8@exchange.orderman.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Roland,

> Sorry if this question was asked before, but appearantly I am not good
> enough in finding the correct search terms ;)
>
> Scenario:
> I want to build a device which uses a BT-chipset from CSR, linux for  
> ARM
> (e.g. TI OMAP) and BlueZ for at least SPP usage.
>
> 1) If I want to sell this device with, what certifications and
> qualifications for BT would I need?

this needs a Bluetooth host stack qualification with SSP.

> 2) If I update the kernel/drivers/my own application (aka "firmware)
> would I need to requalify something?

Depending on what you change. This has to be decided case by case.

> 3) If I update the BlueZ version would I need to requalify something?

Again, case by case decision.

> 4) If I choose to add another profile to the system (e.g. Handsfree)
> would I need to qualify the whole system again or only the Profile I
> want to add?

If you build a modular qualification with components, then you can re- 
use components. If you do it as end-product, then you have to do the  
whole thing again.

Regards

Marcel


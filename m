Return-Path: <cyrus@holtmann.org>
Message-ID: <1325542990.1965.400.camel@aeonflux>
Subject: Re: Disabling Bluetooth also kills WiFi
From: Marcel Holtmann <marcel@holtmann.org>
To: Milan Bouchet-Valat <nalimilan@club.fr>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 02 Jan 2012 14:23:10 -0800
In-Reply-To: <1325457984.19462.3.camel@milan>
References: <1325457984.19462.3.camel@milan>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Milan,

> With kernels 3.1 and 3.2, disabling Bluetooth via rfkill also disables
> my wireless card on my HP Pavilion dm4. This didn't happen with 2.6.41
> (I upgraded from Fedora 15 to 16).
> 
> My devices are set up as this (see attached output of lspci -vnn for
> details about devices):
> # rfkill list
> 0: phy0: Wireless LAN
> 	Soft blocked: no
> 	Hard blocked: no
> 2: hp-wifi: Wireless LAN
> 	Soft blocked: no
> 	Hard blocked: no
> 3: hp-bluetooth: Bluetooth
> 	Soft blocked: no
> 	Hard blocked: no
> 11: hci0: Bluetooth
> 	Soft blocked: no
> 	Hard blocked: no
> 
> The problem is, these commands also stop the WiFi:
> rfkill block bluetooth
> and
> rfkill block 3 [for hp-bluetooth]
> 
> But this one only kills the Bluetooth:
> rfkill block 11

the hp-bluetooth platform switch also killing the hci0 switch is
expected. They are essentially for the same device. That is okay.

That the platform switch kills also WiFi is something you have to take
up with hp-bluetooth platform driver authors. This is the wrong mailing
list unless these guys hang out here as well.

Regards

Marcel



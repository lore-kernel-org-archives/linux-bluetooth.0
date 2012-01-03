Return-Path: <cyrus@holtmann.org>
Message-ID: <1325596098.19462.9.camel@milan>
Subject: Re: Disabling Bluetooth also kills WiFi
From: Milan Bouchet-Valat <nalimilan@club.fr>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 03 Jan 2012 14:08:18 +0100
In-Reply-To: <1325542990.1965.400.camel@aeonflux>
References: <1325457984.19462.3.camel@milan>
	 <1325542990.1965.400.camel@aeonflux>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Le lundi 02 janvier 2012 à 14:23 -0800, Marcel Holtmann a écrit :
> the hp-bluetooth platform switch also killing the hci0 switch is
> expected. They are essentially for the same device. That is okay.
> 
> That the platform switch kills also WiFi is something you have to take
> up with hp-bluetooth platform driver authors. This is the wrong mailing
> list unless these guys hang out here as well.
Ah, sorry, I didn't understand that the hp-bluetooth device was handled
by hp-wmi. I'll ask on LKML then.


Regards

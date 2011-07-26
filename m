Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <04f101cc47f2$652cbbf0$2f8633d0$@ytram.com>
References: <AcxH8lGl8ak3xCaSSCmiX6HP8t/C5Q==>
	<04f101cc47f2$652cbbf0$2f8633d0$@ytram.com>
Date: Tue, 26 Jul 2011 10:26:35 +0300
Message-ID: <CABBYNZ+ZS77M7-iPUx-TTO_b8MWokPgO3ATahd6Hb_otAo2TKg@mail.gmail.com>
Subject: Re: DBus APIs for HCI/L2CAP?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: wyrles@ytram.com
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tom,

On Fri, Jul 22, 2011 at 1:05 AM, Tom Allebrandi <wyrles@ytram.com> wrote:
> Hi -
>
> Is there a DBus API for issuing HCI commands? I want to be able to issue
> vendor specific commands.
>
> Also, I want to be able set the Limited Inquiry Access Code for both
> discovery and discoverability. I see the Discoverable property in
> org.bluez.Adapter but I don't see any way to set the IAC.
>
> Similarly, is there a DBus API for L2CAP? I need to be able to manually
> setup channels and control the packets that I send over those channels.
>
> I'm working with profiles that are not yet implemented in BlueZ. Also, I
> need to be able to generate malformed packets for test purposes.
>
> I'm pretty sure that I can do all of the above with BTIO or the socket
> interface. I'm just trying to be a good boy and use DBus :-).

D-Bus is not really meant for data, it is a high level/convenient API
for applications, so if you are trying to implement a profile you
should probably stick with sockets or use BTIO as bluetoothd and obexd
does.

Regards,

-- 
Luiz Augusto von Dentz

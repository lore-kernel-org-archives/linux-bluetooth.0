Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCHv3 0/3] Sixaxis plugin for Bluez
From: Bastien Nocera <hadess@hadess.net>
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-bluetooth@vger.kernel.org, linux-input@vger.kernel.org,
	Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>,
	"Pascal A . Brisset" <pascal44973@pabr.org>,
	Marcin Tolysz <tolysz@gmail.com>,
	Christian Birchinger <joker@netswarm.net>,
	Filipe Lopes <falktx@gmail.com>, Alan Ott <alan@signal11.us>,
	Mikko Virkkila <virkkila@kapsi.fi>,
	Simon Wood <simon@mungewell.org>
Date: Wed, 08 Jun 2011 15:33:42 +0100
In-Reply-To: <1307538557-9287-1-git-send-email-ospite@studenti.unina.it>
References: <1307538557-9287-1-git-send-email-ospite@studenti.unina.it>
Content-Type: text/plain; charset="ISO-8859-1"
Message-ID: <1307543625.2669.180.camel@novo.hadess.net>
Mime-Version: 1.0
Sender: linux-input-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2011-06-08 at 15:09 +0200, Antonio Ospite wrote:
> 
>   - When the controller is connected via USB the led is set, but then
> it 
>     goes blinking again waiting for the PS button to be pressed,
> maybe 
>     we should wait for the PS button before setting leds, maybe with
> a 
>     simple blocking read() on the hidraw device.

One hard thing to handle is when the device is already in use via USB,
it should automatically connect via Bluetooth when unplugged. I'm not
sure this works right now (I'm a bit hazy on the interaction with the PS
button tbh).

>   - When the controller is connected via USB after it is working over 
>     BT, it is seen as a second controller and the second led it
> turned 
>     on, should we force BT disconnection on USB connection? 

As we can identify the device uniquely through its bdaddr, I'd say yes.


Return-Path: <cyrus@holtmann.org>
Message-Id: <i8xvd084322.fsf@pabr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 25 Feb 2011 15:11:15 +0100
From: pascal44973@pabr.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-bluetooth@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	linux-input@vger.kernel.org, Jim Paris <jim@jtan.com>,
	Ranulf Doswell <ralf@ranulf.net>,
	Marcin Tolysz <tolysz@gmail.com>,
	Christian Birchinger <joker@netswarm.net>,
	Filipe Lopes <falktx@gmail.com>, Alan Ott <alan@signal11.us>,
	Mikko Virkkila <virkkila@kapsi.fi>
Subject: Re: [PATCH v2 0/3] Another try for the Sixaxis plugin
In-Reply-To: <1298628292-8842-1-git-send-email-ospite@studenti.unina.it>
References: <1298628292-8842-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Antonio Ospite writes:
 > FUTURE plans:
 >  - Add support for battery status report
 >  - Add support for Playstation Move (I don't have the hardware, tho),

As far as I know, if your infrastructure can both pair the
sixaxis over USB and register it in /var/lib/bluetooth, then it
will only take a small patch to add support for the Move later.

There are rumours that Sony will announce PC support the Move
at a conference next week, and the speaker seems to have a
strong Linux background.  Maybe that will reveal some useful
information, such as:

- whether it is safe to perform the cable pairing everytime the
  device is plugged in (I'd expect the USB socket to die long
  before any flash chip wears out, but who knows ?)

- whether it is safe to run the LED bulb at full power

- how to use the built-in sensor calibration data.

Pascal

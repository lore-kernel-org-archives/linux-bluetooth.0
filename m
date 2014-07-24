Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 Jul 2014 11:16:59 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: phone connects and then disconnects immediately
Message-ID: <20140724081659.GA9891@t440s.lan>
References: <1406119074.21242.55.camel@pc.interlinx.bc.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406119074.21242.55.camel@pc.interlinx.bc.ca>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Wed, Jul 23, 2014, Brian J. Murrell wrote:
> I am using Bluez 5.18 on my Fedora 20 machine and trying to play music
> from my Android (Nexus 4 with KK 4.4.4) phone to the F20 as a Bluetooth
> sink.
> 
> I have successfully paired the phone and the F20 machine and the phone
> sees it as advertising an Audio Sink but when I try to connect the phone
> bluetoothctl shows the connect immediately followed by a disconnect:
> 
> [CHG] Device XX:XX:XX:XX:XX:XX Connected: yes
> [CHG] Device XX:XX:XX:XX:XX:XX Connected: no
> 
> No messages in the syslog to indicate any problems.
> 
> Any ideas why the immediate disconection or next steps to debug?

To analyze the matter further we'd need to get bluetoothd debug logs
(for which you need to pass -d to the daemon) as well as HCI-level logs
(e.g. using btmon) of this connection failure.

Johan

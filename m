Return-Path: <cyrus@holtmann.org>
From: "Boris Passerat de La Chapelle" <boris.passerat@davidson.fr>
To: <linux-bluetooth@vger.kernel.org>
References: <557AFA18.1060305@albus.fr>
In-Reply-To: <557AFA18.1060305@albus.fr>
Subject: RE: Error on executing compiled bluetoothd with plugins
Date: Fri, 12 Jun 2015 17:52:52 +0200
Message-ID: <028001d0a527$d798fe60$86cafb20$@davidson.fr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jérémie

-----Message d'origine-----
De : linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] De la part de Jérémie Scheer
Envoyé : vendredi 12 juin 2015 17:26
À : linux-bluetooth@vger.kernel.org
Objet : Error on executing compiled >bluetoothd with plugins

>Hello,
>
>I downloaded Bluez 5.30 sources and compiled it against a Debian Jessie (Linux 3.16).
>
>When I try to execute it, I receive the following errors :
>bluetoothd[819]: Bluetooth daemon 5.30
>bluetoothd[819]: Starting SDP server
>bluetoothd[819]: Ignoring (cli) hostname
>bluetoothd[819]: Ignoring (cli) wiimote
>bluetoothd[819]: Ignoring (cli) autopair
>bluetoothd[819]: Ignoring (cli) policy
>bluetoothd[819]: Ignoring (cli) gatt_example
>bluetoothd[819]: Ignoring (cli) neard
>bluetoothd[819]: Ignoring (cli) sap
>bluetoothd[819]: Ignoring (cli) a2dp
>bluetoothd[819]: Ignoring (cli) avrcp
>bluetoothd[819]: Ignoring (cli) network
>bluetoothd[819]: Ignoring (cli) input
>bluetoothd[819]: Ignoring (cli) hog
>bluetoothd[819]: Ignoring (cli) health
>bluetoothd[819]: Ignoring (cli) gap
>bluetoothd[819]: Ignoring (cli) scanparam
>bluetoothd[819]: Ignoring (cli) deviceinfo
>bluetoothd[819]: Ignoring (cli) alert
>bluetoothd[819]: Ignoring (cli) proximity
>bluetoothd[819]: Ignoring (cli) thermometer
>bluetoothd[819]: Ignoring (cli) heartrate
>bluetoothd[819]: Ignoring (cli) cyclingspeed
>bluetoothd[819]: Ignoring (cli) external_dummy
>bluetoothd[819]: Bluetooth management interface 1.6 initialized
>bluetoothd[819]: Failed to obtain handles for "Service Changed" 
>characteristic
>bluetoothd[819]: Failed to register org.bluez.LEAdvertisingManager1
>bluetoothd[819]: Failed to register LEAdvertisingManager1 interface for adapter
>bluetoothd[819]: Not enough free handles to register service
>bluetoothd[819]: Current Time Service could not be registered
>bluetoothd[819]: gatt-time-server: Input/output error (5)
>bluetoothd[819]: hci0 Load Connection Parameters failed: Unknown Command
>(0x01)

>So when I reset my Bluetooth device hci0 and try to advertise LE, I can't see nothing on an iPad for instance.

>When compiling Bluez, I configured it with this command :
>./configure CFLAGS="$CFLAGS --Wno-sign-compare" --disable-udev --prefix=$PWD --enable-experimental ->-enable-maintainer-mode

>Is there something I missed ?

>Jérémie

I had the same issue after activating all plugins. You can disable plugin started with bluetoothd with the option --noplugin= hostname, wiimote... and then it should work !

Boris


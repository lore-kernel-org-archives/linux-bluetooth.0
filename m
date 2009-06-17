Return-Path: <cyrus@holtmann.org>
From: Vikram Kandukuri <Vikram.Kandukuri@Atheros.com>
To: Johan Hedberg <johan.hedberg@gmail.com>, Jothikumar Mothilal
	<Jothikumar.Mothilal@Atheros.com>
CC: "marcel@holtmann.org" <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 17 Jun 2009 21:35:15 +0530
Subject: RE: HSP Ring command
Message-ID: <44EE5C37ADC36343B0625A05DD408C485068E39C75@CHEXMB-01.global.atheros.com>
References: <44EE5C37ADC36343B0625A05DD408C485068E39C2B@CHEXMB-01.global.atheros.com>
 <20090617154529.GA12943@jh-x301>
In-Reply-To: <20090617154529.GA12943@jh-x301>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,
Do we have any VOIP application like SKYPE which has implemented D-Bus meth=
ods for incoming/outgoing/call hold indications?

If we do not use *RING* indication for inband ring from HSP 1.2 I wonder wh=
y BQB tests for HSP still have a test case where we have to send AT+RING co=
mmand when we place a call.

Thanks
Vikram.k

-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@v=
ger.kernel.org] On Behalf Of Johan Hedberg
Sent: Wednesday, June 17, 2009 9:15 PM
To: Jothikumar Mothilal
Cc: marcel@holtmann.org; linux-bluetooth@vger.kernel.org
Subject: Re: HSP Ring command

Hi Jothi,

On Wed, Jun 17, 2009, Jothikumar Mothilal wrote:
> I am running HSP profile test cases with PTS tool.
> I am using Ubuntu 9.04 with Bluez 4.32.
>
> For all HSP test cases, PTS is expecting RING command from IUT.
> From our analysis, headset_send(hs, "\r\nRING\r\n"); " in
> audio/headset.c is not getting initiated.
> I am thinking, RING command is suppose to send by dbus as we register
> the call backs. But dbus is not triggering the RING command.
> Is this expected behavior in BlueZ?

There is the IndicateCall D-Bus method in the org.bluez.Headset interface
which you can use (see doc/audio-api.txt for more info). However for
proper telephony integration you'll need to use a telephony driver (see
audio/telephony-*.c) so that the call indication occurs because of a real
call event of your telephony subsystem.

By default bluez compiles in the dummy telephony driver which provides a
simple D-Bus interface to drive it. There's also a python test script for
it in test/test-telephony which you can use to simulate telephony events.
E.g. "test-telephony incoming 1234" would simulate an incoming call from
the number "1234" and should cause the RING to be sent for HSP
connections.

Also note that starting with version 4.33 bluez uses HSP version 1.2 which
does *not* use the RING indication when the AG has been configured to use
inband-ringtone (for out-of-band ringing it's still used). However 4.32
(which you have) still has HSP 1.1 where the RING indication will always
be sent.

Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

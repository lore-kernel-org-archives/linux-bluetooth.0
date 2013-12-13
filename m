Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1386951737.23365.19.camel@pc.interlinx.bc.ca>
References: <1386948800.23365.2.camel@pc.interlinx.bc.ca>
	<1386949351.6234.0.camel@nuvo>
	<1386949827.23365.9.camel@pc.interlinx.bc.ca>
	<1691350.CipnhsEWy0@uw000953>
	<CAJdJm_POfMm8mtbRAWdG9W3F2PwT8kNYkiHYToVZeVz+D1F+TQ@mail.gmail.com>
	<1386951737.23365.19.camel@pc.interlinx.bc.ca>
Date: Fri, 13 Dec 2013 15:09:20 -0200
Message-ID: <CAJdJm_NMUP3gd1oABgXL9iYJPSwez=1DGCF2b8uKwVNosRS0ZQ@mail.gmail.com>
Subject: Re: Failed to connect: org.bluez.Error.NotReady
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
Cc: Szymon Janc <szymon.janc@tieto.com>,
	Bastien Nocera <hadess@hadess.net>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Fri, Dec 13, 2013 at 2:22 PM, Brian J. Murrell <brian@interlinx.bc.ca> wrote:
> [bluetooth]# power on
> [CHG] Controller 00:02:72:1E:E0:12 Class: 0x0c0104
> Changing power on succeeded
> [CHG] Controller 00:02:72:1E:E0:12 Powered: yes
> [CHG] Device 7C:1E:52:6E:59:D2 Connected: yes
>
> And now the mouse works.  I wonder what happened in the first place to
> make it stop running.  Certainly the unplugging/plugging in of the
> dongle might have been enough to need it powering on so it's not clear
> that it just spontaneously lost power or anything like that.

Since BlueZ 5, the adapter power state (on/off) is not saved anymore
by bluetoothd (on BlueZ 4, there were InitiallyPowered/RememberPowered
options in main.conf that took care of powering up adapters; these
options are gone in BlueZ 5). There should be an external component
that takes care of powering up the adapter after it is attached.

>
>> (assuming there is no UI applet running that should take care of
>> powering it up automatically.)
>
> Which is an interesting point.  What is the UI applet for all of this
> supposed to be now in F20?

As Bastien mentioned, it is built-in for GNOME. I don't use GNOME, but
in theory, once you enable Bluetooth on its settings, the adapter will
be powered on once it is attached.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil

Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <f21e7dc80809131026g15f66f3eq81980dc507607065@mail.gmail.com>
References: <f21e7dc80809131026g15f66f3eq81980dc507607065@mail.gmail.com>
Date: Sat, 13 Sep 2008 20:27:20 +0200
Message-Id: <1221330440.6695.53.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] A2DP over DBUS
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Choi,

> I have a question about how Bluez works with A2DP over DBUS.
> 
> How does the application sends the data packets (the actual music) to
> bluez ? via dbus ? isn't this slow ?

for that we have plugins for ALSA, GStreamer and PulseAudio. They will
take care of the actual sending of the data. The full mechanism is a
little bit more complex. Looks at the source code to see how it works.

Regards

Marcel



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

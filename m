Return-Path: <cyrus@holtmann.org>
Message-ID: <f21e7dc80809131132udb89654hf2b76149b4b03203@mail.gmail.com>
Date: Sat, 13 Sep 2008 21:32:31 +0300
From: "Choi Sonim" <choisonim@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1221330440.6695.53.camel@californication>
MIME-Version: 1.0
References: <f21e7dc80809131026g15f66f3eq81980dc507607065@mail.gmail.com>
	<1221330440.6695.53.camel@californication>
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

Hi Marcel,

On Sat, Sep 13, 2008 at 9:27 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> How does the application sends the data packets (the actual music) to
>> bluez ? via dbus ? isn't this slow ?
>
> for that we have plugins for ALSA, GStreamer and PulseAudio. They will
> take care of the actual sending of the data. The full mechanism is a
> little bit more complex. Looks at the source code to see how it works.

That's interesting, I will look it up.

Can you please explain briefly what's the underlying method that the
plugin uses to send the data to bluez then ? does it directly uses
sockets and sends it to the kernel ?

Thank you Marcel,
Choi
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
> Build the coolest Linux based applications with Moblin SDK & win great prizes
> Grand prize is a trip for two to an Open Source event anywhere in the world
> http://moblin-contest.org/redirect.php?banner_id=100&url=/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <cyrus@holtmann.org>
Message-ID: <f21e7dc80809131154s7d0b7e99t23201743f65e1f50@mail.gmail.com>
Date: Sat, 13 Sep 2008 21:54:55 +0300
From: "Choi Sonim" <choisonim@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1221331676.6695.55.camel@californication>
MIME-Version: 1.0
References: <f21e7dc80809131026g15f66f3eq81980dc507607065@mail.gmail.com>
	<1221330440.6695.53.camel@californication>
	<f21e7dc80809131132udb89654hf2b76149b4b03203@mail.gmail.com>
	<1221331676.6695.55.camel@californication>
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

On Sat, Sep 13, 2008 at 9:47 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> Can you please explain briefly what's the underlying method that the
>> plugin uses to send the data to bluez then ? does it directly uses
>> sockets and sends it to the kernel ?
>
> direct SCO or L2CAP sockets to have a low latency and to avoid copying
> data around.

That's interesting. What about platforms like Android that are only
Java (If I am not wrong) ? Can they connect directly to those sockets
from Java applications ?

Thank you a lot
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

Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <c8c1ba2805090911092de2eb1c@mail.gmail.com>
From: Mikal Krogstad <mikal.krogstad@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Logitech DiNovo Mediapad LCD driver
In-Reply-To: <200509091430.18471.Loial@home.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200509091430.18471.Loial@home.nl>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 9 Sep 2005 20:09:22 +0200

On 9/9/05, Rutger Hendriks <Loial@home.nl> wrote:
> I seem to remember having seen a mention of a little program that could s=
ort
> of talk to the Mediapad of the Logitech DiNovo Media Desktop set. Does an=
yone
> have a copy of this code? I would love to take a look at it. Unfortunatel=
y I
> do not have any access to hardware that can sniff the bluetooth packets f=
rom
> a Microsoft Windows machine, but I think that stuff like that should alre=
ady
> be available somewhere?

Hi Rutger

Marcel made a "proof of concept" program long time ago, but it seems
he didn't give a copy to anyone, and now it is lost. He does not have
time/interest to re-make it either. AFAIR, he described the protocol
as "a strange beast running on top of the HID protocol", but no more
technical info was available at the time I searched for it (Almost two
years ago).

If you have any reverse engineering skills, do you really depend on a
bluetooth sniffer? As far as I know, there is a program called "USB
Spy" for Windows that can capture the communication going to and from
the hub.

I wish you the best of luck. A generic command line tool would be
great for amaroK/Kopete/Kmail plugins. Maybe this tool is something
that can be achieved with a bounty, or something like elance.com. I
know that those few that own the diNovo are drooling for this feature,
probably enough to chip in a few bucks.

Kind regards
Mikal Krogstad


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

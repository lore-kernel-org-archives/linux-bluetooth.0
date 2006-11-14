Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Hilzinger <mhilzinger@linuxnewmedia.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Tue, 14 Nov 2006 17:54:19 +0100
References: <4550E041.80201@op.pl> <1163405941.26272.43.camel@localhost>
	<4559F242.5040106@op.pl>
In-Reply-To: <4559F242.5040106@op.pl>
MIME-Version: 1.0
Message-Id: <200611141754.19451.mhilzinger@linuxnewmedia.de>
Subject: Re: [Bluez-devel] can't add bnep0 to bridge pan0: Invalid argument
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Am Dienstag, 14. November 2006 17:43 schrieb R.M.M:
> Marcel Holtmann wrote:
> > Hi,
>
> <snip>
>
> >> The problem turn up when I try (after establishing connection) to add
> >> bnep0 interface to pan0 bridge interface. After
> >>
> >> ~# brctl addif pan0 bnep0
> >>
> >> I get:
> >>
> >> can't add bnep0 to bridge pan0: Invalid argument
> >>
> >> (bnep0 has IP 0.0.0.0 after ifconfig bnep0 0.0.0.0 and is up, though I
> >> get no answer on ping which I could be a routing problem actually. Also
> >> adding eth1 makes no problems).
> >>
> >> As I said, no messages in logs, no more information. What's wrong?
> >
> > you have a dongle with an invalid BD_ADDR. Return that dongle and get
> > one which has a valid address. Dongles using this address can't be added
> > to a bridge.
>
> Thanks a lot for this piece of advice. I wasn't aware there are
> unlicensed dongles on the market. Unfortunately I can't give mine back:/
> Are they somehow damaged or is it only a software problem?

I heard, that installing it under Windows changes the bt-address...

-- =

Mit freundlichen Gr=FC=DFen,
Marcel Hilzinger

Linux New Media AG
S=FCskindstr. 4
D-81929 M=FCnchen
Tel: +49 (89) 99 34 11 0
Fax: +49 (89) 99 34 11 99

-------------------------------------------------------------------------
SF.net email is sponsored by: A Better Job is Waiting for You - Find it Now.
Check out Slashdot's new job board. Browse through tons of technical jobs
posted by companies looking to hire people just like you.
http://jobs.slashdot.org/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

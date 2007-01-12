Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45A7D8E0.20908@xmission.com>
Date: Fri, 12 Jan 2007 11:52:16 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44F6B7AE.1030209@jambit.com>	<4582A310.60905@jambit.com>	<4583A020.2040808@xmission.com>	<4587D051.8080703@jambit.com>	<458864F1.4070104@xmission.com>	<4589371F.2000507@palmsource.com>	<45A54D5B.8030001@xmission.com>
	<45A5F6DD.7020904@palmsource.com>
In-Reply-To: <45A5F6DD.7020904@palmsource.com>
Subject: Re: [Bluez-devel] How to use sbc.c ?
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

Fr=E9d=E9ric

> In my investigations, I got over a 64 bits version of the codec. I =

> tested it on pc and arm. It gave better results than the 32 bits : the =

> gain is better, the overflow do not occurs, there is still a bit of =

> background noise, but not more than the 32 bits and it may be the sample =

> file. It will probably consume a little bit more cpu, but I found this =

> was not really noticeable (at least on my hardware). But the library =

> could be changed according to needs.
> =

> While this is not the best solution to the problem, I still think users =

> are complaining mainly about gain. So it could be possible to provide it =

> as default. What about you?

We have confirmation that this stuff can be done in 32 bits but it is
more work to get it right. I thought I was getting close back when I was
working on it last but couldn't get over those volume/overflow problems.
I do think the decoder was working ok in 32 bits at least.

We used to run everything in 64 bits. btsco/sbc would have the cvs
history showing the older stuff.

How about if we create a separate cvs module like "sbc64" that contains
libsbc with a 64-bit encoder? I don't like having the implementations
together with a bunch of conditional code choosing one over the other.
That was really ugly and too easy to break.

Brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

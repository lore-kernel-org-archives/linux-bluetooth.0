Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <d66c3bdf0612122152j119bba2ax800a477c6c72f80f@mail.gmail.com>
References: <d66c3bdf0612122152j119bba2ax800a477c6c72f80f@mail.gmail.com>
Date: Wed, 13 Dec 2006 09:29:51 +0100
Message-Id: <1165998591.23723.3.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] periodic inquiry mode.
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Uichin,

> I need some more helps/comments with periodic inquiry mode. As Marcel
> told, I checked the D-Bus based API, which is assumed to be defined in
> HCID. I mainly want to use this for P2P applications, i.e., for
> content sharing/advertisement application, and thus minimizing peer
> discovery latency (or, symmetric discovery latency) is the key issue.
> 
> It seems like the actual configuration in HCID is a bit absurd. It
> uses inquiry window length of 8, and min and max were set to 16 and 24
> respectively; i.e., by multiplying 1.28s, they are 20.48s and 30.72s.
> We need to WAIT8*1.28=10.24s to get a response.
> 
> It seems like nobody has been working on optimizing the periodic
> inquiry mode. I saw a number of papers, but they misunderstood the
> units of various parameters, and thus proposed their own schemes,
> which are yet another version of this "periodic inquiry mode." Some
> analysis work simplified the mode too much, thus failing to reflect
> the reality. (I tried, but it seems like it's non-trivial to exactly
> model the overall system).
> 
> I'm actually working on optimizing the parameter configuration for
> "symmetric" peer discovery. What I found is that unless we're using
> Bluetooth v1.1, we need inquiry window size at most 2, and the min and
> max are set to [0, 2*1.28] (assuming that inquiry scan is adjusted
> accordingly). When I tested it with Bluetooth 2.0 (Broadcom chipset),
> the latency was less than 3 seconds, which is a pretty well match with
> simulation.

nobody said that our values are perfect, but we need to simply pick some
to get this going. If you gonna propose different values, then I am fine
with that and would like to simply change it. You can have a different
set of parameters for each Bluetooth version, because hcid knows the
version of the chip and its manufacturer. So if a Bluetooth 1.1 behaves
different from a 2.0 and a Broadcom chip behaves different from a CSR
chip, then we simply include a table of parameters and pick the best one
at runtime.

One extra thing you should keep in mind is however power consumption. It
is not possible to always assume unlimited power.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

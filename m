Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d66c3bdf0612122152j119bba2ax800a477c6c72f80f@mail.gmail.com>
Date: Tue, 12 Dec 2006 21:52:32 -0800
From: "Uichin (Eugene) Lee" <netssenger@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] periodic inquiry mode.
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

Hello,

I need some more helps/comments with periodic inquiry mode. As Marcel
told, I checked the D-Bus based API, which is assumed to be defined in
HCID. I mainly want to use this for P2P applications, i.e., for
content sharing/advertisement application, and thus minimizing peer
discovery latency (or, symmetric discovery latency) is the key issue.

It seems like the actual configuration in HCID is a bit absurd. It
uses inquiry window length of 8, and min and max were set to 16 and 24
respectively; i.e., by multiplying 1.28s, they are 20.48s and 30.72s.
We need to WAIT8*1.28=10.24s to get a response.

It seems like nobody has been working on optimizing the periodic
inquiry mode. I saw a number of papers, but they misunderstood the
units of various parameters, and thus proposed their own schemes,
which are yet another version of this "periodic inquiry mode." Some
analysis work simplified the mode too much, thus failing to reflect
the reality. (I tried, but it seems like it's non-trivial to exactly
model the overall system).

I'm actually working on optimizing the parameter configuration for
"symmetric" peer discovery. What I found is that unless we're using
Bluetooth v1.1, we need inquiry window size at most 2, and the min and
max are set to [0, 2*1.28] (assuming that inquiry scan is adjusted
accordingly). When I tested it with Bluetooth 2.0 (Broadcom chipset),
the latency was less than 3 seconds, which is a pretty well match with
simulation.

Any comments on this?

-- 
Uichin (Eugene) Lee
Ph.D. Student UCLA CS Dept.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

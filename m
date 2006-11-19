Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45608E0E.60707@free.fr>
Date: Sun, 19 Nov 2006 18:02:06 +0100
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <455CCAF4.8020007@silicom.fr>
	<455CDE8D.4010009@xmission.com>	<455EDB72.7040401@free.fr>
	<455FEF89.4050107@xmission.com>
In-Reply-To: <455FEF89.4050107@xmission.com>
Subject: Re: [Bluez-devel] SCO on bluez : some architectural tips
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Brad,

> Fabien
> 
>> We would have to put
>>> in some locking to keep applications from trying to open more 
>>> simultaneous sco sockets. I wonder how the other audio servers avoid 
>>> this problem.
>> Brad, you should have a look at headsetd source.
>> I solved this problem there by having headsetd open the sco channel and 
>> then hand it over to the application using unix sockets ancillary data. 
>> (man 7 unix for more info)
> 
> nice... just like a cross-process dup().

That's exactly the spirit of it. :-)

> 
> if we have two audio clients open, it sounds like they could both hold 
> the fd to the sco socket--we'd just have to arbitrate who is allowed to 
> use it at any one time.

Exactly. :-) Current headsetd implementation waits for clients 
connections on a unix server socket, and can only accept a single client 
at a time.
Thus we are sure that the server will be able to hand over the sco fd to 
only one client at a time.

Just a question that comes to my mind: Headsetd does only support one 
active application and one SCO headset at a time. Is there any gain 
supporting two headsets at the same time ? I was just trying to look for 
use cases but didn't find any :-(

Cheers,

Fabien

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

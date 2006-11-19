Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <455FEF89.4050107@xmission.com>
Date: Sat, 18 Nov 2006 22:45:45 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <455CCAF4.8020007@silicom.fr> <455CDE8D.4010009@xmission.com>
	<455EDB72.7040401@free.fr>
In-Reply-To: <455EDB72.7040401@free.fr>
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

Fabien

> We would have to put
>> in some locking to keep applications from trying to open more 
>> simultaneous sco sockets. I wonder how the other audio servers avoid 
>> this problem.
> 
> Brad, you should have a look at headsetd source.
> I solved this problem there by having headsetd open the sco channel and 
> then hand it over to the application using unix sockets ancillary data. 
> (man 7 unix for more info)

nice... just like a cross-process dup().

if we have two audio clients open, it sounds like they could both hold 
the fd to the sco socket--we'd just have to arbitrate who is allowed to 
use it at any one time.

Brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

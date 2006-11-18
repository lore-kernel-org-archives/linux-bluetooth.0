Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <455EDB72.7040401@free.fr>
Date: Sat, 18 Nov 2006 11:07:46 +0100
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <455CCAF4.8020007@silicom.fr> <455CDE8D.4010009@xmission.com>
In-Reply-To: <455CDE8D.4010009@xmission.com>
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

Hi Brad,

> Fabien
> 
>> Due to this, i had to fall back on having the SCO file descriptor 
>> available in application process space.
> 
> If it's inevitable, 

I'm afraid it is.

I think we could keep the fd in the audio app's
> userspace and mostly pull things off as envisioned. 

Yes, i would tend to agree with that, i think it's best to hide most of 
the complexity from the application.

We would have to put
> in some locking to keep applications from trying to open more 
> simultaneous sco sockets. I wonder how the other audio servers avoid 
> this problem.

Brad, you should have a look at headsetd source.
I solved this problem there by having headsetd open the sco channel and 
then hand it over to the application using unix sockets ancillary data. 
(man 7 unix for more info)

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

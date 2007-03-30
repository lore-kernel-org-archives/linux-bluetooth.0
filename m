Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Malte Steiner <steiner@mobileart.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <BAY124-W15053C673FC32A41B2AF00F0630@phx.gbl>
References: <BAY124-W15053C673FC32A41B2AF00F0630@phx.gbl>
Date: Fri, 30 Mar 2007 21:45:49 +0200
Message-Id: <1175283949.5851.3.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Multithread Service Discovery
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

Am Freitag, den 30.03.2007, 19:33 +0000 schrieb Robert Rawlins:
> Hello Chaps,
>  
> I'm currently running a C program for service discovery on a list of
> devices. The function loops through the list elements and performs an
> SDP enquiry on each device and returns the results to the screen, but
> I'm finding that if i get a slow device in the list it can hold things
> up a little, and in general it would be fantastic to hit all the
> devices with an enquiry simultaneously.

Multithreading is possible, I use the OpenThreads library to do so for
the same reasons. Attention, OpenThreads is OO and C++ so you might look
for another solution like pthreads.

Cheers,

Malte


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45F843B1.9060400@gmail.com>
Date: Wed, 14 Mar 2007 11:49:21 -0700
From: Xamindar <junkxamindar@gmail.com>
MIME-Version: 1.0
To: ichudov@Algebra.Com, BlueZ users <bluez-users@lists.sourceforge.net>
References: <20070314135409.GA9801@manifold.algebra.com>
In-Reply-To: <20070314135409.GA9801@manifold.algebra.com>
Subject: Re: [Bluez-users] Connecting to cell phone DOES NOT WORK
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

Igor Chudov wrote:
> 4) The phone, when asked to "look around" to find Bluetooth devices,
> does NOT see my laptop.
>   
Your laptop is probably in non-discoverable mode.  Try looking at your 
bluetooth settings.
> What I want is to find a 100% pure scripting solution (preferably no
> GUI). I guess I am misunderstanding who should be connecting to whom,
> so
>
> * Who is the master (laptop vs phone) and who is the slave
>   
Correct me if I'm wrong, but I thought this didn't matter in bluetooth.
> * Who should be initiating connection to whom
>   
Doesn't matter, either way they can be paired.
> * Who should set a PIN and who should supply same PIN for authentication
>   
Again. doesn't matter, they both will be paired.
> I feel that once I get past this confusion, I will be able to go
> forward, I have been a linux user for 12 years (have only linux at
> home). ppp should not be a huge problem, though it's been 6 or so
> years since I used it. 
>   
To do the internet-modem-phone thing you will want to look at your 
rfcomm config as well.  First you need to bind an rfcomm device to your 
phone on the correct channel.  you can find out which channel by pinging 
your phone with l2ping.  I use kppp to connect so I can't help much on a 
scripting solution.

Good luck.
> Thanks A LOT for your help!
>
> i
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>   


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: =?iso-8859-1?Q?S=E9bastien?= Delneste <seb@pong.be>
To: bluez-users@lists.sourceforge.net
Message-ID: <20040325194812.GA28260@pong.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] bluetooth ipaq problem
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 25 Mar 2004 20:48:12 +0100

Hello,

I'm having a serious problem with an iPaq 3870 running Linux (Familiar)

6 months ago, I've been trying to change the PS registers of my CSR
chipset (using the pskey tool)

Since then, my bluetooth hasn't worked anymore.

Today, I finally found back the URL I was looking for with the default
values of the registers.
http://www.samengstrom.com/ipaq/PSKEY-README

I've restored one but, apparently I failed to modify the second one,
which results to the following problem : 

I still can't use the bluetooth function of my iPaq and I can't access
it with pskey anymore 

the values are now : 
1f9	0001
191 01d8 00a8 00fa 0014 0004 0000 0004 001e 0064 000a

now, when I try to use pskey (no matter the speed , I've tried
15200,230400, etc), it gives me the following error :

~ # pskey -d /dev/ttySB0
Physical device :/dev/ttySB0
Speed           :115200
Use BCSP        :NO
Initiating read thread
Now trying to read firmware info
Timeout!!!
Error in reading firmware info


Is there anyone out there who already had this problem ?

I've also heard of pstools (apparently pskey but under PocketPC), could
it help in my case, where can I find it ?

Thx for your help,
Seb




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

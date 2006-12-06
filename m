Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <457639F1.3030908@fourthandvine.com>
Date: Tue, 05 Dec 2006 22:33:05 -0500
From: Chris MacDonald <chris@fourthandvine.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Device 'sleeping' and Reconnecting
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

Hi all,

I just recently purchased an Apple bluetooth keyboard and I'm just 
trying to wrestle with it to get things working smoothly.

So far I've managed to connect to it and have it function properly as a 
keyboard but there seems to be some kind of power saving function to the 
keyboard that I'm having problems with. After about 20 minutes or so (I 
haven't been patient enough to figure out exactly how long it is) after 
being left alone the keyboard no longer functions. Opening hcidump with 
another keyboard and watching the output shows that the keyboard seems 
to be sending something to my bluetooth receiver, but the connection 
never reestablishes to the point where I can type with the keyboard again.

Currently to reconnect everything I just turn the power to the keyboard 
off and on again then with a second keyboard I run 'hidd -connect 
BT_ADDR' and it reconnects. It may be worth mentioning that if I happen 
to hit a key on the keyboard after restarting it and immediately try the 
aforementioned command it fails.

Ideally what I'd like to do is have the keyboard come back to life and 
'just work'. Barring that I'm wondering if it'd be possible to throw 
something into my crontab to keep the connection alive. If anyone can 
help in this endevour that would be awesome. I'd be more than willing to 
provide the necessary output from any commands that should be run to 
shed some light on the situation, I just haven't included any here 
because I'm not sure what's needed/relevant.

Thanks in advance,
Chris

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

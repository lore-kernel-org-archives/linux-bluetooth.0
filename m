Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4280DFBD.9050507@whitelabel.org>
From: Stefan Magdalinski <stefan@whitelabel.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Palm (clie) + bluetooth networking problem
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 10 May 2005 17:22:21 +0100


Right, now I have my dialup working beautifully, the next stage is 
getting my Palm connecting to the laptop so that hopefully I can sync 
with evolution.

I've been following the instructions from

http://www.harbaum.org/till/palm/bluetooth/index.html

(from Marcel's bluetooth HOWTO list)

I can see the clie fine:

stefvaio:/etc/ppp# hcitool scan
Scanning ...
         08:00:46:EF:4B:F4       stefclie
         00:12:62:DC:EA:63       Stefphone

I have successfully added the pc as a trusted device, sdpd is running, 
and I've added the LAN service, as per the HOWTO

The clie networking all appears to be set up OK, but when I try and connect,

it says 'initializing', then 'signing on', but then hangs there. at this 
point, hcidump -X -V shows a continuous stream of ongoing traffic, but 
the signing on never finishes.

/var/log/messages says

May 10 17:08:18 localhost pppd[16725]: pppd 2.4.2 started by root, uid 0
May 10 17:08:18 localhost pppd[16725]: Using interface ppp0
May 10 17:08:18 localhost pppd[16725]: Connect: ppp0 <--> /dev/rfcomm1

and then when I cancel the connection on the Clie

May 10 17:09:23 localhost pppd[16725]: LCP terminated by peer
May 10 17:09:23 localhost pppd[16725]: Hangup (SIGHUP)
May 10 17:09:23 localhost pppd[16725]: Modem hangup
May 10 17:09:23 localhost pppd[16725]: Connection terminated.
May 10 17:09:24 localhost pppd[16725]: Exit.


I can't see an rfcommd running anywhere though, only a krfcommd, are 
they the same thing?

ps aux |grep rfcommd
root      8627  0.0  0.0      0     0 ?  S<   May09   0:00 [krfcommd]

Any other information I need to provide?

actually looking in more detail,

http://article.gmane.org/gmane.linux.bluez.user/5568/match=rfcommd

says that rfcommd is not used any more, but not what is, so I'm stuck.

stef

-- 
/*
Stefan Magdalinski
+447769 666528 (telephone)
smagdali (IM/flickr.com/etc)
*/


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

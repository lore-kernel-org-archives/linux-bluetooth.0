Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Bernd Jucknischke <Bernd.Jucknischke@web.de>
Reply-To: Bernd.Jucknischke@web.de
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200403030832.19665.Bernd.Jucknischke@web.de>
Subject: [Bluez-users] AVM AP-X and DUN profile
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
Date: Wed, 3 Mar 2004 08:32:19 +0100

Dear everybody,

yesterday I have upgraded the firmware of my AP-X and tried to connect to the 
internet via the DUN service (They stated that the DUN part would have been 
improved...). I have proceeded according to Cees' HOWTO and made use of a 
working internet connection, which I normally use with my old modem (I've 
changed /dev/ttyS0 to /dev/rfcomm0). So far so good, dialling worked, but the 
connection got stuck in the LCP process. Here is the log output:

Mar  2 15:31:14 bunter kernel: CSLIP: code copyright 1989 Regents of the 
Univers
ity of California
Mar  2 15:31:14 bunter kernel: PPP generic driver version 2.4.2
Mar  2 15:31:14 bunter pppd[2546]: pppd 2.4.2 started by root, uid 0
Mar  2 15:31:17 bunter hcid[1243]: link_key_request (sba=00:04:0E:82:81:96, 
dba=
00:04:0E:82:00:27)
Mar  2 15:31:17 bunter hcid[1243]: link_key_notify (sba=00:04:0E:82:81:96)
Mar  2 15:31:17 bunter hcid[1243]: Replacing link key 00:04:0E:82:81:96 
00:04:0E
:82:00:27
Mar  2 15:31:17 bunter pppd[2546]: Perms of /dev/rfcomm0 are ok, no 'mesg n' 
nec
cesary.
Mar  2 15:31:18 bunter chat[2548]: abort on (BUSY)
Mar  2 15:31:18 bunter chat[2548]: abort on (NO CARRIER)
Mar  2 15:31:18 bunter chat[2548]: abort on (VOICE)
Mar  2 15:31:18 bunter chat[2548]: abort on (NO DIALTONE)
Mar  2 15:31:18 bunter chat[2548]: abort on (NO DIAL TONE)
Mar  2 15:31:18 bunter chat[2548]: abort on (NO ANSWER)
Mar  2 15:31:18 bunter chat[2548]: abort on (DELAYED)
Mar  2 15:31:18 bunter chat[2548]: send (ATZ^M)
Mar  2 15:31:18 bunter chat[2548]: expect (OK)
Mar  2 15:31:18 bunter chat[2548]: ATZ^M^M
Mar  2 15:31:18 bunter chat[2548]: OK
Mar  2 15:31:18 bunter chat[2548]:  -- got it
Mar  2 15:31:18 bunter chat[2548]: send (ATDT019231770^M)
Mar  2 15:31:19 bunter chat[2548]: expect (CONNECT)
Mar  2 15:31:19 bunter chat[2548]: ^M
Mar  2 15:31:25 bunter chat[2548]: ATDT019231770^M^M
Mar  2 15:31:25 bunter chat[2548]: CONNECT
Mar  2 15:31:25 bunter chat[2548]:  -- got it
Mar  2 15:31:25 bunter chat[2548]: send (\d)
Mar  2 15:31:26 bunter pppd[2546]: Serial connection established.
Mar  2 15:31:26 bunter pppd[2546]: using channel 1
Mar  2 15:31:26 bunter pppd[2546]: Using interface ppp0
Mar  2 15:31:26 bunter pppd[2546]: Connect: ppp0 <--> /dev/rfcomm0

Up to here everything looks OK (AFAICS), then follows:
Mar  2 15:31:27 bunter pppd[2546]: rcvd [LCP ConfReq id=0xbd <auth pap> <magic 
0
xae7a0dbe> <mrru 1524> <endpoint [local:64.74.6d.32]>]
Mar  2 15:31:27 bunter pppd[2546]: sent [LCP ConfReq id=0x1 <asyncmap 0x0> 
<magi
c 0x2dc416cd> <pcomp> <accomp>]
Mar  2 15:31:27 bunter pppd[2546]: sent [LCP ConfRej id=0xbd <mrru 1524>]
Mar  2 15:31:30 bunter pppd[2546]: sent [LCP ConfReq id=0x1 <asyncmap 0x0> 
<magi
c 0x2dc416cd> <pcomp> <accomp>]
Mar  2 15:31:54 bunter last message repeated 8 times
Mar  2 15:31:57 bunter pppd[2546]: LCP: timeout sending Config-Requests
Mar  2 15:31:57 bunter pppd[2546]: Connection terminated.
Mar  2 15:31:58 bunter pppd[2546]: Exit.

It looks to me as if not a single LCP request has been received.
I have browsed through the mail archive a bit and found that similar problems 
have been encountered. However, I'd like to know whether there are news 
concerning this problem. Marcel stated that it could have two reasons: 1) AVM 
has a problem with the firmware 2) the Linux PPP code is wrong somewhere.

TIA for any clue,

Bernd

PS: Please CC me, since I'm not on the list...





-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

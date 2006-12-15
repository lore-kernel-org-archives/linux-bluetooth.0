Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Fri, 15 Dec 2006 18:32:34 -0500 (EST)
From: "Mark T. Valites" <mark-bluez@valites.net>
To: bluez-users@lists.sourceforge.net
Message-ID: <Pine.LNX.4.62.0612151804360.28430@megatron.therowes.net>
MIME-Version: 1.0
Subject: [Bluez-users] Verizon vx8100 Bluetooth DUN (Dial-Up) Problem
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

I've been (unsuccessfully) trying to get tethering to my Verizon LG vx8100 
(version 7 firmware) working over bluetooth for dial-up to PPP since I 
purchased the phone a couple months ago. The same chatscript works 
correctly over a USB data cable.

I enabled the BT DUN profile for the phone and since have been able to 
pair with it through a Airnet ABT201 BT adapter with the following OSs:

Windows XP Home (MS bluetooh drivers)
Windows XP Home (BlueSoliel drivers)
Debian amd64 (2.6.16.2 custom compiled kernel)
Ubuntu Edgy Desktop (2.6.17-10-generic stock kernel, bluez-utils 3.7-1ubuntu4)

The serial profile works correctly for BitPim and I can dial out over the 
DUN one without any problems (both OSs), but after my the PPP server 
displays the banner and presents the username prompt, I can proceed no 
further and the connection eventually times out. A ppp0 device does 
breifly get created, but is never assigned any IP address. I remember 
occasionally being able to send and have an 'm' (from my username) 
displayed.

Trying to eliminate the different variables, I tried a different dial-up 
service I have an account with, the #777 Verizon service, picked up a 
D-Link DBT-120 adapter, tried Windows & tried another laptop - but had no 
luck with any of those attempts. I've iterated through some different flow 
control, port speed and parity combinations, but am by no means a modem 
expert.

Eventually I ended up eBaying a holster for the phone, and got a USB data 
cable along with it. Much to my surprise, dial-up worked correctly through 
the cable with the same chatscript after changing just the device. DUN 
works when paired with a co-worker's Verizon Razr, but I tried a different 
vx8100 & saw failure the same failures as well.

After taking a look at the PPP RFC, I'm starting to think that the problem 
is that the the initial LCP config request(s) are either not being sent or 
aren't being answered by the PPP server - the number of LCP config 
requests sent is always equal to the value specified for 
'lcp-max-configure', unless I increase it high enough to the point where 
the remote ppp server hangs up on me.

If the requests aren't making it to the PPP server, I'm not sure where in 
the setup the problem might be occuring (bluetooh, ppp, phone, Verizon).

I've seen multiple posts on howardforums of folks successfully using their 
own ISP or the Verizon #777 service for dialup through BT DUN. Normally 
just the USB cable would be sufficient, but the main reason I picked up a 
vx8100 was to use my PDA BT connection with it so I could just take my 
Zaurus PDA with me to a sporting event or outdoors and be able to ssh in 
and respond to pages for work.

mark@bait:~$ cat /etc/ppp/peers/bluetoothdialup
noauth
connect "/usr/sbin/chat -v -f /etc/chatscripts/bluetoothdialup"
usepeerdns
/dev/rfcomm0 9600
#/dev/ttyACM0 9600
defaultroute
noipdefault
user mtvtest
connect-delay 10000
lock
debug
kdebug 4
#lcp-max-configure 100

mark@bait:~$ cat /etc/chatscripts/bluetoothdialup
ABORT BUSY ABORT 'NO CARRIER' ABORT VOICE ABORT 'NO DIALTONE' ABORT 'NO DIAL 
TONE' ABORT 'NO ANSWER' ABORT DELAYED
# modeminit
'' ATZ
#'' AT$QCMDR=3
# ispnumber
OK-AT-OK "ATDT<phone number>"
# ispconnect
CONNECT \d\c
# prelogin

# ispname
# isppassword
# postlogin

/etc/ppp/options contains the default values supplied with Debian/ubuntu.

syslog ppp debug output:

Dec  6 06:54:09 bait pppd[18490]: pppd 2.4.4 started by mark, uid 1000
Dec  6 06:54:11 bait chat[18494]: abort on (BUSY)
Dec  6 06:54:11 bait chat[18494]: abort on (NO CARRIER)
Dec  6 06:54:11 bait chat[18494]: abort on (VOICE)
Dec  6 06:54:11 bait chat[18494]: abort on (NO DIALTONE)
Dec  6 06:54:11 bait chat[18494]: abort on (NO DIAL TONE)
Dec  6 06:54:11 bait chat[18494]: abort on (NO ANSWER)
Dec  6 06:54:11 bait chat[18494]: abort on (DELAYED)
Dec  6 06:54:11 bait chat[18494]: send (ATZ^M)
Dec  6 06:54:11 bait chat[18494]: expect (OK)
Dec  6 06:54:11 bait chat[18494]: ATZ^M^M
Dec  6 06:54:11 bait chat[18494]: OK
Dec  6 06:54:11 bait chat[18494]:  -- got it
Dec  6 06:54:11 bait chat[18494]: send (ATDT17165155603^M)
Dec  6 06:54:11 bait chat[18494]: expect (CONNECT)
Dec  6 06:54:11 bait chat[18494]: ^M
Dec  6 06:54:35 bait chat[18494]: ATDT17165155603^M
Dec  6 06:54:35 bait chat[18494]: CONNECT
Dec  6 06:54:35 bait chat[18494]:  -- got it
Dec  6 06:54:35 bait chat[18494]: send (\d)
Dec  6 06:54:36 bait pppd[18490]: Serial connection established.
Dec  6 06:54:36 bait pppd[18490]: using channel 22
Dec  6 06:54:36 bait pppd[18490]: Using interface ppp0
Dec  6 06:54:36 bait pppd[18490]: Connect: ppp0 <--> /dev/rfcomm0
Dec  6 06:54:46 bait pppd[18490]: sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 0x13b8ac8> <pcomp> <accomp>]
Dec  6 06:55:13 bait last message repeated 9 times
Dec  6 06:55:16 bait pppd[18490]: LCP: timeout sending Config-Requests
Dec  6 06:55:16 bait pppd[18490]: Connection terminated.
Dec  6 06:55:16 bait pppd[18490]: Receive serial link is not 8-bit clean:
Dec  6 06:55:17 bait pppd[18490]: Problem: all had bit 7 set to 0
Dec  6 06:55:18 bait pppd[18490]: tcsetattr: Interrupted system call (line 1011)
Dec  6 06:55:18 bait pppd[18490]: Hangup (SIGHUP)
Dec  6 06:55:18 bait pppd[18490]: Modem hangup
Dec  6 06:55:18 bait pppd[18490]: Exit.

I posted the output of 'hcidump -X -V' at:

http://www.valites.net/hcidump

I'm pretty much out of ideas at this point - if anyone has any 
suggestions, I'm eager to investigate them further.

-Mark

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

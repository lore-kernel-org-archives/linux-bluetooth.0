Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Carlos Azevedo <carlosarazevedo@netcabo.pt>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200411281307.43051.carlosarazevedo@netcabo.pt>
Subject: [Bluez-users] State of snd-bt-sco
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
Date: Sun, 28 Nov 2004 13:07:42 +0000

Greetings,

Is snd-bt-sco (from the CVS) currently working ? I can get btsco (the app) to 
connect to the headset 
(http://sourceforge.net/mailarchive/forum.php?thread_id=6030842&forum_id=1883)
and get the following :

Device is 1:0
Voice setting: 0x0060
RFCOMM channel 1 connected
recieved AT+CKPD=200
opened hwdep
connected SCO channel
Setting sco fd
Done setting sco fd
recieved AT+VGS=04
Sending up speaker change 4

but when I run aplay (aplay -D hw:1 prompt-copia1.wav) or arecord it exits 
with

Playing WAVE 'prompt-copia1.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, 
Mono
aplay: pcm_write:1118: write error: Input/output error

I've sprinkled the kernel driver with dprintks but apparently there is no data 
going from the SCO socket to the ALSA driver.
By the way both in btsco and in the driver there's some structs and other 
variables declared inside the code (not at the top of the function). GCC 
2.95.x doesn't like it, so it would be nice if they were moved upstream.

I really need this stuff working, so please give me some pointers as I am 
wiling to hack the code (and hopefully able...)

Carlos A. R. Azevedo


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

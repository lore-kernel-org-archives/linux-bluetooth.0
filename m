Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41A9FD76.9070706@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] State of snd-bt-sco
References: <200411281307.43051.carlosarazevedo@netcabo.pt>
In-Reply-To: <200411281307.43051.carlosarazevedo@netcabo.pt>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Sun, 28 Nov 2004 09:31:50 -0700

Carlos

> Is snd-bt-sco (from the CVS) currently working ? I can get btsco (the app) to 
> connect to the headset 
> (http://sourceforge.net/mailarchive/forum.php?thread_id=6030842&forum_id=1883)

I have not tested it since the module was made standalone. No one has 
reported using it with your plantronics m2500 headset. Do you have a 
different adapter (like a CSR-based usb) you could try it with by the way?

> and get the following :
> 
> Device is 1:0
> Voice setting: 0x0060
> RFCOMM channel 1 connected
> recieved AT+CKPD=200
> opened hwdep
> connected SCO channel
> Setting sco fd
> Done setting sco fd
> recieved AT+VGS=04
> Sending up speaker change 4

looks good

> but when I run aplay (aplay -D hw:1 prompt-copia1.wav) or arecord it exits 
> with
> 
> Playing WAVE 'prompt-copia1.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, 
> Mono
> aplay: pcm_write:1118: write error: Input/output error

does it exit immediately or after a timeout?

if you're using gnome, be sure to "esdctl off" so you're not competing 
with esound.

i had to get everything just perfect with alsa before it would work. 
what does the also stuff in modules.conf look like? mine is:

options snd major=116 cards_limit=2 device_mode=0660 device_gid=29 
device_uid=0

alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss

alias snd-card-0 snd_intel8x0
alias snd-card-1 snd_bt_sco
#alias snd-card-2 snd-share
#alias snd-card-3 snd-virmidi

alias sound-slot-0 snd-card-0
alias sound-slot-1 snd-card-1
alias sound-slot-2 snd-card-2
alias sound-slot-3 snd-card-3

also i found my "alsasound" script under debian was not set up to start 
at boot.

> By the way both in btsco and in the driver there's some structs and other 
> variables declared inside the code (not at the top of the function). GCC 
> 2.95.x doesn't like it, so it would be nice if they were moved upstream.

give us line numbers or a patch please.

brad


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

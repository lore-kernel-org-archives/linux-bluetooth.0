Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] State of snd-bt-sco
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200411281307.43051.carlosarazevedo@netcabo.pt>
References: <200411281307.43051.carlosarazevedo@netcabo.pt>
Content-Type: text/plain
Message-Id: <1101664326.18467.56.camel@pegasus>
Mime-Version: 1.0
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
Date: Sun, 28 Nov 2004 18:52:06 +0100

Hi Carlos,

> Is snd-bt-sco (from the CVS) currently working ? I can get btsco (the app) to 
> connect to the headset 
> (http://sourceforge.net/mailarchive/forum.php?thread_id=6030842&forum_id=1883)
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
> 
> but when I run aplay (aplay -D hw:1 prompt-copia1.wav) or arecord it exits 
> with
> 
> Playing WAVE 'prompt-copia1.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, 
> Mono
> aplay: pcm_write:1118: write error: Input/output error
> 
> I've sprinkled the kernel driver with dprintks but apparently there is no data 
> going from the SCO socket to the ALSA driver.

for me it is working. What is the output of "hciconfig -a"? What kernel
are you running and what Linux distribution do you use? Do you checked
with hcidump what packets are sent?

> By the way both in btsco and in the driver there's some structs and other 
> variables declared inside the code (not at the top of the function). GCC 
> 2.95.x doesn't like it, so it would be nice if they were moved upstream.

What about sending in a patch?

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Packet Order \ L2CAP Connection
From: Marcel Holtmann <marcel@holtmann.org>
To: lucky Dimas <lucky_d80@hotmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <Sea2-F399C1opccV19X00042b44@hotmail.com>
References: <Sea2-F399C1opccV19X00042b44@hotmail.com>
Content-Type: text/plain
Message-Id: <1080687258.2773.35.camel@pegasus>
Mime-Version: 1.0
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
Date: Wed, 31 Mar 2004 00:54:18 +0200

Hi Lucky,

> First I have to apologize if this message is not directly BlueZ related. I 
> am using my own stack on an embedded platform, but the BlueZ stack was one 
> of its models.
> Anyway, I am trying to connect to my Nokia 6310i over my Embedded platform 
> and so far I have managed to make an inquiry, and find my cell 
> phone(Allthough I had to use the max Page timeout!! Is there something wrong 
> with the Nokia Bluetooth implementation, or is it what I fear: EM problems 
> with my PCB?!)
> Now I am trying to create a RFCOMM connection which needs an L2CAP Channel 
> to run over it. Well here is where the troubles starts. Following a log of 
> the packets after the BB_Connection:
> 
> Baseband Connection Table:
> nr, handle, numOfChan, state, bd_addr
> 0, 0x  28,         0,     4, [00:60:57:23:3b:e0].OPEN
> Sending Connect Request:
> ***T:2
> ** T: 28 **
> ** T: 20 **
> ** T: c **
> ** T: 0 **
> ** T: 8 **
> ** T: 0 **
> ** T: 1 **
> ** T: 0 **
> ** T: 2 **
> ** T: 2 **
> ** T: 4 **
> ** T: 0 **
> ** T: 3 **
> ** T: 0 **
> ** T: 40 **
> ** T: 0 **max chang
> 
> ** R: 4[1]**
> ** R: 13
> ** R: 5
> ** R: 1
> ** R: 28
> ** R: 0
> ** R: 1
> ** R: 0
> # compl.
> 
> ** R: 4[1]**
> ** R: d
> ** R: 15
> ** R: 0
> ** R: 28
> ** R: 0
> ** R: 0
> ** R: 1
> ** R: 0
> ** R: 0
> ** R: 0
> ** R: 0
> ** R: 0
> ** R: 0
> ** R: 0
> ** R: 0
> ** R: ff
> ** R: ff
> ** R: ff
> ** R: ff
> ** R: ff
> ** R: ff
> ** R: ff
> ** R: ff
> 
> ** R: 2
> ** R: 28
> ** R: 20
> ** R: 10
> ** R: 0
> ** R: c
> ** R: 0
> ** R: 1
> ** R: 0
> ** R: 3
> ** R: 2
> ** R: 8
> ** R: 0
> ** R: 40
> ** R: 0
> ** R: 40
> ** R: 0
> ** R: 0
> ** R: 0
> ** R: 0
> ** R: 0
> QOS Compl.
> W4_ACL_HDR
> 
> 
> While I Do realize that my UART (Duart to be exact)implementation might 
> contain bugs, I am not quite sure how to interpret this packet order, or 
> what to await. Has someone a Packet sequence for a succesfull RFCOMM 
> connection available? What is my stack supposed to sent after the QOS Setup, 
> is there some kind of diagram available? I checked the specs, looked in 
> "Connect without Cables", and "Das Bluetooth handbuch", but I couldn't find 
> anything...

I don't even understand your log output and it will take me too much
time to think about it. If you want a sample packet sequence you can use
hcidump in raw mode to see what is going on. But this will be HCI layer
and not baseband.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

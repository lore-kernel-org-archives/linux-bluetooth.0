Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
Reply-To: ssc@tziranda.com
Subject: A couple of questions related to a rfcomm server
To: linux-bluetooth@vger.kernel.org
Date: Wed, 13 Jul 2011 11:51:53 +0100
MIME-Version: 1.0
From: =?iso-8859-15?Q?S=E9rgio_Capela?= <ssc@tziranda.com>
Message-ID: <op.vyj0grkdv7v2p6@capela.tziranda.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hello,

since this is the only contact available at bluez.com I'm sending these  
questions to this list. If this is not the contact to be used please  
direct me to the one which is.

I'm trying to make a sort of content server using bluetooth. As such I  
coded a non blocking rfcomm server which accepts remote connections and  
according to the received connections sends data back. The machine doing  
this uses two bluetooth adapters and one is binded to the accepting  
socket, however the same machine, in this case the same application is  
supposed to scan visible remote bluetooth adapters for rssi values and so  
my first question arises.

Is it possible to accept connections at the same time a inquiry is running  
or is the inquiry a blocking operation at the stack level? With two  
adapters my server accepts remote connections and receives and sends data  
but when an inquiry is running it stops accepting connections. The inquiry  
is done in a separate thread.

Another question is related to a rfcomm client getting into D state and  
thus not killable. Due to my setup (two adapters in the same computer) I  
can use the computer as both the server and the client. For test purposes  
only I made a simple rfcomm client and I put it in a shell cycle thus  
stressing the system regarding bluetooth connections. In this situation  
the rfcomm client application becomes unresponsive after some time due to  
a non exiting disk sleep. I then end up with multiple instances of the  
same application and I can't kill them. By launching the application after  
this I can see that the code blocks at a socket connection command  
entering in a disk sleep state from which it doesn't exit. When this  
happens I have to unplug the bluetooth adapter to get it working again  
since it starts to give timeouts with hciconfig commands like "hciconfig  
reset".

Any ideas about this? The problem itself is not serious since it shouldn't  
arise in normal conditions but it does require a reboot because of the  
state D processes and makes the adapter unusable unless it is unplugged.

Best regards,
-- 
Sérgio Pedro dos Santos Capela - Tziranda

Polo Tecnológico de Lisboa
Edifício Empresarial 3
1600-546 Lisboa

Telf:  21 314 09 83
Telml: 96 491 94 37
Email: ssc@tziranda.com

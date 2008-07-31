Return-Path: <cyrus@holtmann.org>
Message-ID: <48919D91.3070703@krevsbech.dk>
Date: Thu, 31 Jul 2008 13:10:09 +0200
From: Kasper Revsbech <mail@krevsbech.dk>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: How to set packet type and how to see which packet type is in use
 ?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi
I am trying to compare some different Bluetooth setup. Doing that I 
would like to try with different baseband packet types.
So far I have been trying in two scenarios using hciconfig hci0 ptype 
<type> and that seems to work, at least in the case where I am using 
RFCOMM sockets for communication. But judging from the transfer rate it 
does not seem to work using a PAND/BNEP setup. This leads to the 
following questions:

 - How can I observe the currently uses packet type? I have been trying 
with hcidump and even parsed it with wireshark but can't really find the 
identifier that identifies witch packet type currently  is in use.

 - Can I by somehow set the packettype using setsocktop() on a rfcomm 
socket ? I have been look to find documentation on the content of the 
sockopt struc used but can't really find any. I have also tried looking 
in the code but can't figure out how to manipulate the packet type else 
that using hciconfig

Thanks
Kasper Revsbech

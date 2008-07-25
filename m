Return-Path: <cyrus@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <984C6308-74DB-4E3E-8790-2F4A380D6447@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: Kasper Revsbech <mail@krevsbech.dk>
In-Reply-To: <48897AB7.20700@krevsbech.dk>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v928.1)
Subject: Re: RFCOMM server multiple client connections
Date: Fri, 25 Jul 2008 14:31:50 +0200
References: <488870AF.3080601@krevsbech.dk> <1216908785.7820.13.camel@californication> <48897AB7.20700@krevsbech.dk>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kasper,

>>> I am trying do do a simple client server setup  with bluez.
>>> I can manage to have a client and a server on rfcomm sockets where  
>>> the server listen on a socket and accept a connection from the  
>>> client by connect. But then if I set the server back to accepting  
>>> without putting down the one client connection it doesn't accept a  
>>> new connection.
>>> When I read thought the documentation I can find on Bluez and  
>>> Bluetooth in general it seems like it should be possible to  
>>> multiplex serveal virtual rfcomm connections  on one actual  
>>> connection. But however I really can get it working and can't find  
>>> any code where they do something similar.
>>>
>>
>> are the clients running on multiple adapters.If they run on the  
>> sameadapter, it won't work. RFCOMM is not a layer that assign dynamic
>> channels numbers to each connection (like L2CAP does) and thus once a
>> RFCOMM channel is in use (the pair is bdaddr:channel) then you can
>> connect to it twice.
>>
>>
> Exactly the client sockets are all originated from the same adapter.  
> What I want to do is by some libsocks tricks to emulate a native tcp/ 
> ip socket and provide nearly the same interface. So far I have been  
> using RFCOMM. As I understand you, this setup with multiple sockets  
> connections from each host is possible using a l2cap socket instead.  
> Which leads into the next question. Reading documentation on  
> Bluetooth stacks in general some seems to provide a SOCK_STREAM type  
> using l2cap. However this does not seems to be the case in the Bluez  
> stack. So is there a way to have a somehow reliable stream  
> connection  allowing multiple connections from each host?

RFCOMM is SOCK_STREAM and L2CAP is SOCK_SEQPACKET. If someone  
implements L2CAP retransmission and flow-control we could have  
SOCK_STREAM for L2CAP, too.

Regards

Marcel


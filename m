Return-Path: <matthias@ma-c.de>
Subject: Re: [Bluez-users] rfcomm pppd
From: Matthias Albert <matthias@ma-c.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1097927566.4911.7.camel@pegasus>
References: <1097845922.12708.16.camel@ringo.aicas.burg>
	 <1097927566.4911.7.camel@pegasus>
Content-Type: text/plain
Message-Id: <1097945209.20193.1.camel@fragger>
Mime-Version: 1.0
Date: Sat, 16 Oct 2004 18:46:50 +0200
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,
> Hi Matthias,
> 
>> now I'm able to establish a connection from my ipaq (running
familiar)
>> to my notebook (linux, debian host).
>>
>> hcitool scan -> list of all available bluetooth devices
>>  -> select the one I need
>> sdptool browse <bluetoothadress> -> gives me list of all availble
>> profiles
>>
>> rfcomm connect  <bluetoothadress> 1 -> do a serial connection to my
bt
>> device
>>
>> rfcomm show -> give me a list of established connections
>>
>> So everytime I do this, the pppd is starting. If nothing happens the
>> connection will be closed. Where can I define which program should be
>> started? I don't want that pppd is starting. I want to see with
minicom
>> what happen on the device. Do you know what I mean?. So where can I
>> define this?
> 
> I don't understand what you mean. Do you establish the connection from
> your iPAQ or from your notebook?
Now I know how it works :). Im sorry for my not clear question.
Everytime I started "rfcomm connect" from my ipaq to establish a
connection to my notebook -> the ppp daemon on my notebook was starting
and using the rfcomm device. So I was not able to use minicom for the
rfcomm device. My question obtained how I can configure or choose the
program that should be started on my client (in this case notebook =
client).

But I learned that I can do "rfcomm bind" and after that I can use the
device with any program I want. If so I had to establish a serial
bluetooth  connection between the ipaq and a linux client and after that
I have to run a little java program to test javax.com.  And it works
perfectly :). Marcel thx a lot for your clear and excellent
documentation at 

http://www.holtmann.org/papers/bluetooth/uptimes2003.html

Have a nice time and a nice weekend.

Kind regards,
Matthias

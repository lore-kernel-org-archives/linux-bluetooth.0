Return-Path: <Linux@feline-soul.com>
From: "Bearcat M. Sandor" <Linux@feline-soul.com>
Reply-To: Linux@feline-soul.com
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] Page timeout on Logetech cordless elite keyboard but mouse works
Date: Wed, 26 Jul 2006 01:40:09 -0600
Cc: BlueZ users <bluez-users@lists.sourceforge.net>
References: <200607260027.41270.Linux@feline-soul.com> <1153898346.746.4.camel@localhost>
In-Reply-To: <1153898346.746.4.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200607260140.10216.Linux@feline-soul.com>
List-ID: <bluez-users.lists.sourceforge.net>

Marcel,

hidd --server is indeed running. 

At my start up i do:
modprobe hidp
/usr/bin/hidd --server
hid2hci -0
/usr/bin/hidd --connect 00:07:61:1d:29:32

That connects the mouse just fine. However the keyboard never wakes up.  Even 
removing and replacing a battery does nothing. A "/usr/bin/hidd --connect 
00:07:61:1B:50:9B" just gives me the time out error. (forget the MAC i 
entered below, i cut/paste the wrong one). Nothing appears in my syslogs when 
i do a hdd --connect.

Thanks for the help so far,

Bearcat

On Wednesday 26 July 2006 01:19 in an email titled "Re: [Bluez-users] Page 
timeout on Logetech cordless elite keyboard but mouse works" Marcel Holtmann 
wrote:
>Hi Bearcat,
>
>> I am running sourcemage gnu/linux. My kernel is 2.6.17 and blues-libs and
>> bluez-utils are versions 3.1. I have a Logitech cordless elite set
>> (keyboard and MX 900 mouse).
>>
>> The basis for my work on it so far is here:
>> http://www.bueche.ch/comp/mx900/mx900.html
>>
>> The logitech hub switches over to hci just fine and the mouse is
>> successfully connected via blue tooth. (Note, both mouse and kb work in
>> pure hid mode with no bluetooth). I need the bluetooth hub working as i
>> will be getting a headset this week, that i need to have operational
>>
>> However, i can not get the keyboard to connect. When i enter a "hidd
>> --connect 00:07:61:1d:29:32" i get "Can't get device information: Host is
>> down" from the terminal  and "Problem connecting with 00:07:61:1d:29:32:
>> Page Timeout" on a kdebluetooth tool tip.
>>
>> I have hit the connect button on the keyboard repeatedly and even taken
>> out a battery for a few seconds. I have verified that i am using the
>> correct MAC address via the printing on the bottom of the keyboard.
>>
>> I'll be happy to provide what ever config info you all need to help me
>> resolve this.
>
>make sure that "hidd --server" is running, because the keyboard will
>re-connect to you.
>
>Regards
>
>Marcel

-- 
Bearcat M. Sandor
Bearcat@feline-soul.com
ICQ: 6628727
MSN: bearcatsandor@hotmail.com
Yahoo: bearcatsandor
AIM: bearcatmsandor
Jabber: bearcatsandor@jabber.org

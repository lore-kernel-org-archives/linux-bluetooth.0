Return-Path: <Linux@feline-soul.com>
From: "Bearcat M. Sandor" <Linux@feline-soul.com>
Reply-To: Linux@feline-soul.com
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] Page timeout on Logetech cordless elite keyboard but mouse works
Date: Wed, 26 Jul 2006 02:11:03 -0600
Cc: BlueZ users <bluez-users@lists.sourceforge.net>
References: <200607260027.41270.Linux@feline-soul.com> <200607260140.10216.Linux@feline-soul.com> <1153899970.746.28.camel@localhost>
In-Reply-To: <1153899970.746.28.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200607260211.03793.Linux@feline-soul.com>
List-ID: <bluez-users.lists.sourceforge.net>

Marcel,

The hidd --connect is only being issued once.  The keyboard never connects to 
me.

Bearcat


On Wednesday 26 July 2006 01:46 in an email titled "Re: [Bluez-users] Page 
timeout on Logetech cordless elite keyboard but mouse works" Marcel Holtmann 
wrote:
>Hi Bearcat,
>
>> hidd --server is indeed running.
>>
>> At my start up i do:
>> modprobe hidp
>> /usr/bin/hidd --server
>> hid2hci -0
>> /usr/bin/hidd --connect 00:07:61:1d:29:32
>>
>> That connects the mouse just fine. However the keyboard never wakes up. 
>> Even removing and replacing a battery does nothing. A "/usr/bin/hidd
>> --connect 00:07:61:1B:50:9B" just gives me the time out error. (forget the
>> MAC i entered below, i cut/paste the wrong one). Nothing appears in my
>> syslogs when i do a hdd --connect.
>
>the "hidd --connect ..." should only be used once. Every further connect
>will be done by the keyboard or the mouse. I stated this various times.
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

Return-Path: <oliver.ellis@ntlworld.com>
Message-ID: <40605F5C.30902@ntlworld.com>
Date: Tue, 23 Mar 2004 16:01:32 +0000
From: Oli Ellis <oliver.ellis@ntlworld.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] dinovo multimedia keys
References: <406005DB.2090109@ntlworld.com> <1080051605.2515.20.camel@pegasus>
In-Reply-To: <1080051605.2515.20.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Re: the dinovo wrong consumer usage

Possibly cracked it?

>>My question is, are the consumer keymaps in parser.c some sort of 
>>immutable bluetooth standard or just what your personal keyboard is? For 
>>example, you have the following for volumes:
>>        case 0xe2:    butt = KEY_MUTE;    break;
>>        case 0xe9:    butt = KEY_VOLUMEUP;    break;
>>        case 0xea:    butt = KEY_VOLUMEDOWN;    break;
>>Whereas, my dinovo works with
>>        case 0xe3:    butt = KEY_MUTE;    break;
>>        case 0xea:    butt = KEY_VOLUMEUP;    break;
>>        case 0xeb:    butt = KEY_VOLUMEDOWN;    break;
>>What sort of keyboard do you have?
>>
>Maybe there is a bit error somewhere in parser.c. Actually the consumer
>usages are defined in the USB HID standard and should be general for all
>Bluetooth keyboards.
>  
>
It does not seem to be an error with the parser - I checked the USB HID 
usage tables, and they tally up with the parser code. However, the 
consumer buttons on the dinovo all seem to be out by one. For example:

Key label	keyboard reports (hex)	Should be (hex)
-------------------------------------------------------
My Pictures	1b7			1b6
My Music	1b8			1b7
Volume+		ea			e9
Volume-		eb			ea
Mute		e3			e2
&c

Now the question is whether this is a problem in hardware (and if so how
widespread it is), or the kernel bluetooth bit, or the parser. I can't see
anything wrong with parser.c, and am inclined towards a bodge job by
Logitech (and I was so pleased with my new keyboard...) However the
DiNovo is widespread, so if it is a HID implementation error, any ideas on
how it can be elegantly worked around?

Regards,
Oli

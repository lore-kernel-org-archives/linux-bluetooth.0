Return-Path: <zhikui.chen@po.uni-stuttgart.de>
Message-ID: <40E40A44.60008@po.uni-stuttgart.de>
Date: Thu, 01 Jul 2004 14:57:40 +0200
From: Zhikui Chen <zhikui.chen@po.uni-stuttgart.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: bluez-users <bluez-users@lists.sourceforge.net>
Subject: Re: Help for bluez-bluefw-1.0.
References: <40E40440.8070109@po.uni-stuttgart.de> <1088685238.4540.190.camel@pegasus>
In-Reply-To: <1088685238.4540.190.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Thanks. Whats bluez modules will be needed for 2.6.7?

 Bluetooth I will use is USB dongle ePox and the courrent kernel is 2.6.7.
I configured 2.6.7 kernel and built it. and built bluez stuffs: hcidump, 
hciemu, libs2.7, pan1.1, utils2.7
And I modified /etc/modules.conf by adding lines:
alias bt-proto-0 l2cap
alias net-pf-31 bluez
alias bt-proto-2 sco
alias bt-proto-3 rfcomm
alias bt-proto-4 bnep
alais char-major-10-250 hci_uhci

BUT:
For my redhat 8 (my notebook PCG 2600TEK only can be installed redhat 8, 
redhat 9 and mandrake 9.2 could not be install), hciconfig could not be 
found, and using locate hciconfig, there is output. Marcel could tell me 
the reason and how should I do?
For my redhat 9 (my PC), hciconfig reports that Can't open HCI socket, 
Address family not surport by protocol, but for 2.4.25, it is ok. Would 
you like to tell me, whta sould I do? I want to build a bluetooth 
connection betweent my pc and my notebook. The both bluetooth drivers 
are BT-DG03 (USB ePOX).

Thanks a lot.

Zhikui

Marcel Holtmann wrote:

>Hi Zhikui,
>
>  
>
>>I have download bluez-bluefw-1.0 source code for Redhat 8 and 9, and 
>>extracted the gziped file. But ./configure outputs "configure error : 
>>Linux kernel source not found in /usr/src/linux", who can tell me why 
>>and how to the next step? And tried to install bluez-bluefw-1.0.rpm, I 
>>was told cannot open packages database in /var/lib/rpm and I am sure I 
>>am root login.
>>    
>>
>
>for what driver do you need bluefw? If you use a 2.6.7 kernel then there
>is no need to use bluefw.
>
>Regards
>
>Marcel
>
>
>
>  
>

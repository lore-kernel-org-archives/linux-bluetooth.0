Return-Path: <cyrus@holtmann.org>
Message-ID: <4A64127A.5070901@dtsp.co.nz>
Date: Mon, 20 Jul 2009 18:45:14 +1200
From: David Sainty <David.Sainty@dtsp.co.nz>
MIME-Version: 1.0
To: linux bluetooth mailinglist <linux-bluetooth@vger.kernel.org>,
	madduck@madduck.net
Subject: Re: How to replace DUN with bluez 4?
References: <20090718055411.GA21651@piper.oerlikon.madduck.net> <2d5a2c100907191036o7c48c405r32f0292a9168cb92@mail.gmail.com> <20090719175737.GA9278@piper.oerlikon.madduck.net> <2d5a2c100907191120g79980cebme985bbff2fbb6ef5@mail.gmail.com> <20090720052314.GA10357@piper.oerlikon.madduck.net>
In-Reply-To: <20090720052314.GA10357@piper.oerlikon.madduck.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

martin f krafft wrote:
> also sprach Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2009.07.19.2020 +0200]:
>   
>> Have you tried this:
>> https://help.ubuntu.com/community/BluetoothDialup#Configuring%20PPP
>>     
>
> It's the wrong way around: I don't want to connect my computer via
> the phone, I want to give my Palm access to the Net via my computer.
>   
I use this (Palm T3).  It's a bit of a hack, and relies on proxyarp, 
which means it doesn't work if your computer is using a second PPP link 
itself for networking (or OpenVPN). NAT would be cleaner.  It also 
(enormous hack) guesses an IP address for the Palm by XORing the 
machine's own IP by 0.0.0.64.

#!/bin/sh
: ${rfdevice:=rfcomm0}
iface=`netstat -rn|sed -n -e 's/^0\.0\.0\.0 .* 
\([a-z][a-z]*[0-9][0-9]*\)$/\1/p'`
set -- x `ifconfig $iface | sed -n -e 's/^ *inet 
addr:\([0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\)\.\([0-9][0-9]*\) .*$/\1 
\2/p'`
localIP="${2}.${3}"
bluetoothIP="${2}.$((${3}^64))"
dns=`sed -n -e 's/^nameserver  *\([0-9][0-9.]*\)[^0-9]*$/ms-dns \1/p' < 
/etc/resolv.conf`
sysctl -w net.ipv4.ip_forward=1
sdptool add --channel=1 SP
rfcomm --encrypt watch "$rfdevice" 1 pppd '{}' 
"${localIP}:${bluetoothIP}" local nodetach noauth proxyarp $dns

> Right, but they are Linux Desktop. dund worked on non-desktops.
>
> It's scary to see this desktop trend. It's like Windows NT 4.0, and
> the Windows-typical need to log in to be able to start a firewall or
> fileserver.
>
>   

It does seem like an omission.


Return-Path: <rafael@3wt.com.br>
Message-ID: <4162D886.8010406@3wt.com.br>
Date: Tue, 05 Oct 2004 14:23:18 -0300
From: Rafael Vidal Aroca <rafael@3wt.com.br>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcommX and ppp
References: <41629C2B.4040201@3wt.com.br> <1096991861.20349.73.camel@pegasus>
In-Reply-To: <1096991861.20349.73.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>


       Well, everything is fine, but my ppp is configured to give a 
unique ip. You can check this from my peer file /etc/ppp/peers/dun that 
follows:

    # do not require auth
noauth

# do not use modem control lines we aren't using a real serial line
local

# do not determinate local ip from hostname
noipdefault

# usefull ARP proxing
proxyarp

# do not enable default route
nodefaultroute

# do not use ipx
noipx

# set disconnect timeout
idle 0

# local ip : remote ip
10.0.0.1:10.0.0.2

# dns
ms-dns 10.0.0.1

# netmask
netmask 255.255.255.0


    Note the line: 10.0.0.1:10.0.0.2

    Can i change this to multiple ips? Because the problem is exactly 
this: all devices in the same ip...

[]s Rafael.



Marcel Holtmann wrote:

>Hi Rafael,
>
>  
>
>>    i set up a Linux box as a gateway for pdas to access internet. The 
>>first device that connects to the LAN service gets rfcomm0 and have 
>>internet access!
>>
>>    The other devices get rfcomm1, rfcomm2, rfcomm3.....all ok up to now.
>>
>>    The problem is that none of then estabilishes a ppp connection. What 
>>could it be?
>>    
>>
>
>I have no idea. Tell us more about your setup. Do you use dund?
>
>Regards
>
>Marcel
>
>  
>

Return-Path: <JRODRIGUEZV@telefonica.net>
Message-ID: <409C9E4B.3070607@telefonica.net>
Date: Sat, 08 May 2004 10:46:03 +0200
From: Jose Angel Rodriguez <jrodriguezv@telefonica.net>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] NAP problem
References: <409B756D.6000705@telefonica.net>	 <1083946390.4420.120.camel@pegasus>  <409C1B27.1050205@telefonica.net> <1083972662.4420.156.camel@pegasus>
In-Reply-To: <1083972662.4420.156.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Marcel Holtmann wrote:

>Hi Jose,
>
>  
>
>>>>I hava a Debian Sarge PC as a NAP for a bluetooth network. The computer 
>>>>is also connected to an ADSL.
>>>>
>>>>This is my etc/network/interfaces file:
>>>># /etc/network/interfaces -- configuration file for ifup(8), ifdown(8)
>>>>
>>>># The loopback interface
>>>>auto lo
>>>>iface lo inet loopback
>>>>
>>>># The first network card - this entry was created during the Debian 
>>>>installation# (network, broadcast and gateway are optional)
>>>>auto eth0
>>>>iface eth0 inet static
>>>>      address 192.168.0.2
>>>>      netmask 255.255.255.0
>>>>      network 192.168.0.0
>>>>      broadcast 192.168.0.255
>>>>      gateway 192.168.0.1
>>>>
>>>># bluetooth network server
>>>>iface bnep0 inet static
>>>>      address 10.0.0.1
>>>>      netmask 255.255.255.0
>>>>
>>>>eth0 is the ADSL connection an bnep0 is the bluetooth connection.
>>>>
>>>>My /etc/bluetooth/pan/dev-up file:
>>>>#!/bin/sh
>>>>ifup bnep0
>>>>
>>>>I think everytime a client connects it runs /etc/bluetooth/pan/dev-up. 
>>>>Everything was working fine, but after updating packages with apt-get 
>>>>everytime a client connects I have to configure bnep0 interface by hand 
>>>>(ifup bnep0).
>>>>
>>>>¿Does anybody know why /etc/bluetooth/pan/dev-up does not work now? ¿How 
>>>>can I configure bnep0 interface automaticaly?
>>>>   
>>>>
>>>>        
>>>>
>>>what about putting "auto bnep0" into the interfaces file ;)
>>>
>>>      
>>>
>>I tried this but it doesn't work. It was working fine with this 
>>interfaces file, but now :-(
>>    
>>
>
>my fault, the auto is for the boot time. You don't need any extra stuff
>and you also don't need any PAN dev-up script. Check your hotplug
>installation why it is not working. It is not a BlueZ problem.
>
>  
>
>>¿Should /etc/bluetooth/pan/dev-up run everytime a client connects? If I 
>>run that scrip manualy everythig works fine.
>>    
>>
>
>I don't know, because I never used it.
>
>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by Sleepycat Software
>Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
>higher performing products faster, at low TCO.
>http://www.sleepycat.com/telcomwpreg.php?From=dnemail3
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>  
>
Thank you very much for your time and your help :-)

Jose

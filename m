Return-Path: <mreimer@vpop.net>
Message-ID: <4032E275.8050801@vpop.net>
Date: Tue, 17 Feb 2004 21:56:37 -0600
From: Matthew Reimer <mreimer@vpop.net>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] How to configure a 723kbps connection?
References: <lists.bluez.users.1077061006.2665.141.camel@pegasus.SOMEWHERE> <lists.bluez.users.4032E137.7080902@vpop.net>
In-Reply-To: <lists.bluez.users.4032E137.7080902@vpop.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Matthew Reimer wrote:
> Marcel Holtmann wrote:
> 
>>Run "hcidump -w <file>" (as root).
>>  
>>
> Ok, it's at http://sermons.desiringGod.org/~mreimer/h2215.dump. It's 
> large (11M), but I thought that it would be better to give you more info 
> than less. This is what I did:
> 
> 1. linux: start hcidump
> 2. ipaq: start a NAP session from PocketPC2003 to the linux box
> 3. ipaq: start PocketIE and began downloading a movie trailer
> 4. ipaq: stopped the download after a minute or so
> 5. ipaq: disconnected the NAP connection, then turned off bluetooth
> 6. linux: stopped the dump
> 
> My Actiontec dongle is 00:20:E0:3A:2E:57 and the ipaq is 00:04:3E:81:90:E0.
> 
> Let me know if there might be sensitive information in this dump so I 
> can respond appropriately. I hope this info helps.
> 
> Matt

BTW, the bluetooth dongle on the linux box was in its normal state:

$ hciconfig -a
hci0:   Type: USB
         BD Address: 00:20:E0:3A:2E:57 ACL MTU: 192:8  SCO MTU: 64:8
         UP RUNNING PSCAN ISCAN AUTH ENCRYPT
         RX bytes:2825848 acl:32991 sco:0 events:161779 errors:0
         TX bytes:42819062 acl:228294 sco:0 commands:117 errors:0
         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy: HOLD SNIFF PARK
         Link mode: ACCEPT MASTER
         Name: 'sermons.desiringGod.org-0'
         Class: 0x000104
         Service Classes: Unspecified
         Device Class: Computer, Desktop workstation
         HCI Ver: 1.1 (0x1) HCI Rev: 0x322 LMP Ver: 1.1 (0x1) LMP 
Subver: 0x322
         Manufacturer: Cambridge Silicon Radio (10)

Matt

Return-Path: <andrew@radke.iig.com.au>
Message-ID: <3F26FB4B.6060007@radke.iig.com.au>
Date: Wed, 30 Jul 2003 08:55:07 +1000
From: Andrew Radke <andrew@radke.iig.com.au>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluez and OBEX File Transfer
References: <3F229216.3060000@radke.iig.com.au>
	<1059380203.1015.80.camel@pegasus>
In-Reply-To: <1059380203.1015.80.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Marcel Holtmann wrote:
[snip]
> I have started a btftp client, which you can found in the BlueZ CVS in
> the repository obex. But at the moment no btftpd exists.

The client will be a nice addition. Any plans on the btftpd? Anything a 
non-programmer can do to help? Write it in Perl maybe? :-)

> BTW please send me "hcitool info <t610-bdaddr>" and the complete sdptool
> browse for your phone.
> 
> Regards
> 
> Marcel

# hcitool info 00:0a:**:**:**:**
Requesting information ...
         BD Address:  00:0a:**:**:**:**
         Device Name: T610
         LMP Version: 1.1 (0x1) LMP Subversion: 0x400
         Manufacturer: Ericsson Mobile Comunications (0)
         Features: 0x04 0xea 0x31 0x00
                 <encryption> <RSSI> <SCO link> <HV3 packets>
                 <u-law log> <A-law log> <CVSD>

# sdptool browse 00:0a:**:**:**:**
Browsing 00:0A:**:**:**:** ...
Service Name: Dial-up Networking
Service RecHandle: 0x10000
Service Class ID List:
   "Dialup Networking" (0x1103)
   "Generic Networking" (0x1201)
Protocol Descriptor List:
   "L2CAP" (0x0100)
   "RFCOMM" (0x0003)
     Channel: 1
Profile Descriptor List:
   "Dialup Networking" (0x1103)
     Version: 0x0100

Service Name: Voice gateway
Service RecHandle: 0x10002
Service Class ID List:
   "Headset Audio Gateway" (0x1112)
   "Generic Audio" (0x1203)
Protocol Descriptor List:
   "L2CAP" (0x0100)
   "RFCOMM" (0x0003)
     Channel: 3
Profile Descriptor List:
   "Headset" (0x1108)
     Version: 0x0100

Service Name: Serial Port 1
Service RecHandle: 0x10003
Service Class ID List:
   "Serial Port" (0x1101)
Protocol Descriptor List:
   "L2CAP" (0x0100)
   "RFCOMM" (0x0003)
     Channel: 4

Service Name: Serial Port 2
Service RecHandle: 0x10004
Service Class ID List:
   "Serial Port" (0x1101)
Protocol Descriptor List:
   "L2CAP" (0x0100)
   "RFCOMM" (0x0003)
     Channel: 5

Service Name: OBEX Object Push
Service RecHandle: 0x10005
Service Class ID List:
   "OBEX Object Push" (0x1105)
Protocol Descriptor List:
   "L2CAP" (0x0100)
   "RFCOMM" (0x0003)
     Channel: 10
   "OBEX" (0x0008)
Profile Descriptor List:
   "OBEX Object Push" (0x1105)
     Version: 0x0100

Service Name: IrMC Synchronization
Service RecHandle: 0x10006
Service Class ID List:
   "IrMCSync" (0x1104)
Protocol Descriptor List:
   "L2CAP" (0x0100)
   "RFCOMM" (0x0003)
     Channel: 11
   "OBEX" (0x0008)
Profile Descriptor List:
   "IrMCSync" (0x1104)
     Version: 0x0100

Service Name: HF Voice gateway
Service RecHandle: 0x10007
Service Class ID List:
   "" (0x111f)
   "Generic Audio" (0x1203)
Protocol Descriptor List:
   "L2CAP" (0x0100)
   "RFCOMM" (0x0003)
     Channel: 6
Profile Descriptor List:
   "" (0x111e)
     Version: 0x0100

Service Name: OBEX Basic Imaging
Service RecHandle: 0x1000b
Service Class ID List:
   "" (0x111b)
Protocol Descriptor List:
   "L2CAP" (0x0100)
   "RFCOMM" (0x0003)
     Channel: 15
   "OBEX" (0x0008)
Profile Descriptor List:
   "" (0x111a)
     Version: 0x0100

Service Name: OBEX File Transfer
Service RecHandle: 0x1000f
Service Class ID List:
   "OBEX File Transfer" (0x1106)
Protocol Descriptor List:
   "L2CAP" (0x0100)
   "RFCOMM" (0x0003)
     Channel: 7
   "OBEX" (0x0008)
Profile Descriptor List:
   "OBEX File Transfer" (0x1106)
     Version: 0x0100

Return-Path: <James@superbug.demon.co.uk>
Message-ID: <406B27A8.2000308@superbug.demon.co.uk>
Date: Wed, 31 Mar 2004 21:18:48 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Steven Singer <steven.singer@csr.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] sco / csr final notes
References: <406A9E23.9000406@soft.uni-linz.ac.at>	 <1080730774.2674.6.camel@pegasus> <406AAFFF.6040504@soft.uni-linz.ac.at>	     <406ADF3E.4020502@csr.com> <406AE027.7030000@soft.uni-linz.ac.at>	 <406AF150.8080105@csr.com> <406B17A4.8000607@superbug.demon.co.uk> <1080761775.2536.3.camel@pegasus>
In-Reply-To: <1080761775.2536.3.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
> Hi James,
> 
> 
>>Just out of interest, how does one upgrade the firmware on a USB device 
>>using a CSR chip ?
>>
>>I have this device: -
>>
>>bash-2.05b# hciconfig hci0 version
>>hci0:   Type: USB
>>         BD Address: 00:A0:96:1F:42:BF ACL MTU: 192:8  SCO MTU: 64:8
>>         HCI Ver: 1.1 (0x1) HCI Rev: 0x135 LMP Ver: 1.1 (0x1) LMP 
>>Subver: 0x135
>>         Manufacturer: Cambridge Silicon Radio (10)
>>
>>bash-2.05b# hciconfig hci0 revision
>>hci0:   Type: USB
>>         BD Address: 00:A0:96:1F:42:BF ACL MTU: 192:8  SCO MTU: 64:8
>>         HCI 13.10
>>         Chip version: BlueCore01b
>>         Max key size: 56 bit
>>         SCO mapping:  HCI
> 
> 
> you need a *.dfu firmware file from your dongle manufacturer.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 

The dongle manufacturer is Mitsumi, and I cannot find any firmware files 
for it.
Does anyone know of any url that might have updated firmware for this 
device ?

Cheers
James

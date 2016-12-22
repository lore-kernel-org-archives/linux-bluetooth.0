Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Tom Harada <tomharada@lnihealth.com>
Subject: Changing authentication requirements in older kernel
To: <linux-bluetooth@vger.kernel.org>
Message-ID: <346b1f21-e4f8-fd90-ed08-8cd5614fde7d@lnihealth.com>
Date: Thu, 22 Dec 2016 16:47:00 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I have a BLE device that is unusually picky about the pairing requests 
it receives. As far as I can tell, it will not pair if the MITM bit in 
the authentication requirements is not set, or if the initiator key 
distribution field is not set. It will not pair with BlueZ running under 
kernel 3.10.17, where the pairing request looks like this:

< ACL Data TX: Handle 64 flags 0x00 dlen 11
       SMP: Pairing Request (0x01) len 6
         IO capability: KeyboardOnly (0x02)
         OOB data: Authentication data not present (0x00)
         Authentication requirement: Bonding, No MITM, Legacy, No 
Keypresses (0x01)
         Max encryption key size: 16
         Initiator key distribution: <none> (0x00)
         Responder key distribution: EncKey (0x01)

It will pair under kernel 4.4.11, where the pairing request looks like this:

< ACL Data TX: Handle 64 flags 0x00 dlen 11
       SMP: Pairing Request (0x01) len 6
         IO capability: KeyboardOnly (0x02)
         OOB data: Authentication data not present (0x00)
         Authentication requirement: Bonding - MITM (0x05)
         Max encryption key size: 16
         Initiator key distribution: EncKey IdKey Sign (0x07)
         Responder key distribution: EncKey IdKey Sign (0x07)

I would like to make the older kernel's handling of pairing requests 
match the newer one's. I'm having some success using newer Bluetooth 
kernel modules from backports (3.15.9-1 appears to give the desired 
behavior), but I don't know if this is a good long-term solution since 
the target system is not using a mainline kernel. Is it possible to 
change the authentication requirements and/or initiator key distribution 
in user space?

Thanks,
Tom Harada

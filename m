Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: kernel smp.c functions not called by Bluetootl LE controller
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <89D1DA64-12E6-43B1-8C82-E8CA32BA2AE2@holtmann.org>
Date: Fri, 21 Jul 2017 13:41:01 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <282CA1D1-674A-4216-B838-710D1609EDDA@holtmann.org>
References: <38d8a549-4335-cf0b-9273-d9ef9b51ac0b@rub.de>
 <19307C37-EF03-4E42-AFAD-06855DCB7A3F@holtmann.org>
 <c27d57e1-9f43-8c7c-f352-23ea513771b0@rub.de>
 <89D1DA64-12E6-43B1-8C82-E8CA32BA2AE2@holtmann.org>
To: Martin Grothe <martin.grothe@rub.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Martin,

>>>> I try to call printk (with priority KERN_ALERT) functions placed in the
>>>> net/bluetooth/smp.c file of my linux kernel 4.9.35 in order to get
>>>> output from specifc functions like:
>>>> 
>>>> static int smp_cmd_public_key()
>>>> 
>>>> But during a pairing with another bluetooth LE device the output of
>>>> these function is never shown in /var/log/kern.log
>>>> 
>>>> Is there any way to verify, that the LE Controller accesses the Security
>>>> Manager Protocol source code the Linux Kernel?
>>>> 
>>>> As far as I understood the Core Specification, in BT 4.0 an above the
>>>> Security Manager is always integrated in the Link Manager, when it comes
>>>> to BR/EDR. But for LE the SM is integrated in the Host part and not the
>>>> Controller. Thus LE Controller should access the smp.c in the Linux kernel.
>>> 
>>> just run btmon and you see all the security manager exchanges.
>>> 
>>> Regards
>>> 
>>> Marcel
>>> 
>> Hi Marcel,
>> I tested it, and I saw some basic SMP messages, like:
>> 
>> Sent Pairing Request: Bonding, MITM, Initiator Key(s): LTK CSRK ,
>> Responder Key(s): LTK IRK CSRK
>> 
>> I get a response and a confirmation of the pairing afterwards, but I
>> don't see the key exchange, or the messages from Authentication Stage 1
>> or 2.
>> 
>> Is there any way to log parts of the smp.c functions into kern.log?
> 
> just send the file created via "btmon -w trace.log" and I can tell you what is going on here. My guess is that you do not have LE SC enabled. That means legacy pairing is happening which does not using public key exchange.

< ACL Data TX: Handle 3585 flags 0x00 dlen 11
      SMP: Pairing Request (0x01) len 6
        IO capability: DisplayYesNo (0x01)
        OOB data: Authentication data not present (0x00)
        Authentication requirement: Bonding, MITM, SC, No Keypresses (0x0d)
        Max encryption key size: 16
        Initiator key distribution: EncKey Sign (0x05)
        Responder key distribution: EncKey IdKey Sign (0x07)
> ACL Data RX: Handle 3585 flags 0x02 dlen 11
      SMP: Pairing Response (0x02) len 6
        IO capability: NoInputNoOutput (0x03)
        OOB data: Authentication data not present (0x00)
        Authentication requirement: Bonding, No MITM, Legacy, No Keypresses (0x01)
        Max encryption key size: 16
        Initiator key distribution: Sign (0x04)
        Responder key distribution: EncKey IdKey (0x03)

So while your Linux side supports LE SC, your remote side only supports legacy pairing. Which means no public key exchange will happen,

The LTK information is distributed instead of locally derived as with LE SC that uses ECDH.

> ACL Data RX: Handle 3585 flags 0x02 dlen 21
      SMP: Encryption Information (0x06) len 16
        Long term key: 8eb620e0cf2f490b9a174777d45c57b3
> ACL Data RX: Handle 3585 flags 0x02 dlen 15
      SMP: Master Identification (0x07) len 10
        EDIV: 0x4be8
        Rand: 0xf9cd7eb564bf38b9

Btw. I have yet to see a LE HID device that uses LE SC.

Regards

Marcel


Return-Path: <cyrus@holtmann.org>
Message-ID: <548A2ACB.3080508@netcommwireless.com>
Date: Fri, 12 Dec 2014 10:37:47 +1100
From: Alan Au <alan.au@netcommwireless.com>
MIME-Version: 1.0
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Subject: Re: Unable to make subsequent BLE connections
References: <5488D75C.2010700@netcommwireless.com> <20141211073659.GA14258@t440s.P-661HNU-F1>
In-Reply-To: <20141211073659.GA14258@t440s.P-661HNU-F1>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 11/12/14 18:36, Johan Hedberg wrote:
> Hi Alan,
>
> On Thu, Dec 11, 2014, Alan Au wrote:
>> I'm connecting to a BLE oximeter device. The first couple of connects
>> succeed. But after that the connection always fails. I have tried with both
>> gatttool and with my own code. hcidump shows that the "LE Start Encryption"
>> command fails with  "PIN or Key Missing". If I delete the pairing (that was
>> created by the earlier successful connection) then subsequent connects will
>> succeed for a few times again.
>>
>> I analysed the hcidumps of successful and failed connects. In the failed
>> case, it looks to me like bluez is not sending out an SMP PairingRequest in
>> response to an SMP SecurityRequest from the slave. I can see in the kernel
>> code that smp_cmd_security_req() does not send out the PairingRequest if it
>> finds an LTK. But is that correct? Should it not try to pair anyway because
>> the remote device is requesting it and may have deleted the earlier bonding.
> According to the SMP specification "The Security Request command is used
> by the slave to request that the master initiates security with the
> requested security properties". That doesn't talk about always sending a
> Pairing Request but initiating security, which makes sense since there'd
> otherwise be no other way for the slave to request the connection to be
> encrypted with a shared LTK.

That makes sense and I agree that bluez does appear to be conforming to 
this aspect of the spec.

>
> So sounds like your device is for whatever reason (maybe it's broken)
> loosing its pairing information after some time. Even though our
> behavior with the Security Request should be correct we could consider
> the reaction to the "PIN or Key Missing" error. There's a table in
> section 2.4.4.2 of the SMP specification (page 2321 of core spec 4.2)
> that explains the allowed behavior in this scenario. However, if bonding
> was performed (which I suspect it was) the table only gives the option
> of notifying the user of the failure (which is what we do right now).

Yep, it may very well be an issue with the device.

>
>> I can provide the detailed hcidumps if anyone needs that.
> Sure, but preferably with btmon instead of hcidump. Please include the
> original pairing procedure in addition to the failure so that we can see
> whether bonding was performed or not (otoh since you say that you had at
> least a second successful connection it sounds like you must have done
> bonding).

Here's the dump of a successful connection. Then a failed one. The one 
thing I did notice is that the device requests no bonding. The local 
host then negotiates bonding in the actual pairing request. That's for 
the successful case. For the failed case, the device also requests no 
bonding. Not sure if that has any bearing (I'll comb the spec again to 
see what it says about this situation). Please let me know if you can 
draw any conclusions from the data or need anything further.

Successful Connection
===============

< HCI Command: LE Create Connection (0x08|0x000d) plen 25 [hci0] 59.296413
         Scan interval: 60.000 msec (0x0060)
         Scan window: 30.000 msec (0x0030)
         Filter policy: White list is not used (0x00)
         Peer address type: Public (0x00)
         Peer address: 00:1C:05:FF:F0:30 (OUI 00-1C-05)
         Own address type: Public (0x00)
         Min connection interval: 50.00 msec (0x0028)
         Max connection interval: 70.00 msec (0x0038)
         Connection latency: 0x0000
         Supervision timeout: 420 msec (0x002a)
         Min connection length: 0.000 msec (0x0000)
         Max connection length: 0.000 msec (0x0000)
 > HCI Event: Command Status (0x0f) plen 4 [hci0] 59.298413
       LE Create Connection (0x08|0x000d) ncmd 2
         Status: Success (0x00)
 > HCI Event: LE Meta Event (0x3e) plen 19 [hci0] 59.974382
       LE Connection Complete (0x01)
         Status: Success (0x00)
         Handle: 16
         Role: Master (0x00)
         Peer address type: Public (0x00)
         Peer address: 00:1C:05:FF:F0:30 (OUI 00-1C-05)
         Connection interval: 67.50 msec (0x0036)
         Connection latency: 0.00 msec (0x0000)
         Supervision timeout: 420 msec (0x002a)
         Master clock accuracy: 0x00
@ Device Connected: 00:1C:05:FF:F0:30 (1) flags 0x0000
 > ACL Data RX: Handle 16 flags 0x02 dlen 6 [hci0] 60.078538
       SMP: Security Request (0x0b) len 1
         Authentication requirement: No bonding - No MITM (0x00)
< ACL Data TX: Handle 16 flags 0x00 dlen 11 [hci0] 60.078851
       SMP: Pairing Request (0x01) len 6
         IO capability: NoInputNoOutput (0x03)
         OOB data: Authentication data not present (0x00)
         Authentication requirement: Bonding - No MITM (0x01)
         Max encryption key size: 16
         Initiator key distribution: <none> (0x00)
         Responder key distribution: EncKey (0x01)
 > HCI Event: Number of Completed Packets (0x13) plen 5 [hci0] 60.146413
         Num handles: 1
         Handle: 16
         Count: 1
 > ACL Data RX: Handle 16 flags 0x02 dlen 11 [hci0] 60.213038
       SMP: Pairing Response (0x02) len 6
         IO capability: NoInputNoOutput (0x03)
         OOB data: Authentication data not present (0x00)
         Authentication requirement: Bonding - No MITM (0x01)
         Max encryption key size: 16
         Initiator key distribution: <none> (0x00)
         Responder key distribution: EncKey (0x01)
< ACL Data TX: Handle 16 flags 0x00 dlen 21 [hci0] 60.213663
       SMP: Pairing Confirm (0x03) len 16
         Confim value: ccd21e4e59474336a01e180f6a65c37e
 > HCI Event: Number of Completed Packets (0x13) plen 5 [hci0] 60.281413
         Num handles: 1
         Handle: 16
         Count: 1
 > ACL Data RX: Handle 16 flags 0x02 dlen 21 [hci0] 60.348038
       SMP: Pairing Confirm (0x03) len 16
         Confim value: 14c7fe2cb506ced2298be45d03f3e800
< ACL Data TX: Handle 16 flags 0x00 dlen 21 [hci0] 60.348319
       SMP: Pairing Random (0x04) len 16
         Random value: 61f4f3ca92d349923f52f0fc5fba4d9b
 > HCI Event: Number of Completed Packets (0x13) plen 5 [hci0] 60.416444
         Num handles: 1
         Handle: 16
         Count: 1
 > ACL Data RX: Handle 16 flags 0x02 dlen 21 [hci0] 60.483038
       SMP: Pairing Random (0x04) len 16
         Random value: 4af6c7906f2eddd99a2a9ee94e3597ec
< HCI Command: LE Start Encryption (0x08|0x0019) plen 28 [hci0] 60.483601
         Handle: 16
         Random number: 0x0000000000000000
         Encrypted diversifier: 0x0000
         Long term key: df94c4102b030cfbbc2e12f8ebca01ba
 > HCI Event: Command Status (0x0f) plen 4 [hci0] 60.485413
       LE Start Encryption (0x08|0x0019) ncmd 2
         Status: Success (0x00)
 > HCI Event: Encryption Change (0x08) plen 4 [hci0] 60.753413
         Status: Success (0x00)
         Handle: 16
         Encryption: Enabled with AES-CCM (0x01)
 > ACL Data RX: Handle 16 flags 0x02 dlen 21 [hci0] 60.820413
       SMP: Encryption Information (0x06) len 16
         Long term key: 080b10bacd048f5bd98e72fb1ae5527b
 > ACL Data RX: Handle 16 flags 0x02 dlen 15 [hci0] 60.821194
       SMP: Master Identification (0x07) len 10
         EDIV: 0x5256
         Rand: 0xa38007f54be58be6
@ New Long Term Key: 00:1C:05:FF:F0:30 (1) Master


Failed Connection
===========

< HCI Command: LE Create Connection (0x08|0x000d) plen 25 [hci0] 209.031177
         Scan interval: 60.000 msec (0x0060)
         Scan window: 30.000 msec (0x0030)
         Filter policy: White list is not used (0x00)
         Peer address type: Public (0x00)
         Peer address: 00:1C:05:FF:F0:30 (OUI 00-1C-05)
         Own address type: Public (0x00)
         Min connection interval: 50.00 msec (0x0028)
         Max connection interval: 70.00 msec (0x0038)
         Connection latency: 0x0000
         Supervision timeout: 420 msec (0x002a)
         Min connection length: 0.000 msec (0x0000)
         Max connection length: 0.000 msec (0x0000)
 > HCI Event: Command Status (0x0f) plen 4 [hci0] 209.033427
       LE Create Connection (0x08|0x000d) ncmd 2
         Status: Success (0x00)
 > HCI Event: LE Meta Event (0x3e) plen 19 [hci0] 209.835396
       LE Connection Complete (0x01)
         Status: Success (0x00)
         Handle: 16
         Role: Master (0x00)
         Peer address type: Public (0x00)
         Peer address: 00:1C:05:FF:F0:30 (OUI 00-1C-05)
         Connection interval: 67.50 msec (0x0036)
         Connection latency: 0.00 msec (0x0000)
         Supervision timeout: 420 msec (0x002a)
         Master clock accuracy: 0x00
@ Device Connected: 00:1C:05:FF:F0:30 (1) flags 0x0000
 > ACL Data RX: Handle 16 flags 0x02 dlen 6 [hci0] 210.005927
       SMP: Security Request (0x0b) len 1
         Authentication requirement: No bonding - No MITM (0x00)
< HCI Command: LE Start Encryption (0x08|0x0019) plen 28 [hci0] 210.007802
         Handle: 16
         Random number: 0xa38007f54be58be6
         Encrypted diversifier: 0x5256
         Long term key: 080b10bacd048f5bd98e72fb1ae5527b
 > HCI Event: Command Status (0x0f) plen 4 [hci0] 210.009427
       LE Start Encryption (0x08|0x0019) ncmd 2
         Status: Success (0x00)
 > HCI Event: Encryption Change (0x08) plen 4 [hci0] 210.142427
         Status: PIN or Key Missing (0x06)
         Handle: 16
         Encryption: Disabled (0x00)
< HCI Command: Disconnect (0x01|0x0006) plen 3 [hci0] 210.142677
         Handle: 16
         Reason: Authentication Failure (0x05)
 > HCI Event: Command Status (0x0f) plen 4 [hci0] 210.144427
       Disconnect (0x01|0x0006) ncmd 2
         Status: Success (0x00)
 > HCI Event: Disconnect Complete (0x05) plen 4 [hci0] 210.209427
         Status: Success (0x00)
         Handle: 16
         Reason: Connection Terminated By Local Host (0x16)
@ Device Disconnected: 00:1C:05:FF:F0:30 (1) reason 0

Alan

> Johan


______________________________________________________________________
This communication contains information which may be confidential or privileged. The information is intended solely for the use of the individual or entity named above.  If you are not the intended recipient, be aware that any disclosure, copying, distribution or use of the contents of this information is prohibited.  If you have received this communication in error, please notify me by telephone immediately.
______________________________________________________________________

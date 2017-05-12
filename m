Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Fri, 12 May 2017 15:45:14 +0100
From: John Keeping <john@metanate.com>
To: linux-bluetooth@vger.kernel.org
Subject: Determining whether a Bluetooth device supports pairing
Message-ID: <20170512154514.5a51d896.john@metanate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have a BLE MIDI keyboard which does not support pairing, and so far as
I can tell there is no way to determine this via the BlueZ DBus API.

If I try to pair I get the following hcidump trace which does indicate
that the device doesn't support pairing:

-- >8 --
< ACL data: handle 64 flags 0x00 dlen 11
    SMP: Pairing Request (0x01)
      capability 0x03 oob 0x00 auth req 0x09
      max key size 0x10 init key dist 0x0d resp key dist 0x0f
      Capability: NoInputNoOutput (OOB data not present)
      Authentication: Bonding (No MITM Protection)
      Initiator Key Distribution:  LTK  CSRK
      Responder Key Distribution:  LTK IRK CSRK
> ACL data: handle 64 flags 0x02 dlen 6
    SMP: Pairing Failed (0x05)
      reason 0x05
      Reason Pairing Not Supported
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 64 reason 0x05
    Reason: Authentication Failure
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 64 packets 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 64 reason 0x16
    Reason: Connection Terminated by Local Host
-- 8< --

It seems that if pairing fails, the kernel disconnects from the device
and the DBus method returns AuthenticationFailed, but I can't see any
way to figure out whether or not a device supports pairing without
trying to pair with it.

Am I missing some method for determining whether or not a device
supports pairing?  Or do we need to handle SMP_PAIRING_NOTSUPP
specially?

I'm happy to work up some patches if the latter, but I'd like to make
sure I'm heading in a sensible direction before starting on that!


Thanks,
John

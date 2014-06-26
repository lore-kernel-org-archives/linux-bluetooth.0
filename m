Return-Path: <cyrus@holtmann.org>
MIME-version: 1.0
Content-type: text/plain; CHARSET=US-ASCII
From: d.eriksson@me.com
Subject: BLE (HOGP) Direct Adv -> Re-connect request, mysterious ~5sec latency
Message-id: <99041177-7FBC-46E9-830F-0B92A6187048@me.com>
Date: Thu, 26 Jun 2014 17:57:26 +0200
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm trying to figure out why we get a 4-5sec delay between a BLE reconnect (direct-advertise) to when the first event pops up in the kernel/bluez.

I can see in wireshark that as soon as my BLE-device advertises, the TI-BLE chip on the linux 3.13 host-side responds immediately, but from here to when we get the hid device up and ready, it takes another 4-5seconds. Any ideas why!?


See the btmon + corresponding "wire-shark dump" (made using a wireless sniffer) between ~105-110sec.
(note that the second offset between the two are off by ~2sec)

	https://mega.co.nz/#!LQlVQQ5J!ouwcuee61u3cqwtVqIMVjRf5WgXBXDQJvelClDS4WDU


on the btmon side you can see the below behaviour



> ACL Data RX: Handle 1025 flags 0x02 dlen 12                                                                                   [hci0] 107.714506
      ATT: Read Response (0x0b) len 7
        Value: 02672302000100
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                          [hci0] 107.742699
        Num handles: 1
        Handle: 1025
        Count: 1
> ACL Data RX: Handle 1025 flags 0x02 dlen 16                                                                                  
[hci0] 111.638371
      LE L2CAP: Connection Parameter Update Request (0x12) ident 2 len 8
        Min interval: 6
        Max interval: 24
        Slave latency: 6
        Timeout multiplier: 30
< ACL Data TX: Handle 1025 flags 0x00 dlen 10                                                                                   [hci0] 111.638484
      LE L2CAP: Connection Parameter Update Response (0x13) ident 2 len 2
        Result: Connection Parameters accepted (0x0000)
< HCI Command: LE Connection Update (0x08|0x0013) plen 14                                                                       [hci0] 111.638531
        Handle: 1025
        Min connection interval: 7.50 msec (0x0006)
        Max connection interval: 30.00 msec (0x0018)
        Connection latency: 0x0006
        Supervision timeout: 300 msec (0x001e)
        Min connection length: 0.625 msec (0x0001)
        Max connection length: 0.625 msec (0x0001)
> HCI Event: Command Status (0x0f) plen 4                                                                                       [hci0] 111.639402
      LE Connection Update (0x08|0x0013) ncmd 1
        Status: Success (0x00)



best David

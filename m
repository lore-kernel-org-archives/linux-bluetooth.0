Return-Path: <cyrus@holtmann.org>
Message-ID: <532096FA.5060008@hurleysoftware.com>
Date: Wed, 12 Mar 2014 13:18:50 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>,
 Scott James Remnant <keybuk@chromium.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: rctest -c "Can't connect: Device or resource busy (16)"
References: <CAHZ1yC=+XNxEx5ivA+ebGi_Cjui2Mcrx+q83b-eUPvt2J0XLPw@mail.gmail.com> <7C822ED2-E0F6-4CC7-AF1D-D909AD7C0B1F@holtmann.org> <CAHZ1yCnx_fbd_O5VLZ6TWpBbyT3vsx_1JB-qOR5NBYuGMwnA_g@mail.gmail.com> <15A2D205-97BC-4790-A998-52AD8941DB3F@holtmann.org> <531FCE03.4080704@hurleysoftware.com>
In-Reply-To: <531FCE03.4080704@hurleysoftware.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

> On 03/11/2014 10:14 PM, Marcel Holtmann wrote:
>> Hi Scott,
>>
>>> 3.10 with bluetooth-next applied - btmon of both sides attached
>>
>> I am seeing the same with bluetooth-next on a 3.13 kernel. It even has a weird pattern for me.
>>
>> rctest[52844]: Connected [handle 11, class 0x000000, priority 0]
>> rctest[52844]: Can't connect: Device or resource busy (16)
>> rctest[52844]: Can't connect: Device or resource busy (16)
>> rctest[52844]: Can't connect: Device or resource busy (16)
>> rctest[52844]: Can't connect: Device or resource busy (16)
>> rctest[52844]: Can't connect: Device or resource busy (16)
>> rctest[52844]: Can't connect: Device or resource busy (16)
>> rctest[52844]: Can't connect: Device or resource busy (16)
>> rctest[52844]: Can't connect: Device or resource busy (16)
>> rctest[52844]: Can't connect: Device or resource busy (16)
>> rctest[52844]: Can't connect: Device or resource busy (16)
>> rctest[52844]: Can't connect: Device or resource busy (16)
>> rctest[52844]: Can't connect: Device or resource busy (16)
>> rctest[52844]: Can't connect: Connection refused (111)
>> rctest[52844]: Can't connect: Connection reset by peer (104)
>> rctest[52844]: Can't connect: Connection reset by peer (104)
>> rctest[52844]: Connected [handle 11, class 0x000000, priority 0]
>>
>> Unfortunately I currently have no idea on why this happens. When using
>> SO_LINGER of 60 seconds with rctest -L 60 -c <bdaddr> I am getting some
>> really odd tracing behavior.
>>
>>> ACL Data RX: Handle 11 flags 0x02 dlen 14
>>        L2CAP: Command Reject (0x01) ident 7 len 6
>>          Reason: Invalid CID in request (0x0002)
>>          Destination CID: 64
>>          Source CID: 0
>>
>> This should never happen and makes me wonder if something is
>> even screwed up one down in L2CAP. Do you happen to have time
>> to bisect this and figure out which patch introduced this behavior.

There are 2 separate problems going on here.

The failure to reconnect is happening because after sending DISC,
the sender still replies to stale MCC packets, which the receiver
(whose state now reflects the DISC) replies with a DM packet which
gets received on the re-opened dlc, causing it to disconnect with
error. This is trivially fixable, and AFAICT, is not a regression.

The 2nd problem of not being able to reconnect in a reasonable
number of times is due to the huge round-trip delays after receiving
DISC and replying with UA.

This is a result of the excessive number of execution contexts
being used on the BT stack.

1) from USB interrupt -> btusb_bulk_complete -> queue_work(rx_work)
2) hci_rx_work -> l2cap_data_channel -> l2cap_sock_recv_cb -> sock_queue_rcv_skb
3) -> rfcomm_l2data_ready -> rfcomm_schedule
4) rfcomm_process_rx -> rfcomm_recv_disc -> rfcomm_send_ua -> l2cap_do_send -> hci_queue_acl
5) hci_tx_work -> btusb_send_frame

On a 8-core preempt workstation, this takes ~200us, which is a lot for
receiving a 12-byte packet and replying with a 12-byte packet.
Plus, it doesn't help that USB tacks on another 918us to actually
complete the URB.

On a 1-core non-preempt laptop, this takes 51ms!

Regards,
Peter Hurley

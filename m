Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1336432823-3359-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1336432823-3359-1-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Tue, 8 May 2012 19:21:44 -0300
Message-ID: <CAKT1EBe85WOxpTto1u13Fb9a_EVDpN06+5zG7mTZunC-XSUdyA@mail.gmail.com>
Subject: Re: [PATCH] RFC: LE Connection Complete has only status parameter set
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Mon, May 7, 2012 at 8:20 PM, Andrzej Kaczmarek
<andrzej.kaczmarek@tieto.com> wrote:
> Hi,
>
> I noticed that my BLE dongle does not return peer address in LE Connection
> Complete event after connection attempt was cancelled with LE Create Connection
> Cancel command, as follows:
>
> 2012-05-07 11:21:39.133378 < HCI Command: LE Create Connection (0x08|0x000d) plen 25
>    bdaddr 00:22:D0:10:13:EE type 1
> 2012-05-07 11:21:39.138774 > HCI Event: Command Status (0x0f) plen 4
>    LE Create Connection (0x08|0x000d) status 0x00 ncmd 1
> 2012-05-07 11:21:44.752854 < HCI Command: LE Create Connection Cancel (0x08|0x000e) plen 0
> 2012-05-07 11:21:44.759475 > HCI Event: Command Complete (0x0e) plen 4
>    LE Create Connection Cancel (0x08|0x000e) ncmd 1
> 2012-05-07 11:21:44.764479 > HCI Event: LE Meta Event (0x3e) plen 19
>    LE Connection Complete
>      status 0x02 handle 0, role master
>      bdaddr 00:00:00:00:00:00 (Public)
>
> This causes problems in kernel since hci_conn is not properly removed and
> subsequent connections to this peer are not possible - since connection with
> peer 00:00:00:00:00:00 does not exist, it will be created and immediately
> removed (due to non-zero status code) leaving original hci_conn intact:
>
> [14898.739425] [6603] hci_connect: hci0 dst 00:22:D0:10:13:EE
> [14898.739429] [6603] hci_conn_add: hci0 dst 00:22:D0:10:13:EE
> [14898.739434] [6603] hci_conn_init_sysfs: conn ffff880079f03000
> [14898.739440] [6603] hci_send_cmd: hci0 opcode 0x200d plen 25
> [14898.739443] [6603] hci_send_cmd: skb len 28
> [14898.739487] [6603] hci_chan_create: hci0 conn ffff880079f03000
> ...
> [14938.860231] [55] hci_send_cmd: hci0 opcode 0x200e plen 0
> ...
> [14938.876427] [55] hci_le_conn_complete_evt: hci0 status 2
> [14938.876433] [55] hci_conn_add: hci0 dst 00:00:00:00:00:00
> [14938.876439] [55] hci_conn_init_sysfs: conn ffff88007aeff800
> [14938.876454] [55] hci_send_to_control: len 14
> [14938.876470] [55] l2cap_connect_cfm: hcon ffff88007aeff800 bdaddr 00:00:00:00:00:00 status 2
> [14938.876474] [55] hci_conn_del: hci0 conn ffff88007aeff800 handle 0
>
>
> I'm not sure if behaviour of BLE dongle is correct but I'd say yes since
> Bluetooth spec states in part E section 7.8.13 as follows:
> The LE Connection Complete event with the error code Unknown Connection
> Identifier (0x02) shall be sent after the Command Complete event for the
> LE_Create_Connection_Cancel command if the cancellation was successful.

PTS, CSR, and Atheros send the peer address properly. Broadcom and STE don't.
Indeed, the SPEC is not precise about this. Probably, the firmware
developers decided to send "00:00:00:00:00:00" to implement the white
list support easily.

BR,
Claudio.

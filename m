Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <8D8512CF-7924-48A3-9B8E-78145262DA99@holtmann.org>
References: <CAGd9gwhd4DuEw_jHJAZF99YwNT==-s9yW6KEkZ_A2w+eeFy88w@mail.gmail.com>
 <6D8CE567-F4C5-42BE-8E0E-5D558E9C439D@holtmann.org> <CAGd9gwjLr8vhqXNW0ALBsfpjZ+Rnt0bhif1sHDExqT7Syc4NFA@mail.gmail.com>
 <38279439-FECC-452A-9514-A431580DFA7C@holtmann.org> <CAGd9gwjHXfcG6uaZYmoV2y+ymCX4PzCvuvA1mwT00wOExkwXmg@mail.gmail.com>
 <8D8512CF-7924-48A3-9B8E-78145262DA99@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
Date: Mon, 24 Jun 2013 18:02:26 -0700
Message-ID: <CAGd9gwiBts9DE8taJ_MzpCsho6Eh7hsq1Eq7g7WbZySaHMfnSg@mail.gmail.com>
Subject: Re: [BUG] HCI_RESET and Num_HCI_Command_Packets limit
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>, keybuk <keybuk@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Jun 21, 2013 at 6:22 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>>> I can't say this for sure, but if this is our fault and not a hardware =
issue then this seems to be a pretty nasty race condition.
>>>
>>> To debug this you might need to work with dynamic_debug for Bluetooth c=
ore and add a few more DBG statements so we get timing information that we =
can compare with the btmon trace.
>>>
>>> So in theory all modern chips should send HCI_Reset on devup. Only a fe=
w old broken ones will send HCI_Reset on devdown. Can you check that the at=
h3k does not send a quirk here and really does HCI_Reset on devup. And that=
 the ath3k firmware loading part not accidentally gets in the way.
>>>
>>> It would be also good to verify if devup or devdown is the root cause h=
ere.
>>
>> I don't understand how this could be a hardware problem. I must be
>> missing something. The host is sending to the controller two
>> consecutive commands, the second one is a HCI_Reset caused by the
>> power off/on, but the spec says that we should not send more than one
>> command at that point (ncmd of the last event is 1). So, since we are
>> out of spec the firmware is happy to block itself in a bad way :)
>> right?
>
> It is most likely our bug. Sometimes the hardware does however behave fun=
ny.
>
> My guess right now is that you are hitting a really nasty race conditions=
 and in ath3k chips is shows up easier since the command processing is slow=
er.
>
> So in hci_do_dev_close() we forcefully set the cmd_cnt to 1. And in case =
of HCI_QUIRK_RESET_ON_CLOSE we are sending a HCI Reset from close.
>
> Before we go ahead with this, I like you to confirm what HCI Reset behavi=
or you actually have for your hardware. HCI Reset on devup or on devdown. C=
heck your full btmon where we send the HCI Reset.
>
> What we might need to do different here is to check if we have a pending =
command, flush all other commands and then wait for this command to complet=
e before sending HCI Reset.
>
> So in theory that HCI Request Lock should protect the whole init and shut=
down procedures and all mgmt and ioctl interfaces should block each other. =
Why this is not the case is something else to investigate. Maybe we have so=
me issue there as well.

I enabled dynamic debug on this kernel. Again, I'm running 3.8.11. I
added a debug line to check HCI_QUIRK_RESET_ON_CLOSE and
"test_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks)" evaluates to 0; so
the reset is sent during device up. Nevertheless, the bug is because a
combination of both:

The timelime for the bug is the following.
1. Due a previous "btmgmt power on" we are interacting with the
bluetooth controller. There are 3 commands queued. The last command
sent was a HCI_Write_Scan_Enable.
2. The Command complete event for HCI_Write_Scan_Enable is received,
with status =3D 0 and ncmd =3D 1
3. The following command on the queue goes out (a
HCI_Write_Class_of_Device, but is irrelevant). Two other commands
remain in the queue.
4. We have bad luck and "btmgmt power off" is executed. This opens a
mgmt socket and sends the power off. hci_dev_do_close gets called as a
consequence of this.
5. hci_dev_do_close clears the cmd, rx and tx queues in the kernel,
and sets the cmd_cnt to 1, even if the current command
(HCI_Write_Class_of_Device in this case) did not finish. From this
point we have an inconsistent state, since cmd_cnt is 1, but we are
not allowed to send a command to the adapter.
6. We have even more bad luck, and "btmgmt power on" is executed. This
causes, eventually, hci_dev_open to be called which schedules a
HCI_Reset command (and a few more that are queued).
7. The HCI_Reset command is sent to the Bluetooth Controller since cmd_cnt =
is 1.

The dmesg log (with opcode anotations) is included below. I don't see
any hci_rx_work after step 2 in the log.
Running this with usbmon shows that the two commands are being sent
without the event received in the middle.

I agree with Marcel that the right fix should be to wait until we
receive the completion event from the adapter. I'm certainly not very
familiar with this code, but I'll try to hack it =3D) Suggestions are
welcomed!

Thanks,
Alex.


[  333.345868] hci_rx_work:2860: hci0
[  333.345876] hci_rx_work:2889: hci0 Event packet
[  333.345883] hci_cc_write_scan_enable:306: hci0 status 0x00
[  333.345890] hci_sent_cmd_data:2204: hci0 opcode 0x0c1a #######
HCI_Write_Scan_Enable
[  333.345898] hci_req_complete:62: hci0 command 0x0c1a result 0x00
[  333.345914] hci_cmd_work:2916: hci0 cmd_cnt 1 cmd queued 3
[  333.345923] hci_send_frame:2136: hci0 type 1 len 6
[  333.346889] hci_rx_work:2860: hci0
[  333.346897] hci_rx_work:2889: hci0 Event packet
[  333.346904] hci_cc_write_class_of_dev:369: hci0 status 0x00
[  333.346910] hci_sent_cmd_data:2204: hci0 opcode 0x0c24 #######
HCI_Write_Class_of_Device
[  333.346919] hci_send_to_control:147: len 9
[  333.346938] hci_cmd_work:2916: hci0 cmd_cnt 1 cmd queued 2
[  333.346947] hci_send_frame:2136: hci0 type 1 len 251
[  333.347267] hci_sock_create:1066: sock ffff8801183e2c00
[  333.347286] hci_sock_bind:598: sock ffff8801183e2c00 sk ffff88011a158800
[  333.347477] hci_sock_sendmsg:794: sock ffff8801183e2c00 sk ffff88011a158=
800
[  333.347483] mgmt_control:2766: got 7 bytes
[  333.347489] hci_dev_get:287: 0
[  333.347494] hci_dev_hold:655: hci0 orig refcnt 5
[  333.347499] set_powered:778: request for hci0
[  333.347512] hci_dev_put:647: hci0 orig refcnt 6
[  333.347523] hci_power_off:1160: hci0
[  333.347528] hci_dev_do_close:785: hci0 ffff88014a967000
[  333.347534] hci_req_cancel:100: hci0 err 0x13
[  333.347540] hci_conn_hash_flush:812: hdev hci0
[  333.347545] hci_sock_dev_event:376: hdev hci0 event 4
[  333.347553] hci_send_to_sock:76: hdev           (null) len 8
[  333.350268] cmd_complete:248: sock ffff88011a158800
[  333.350289] hci_send_to_control:147: len 10
[  333.350301] hci_dev_put:647: hci0 orig refcnt 5
[  333.350309] hci_sock_recvmsg:748: sock ffff8801183e2c00, sk ffff88011a15=
8800
[  333.350595] hci_sock_release:421: sock ffff8801183e2c00 sk ffff88011a158=
800
[  333.352418] hci_sock_create:1066: sock ffff8801183e1b80
[  333.352438] hci_sock_bind:598: sock ffff8801183e1b80 sk ffff88011a15a800
[  333.352594] hci_sock_sendmsg:794: sock ffff8801183e1b80 sk ffff88011a15a=
800
[  333.352600] mgmt_control:2766: got 7 bytes
[  333.352604] hci_dev_get:287: 0
[  333.352609] hci_dev_hold:655: hci0 orig refcnt 4
[  333.352613] set_powered:778: request for hci0
[  333.352622] hci_dev_put:647: hci0 orig refcnt 5
[  333.352632] hci_power_on:1143: hci0
[  333.352635] hci_dev_get:287: 0
[  333.352639] hci_dev_hold:655: hci0 orig refcnt 4
[  333.352643] hci_dev_open:703: hci0 ffff88014a967000
[  333.352865] __hci_request:117: hci0 start
[  333.352880] hci_init_req:208: hci0 0
[  333.352893] hci_reset_req:172: hci0 0
[  333.352906] hci_send_cmd:2162: hci0 opcode 0x0c03 plen 0 ######## HCI Re=
set
[  333.352916] hci_send_cmd:2177: skb len 3
[  333.352929] hci_send_cmd:2162: hci0 opcode 0x1003 plen 0 ########
HCI Read local supported features
[  333.352935] hci_cmd_work:2916: hci0 cmd_cnt 1 cmd queued 1
[  333.352937] hci_send_cmd:2177: skb len 3
[  333.352944] hci_send_cmd:2162: hci0 opcode 0x1001 plen 0 ########
HCI Read local version information
[  333.352949] hci_send_frame:2136: hci0 type 1 len 3
[  333.352955] hci_send_cmd:2177: skb len 3
[  333.352965] hci_cmd_work:2916: hci0 cmd_cnt 0 cmd queued 2
[  333.362660] bt_sock_poll:417: sock ffff8801402b42c0, sk ffff88011bcdfc00
[  333.362669] bt_sock_poll:417: sock ffff88012679d080, sk ffff88011e063400
[  333.362674] bt_sock_poll:417: sock ffff88012679c580, sk ffff88011e062800
[  333.362678] bt_sock_poll:417: sock ffff88012679c2c0, sk ffff88011e063000
[  333.362682] bt_sock_poll:417: sock ffff88012679c000, sk ffff880146445c00
[  333.362686] bt_sock_poll:417: sock ffff88012679cb00, sk ffff880146446800
[  333.362735] hci_sock_recvmsg:748: sock ffff8801402cf440, sk ffff88011b41=
f800
[  333.362751] bt_sock_poll:417: sock ffff8801402b42c0, sk ffff88011bcdfc00
[  333.362754] bt_sock_poll:417: sock ffff88012679d080, sk ffff88011e063400
[  333.362756] bt_sock_poll:417: sock ffff88012679c580, sk ffff88011e062800
[  333.362758] bt_sock_poll:417: sock ffff88012679c2c0, sk ffff88011e063000
[  333.362760] bt_sock_poll:417: sock ffff88012679c000, sk ffff880146445c00
[  333.362762] bt_sock_poll:417: sock ffff88012679cb00, sk ffff880146446800
[  333.362768] hci_sock_recvmsg:748: sock ffff8801402cf440, sk ffff88011b41=
f800
[  333.370467] bt_sock_poll:417: sock ffff8801402b42c0, sk ffff88011bcdfc00
[  333.370476] bt_sock_poll:417: sock ffff88012679d080, sk ffff88011e063400
[  333.370480] bt_sock_poll:417: sock ffff88012679c580, sk ffff88011e062800
[  333.370485] bt_sock_poll:417: sock ffff88012679c2c0, sk ffff88011e063000
[  333.370489] bt_sock_poll:417: sock ffff88012679c000, sk ffff880146445c00
[  333.370493] bt_sock_poll:417: sock ffff88012679cb00, sk ffff880146446800
[  333.370623] bt_sock_poll:417: sock ffff8801402b42c0, sk ffff88011bcdfc00
[  333.370628] bt_sock_poll:417: sock ffff88012679d080, sk ffff88011e063400
[  333.370633] bt_sock_poll:417: sock ffff88012679c580, sk ffff88011e062800
[  333.370637] bt_sock_poll:417: sock ffff88012679c2c0, sk ffff88011e063000
[  333.370641] bt_sock_poll:417: sock ffff88012679c000, sk ffff880146445c00
[  333.370645] bt_sock_poll:417: sock ffff88012679cb00, sk ffff880146446800
[  343.349711] __hci_request:148: hci0 end: err -110
[  343.352606] hci_dev_put:647: hci0 orig refcnt 5

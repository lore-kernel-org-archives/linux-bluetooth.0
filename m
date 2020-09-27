Return-Path: <SRS0=GKuY=DE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4D7C4346E
	for <linux-bluetooth@archiver.kernel.org>; Sun, 27 Sep 2020 12:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7BF92389F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 27 Sep 2020 12:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgI0MEv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 27 Sep 2020 08:04:51 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:36886 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgI0MEv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 27 Sep 2020 08:04:51 -0400
Received: from [172.20.10.2] (x527179c4.dyn.telefonica.de [82.113.121.196])
        by mail.holtmann.org (Postfix) with ESMTPSA id EF808CECFF;
        Sun, 27 Sep 2020 14:11:46 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] Bluetooth: Fix the vulnerable issue on enc key size
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <004951c574594df68829e1a076bc94da@realsil.com.cn>
Date:   Sun, 27 Sep 2020 14:04:46 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Max Chou <max.chou@realtek.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <A9AD70E3-D2FE-4D9C-9B9B-C7D448A60A30@holtmann.org>
References: <004951c574594df68829e1a076bc94da@realsil.com.cn>
To:     =?utf-8?B?6ZmG5pyx5Lyf?= <alex_lu@realsil.com.cn>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alex,

>>>>> When someone attacks the service provider, it creates connection,
>>>>> authenticates. Then it requests key size of one byte and it identifies
>>>>> the key with brute force methods.
>>>>> 
>>>>> After l2cap info req/resp exchange is complete. the attacker sends l2cap
>>>>> connect with specific PSM.
>>>>> 
>>>>> In above procedure, there is no chance for the service provider to check
>>>>> the encryption key size before l2cap_connect(). Because the state of
>>>>> l2cap chan in conn->chan_l is BT_LISTEN, there is no l2cap chan with the
>>>>> state of BT_CONNECT or BT_CONNECT2.
>>>>> 
>>>>> So service provider should check the encryption key size in
>>>>> l2cap_connect()
>>>>> 
>>>>> Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
>>>>> ---
>>>>> net/bluetooth/l2cap_core.c | 7 +++++++
>>>>> 1 file changed, 7 insertions(+)
>>>>> 
>>>>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>>>>> index ade83e224567..63df961d402d 100644
>>>>> --- a/net/bluetooth/l2cap_core.c
>>>>> +++ b/net/bluetooth/l2cap_core.c
>>>>> @@ -4150,6 +4150,13 @@ static struct l2cap_chan *l2cap_connect(struct
>>>> l2cap_conn *conn,
>>>>> 
>>>>> 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE) {
>>>>> 		if (l2cap_chan_check_security(chan, false)) {
>>>>> +			if (!l2cap_check_enc_key_size(conn->hcon)) {
>>>>> +				l2cap_state_change(chan, BT_DISCONN);
>>>>> +				__set_chan_timer(chan,
>>>> L2CAP_DISC_TIMEOUT);
>>>>> +				result = L2CAP_CR_SEC_BLOCK;
>>>>> +				status = L2CAP_CS_NO_INFO;
>>>>> +				goto response;
>>>>> +			}
>>>>> 			if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
>>>>> 				l2cap_state_change(chan, BT_CONNECT2);
>>>>> 				result = L2CAP_CR_PEND;
>>>> 
>>>> I am not following what you are trying to fix here. Can you show this with
>> a
>>>> btmon trace from an attacking device?
>>>> 
>>>> Regards
>>>> 
>>>> Marcel
>>>> 
>>>> 
>>> 
>>> I'm sorry, I didn't have btmon trace from an attacking device.
>>> I didn't have the real attacking device. I just simulate the attacking.
>>> I have a device that can create one byte size encryption key.
>>> It uses the link key that was produced by pairing with the service provider.
>> Actually the KNOB (Key Negotiation of Bluetooth Attack) says, the link key is
>> unnecessary for the reconnection.
>>> I use this device to reconnect to service provider, and then initiate the Key
>> Negotiation for one byte size encryption key. Actually the attacker identified
>> the encryption key with some brute force methods.
>>> 
>>> I want to provide the trace on service provider side.
>> 
>> what kernel version are you running? I wonder if we should always return
>> L2CAP_CR_PEND here. Do you have a reproducer code?
> 
> I'm running kernel 5.8.0-rc6 on acceptor and kernel 5.8.5 on the initiator which acts as an attacker.
> For the attack simulation, some code needs to be changed on each size.
> On the acceptor, the master parameter for bt_io_listen() in bluetoothd should be changed to FALSE in profiles/audio/a2dp.c a2dp_server_listen() and profiles/audio/avctp.c avctp_server_socket().
> The change makes the kernel not to change the role to master when it receives hci conn req event.
> I did the change in order to make the controller to send LMP_ENCRYPTION_KEY_SIZE_REQ PDU for one byte key size.
> 
> On the initiator, the below encryption key size check should be removed.
> @@ -1622,10 +1624,13 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
>                                continue;
>                        }
> 
> -                       if (l2cap_check_enc_key_size(conn->hcon))
> -                               l2cap_start_connection(chan);
> -                       else
> -                               l2cap_chan_close(chan, ECONNREFUSED);
> +                       /* Just simulate KNOB */
> +                       l2cap_start_connection(chan);
> +                       /* if (l2cap_check_enc_key_size(conn->hcon))
> +                        *      l2cap_start_connection(chan);
> +                        * else
> +                        *      l2cap_chan_close(chan, ECONNREFUSED);
> +                        */
> 
> At last, I did the test as below:
> 1. On the initiator, pair acceptor
> 2. Run l2test -r -P 3 on the acceptor
> 3. Run l2test -n -P 3 <bdaddr> on the initiator
> 
>> 
>> The problem really is that the MASK_REQ_DONE indication is not enough to
>> make a decision for the key size. We have to ensure that also the key size is
>> actually available. If that is not yet done, then we should not check it. This
>> means that any response to L2CAP_Connect_Request PDU needs to be
>> delayed until the key size has been read.
> 
> In my test case, the key size has been read from controller before the l2cap conn request PDU is received.
> 
> < HCI Command: Read Encryption Key Size (0x05|0x0008) plen 2                                         #22 [hci0] 43.089859
>        Handle: 1
>> HCI Event: Command Complete (0x0e) plen 7                                                           #23 [hci0] 43.091528
>      Read Encryption Key Size (0x05|0x0008) ncmd 2
>        Status: Success (0x00)
>        Handle: 1
>        Key size: 1
>> ACL Data RX: Handle 1 flags 0x02 dlen 10                                                            #24 [hci0] 43.140888
>      L2CAP: Information Request (0x0a) ident 1 len 2
>        Type: Extended features supported (0x0002)
> ......
>> ACL Data RX: Handle 1 flags 0x02 dlen 12                                                            #34 [hci0] 43.148405
>      L2CAP: Connection Request (0x02) ident 3 len 4
>        PSM: 3 (0x0003)
>        Source CID: 64

the easiest way to fake this is just to assign a different value than the one returned by Read Encryption Key Size on the acceptor side. No need to mess with LMP details.

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1df95145f574..741b7ad31ff8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3034,7 +3034,7 @@ static void read_enc_key_size_complete(struct hci_dev *hdev, u8 status,
                           handle);
                conn->enc_key_size = 0;
        } else {
-               conn->enc_key_size = rp->key_size;
+               conn->enc_key_size = 1;
        }

If you add this change to both sides, what are the steps to reproduce this and what does btmon show? You might have to also enable dynamic_debug for l2cap.ko so that we see the function call trace.

I am a bit pedantic with this one, since it is critical to understand where the current changes to handle anything KNOB related have their shortcomings. I spent so much time testing every single corner case. Certainly I could have missed something, but if I really did, this time around I want to either simplify the code or properly comment it at least.

Please see the other email thread / patch from Archie trying to also add another encryption key size check.

Regards

Marcel


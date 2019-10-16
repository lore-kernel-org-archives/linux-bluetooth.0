Return-Path: <SRS0=8ZYm=YJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E94FA372A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Oct 2019 19:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B574222BE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Oct 2019 19:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436683AbfJPTI6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Oct 2019 15:08:58 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:35649 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730057AbfJPTI6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Oct 2019 15:08:58 -0400
Received: from surfer-172-29-2-69-hotspot.internet-for-guests.com (p2E5701B0.dip0.t-ipconnect.de [46.87.1.176])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7AFD9CECDD;
        Wed, 16 Oct 2019 21:17:54 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: Kernel Bluetooth Protocol Stack Problem
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CACokStd64AUce4_2swgB06w1BH5DJpB02zwgyxfEMw=nvwJqKQ@mail.gmail.com>
Date:   Wed, 16 Oct 2019 21:08:55 +0200
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <C8D0046A-3303-4788-B3B4-1C88DFBE6EDB@holtmann.org>
References: <CACokStdMboxnDPR6cdQYfpfdNApQCn73pjQZNqQ+ag0QPYZXgw@mail.gmail.com>
 <140A3914-6A0F-4E42-9858-7CDFE348C0CA@holtmann.org>
 <CACokStd_VLLP=dc+v=MZXpYF+Pw57f0Cma3-HSrXz5_PdiyRfw@mail.gmail.com>
 <D18AA174-F883-481F-B172-EB98B26E925F@holtmann.org>
 <CACokStd64AUce4_2swgB06w1BH5DJpB02zwgyxfEMw=nvwJqKQ@mail.gmail.com>
To:     hongyi mao <maohongyicn@gmail.com>
X-Mailer: Apple Mail (2.3594.4.19)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Hongyi,

>>> My use scenario: the peripheral is a BLE thermometer and
>>> hygrometer,and the data of the thermometer and hygrometer is stored in
>>> the BLE Advertising packet.
>>> the host sends the LE Set Scan Enable Command to the local controller,
>>> and then the host receives the le_meta_event and parses the data in
>>> the BLE Advertising packet.
>>> 
>>> The problem occurred: the host side received other events besides
>>> le_meta_event, such as HCI_EV_INQUIRY_COMPLETE event,
>>> HCI_EV_CONN_REQUEST event, HCI_EV_CHANNEL_SELECTED event..., the
>>> reason for receiving these events may be BR/EDR/LE controllers wrong
>>> or other, this We are investigating.
>>> 
>>> However, I think that when the host receives the HCI_EV_CONN_REQUEST
>>> event according to the procedure described in kernel,
>>> Hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
>>> ->hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
>>> ->conn = hci_conn_add(hdev, ev->link_type, &ev->bdaddr,HCI_ROLE_SLAVE);
>>> ->hci_send_cmd(hdev, HCI_OP_ACCEPT_CONN_REQ, sizeof(cp), &cp); or
>>> hci_send_cmd(hdev, HCI_OP_ACCEPT_SYNC_CONN_REQ, sizeof(cp),&cp);
>>> The host should receive the HCI_EV_CONN_COMPLETE event or the
>>> HCI_EV_SYNC_CONN_COMPLETE event,
>>> but we did not receive it. Or the host receives the
>>> HCI_EV_CONN_COMPLETE event or HCI_EV_SYNC_CONN_COMPLETE, but
>>> ev->status != 0;
>>> The result is that the data for conn->handle is not updated, conn->handle=0.
>>> 
>>> Next, the host may receive other events, such as
>>> HCI_EV_CHANNEL_SELECTED event, HCI_EV_PHY_LINK_COMPLETE event,
>>> HCI_EV_PHY_LINK_COMPLETE event...,
>>> but we did not receive an event that can update the struct hci_conn data.
>>> For example, the host receives the HCI_EV_CHANNEL_SELECTED event next.
>>> Hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
>>> ->hci_chan_selected_evt(struct hci_dev *hdev, struct sk_buff
>>> *skb);//but ev->phy_handle=0;
>>> ->hcon = hci_conn_hash_lookup_handle(hdev, ev->phy_handle);//host will
>>> find struct hci_conn because conn->handle=0 ev->phy_handle=0,hcon !=
>>> NULL
>>> ->amp_read_loc_assoc_final_data(hdev, hcon);
>>> ->set_bit(READ_LOC_AMP_ASSOC_FINAL, &mgr->state); //host did not
>>> receive any other events to update the data in hcon, mgr = NULL
>>> 
>>> This situation will lead to kernel oops
>>> 
>>> This problem can also occur when the host receives other events. As
>>> long as the event ev->phy_handle=0, the struct hci_conn is found,
>>> and the uninitialized data in the struct hci_conn is manipulated in
>>> the event, this problem will occur.
>>> 
>>> Maybe this problem is a controller error, but I think the kernel stack
>>> should take this usage scenario into consideration.
>>> The attachment trace.log is the hci log we grab.The trace.log may not
>>> have caught this situation, but this situation requires a long test to
>>> appear.
>> 
>> what kind of hardware is this?
>> 
>> < HCI Command: Read Local Version Information (0x04|0x0001) plen 0
>>> HCI Event: Command Complete (0x0e) plen 12
>>      Read Local Version Information (0x04|0x0001) ncmd 1
>>        Status: Success (0x00)
>>        HCI version: Bluetooth 4.1 (0x07) - Revision 0 (0x0000)
>>        LMP version: Bluetooth 4.1 (0x07) - Subversion 602 (0x025a)
>>        Manufacturer: Qualcomm (29)
>> < HCI Command: Read BD ADDR (0x04|0x0009) plen 0
>>> HCI Event: Command Complete (0x0e) plen 10
>>      Read BD ADDR (0x04|0x0009) ncmd 1
>>        Status: Success (0x00)
>>        Address: C8:02:8F:04:89:1B (Nova Electronics (Shanghai) Co., Ltd.)
>> 
>> Is this some sort of new USB dongle from Qualcomm?
>> 
>> The problem is not Channel Selected event. That is just a symptom. The problem is that the hardware is sending garbage or you uncovered a bug in the driver or the USB controller.
>> 
>>> HCI Event: Unknown (0xaf) plen 168
>>        aa b1 32 13 56 7b dd 4d 68 d2 ec 2b 0e b6 3e 2b  ..2.V{.Mh..+..>+
>>        02 01 03 01 b8 63 5a d0 83 0c 1f 1e ff 06 00 01  .....cZ.........
>>        09 20 02 3c 26 fe 29 8d b4 89 26 03 37 3d 5c 23  . .<&.)...&.7=\#
>>        8e ba 27 b6 41 c3 d2 2d 9b 7f b5 3e 2b 02 01 03  ..'.A..-...>+...
>>        01 7a f7 04 dd a4 20 1f 1e ff 06 00 01 09 20 00  .z.... ....... .
>>        0e 5f f0 72 0f 3b ea 9b ae ba 77 fa 41 35 4d 7a  ._.r.;....w.A5Mz
>>        3f 7b 28 18 9a bb 39 b1 3e 29 02 01 03 01 fb 6e  ?{(...9.>).....n
>>        54 04 1f 39 1d 1c ff 06 00 01 09 21 0a 61 76 81  T..9.......!.av.
>>        ad 16 28 44 45 53 4b 54 4f 50 2d 4a 4a 38 36 35  ..(DESKTOP-JJ865
>>        34 30 c1 3e 2b 02 01 03 01 79 03 3f 35 8e 01 1f  40.>+....y.?5...
>>        1e ff 06 00 01 09 20 02                          ...... .
>>> HCI Event: Unknown (0x6b) plen 233
>>        87 d9 8b 41 cf 02 af a8 aa b1 32 13 56 7b dd 4d  ...A......2.V{.M
>>        68 d2 ec 2b 0e b5 3e 2b 02 01 03 01 7a f7 04 dd  h..+..>+....z...
>>        a4 20 1f 1e ff 06 00 01 09 20 00 0e 5f f0 72 0f  . ....... .._.r.
>>        3b ea 9b ae ba 77 fa 41 35 4d 7a 3f 7b 28 18 9a  ;....w.A5Mz?{(..
>>        bb 39 b2 3e 29 02 01 03 01 fb 6e 54 04 1f 39 1d  .9.>).....nT..9.
>>        1c ff 06 00 01 09 21 0a 61 76 81 ad 16 28 44 45  ......!.av...(DE
>>        53 4b 54 4f 50 2d 4a 4a 38 36 35 34 30 c1 3e 2b  SKTOP-JJ86540.>+
>>        02 01 03 01 a3 f8 96 8c 85 25 1f 1e ff 06 00 01  .........%......
>>        09 20 02 7f 31 9e b5 d1 76 45 f0 77 95 eb e7 5a  . ..1...vE.w...Z
>>        93 38 cc 88 20 5c 58 62 d2 af ab 3e 2b 02 01 03  .8.. \Xb...>+...
>>        01 79 03 3f 35 8e 01 1f 1e ff 06 00 01 09 20 02  .y.?5......... .
>>        6b e9 87 d9 8b 41 cf 02 af a8 aa b1 32 13 56 7b  k....A......2.V{
>>        dd 4d 68 d2 ec 2b 0e b6 3e 2b 02 01 03 01 7a f7  .Mh..+..>+....z.
>>        04 dd a4 20 1f 1e ff 06 00 01 09 20 00 0e 5f f0  ... ....... .._.
>>        72 0f 3b ea 9b ae ba 77 fa                       r.;....w.
>>> HCI Event: Channel Selected (0x41) plen 53
>>        invalid packet size
>>        4d 7a 3f 7b 28 18 9a bb 39 b3 3e 2b 02 01 03 01  Mz?{(...9.>+....
>>        79 03 3f 35 8e 01 1f 1e ff 06 00 01 09 20 02 6b  y.?5......... .k
>>        e9 87 d9 8b 41 cf 02 af a8 aa b1 32 13 56 7b dd  ....A......2.V{.
>>        4d 68 d2 ec 2b                                   Mh..+
>> 
>> So maybe this is missing a firmware download that has bug fixes. You might need to examine the Windows driver.
>> 
>> Regards
>> 
>> Marcel
>> 
> 
> My bluetooth module with IDS is:
> ID 0cf3:e500 Qualcomm Corp.Qualcomm Atheros QCA9377-7
> 
> Yes, I admit that the problem is that the hardware is sending garbage
> or uncovered a bug in the driver or the USB controller.
> We are solving the problem of the hardware or driver or the USB controller.
> 
> But I think that no matter harware error or a bug in the driver or the
> USB controller, our host receives garbage,
> it should not cause oops in the kernel, should we have a countermeasure?
> When this abnormality occurs, prevent the kernel Oops occurred.
> 
> When the host receives the HCI_EV_CONN_REQUEST event, but the connection fails,
> conn->handle does not update conn->handle=0,struct conn is not free
> and hardware is still sending garbage.
> This situation may lead to kernel oops.

you try to fix one symptom and still have to deal with all the other ones. Find a firmware for your hardware in the Windows driver or ask Qualcomm to fix this crappy device. It is plain and simple broken hardware.

Regards

Marcel


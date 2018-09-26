Return-Path: <SRS0=Mlcw=MI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20471C43382
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Sep 2018 11:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FAD1214DC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Sep 2018 11:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjnVVjIz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FAD1214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeIZRgb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:36:31 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:38329 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbeIZRga (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Sep 2018 13:36:30 -0400
Received: by mail-oi1-f182.google.com with SMTP id u197-v6so3460721oif.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Sep 2018 04:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mNFx1Iec8E3KunW5bVd3kqkY6wXAkXlNiLBF3iP+xok=;
        b=jjnVVjIzN6lHMqhPjMCzcKF5lQFiRR8dVDNT9Czrw4TwjGVgA7OCaQT22VIfyFPAuI
         KZxmzoEKxAZjFZYhMGeFRVLGEczhUlj7N+qcpLqdNhFgg6PRHda3+jdtBtc4G5m0JsMw
         rNFrTNHyJZByngb5Pe/F/uCos76OlK80bKqT1r4g1gYY0iDzZXufxCReyPFV4Q0Udb0p
         vzSzek7m5h+OMhSbWWCIZSuJQ8HscVZ236RWXKXjpiIxMdfPgDtJLZtyosWqydNpXkyL
         Tw9BwVFeorVRlxFsOExI5PrAbJ/9aV8pOgFGQYLVKIz4IE0F0zcG7lyaYkhTM/s3Itw0
         O5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mNFx1Iec8E3KunW5bVd3kqkY6wXAkXlNiLBF3iP+xok=;
        b=HSXptb3PrnuRb34duUL9Wcsvt4PRksei1UYtTgSNpnko9hJmm60cHwkezEK4MdND8Z
         wyGtVOnxj6cOf2CiD39s89siZFlvDoHthU6ix/LB99F4mAHScR6+XzCRUiADPtts+c2A
         Nz7fuEM0L5ExPO99S6jiFzV85HTi4qRt2KWeAbT5r6tl9oeZDj0nfD3jaf6k/EktgJh8
         20nSX9vxF1DbgwKnn7HQzvsbjPDUW+5GPgiYVq6rFWY78oleakxmK1nlS4BRhEXBNvDi
         rjjNDlaTAoldSz+Ykn91GjrKLPxNONYKPyXkLtFNekB9EipAM2nXOhQx5hF4+F9myBvt
         +d6Q==
X-Gm-Message-State: ABuFfohvzhoAK5PQfsP/8pOUNyM9SaBn1KKthvG+B7GJmWo2QIGBE6ZK
        GO0dj0E2xmZLJl5XXp/28qJUQ912Gll6j69lDijTQg==
X-Google-Smtp-Source: ACcGV629dB9S60bxAbbKAzKmFqGH64usuiVJeZdsJeARUBMdoumOa/q3BRGPS8ZJkSkjChJjx3XrTZfMrKGqfIdKZYo=
X-Received: by 2002:aca:c42:: with SMTP id i2-v6mr237032oiy.219.1537961039351;
 Wed, 26 Sep 2018 04:23:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5b02:0:0:0:0:0 with HTTP; Wed, 26 Sep 2018 04:23:58
 -0700 (PDT)
In-Reply-To: <20180926110330.GB13451@xps.lan>
References: <CAOiLkfOuenvh5ZLQD_k-yi7mL1Epr+gGJZ65zr2Fcp2SzE9F7w@mail.gmail.com>
 <20180926110330.GB13451@xps.lan>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 26 Sep 2018 14:23:58 +0300
Message-ID: <CABBYNZ+=601yD+o0EHoQc_-5k+W1WuG0JCp4cORmjEfz8Nav7g@mail.gmail.com>
Subject: Re: Security block and Bluez - connection issue with Android
To:     fabien dvlt <fabiendvlt@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Fabien,

On Wed, Sep 26, 2018 at 2:03 PM, fabien dvlt <fabiendvlt@gmail.com> wrote:
> Hi,
>
> Here is an ugly patch only for understanding or testing purpose.
>
> It did correct my connections issues but there might side effects (like a
> deadlock although I did not have any).
>
> If you have any advise on how to fix this connection issue in a clean way=
,
> I would be glad to know it. I will be trying to do something cleaner in t=
he
> next days.

Usually this short of problem is race condition between the USB
endpoints, the controller send the encryption change on the command
endpoint along with ACL packets on the data endpoint but the data
endpoint endup being picked first thus causing the problem.

> ---
>
> --- linux-4.9.109/net/bluetooth/hci_core.c      2018-09-26 11:09:46.31330=
8347 +0200
> +++ linux/net/bluetooth/hci_core.c      2018-09-26 11:08:40.633482950 +02=
00
> @@ -4038,6 +4038,32 @@
>         kfree_skb(skb);
>  }
>
> +static int hci_acldata_packet_has_pending_sec_level(struct hci_dev *hdev=
,
> +                struct sk_buff *skb)
> +{
> +       struct hci_acl_hdr *hdr =3D (void *) skb->data;
> +       struct hci_conn *hcon;
> +       __u16 handle;
> +
> +       handle =3D __le16_to_cpu(hdr->handle);
> +       handle =3D hci_handle(handle);
> +
> +       BT_DBG("#hci_acldata_packet_has_pending_sec_level: before lock");
> +       hci_dev_lock(hdev);
> +       BT_DBG("#hci_acldata_packet_has_pending_sec_level: after lock");
> +
> +       hcon =3D hci_conn_hash_lookup_handle(hdev, handle);
> +
> +       hci_dev_unlock(hdev);
> +
> +       if (hcon) {
> +               return hcon->pending_sec_level !=3D hcon->sec_level;
> +       }
> +
> +       return 0;
> +}
> +
> +
>  /* SCO data packet */
>  static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb=
)
>  {
> @@ -4164,6 +4190,39 @@
>         spin_unlock_irqrestore(&hdev->cmd_q.lock, flags);
>  }
>
> +static struct sk_buff *hci_dequeue_rx_packet(struct hci_dev *hdev)
> +{
> +       unsigned long flags;
> +       struct sk_buff *skb;
> +       struct sk_buff_head *list =3D &hdev->rx_q;
> +
> +       BT_DBG("#hci_dequeue_rx_packet: before lock");
> +       spin_lock_irqsave(&list->lock, flags);
> +       BT_DBG("#hci_dequeue_rx_packet: after lock");
> +
> +       skb =3D skb_peek(list);
> +
> +       while (skb) {
> +               if (hci_skb_pkt_type(skb) !=3D HCI_ACLDATA_PKT) {
> +                       break;
> +               }
> +
> +               if (!hci_acldata_packet_has_pending_sec_level(hdev, skb))=
 {
> +                       break;
> +               }
> +
> +               BT_DBG("skipping ACL packet (delayed because of pending s=
ec level)");
> +               skb =3D skb_peek_next(skb, list);
> +       }
> +
> +       if (skb)
> +               __skb_unlink(skb, list);
> +
> +       spin_unlock_irqrestore(&list->lock, flags);
> +
> +       return skb;
> +}
> +
>  static void hci_rx_work(struct work_struct *work)
>  {
>         struct hci_dev *hdev =3D container_of(work, struct hci_dev, rx_wo=
rk);
> @@ -4171,7 +4230,7 @@
>
>         BT_DBG("%s", hdev->name);
>
> -       while ((skb =3D skb_dequeue(&hdev->rx_q))) {
> +       while ((skb =3D hci_dequeue_rx_packet(hdev))) {
>                 /* Send copy to monitor */
>                 hci_send_to_monitor(hdev, skb);

I think someone tried this before but it was considered too much of a
hack since with this sort of logic we would not garanteed that all
packets were actually encrypted over the air.

>
>
> On Tue, Sep 25, 2018 at 06:08:32PM +0200, fabien dvlt wrote:
>> Hello,
>>
>> After trying 42 connections, 30% of my attempts are failing on
>> authentication (bluez 5.47). This happens with multiple (all?) Android
>> phones.
>>
>> Below are the btmon logs which I am finding interesting after that you
>> will find the complete logs.
>>
>> For all of my failing connection, I saw that an L2CAP connection
>> requests with PSM 0x19 is processed just before 'Encryption Change'
>> event. But, for all successful attempts this L2CAP connection request
>> is made after "Encryption Change' event.
>> So I made a patch to postpone the involved ACL packet after the
>> Encryption Change event and now I have 100% of success but it is still
>> a little hackish.
>>
>> May be this is also related to
>> https://www.spinics.net/lists/linux-bluetooth/msg72827.html
>>
>> Thank you
>>
>> ------------------------------
>>
>> > HCI Event: Link Key Request (0x17) plen 6                             =
                                                                           =
                                                                           =
                                                                           =
                                              #195 [hci0] 21.708115
>>         Address: 64:A2:F9:XX:XX:XX (OUI 64-A2-F9)
>> < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
>>
>>
>>
>>                                                            #196 [hci0]
>> 21.708397
>>         Address: 64:A2:F9:XX:XX:XX (OUI 64-A2-F9)
>>         Link key: feff6b48c953f119c1579913be0c0f65
>> > HCI Event: Command Complete (0x0e) plen 10                            =
                                                                           =
                                                                           =
                                                                           =
                                              #197 [hci0] 21.710115
>>       Link Key Request Reply (0x01|0x000b) ncmd 1
>>         Status: Success (0x00)
>>         Address: 64:A2:F9:XX:XX:XX (OUI 64-A2-F9)
>> > ACL Data RX: Handle 13 flags 0x02 dlen 12                             =
                                                                           =
                                                                           =
                                                                           =
                                              #198 [hci0] 21.813116
>>       L2CAP: Connection Request (0x02) ident 7 len 4
>>         PSM: 25 (0x0019)
>>         Source CID: 75
>> > HCI Event: Encryption Change (0x08) plen 4                            =
                                                                           =
                                                                           =
                                                                           =
                                              #199 [hci0] 21.813155
>>         Status: Success (0x00)
>>         Handle: 13
>>         Encryption: Enabled with AES-CCM (0x02)
>> < ACL Data TX: Handle 13 flags 0x00 dlen 16
>>
>>
>>
>>                                                            #200 [hci0]
>> 21.813256
>>       L2CAP: Connection Response (0x03) ident 7 len 8
>>         Destination CID: 0
>>         Source CID: 75
>>         Result: Connection refused - security block (0x0003)
>>         Status: No further information available (0x0000)
>>
>> ------------------------------
>>
>> # COMPLETE BTMON LOGS
>>
>> > HCI Event: Connect Request (0x04) plen 10                             =
                                                                           =
                                                                           =
                                                                           =
                                              #152 [hci0] 21.335093
>>         Address: 64:A2:F9:XX:XX:XX (OUI 64-A2-F9)
>>         Class: 0x5a020c
>>           Major class: Phone (cellular, cordless, payphone, modem)
>>           Minor class: Smart phone
>>           Networking (LAN, Ad hoc)
>>           Capturing (Scanner, Microphone)
>>           Object Transfer (v-Inbox, v-Folder)
>>           Telephony (Cordless telephony, Modem, Headset)
>>         Link type: ACL (0x01)
>> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>>
>>
>>
>>                                                            #153 [hci0]
>> 21.335196
>>         Address: 64:A2:F9:XX:XX:XX (OUI 64-A2-F9)
>>         Role: Master (0x00)
>> > HCI Event: Command Status (0x0f) plen 4                               =
                                                                           =
                                                                           =
                                                                           =
                                              #154 [hci0] 21.337107
>>       Accept Connection Request (0x01|0x0009) ncmd 1
>>         Status: Success (0x00)
>> > HCI Event: Role Change (0x12) plen 8                                  =
                                                                           =
                                                                           =
                                                                           =
                                              #155 [hci0] 21.589092
>>         Status: Success (0x00)
>>         Address: 64:A2:F9:XX:XX:XX (OUI 64-A2-F9)
>>         Role: Master (0x00)
>> > HCI Event: Connect Complete (0x03) plen 11                            =
                                                                           =
                                                                           =
                                                                           =
                                              #156 [hci0] 21.596088
>>         Status: Success (0x00)
>>         Handle: 13
>>         Address: 64:A2:F9:XX:XX:XX (OUI 64-A2-F9)
>>         Link type: ACL (0x01)
>>         Encryption: Disabled (0x00)
>> < HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
>>
>>
>>
>>                                                            #157 [hci0]
>> 21.596328
>>         Handle: 13
>> > HCI Event: Command Status (0x0f) plen 4                               =
                                                                           =
                                                                           =
                                                                           =
                                              #158 [hci0] 21.607116
>>       Read Remote Supported Features (0x01|0x001b) ncmd 1
>>         Status: Success (0x00)
>> > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7             =
                                                                           =
                                                                           =
                                                                           =
                                              #159 [hci0] 21.608112
>>         Address: 64:A2:F9:XX:XX:XX (OUI 64-A2-F9)
>>         Page scan repetition mode: R1 (0x01)
>> > HCI Event: Max Slots Change (0x1b) plen 3                             =
                                                                           =
                                                                           =
                                                                           =
                                              #160 [hci0] 21.609114
>>         Handle: 13
>>         Max slots: 5
>> > HCI Event: Read Remote Supported Features (0x0b) plen 11              =
                                                                           =
                                                                           =
                                                                           =
                                              #161 [hci0] 21.612116
>>         Status: Success (0x00)
>>         Handle: 13
>>         Features: 0xff 0xfe 0x8f 0xfe 0xd8 0x3f 0x5b 0x87
>>           3 slot packets
>>           5 slot packets
>>           Encryption
>>           Slot offset
>>           Timing accuracy
>>           Role switch
>>           Hold mode
>>           Sniff mode
>>           Power control requests
>>           Channel quality driven data rate (CQDDR)
>>           SCO link
>>           HV2 packets
>>           HV3 packets
>>           u-law log synchronous data
>>           A-law log synchronous data
>>           CVSD synchronous data
>>           Paging parameter negotiation
>>           Power control
>>           Transparent synchronous data
>>           Broadcast Encryption
>>           Enhanced Data Rate ACL 2 Mbps mode
>>           Enhanced Data Rate ACL 3 Mbps mode
>>           Enhanced inquiry scan
>>           Interlaced inquiry scan
>>           Interlaced page scan
>>           RSSI with inquiry results
>>           Extended SCO link (EV3 packets)
>>           AFH capable slave
>>           AFH classification slave
>>           LE Supported (Controller)
>>           3-slot Enhanced Data Rate ACL packets
>>           5-slot Enhanced Data Rate ACL packets
>>           Sniff subrating
>>           Pause encryption
>>           AFH capable master
>>           AFH classification master
>>           Enhanced Data Rate eSCO 2 Mbps mode
>>           Extended Inquiry Response
>>           Simultaneous LE and BR/EDR (Controller)
>>           Secure Simple Pairing
>>           Encapsulated PDU
>>           Non-flushable Packet Boundary Flag
>>           Link Supervision Timeout Changed Event
>>           Inquiry TX Power Level
>>           Enhanced Power Control
>>           Extended features
>> < HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
>>
>>
>>
>>                                                            #162 [hci0]
>> 21.612211
>>         Handle: 13
>>         Page: 1
>> > HCI Event: Command Status (0x0f) plen 4                               =
                                                                           =
                                                                           =
                                                                           =
                                              #163 [hci0] 21.614113
>>       Read Remote Extended Features (0x01|0x001c) ncmd 1
>>         Status: Success (0x00)
>> > ACL Data RX: Handle 13 flags 0x02 dlen 10                             =
                                                                           =
                                                                           =
                                                                           =
                                              #164 [hci0] 21.617110
>>       L2CAP: Information Request (0x0a) ident 2 len 2
>>         Type: Extended features supported (0x0002)
>> > HCI Event: Read Remote Extended Features (0x23) plen 13               =
                                                                           =
                                                                           =
                                                                           =
                                              #165 [hci0] 21.617139
>>         Status: Success (0x00)
>>         Handle: 13
>>         Page: 1/2
>>         Features: 0x0f 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>>           Secure Simple Pairing (Host Support)
>>           LE Supported (Host)
>>           Simultaneous LE and BR/EDR (Host)
>>           Secure Connections (Host Support)
>> < HCI Command: Remote Name Request (0x01|0x0019) plen 10
>>
>>
>>
>>                                                            #166 [hci0]
>> 21.617258
>>         Address: 64:A2:F9:XX:XX:XX (OUI 64-A2-F9)
>>         Page scan repetition mode: R2 (0x02)
>>         Page scan mode: Mandatory (0x00)
>>         Clock offset: 0x0000
>> < ACL Data TX: Handle 13 flags 0x00 dlen 10
>>
>>
>>
>>                                                            #167 [hci0]
>> 21.617284
>>       L2CAP: Information Request (0x0a) ident 1 len 2
>>         Type: Extended features supported (0x0002)
>> < ACL Data TX: Handle 13 flags 0x00 dlen 16
>>
>>
>>
>>                                                            #168 [hci0]
>> 21.617307
>>       L2CAP: Information Response (0x0b) ident 2 len 8
>>         Type: Extended features supported (0x0002)
>>         Result: Success (0x0000)
>>         Features: 0x000002b8
>>           Enhanced Retransmission Mode
>>           Streaming Mode
>>           FCS Option
>>           Fixed Channels
>>           Unicast Connectionless Data Reception
>> > HCI Event: Command Status (0x0f) plen 4                               =
                                                                           =
                                                                           =
                                                                           =
                                              #169 [hci0] 21.619110
>>       Remote Name Request (0x01|0x0019) ncmd 1
>>         Status: Success (0x00)
>> > HCI Event: Number of Completed Packets (0x13) plen 5                  =
                                                                           =
                                                                           =
                                                                           =
                                              #170 [hci0] 21.620114
>>         Num handles: 1
>>         Handle: 13
>>         Count: 1
>> > ACL Data RX: Handle 13 flags 0x02 dlen 16                             =
                                                                           =
                                                                           =
                                                                           =
                                              #171 [hci0] 21.622116
>>       L2CAP: Information Response (0x0b) ident 1 len 8
>>         Type: Extended features supported (0x0002)
>>         Result: Success (0x0000)
>>         Features: 0x000000b8
>>           Enhanced Retransmission Mode
>>           Streaming Mode
>>           FCS Option
>>           Fixed Channels
>> < ACL Data TX: Handle 13 flags 0x00 dlen 10
>>
>>
>>
>>                                                            #172 [hci0]
>> 21.622208
>>       L2CAP: Information Request (0x0a) ident 2 len 2
>>         Type: Fixed channels supported (0x0003)
>> > HCI Event: Number of Completed Packets (0x13) plen 5                  =
                                                                           =
                                                                           =
                                                                           =
                                              #173 [hci0] 21.626110
>>         Num handles: 1
>>         Handle: 13
>>         Count: 1
>> > ACL Data RX: Handle 13 flags 0x02 dlen 10                             =
                                                                           =
                                                                           =
                                                                           =
                                              #174 [hci0] 21.628106
>>       L2CAP: Information Request (0x0a) ident 3 len 2
>>         Type: Fixed channels supported (0x0003)
>> < ACL Data TX: Handle 13 flags 0x00 dlen 20
>>
>>
>>
>>                                                            #175 [hci0]
>> 21.628386
>>       L2CAP: Information Response (0x0b) ident 3 len 12
>>         Type: Fixed channels supported (0x0003)
>>         Result: Success (0x0000)
>>         Channels: 0x0000000000000086
>>           L2CAP Signaling (BR/EDR)
>>           Connectionless reception
>>           Security Manager (BR/EDR)
>> > ACL Data RX: Handle 13 flags 0x02 dlen 20                             =
                                                                           =
                                                                           =
                                                                           =
                                              #176 [hci0] 21.636079
>>       L2CAP: Information Response (0x0b) ident 2 len 12
>>         Type: Fixed channels supported (0x0003)
>>         Result: Success (0x0000)
>>         Channels: 0x0000000000000082
>>           L2CAP Signaling (BR/EDR)
>>           Security Manager (BR/EDR)
>> > ACL Data RX: Handle 13 flags 0x02 dlen 12                             =
                                                                           =
                                                                           =
                                                                           =
                                              #177 [hci0] 21.638082
>>       L2CAP: Connection Request (0x02) ident 4 len 4
>>         PSM: 1 (0x0001)
>>         Source CID: 74
>> @ MGMT Event: Device Connected (0x000b) plen 18
>>
>>
>>
>>                                                        {0x0002} [hci0]
>> 21.638158
>>         BR/EDR Address: 64:A2:F9:XX:XX:XX (OUI 64-A2-F9)
>>         Flags: 0x00000000
>>         Data length: 5
>>         Class: 0x5a020c
>>           Major class: Phone (cellular, cordless, payphone, modem)
>>           Minor class: Smart phone
>>           Networking (LAN, Ad hoc)
>>           Capturing (Scanner, Microphone)
>>           Object Transfer (v-Inbox, v-Folder)
>>           Telephony (Cordless telephony, Modem, Headset)
>> @ MGMT Event: Device Connected (0x000b) plen 18
>>
>>
>>
>>                                                        {0x0001} [hci0]
>> 21.638158
>>         BR/EDR Address: 64:A2:F9:XX:XX:XX (OUI 64-A2-F9)
>>         Flags: 0x00000000
>>         Data length: 5
>>         Class: 0x5a020c
>>           Major class: Phone (cellular, cordless, payphone, modem)
>>           Minor class: Smart phone
>>           Networking (LAN, Ad hoc)
>>           Capturing (Scanner, Microphone)
>>           Object Transfer (v-Inbox, v-Folder)
>>           Telephony (Cordless telephony, Modem, Headset)
>> < ACL Data TX: Handle 13 flags 0x00 dlen 16
>>
>>
>>
>>                                                            #178 [hci0]
>> 21.638233
>>       L2CAP: Connection Response (0x03) ident 4 len 8
>>         Destination CID: 64
>>         Source CID: 74
>>         Result: Connection successful (0x0000)
>>         Status: No further information available (0x0000)
>> < ACL Data TX: Handle 13 flags 0x00 dlen 23
>>
>>
>>
>>                                                            #179 [hci0]
>> 21.638251
>>       L2CAP: Configure Request (0x04) ident 3 len 15
>>         Destination CID: 74
>>         Flags: 0x0000
>>         Option: Retransmission and Flow Control (0x04) [mandatory]
>>           Mode: Basic (0x00)
>>           TX window size: 0
>>           Max transmit: 0
>>           Retransmission timeout: 0
>>           Monitor timeout: 0
>>           Maximum PDU size: 0
>> > HCI Event: Remote Name Req Complete (0x07) plen 255                   =
                                                                           =
                                                                           =
                                                                           =
                                              #180 [hci0] 21.643122
>>         Status: Success (0x00)
>>         Address: 64:A2:F9:XX:XX:XX (OUI 64-A2-F9)
>>         Name: OnePlus 6
>> > HCI Event: Number of Completed Packets (0x13) plen 5                  =
                                                                           =
                                                                           =
                                                                           =
                                              #181 [hci0] 21.644131
>>         Num handles: 1
>>         Handle: 13
>>         Count: 1
>> > HCI Event: Number of Completed Packets (0x13) plen 5                  =
                                                                           =
                                                                           =
                                                                           =
                                              #182 [hci0] 21.645124
>>         Num handles: 1
>>         Handle: 13
>>         Count: 1
>> > HCI Event: Number of Completed Packets (0x13) plen 5                  =
                                                                           =
                                                                           =
                                                                           =
                                              #183 [hci0] 21.648116
>>         Num handles: 1
>>         Handle: 13
>>         Count: 1
>> > HCI Event: Number of Completed Packets (0x13) plen 5                  =
                                                                           =
                                                                           =
                                                                           =
                                              #184 [hci0] 21.649120
>>         Num handles: 1
>>         Handle: 13
>>         Count: 1
>> > ACL Data RX: Handle 13 flags 0x02 dlen 16                             =
                                                                           =
                                                                           =
                                                                           =
                                              #185 [hci0] 21.658113
>>       L2CAP: Configure Request (0x04) ident 5 len 8
>>         Destination CID: 64
>>         Flags: 0x0000
>>         Option: Maximum Transmission Unit (0x01) [mandatory]
>>           MTU: 672
>> < ACL Data TX: Handle 13 flags 0x00 dlen 18
>>
>>
>>
>>                                                            #186 [hci0]
>> 21.658194
>>       L2CAP: Configure Response (0x05) ident 5 len 10
>>         Source CID: 74
>>         Flags: 0x0000
>>         Result: Success (0x0000)
>>         Option: Maximum Transmission Unit (0x01) [mandatory]
>>           MTU: 672
>> > ACL Data RX: Handle 13 flags 0x02 dlen 14                             =
                                                                           =
                                                                           =
                                                                           =
                                              #187 [hci0] 21.659124
>>       L2CAP: Configure Response (0x05) ident 3 len 6
>>         Source CID: 64
>>         Flags: 0x0000
>>         Result: Success (0x0000)
>> > HCI Event: Number of Completed Packets (0x13) plen 5                  =
                                                                           =
                                                                           =
                                                                           =
                                              #188 [hci0] 21.661118
>>         Num handles: 1
>>         Handle: 13
>>         Count: 1
>> > ACL Data RX: Handle 13 flags 0x02 dlen 28                             =
                                                                           =
                                                                           =
                                                                           =
                                              #189 [hci0] 21.663116
>>       Channel: 64 len 24 [PSM 1 mode 0] {chan 0}
>>       SDP: Service Search Attribute Request (0x06) tid 0 len 19
>>         Search pattern: [len 5]
>>           Sequence (6) with 3 bytes [8 extra bits] len 5
>>             UUID (3) with 2 bytes [0 extra bits] len 3
>>               Audio Sink (0x110b)
>>         Max record count: 656
>>         Attribute list: [len 11]
>>           Sequence (6) with 9 bytes [8 extra bits] len 11
>>             Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
>>               0x0001
>>             Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
>>               0x0004
>>             Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
>>               0x0009
>>         Continuation state: 0
>> < ACL Data TX: Handle 13 flags 0x00 dlen 58
>>
>>
>>
>>                                                            #190 [hci0]
>> 21.663513
>>       Channel: 74 len 54 [PSM 1 mode 0] {chan 0}
>>       SDP: Service Search Attribute Response (0x07) tid 0 len 49
>>         Attribute bytes: 46
>>           Attribute list: [len 42] {position 0}
>>             Attribute: Service Class ID List (0x0001) [len 2]
>>               UUID (3) with 2 bytes [0 extra bits] len 3
>>                 Audio Sink (0x110b)
>>             Attribute: Protocol Descriptor List (0x0004) [len 2]
>>               Sequence (6) with 6 bytes [8 extra bits] len 8
>>                 UUID (3) with 2 bytes [0 extra bits] len 3
>>                   L2CAP (0x0100)
>>                 Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
>>                   0x0019
>>               Sequence (6) with 6 bytes [8 extra bits] len 8
>>                 UUID (3) with 2 bytes [0 extra bits] len 3
>>                   AVDTP (0x0019)
>>                 Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
>>                   0x0103
>>             Attribute: Bluetooth Profile Descriptor List (0x0009) [len 2=
]
>>               Sequence (6) with 6 bytes [8 extra bits] len 8
>>                 UUID (3) with 2 bytes [0 extra bits] len 3
>>                   Advanced Audio Distribution (0x110d)
>>                 Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
>>                   0x0103
>>         Continuation state: 0
>> > HCI Event: Number of Completed Packets (0x13) plen 5                  =
                                                                           =
                                                                           =
                                                                           =
                                              #191 [hci0] 21.670123
>>         Num handles: 1
>>         Handle: 13
>>         Count: 1
>> > ACL Data RX: Handle 13 flags 0x02 dlen 12                             =
                                                                           =
                                                                           =
                                                                           =
                                              #192 [hci0] 21.682116
>>       L2CAP: Disconnection Request (0x06) ident 6 len 4
>>         Destination CID: 64
>>         Source CID: 74
>> < ACL Data TX: Handle 13 flags 0x00 dlen 12
>>
>>
>>
>>                                                            #193 [hci0]
>> 21.682230
>>       L2CAP: Disconnection Response (0x07) ident 6 len 4
>>         Destination CID: 64
>>         Source CID: 74
>> > HCI Event: Number of Completed Packets (0x13) plen 5                  =
                                                                           =
                                                                           =
                                                                           =
                                              #194 [hci0] 21.685121
>>         Num handles: 1
>>         Handle: 13
>>         Count: 1
>> > HCI Event: Link Key Request (0x17) plen 6                             =
                                                                           =
                                                                           =
                                                                           =
                                              #195 [hci0] 21.708115
>>         Address: 64:A2:F9:XX:XX:XX (OUI 64-A2-F9)
>> < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
>>
>>
>>
>>                                                            #196 [hci0]
>> 21.708397
>>         Address: 64:A2:F9:XX:XX:XX (OUI 64-A2-F9)
>>         Link key: feff6b48c953f119c1579913be0c0f65
>> > HCI Event: Command Complete (0x0e) plen 10                            =
                                                                           =
                                                                           =
                                                                           =
                                              #197 [hci0] 21.710115
>>       Link Key Request Reply (0x01|0x000b) ncmd 1
>>         Status: Success (0x00)
>>         Address: 64:A2:F9:XX:XX:XX (OUI 64-A2-F9)
>> > ACL Data RX: Handle 13 flags 0x02 dlen 12                             =
                                                                           =
                                                                           =
                                                                           =
                                              #198 [hci0] 21.813116
>>       L2CAP: Connection Request (0x02) ident 7 len 4
>>         PSM: 25 (0x0019)
>>         Source CID: 75
>> > HCI Event: Encryption Change (0x08) plen 4                            =
                                                                           =
                                                                           =
                                                                           =
                                              #199 [hci0] 21.813155
>>         Status: Success (0x00)
>>         Handle: 13
>>         Encryption: Enabled with AES-CCM (0x02)
>> < ACL Data TX: Handle 13 flags 0x00 dlen 16
>>
>>
>>
>>                                                            #200 [hci0]
>> 21.813256
>>       L2CAP: Connection Response (0x03) ident 7 len 8
>>         Destination CID: 0
>>         Source CID: 75
>>         Result: Connection refused - security block (0x0003)
>>         Status: No further information available (0x0000)
>> < HCI Command: Read Encryption Key Size (0x05|0x0008) plen 2
>>
>>
>>
>>                                                            #201 [hci0]
>> 21.813277
>>         Handle: 13
>> > HCI Event: Command Complete (0x0e) plen 7                             =
                                                                           =
                                                                           =
                                                                           =
                                              #202 [hci0] 21.815118
>>       Read Encryption Key Size (0x05|0x0008) ncmd 1
>>         Status: Success (0x00)
>>         Handle: 13
>>         Key size: 16
>> > HCI Event: Number of Completed Packets (0x13) plen 5                  =
                                                                           =
                                                                           =
                                                                           =
                                              #203 [hci0] 21.816118
>>         Num handles: 1
>>         Handle: 13
>>         Count: 1
>>
>> < HCI Command: Disconnect (0x01|0x0006) plen 3
>>
>>
>>
>>                                                            #204 [hci0]
>> 25.727125
>>         Handle: 13
>>         Reason: Authentication Failure (0x05)
>> > HCI Event: Command Status (0x0f) plen 4                               =
                                                                           =
                                                                           =
                                                                           =
                                              #205 [hci0] 25.729069
>>       Disconnect (0x01|0x0006) ncmd 1
>>         Status: Success (0x00)
>> > HCI Event: Disconnect Complete (0x05) plen 4                          =
                                                                           =
                                                                           =
                                                                           =
                                              #206 [hci0] 25.738073
>>         Status: Success (0x00)
>>         Handle: 13
>>         Reason: Connection Terminated By Local Host (0x16)
>> @ MGMT Event: Device Disconnected (0x000c) plen 8
>>
>>
>>
>>                                                        {0x0002} [hci0]
>> 25.738149
>>         BR/EDR Address: 64:A2:F9:XX:XX:XX (OUI 64-A2-F9)
>>         Reason: Connection terminated by local host (0x02)
>> @ MGMT Event: Device Disconnected (0x000c) plen 8
>>
>>
>>
>>                                                        {0x0001} [hci0]
>> 25.738149
>>         BR/EDR Address: 64:A2:F9:XX:XX:XX (OUI 64-A2-F9)
>>         Reason: Connection terminated by local host (0x02)



--=20
Luiz Augusto von Dentz

Return-Path: <SRS0=ITyu=7V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817EBC433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jun 2020 16:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6056E2053B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jun 2020 16:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbgFHQd2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Jun 2020 12:33:28 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:50727 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgFHQd1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Jun 2020 12:33:27 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id B2792CECC6;
        Mon,  8 Jun 2020 18:43:14 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Should we disable ERTM as default?
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZJjhrTS+zkTqEu=8Nby7LUddwb0BUNVdkzDTACU-YZKrw@mail.gmail.com>
Date:   Mon, 8 Jun 2020 18:33:24 +0200
Cc:     Yun-hao Chung <howardchung@google.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        ChromeOS BT Qualification <chromeos-bt-qual@google.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <D2E71E47-5B2C-43EA-AFF5-07A3BB1DE094@holtmann.org>
References: <CAPHZWUe9sLt8jsD57i3=PQxMfjODP7dUYLBm2qpSXFdgd9cvAQ@mail.gmail.com>
 <64A824C9-7C3C-4B08-8A9E-827121C4786D@holtmann.org>
 <CABBYNZJtgCNeZCYQ9tWno9qD9Vi2AaJNLH5TLxMtASHS-c+ySQ@mail.gmail.com>
 <CAPHZWUd=t6icDXpz=td0teDoKHtE6FMH3OPE5R+BH53GOrXAdg@mail.gmail.com>
 <558DADDA-AC07-4463-A94E-085B16976AAB@holtmann.org>
 <CAPHZWUeo3sAGsgAapYYZTSt_apKvP-2LHOxBbYF_8pcaCzYn1Q@mail.gmail.com>
 <CABBYNZJjhrTS+zkTqEu=8Nby7LUddwb0BUNVdkzDTACU-YZKrw@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>> Here is the piece of the btmon trace.  What should be the next step?
>> 
>> < ACL Data TX: Handle 256 flags 0x00 dlen 6
>>      Channel: 66 len 2 [PSM 25 mode Basic (0x00)] {chan 2}
>>      AVDTP: Discover (0x01) Command (0x00) type 0x00 label 3 nosp 0
>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>        Num handles: 1
>>        Handle: 256
>>        Count: 1
>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>        Num handles: 1
>>        Handle: 256
>>        Count: 1
>>> ACL Data RX: Handle 256 flags 0x02 dlen 8
>>      Channel: 66 len 4 [PSM 25 mode Basic (0x00)] {chan 2}
>>      AVDTP: Discover (0x01) Response Accept (0x02) type 0x00 label 3 nosp 0
>>        ACP SEID: 1
>>          Media Type: Audio (0x00)
>>          SEP Type: SNK (0x01)
>>          In use: No
>> < ACL Data TX: Handle 256 flags 0x00 dlen 18
>>      Channel: 66 len 14 [PSM 25 mode Basic (0x00)] {chan 2}
>>      AVDTP: Set Configuration (0x03) Command (0x00) type 0x00 label 4 nosp 0
>>        ACP SEID: 1
>>        INT SEID: 1
>>        Service Category: Media Transport (0x01)
>>        Service Category: Media Codec (0x07)
>>          Media Type: Audio (0x00)
>>          Media Codec: SBC (0x00)
>>            Frequency: 48000 (0x10)
>>            Channel Mode: Joint Stereo (0x01)
>>            Block Length: 16 (0x10)
>>            Subbands: 8 (0x04)
>>            Allocation Method: Loudness (0x01)
>>            Minimum Bitpool: 2
>>            Maximum Bitpool: 64
>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>        Num handles: 1
>>        Handle: 256
>>        Count: 1
>>> ACL Data RX: Handle 256 flags 0x02 dlen 6
>>      Channel: 66 len 2 [PSM 25 mode Basic (0x00)] {chan 2}
>>      AVDTP: Set Configuration (0x03) Response Accept (0x02) type 0x00 label 4 nosp 0
>> < ACL Data TX: Handle 256 flags 0x00 dlen 7
>>      Channel: 66 len 3 [PSM 25 mode Basic (0x00)] {chan 2}
>>      AVDTP: Open (0x06) Command (0x00) type 0x00 label 5 nosp 0
>>        ACP SEID: 1
>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>        Num handles: 1
>>        Handle: 256
>>        Count: 1
>>> ACL Data RX: Handle 256 flags 0x02 dlen 6
>>      Channel: 66 len 2 [PSM 25 mode Basic (0x00)] {chan 2}
>>      AVDTP: Open (0x06) Response Accept (0x02) type 0x00 label 5 nosp 0
>> < ACL Data TX: Handle 256 flags 0x00 dlen 12
>>      L2CAP: Connection Request (0x02) ident 6 len 4
>>        PSM: 25 (0x0019)
>>        Source CID: 67
>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>        Num handles: 1
>>        Handle: 256
>>        Count: 1
>>> ACL Data RX: Handle 256 flags 0x02 dlen 16
>>      L2CAP: Connection Response (0x03) ident 6 len 8
>>        Destination CID: 67
>>        Source CID: 67
>>        Result: Connection pending (0x0001)
>>        Status: No further information available (0x0000)
>>> ACL Data RX: Handle 256 flags 0x02 dlen 16
>>      L2CAP: Connection Response (0x03) ident 6 len 8
>>        Destination CID: 67
>>        Source CID: 67
>>        Result: Connection successful (0x0000)
>>        Status: No further information available (0x0000)
>> < ACL Data TX: Handle 256 flags 0x00 dlen 23
>>      L2CAP: Configure Request (0x04) ident 7 len 15
>>        Destination CID: 67
>>        Flags: 0x0000
>>        Option: Retransmission and Flow Control (0x04) [mandatory]
>>          Mode: Basic (0x00)
>>          TX window size: 0
>>          Max transmit: 0
>>          Retransmission timeout: 0
>>          Monitor timeout: 0
>>          Maximum PDU size: 0
>>> ACL Data RX: Handle 256 flags 0x02 dlen 23
>>      L2CAP: Configure Request (0x04) ident 222 len 15
>>        Destination CID: 67
>>        Flags: 0x0000
>>        Option: Retransmission and Flow Control (0x04) [mandatory]
>>          Mode: Streaming (0x04)
> 
> Looks like we should be using BT_IO_MODE_STREAMING with MPS then.
> 
>>          TX window size: 0
>>          Max transmit: 0
>>          Retransmission timeout: 0
>>          Monitor timeout: 0
>>          Maximum PDU size: 672
>> < ACL Data TX: Handle 256 flags 0x00 dlen 25
>>      L2CAP: Configure Response (0x05) ident 222 len 17
>>        Source CID: 67
>>        Flags: 0x0000
>>        Result: Failure - unacceptable parameters (0x0001)
>>        Option: Retransmission and Flow Control (0x04) [mandatory]
>>          Mode: Basic (0x00)
>>          TX window size: 0
>>          Max transmit: 0
>>          Retransmission timeout: 0
>>          Monitor timeout: 0
>>          Maximum PDU size: 672
>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>        Num handles: 1
>>        Handle: 256
>>        Count: 1
>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>        Num handles: 1
>>        Handle: 256
>>        Count: 1
>>> ACL Data RX: Handle 256 flags 0x02 dlen 29
>>      L2CAP: Configure Response (0x05) ident 7 len 21
>>        Source CID: 67
>>        Flags: 0x0000
>>        Result: Success (0x0000)
>>        Option: Maximum Transmission Unit (0x01) [mandatory]
>>          MTU: 672
>>        Option: Retransmission and Flow Control (0x04) [mandatory]
>>          Mode: Basic (0x00)
>>          TX window size: 0
>>          Max transmit: 0
>>          Retransmission timeout: 0
>>          Monitor timeout: 0
>>          Maximum PDU size: 0
>>> ACL Data RX: Handle 256 flags 0x02 dlen 12
>>      L2CAP: Configure Request (0x04) ident 223 len 4
>>        Destination CID: 67
>>        Flags: 0x0000
>> < ACL Data TX: Handle 256 flags 0x00 dlen 18
>>      L2CAP: Configure Response (0x05) ident 223 len 10
>>        Source CID: 67
>>        Flags: 0x0000
>>        Result: Success (0x0000)
>>        Option: Maximum Transmission Unit (0x01) [mandatory]
>>          MTU: 672
>> 
>> Thanks.
>> 
>> On Mon, Jun 8, 2020 at 3:58 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>>> 
>>> Hi Yun-hao,
>>> 
>>>> I think it is more likely to be the PTS's limitations. I realized the
>>>> problem is in the media channel not in the signaling channel. PTS
>>>> wants to use streaming mode, but bluez rejects it, and then PTS aborts
>>>> the test. According to the MPS 1.0 Spec 6.2, L2CAP streaming mode is
>>>> the recommendation for optimization when using MPS media control
>>>> channels, so I think bluez doesn't do anything wrong during this test.
>>> 
>>> do you have the btmon trace for this. I think we should accept ERTM on the media channel. The unfortunate part is that control and media channels both use PSM 25 and so we can’t be really selective when we are the acceptor. If MPS wants us to accept ERTM on the media channel we should allow. For all I care we can even accept it on the control channel, but it is just a waste of overhead on the L2CAP headers. Actually the new Enhanced Flow Control mode on BR/EDR would be more efficient for A2DP.
> 
> Perhaps we can default to Streaming mode if MPS is enabled, we could
> actually do use it only for the transport channel while initiating but
> as a receiver I don't think it is possible to change after listen.

yep, as acceptor we would have to enable streaming mode and allow to downgrade to basic mode. For initiator we can separate between control channel in basic mode and media channel in streaming mode.

Regards

Marcel


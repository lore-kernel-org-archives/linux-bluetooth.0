Return-Path: <SRS0=5+i7=ZL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD990C432C0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 05:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A1322318
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 05:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbfKSFGO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:06:14 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:55250 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfKSFGO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Nov 2019 00:06:14 -0500
Received: from marcel-macbook.holtmann.net (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id 31B17CECED;
        Tue, 19 Nov 2019 06:15:19 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: Bluetooth disconnect event / Link layer monitoring
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZ+VfyOeWjfdE64bVQM0eAJE789NRBjy+wgKa_Dka2ZZJg@mail.gmail.com>
Date:   Tue, 19 Nov 2019 06:06:12 +0100
Cc:     Guy Morand <g.morand@scewo.ch>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <F827D8AB-4404-4C81-9368-A18AB87D9292@holtmann.org>
References: <CAGssATiS=dpA=WOSfLek385o2g=C5sb0z+z=V7CDswn9_5Eu-g@mail.gmail.com>
 <CABBYNZ+VfyOeWjfdE64bVQM0eAJE789NRBjy+wgKa_Dka2ZZJg@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>> We are developing a wheelchair that we can controle with a bluetooth
>> gamepad, the XBOX 360 controller to be more precise. It basically works
>> fine but when I remove the battery, I get the disconnect event in the
>> user space around 10 seconds later. That is not acceptable since the
>> wheelchair will keep rolling to potentially dangerous places!
>> 
>> I tried to implement a ping mechanism on the bluetooth layer, inspired
>> from bluez sources somewhere:
>>  int _socket_fd = socket(PF_BLUETOOTH, SOCK_RAW, BTPROTO_L2CAP);
>>  // bind on AF_BLUETOOTH
>>  // connect with AF_BLUETOOTH
>> 
>>  send_cmd->ident = PING_IDENT;
>>  send_cmd->len = htobs(PING_DATA_SIZE);
>>  send_cmd->code = L2CAP_ECHO_REQ;
>>  if (send(_socket_fd, send_buffer, PING_PACKET_SIZE, 0) <= 0) {
>>    // ...
>>  }
>> 
>> It basically works fine except when the signal gets bad. This will get
>> printed by the kernel:
>> [  859.629431] Bluetooth: hci0 link tx timeout
>> [  859.635482] Bluetooth: hci0 killing stalled connection 9c:aa:1b:6b:51:c9
>> 
>> In that case, I don't get event from the /dev/jsX device but the gamepad
>> seems to still answer to pings??!!
>> 
>> Since I haven't found any acceptable workaround and always find the same
>> pages again and again, I'm asking here:
>> * Is it possible to achieve what I want?
>> * Does it make sense that the ping work but the HID layer seems dead?
>> * Any recommendation, pointers?
> 
> Id look into adjusting the link supervision timeout instead of
> creating a raw socket, you can use hcitool to do that, neither is
> really great since it require root but at least the supervision
> timeout is something a lot more reliable for this.

we can add an option to L2CAP sockets to adjust the link supervision timeout.

Anyway, these days, I would _not_ use Bluetooth BR/EDR for controlling anything. I would find a Gamepad that utilizes Bluetooth LE and focus on that.

Regards

Marcel


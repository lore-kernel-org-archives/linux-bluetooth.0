Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE63C47089
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Dec 2022 03:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiLFDQq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Dec 2022 22:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbiLFDQm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Dec 2022 22:16:42 -0500
X-Greylist: delayed 305 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Dec 2022 19:16:40 PST
Received: from net153.net (unknown [38.67.43.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1683025E9A
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Dec 2022 19:16:39 -0800 (PST)
Received: from [IPV6:2001:470:b965:1:26a1:8f80:3e64:f9a1] (unknown [IPv6:2001:470:b965:1:26a1:8f80:3e64:f9a1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by net153.net (Postfix) with ESMTPSA id 8BE88778
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Dec 2022 21:11:31 -0600 (CST)
Message-ID: <f85a4334-fc06-76a1-e693-d5e8dedf5300@net153.net>
Date:   Mon, 5 Dec 2022 21:11:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To:     linux-bluetooth@vger.kernel.org
From:   Samuel Smith <satlug@net153.net>
Subject: Needless logging with QCA WCN6855
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

Not sure if this is the right place, but I've noticed excessive logging 
coming from the bluetooth stack while using the QCA WCN6855 combined 
bluetooth/wifi card. Using a bluetooth mouse results in a few messages 
per minute. Using wireless headphones results in upwards of 3 messages 
per second.

The computer is a Lenovo T14 Amd Gen 2 (sku 20XK006BUS) Direct link 
here: https://tinyurl.com/5xrad7w5

The software is Debian Stable, with kernel versions of 5.18, 5.19, and 6.0.

The excessive logging is in the the form of:

[3400058.603040] Bluetooth: hci0: ACL packet for unknown connection 
handle 3804
[3400058.603396] Bluetooth: hci0: ACL packet for unknown connection 
handle 3804
[3400058.603916] Bluetooth: hci0: ACL packet for unknown connection 
handle 3804
[3400059.000540] Bluetooth: hci0: ACL packet for unknown connection 
handle 3804
[3400061.130513] Bluetooth: hci0: ACL packet for unknown connection 
handle 3804
[3400083.158218] Bluetooth: hci0: ACL packet for unknown connection 
handle 3804
[3400083.158622] Bluetooth: hci0: ACL packet for unknown connection 
handle 3804
[3400083.159139] Bluetooth: hci0: ACL packet for unknown connection 
handle 3804
  [3400083.623400] Bluetooth: hci0: ACL packet for unknown connection 
handle 3804

"Connection handle 3804" coincides with this commit 
(https://github.com/torvalds/linux/commit/c614ca3f7476934de54dd731e09d094ad822696c) 
from Oct 2018 where extra logic was added to hci_qca.c to handle the 
fact that QCA devices use ACL packets to transmit extra controller 
debugging info. The WCN6855 chipset does not use the UART interface but 
uses btusb.c. The logic from hci_qca.c was never backported for the USB 
interface though. I believe that is the problem. There are other 
manufactures doing similar within btusb.c, see btusb_recv_acl_mtk().

It also seems at one time QCA was disabling the extra logging via some 
extra commands, at least for the devices that use btqca.c: 
https://github.com/torvalds/linux/commit/83e81961ff7ef75f97756f316caea5aa6bcc19cc

So because this is all QCA code, I'm not sure if I'm at liberty to 
provide a patch. For now, I've simply built the bluetooth stack with 
logging for "unknown connection handle" disabled (within 
hci_recv_frame() ). But could someone in the know perhaps forward this 
to any applicable maintainers?

Feel free to ask me for any extra info if needed.

Kind regards,
Samuel Smith

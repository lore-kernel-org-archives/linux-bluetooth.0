Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D44C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 10:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbiBXK0u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Feb 2022 05:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbiBXK0t (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Feb 2022 05:26:49 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261DF28B63E
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Feb 2022 02:26:19 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nNBKD-000699-LP; Thu, 24 Feb 2022 11:26:17 +0100
Message-ID: <0ab4466e-1fa8-1904-3f71-770fbd28c83a@leemhuis.info>
Date:   Thu, 24 Feb 2022 11:26:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: bug kernel 5.17, qualcom and intel adapters, unable to reliably
 connect to bluetooth devices
Content-Language: en-BW
To:     Chris Murphy <lists@colorremedies.com>,
        Bluetooth <linux-bluetooth@vger.kernel.org>
References: <CAJCQCtSeUtHCgsHXLGrSTWKmyjaQDbDNpP4rb0i+RE+L2FTXSA@mail.gmail.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
In-Reply-To: <CAJCQCtSeUtHCgsHXLGrSTWKmyjaQDbDNpP4rb0i+RE+L2FTXSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1645698379;293772a1;
X-HE-SMSGID: 1nNBKD-000699-LP
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

[TLDR: I'm adding the regression report below to regzbot, the Linux
kernel regression tracking bot; all text you find below is compiled from
a few templates paragraphs you might have encountered already already
from similar mails.]

Hi, this is your Linux kernel regression tracker speaking.

Thanks for the report and CCing the regression list in a downstream reply.

To be sure this issue doesn't fall through the cracks unnoticed, I'm
adding it to regzbot, my Linux kernel regression tracking bot:

#regzbot ^introduced v5.16..
#regzbot title net: bluetooth: qualcom and intel adapters, unable to
reliably connect to bluetooth devices
#regzbot ignore-activity

Reminder for developers: when fixing the issue, please add a 'Link:'
tags pointing to the report (the mail quoted above) using
lore.kernel.org/r/, as explained in
'Documentation/process/submitting-patches.rst' and
'Documentation/process/5.Posting.rst'. This allows the bot to connect
the report with any patches posted or committed to fix the issue; this
again allows the bot to show the current status of regressions and
automatically resolve the issue when the fix hits the right tree.

I'm sending this to everyone that got the initial report, to make them
aware of the tracking. I also hope that messages like this motivate
people to directly get at least the regression mailing list and ideally
even regzbot involved when dealing with regressions, as messages like
this wouldn't be needed then.

Don't worry, I'll send further messages wrt to this regression just to
the lists (with a tag in the subject so people can filter them away), if
they are relevant just for regzbot. With a bit of luck no such messages
will be needed anyway.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.





On 11.02.22 02:44, Chris Murphy wrote:
> Since kernel 5.17, some users are seeing problems connecting to
> bluetooth devices, the problem doesn't happen with 5.16 series
> kernels.
> 
> So far two different devices are affected, although it's possible it's
> not even device related, but could be the interface between kernel and
> user space.
> 
> Case 1:
> 
> Bus 001 Device 003: ID 0cf3:e301 Qualcomm Atheros Communications
> 
> Not seeing anything that stands out in dmesg, bluetoothd -d shows
> various curious messages like
> 
> bluetoothd[5889]: src/service.c:change_state() 0x7f33becdebc0: device
> 94:65:2D:DC:F4:A7 profile avrcp-controller state changed: disconnected
> -> unavailable (0)
> and
> bluetoothd[5889]: src/service.c:change_state() 0x7f33becd91e0: device
> 94:65:2D:DC:F4:A7 profile Hands-Free Voice gateway state changed:
> unavailable -> disconnected (0)
> 
> 
> Case 2:
> 
> Bus 001 Device 005: ID 8087:0aaa Intel Corp. Bluetooth 9460/9560
> Jefferson Peak (JfP)
> [    5.923865] kernel: Bluetooth: hci0: Found device firmware:
> intel/ibt-17-16-1.sfi
> [    5.930536] kernel: Bluetooth: hci0: Boot Address: 0x40800
> [    5.930539] kernel: Bluetooth: hci0: Firmware Version: 60-44.21
> ...
> [16102.640651] Bluetooth: hci0: unexpected event 0xff length: 5 > 0
> [16102.640802] Bluetooth: hci0: Waiting for device to boot
> [16102.654712] Bluetooth: hci0: Device booted in 13698 usecs
> [16102.654753] Bluetooth: hci0: unexpected event 0xff length: 7 > 0
> [16102.655907] Bluetooth: hci0: Found Intel DDC parameters:
> intel/ibt-17-16-1.ddc
> [16102.657821] Bluetooth: hci0: Applying Intel DDC parameters completed
> [16102.658829] Bluetooth: hci0: Firmware revision 0.1 build 60 week 44 2021
> [17422.210558] Bluetooth: hci0: command 0x0c03 tx timeout
> [17430.338412] Bluetooth: hci0: HCI reset during shutdown failed
> 
> [15975.194153] bluetoothd[42895]:
> src/adapter.c:device_found_callback() hci0 addr 75:0B:19:0C:47:F6,
> rssi -82 flags 0x0000 eir_len 17
> [15975.194412] bluetoothd[42895]:
> src/adv_monitor.c:btd_adv_monitor_offload_supported() Manager is NULL,
> get offload support failed
> [15975.194510] bluetoothd[42895]: src/device.c:device_set_legacy() legacy 0
> [15975.194599] bluetoothd[42895]:
> src/device.c:device_set_rssi_with_delta() rssi -82 delta 1
> [15975.194661] bluetoothd[42895]: src/device.c:device_set_flags() flags 26
> 
> There are many many of the "Manager is NULL, get offload support
> failed" messages in this case. I'm not entirely sure the root causes
> are the same for the two cases.
> 
> Downstream bug has attachments (dmesg, btmon, lsbsb, journalctl
> snippet with bluetoothd in debug, for both)
> https://bugzilla.redhat.com/show_bug.cgi?id=2053283
> 
> Thanks,
> 

-- 
Additional information about regzbot:

If you want to know more about regzbot, check out its web-interface, the
getting start guide, and the references documentation:

https://linux-regtracking.leemhuis.info/regzbot/
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

The last two documents will explain how you can interact with regzbot
yourself if your want to.

Hint for reporters: when reporting a regression it's in your interest to
CC the regression list and tell regzbot about the issue, as that ensures
the regression makes it onto the radar of the Linux kernel's regression
tracker -- that's in your interest, as it ensures your report won't fall
through the cracks unnoticed.

Hint for developers: you normally don't need to care about regzbot once
it's involved. Fix the issue as you normally would, just remember to
include 'Link:' tag in the patch descriptions pointing to all reports
about the issue. This has been expected from developers even before
regzbot showed up for reasons explained in
'Documentation/process/submitting-patches.rst' and
'Documentation/process/5.Posting.rst'.

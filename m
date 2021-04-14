Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5459DC43460
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Apr 2021 06:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DE2161220
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Apr 2021 06:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349642AbhDNG7f (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Apr 2021 02:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349576AbhDNG7d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Apr 2021 02:59:33 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE50C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Apr 2021 23:59:11 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id t23so9762623pjy.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Apr 2021 23:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=C/7TcBhBizHABgSpmiEMFlLUmsctOi7afDo3pNON0nk=;
        b=bgCVgYrumKPGXUMNtgrIOIGgigbjpIdDcOl2d72nfbP3vHYPGcnayNgFH+6L+UNPfy
         zIGEX2g4YD/13RLokArh2FkSvbS+yBhLQNClFAgSJg7q6VnXt0N7BSOxELZ9MQ1/Yrdz
         X41p9MwnZCMJ/FiXKVb6l+wGtRTWNXMaqf27lhKpc2Gsa3xtuyOM6vRdJ2Lc8CcsJIfq
         zZQht5aOutzMCS5B3bw4yDAR6I9u7x7XC5SIAUWKFrQvct5d3xV3CmbpS7b+WHvJhyIv
         MQEzPeLC8rhrCTeb0n8+7HqBCX4ejn8uWaAax0uQrRDpibVbz7H2xmA0tjq3msOf3Xec
         PMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=C/7TcBhBizHABgSpmiEMFlLUmsctOi7afDo3pNON0nk=;
        b=rqEHubNRr3i2KXPun9iFVRQGgiL3aXqGAHQfXbh7wYeIvFz1WkUGbXX3SITZP+agMC
         v7615xobtRUc0gO3I59o3YjoNNmbAqJQchdNt1JhLXr+Vdfgs4VqxbhkltrXS0Fl9Hzd
         pkOACESTOmsoOvcz+vg40MYEQ13q8s2yKYtXRYNSxtft3hPp030cgVGf22Rm1Rmc0xr1
         PXe4CiKwl6p5e3btCrfIpzQXFMNTHBkI8Ul3pcZOwmokK2arPYJnrRWHY56xX+GvbI9G
         VO3c7VAUVS6P2EW2zDuOlWiANuwFCy904Qh43oJDd4dPt5xLK3tynnlk/ibH6fL4mqeJ
         kTRg==
X-Gm-Message-State: AOAM531HfrcD6bA7Mm4hZvEIIdApZ8guHJRtnt+5J/VOiuXqsQKp0FYK
        NLW+x1EGiRqGaCWoYPPfAog/PPJPIUoslfSCADTXPQBISMgj5F2Z
X-Google-Smtp-Source: ABdhPJyhmNJN/ziRpIQEywX8CLFdwMew1x0b+o9NQhp1l//y/8QtNhYjuHwlP3rR7E4gaEE1vcFAv+I97uwgtxH68d8=
X-Received: by 2002:a17:90a:300f:: with SMTP id g15mr2107391pjb.88.1618383550815;
 Tue, 13 Apr 2021 23:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAA_JV5Mz=xFthCPpLKZtYj8hwvrei9pg3HZo8SLJgU1xc8N0DQ@mail.gmail.com>
In-Reply-To: <CAA_JV5Mz=xFthCPpLKZtYj8hwvrei9pg3HZo8SLJgU1xc8N0DQ@mail.gmail.com>
From:   nagesh shamnur <nagesh.shamnur@gmail.com>
Date:   Wed, 14 Apr 2021 12:28:59 +0530
Message-ID: <CAA_JV5PmRr4G2bcoJLaR8ccKD5OE0O=L9H121SLmJJW2On3p2w@mail.gmail.com>
Subject: Re: Issue connecting laptop and RPi via 6LoWPAN over BLE
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Group,
    My earlier issue of getting 0x12 error got solved after upgrading
my kernel version to "5.11.13-051113-generic" on my ubuntu laptop, but
 bt0 doesn't seem to be established. unable to figure out what could
be the issue here.

Following are the commands i have run with no errors (even no logs in dmesg)

#modprobe bluetooth_6lowpan
#echo 1 > /sys/kernel/debug/bluetooth/6lowpan_enable
#echo "connect RPi4B_BD_Address 1 " >
/sys/kernel/debug/bluetooth/6lowpan_control

but bt0 is not created when checked ifconfig -a

btmon log is as below:
"
< HCI Command: Unknown (0x08|0x0041) plen 8

                                           [hci0] 143.040756
        00 01 01 00 60 00 60 00                          ....`.`.
> HCI Event: Command Complete (0x0e) plen 4                                                                                                                                              [hci0] 143.155668
      Unknown (0x08|0x0041) ncmd 1
        Status: Success (0x00)
< HCI Command: Unknown (0x08|0x0042) plen 6

                                           [hci0] 143.155720
        01 01 00 00 00 00                                ......
> HCI Event: Command Complete (0x0e) plen 4                                                                                                                                              [hci0] 143.157661
      Unknown (0x08|0x0042) ncmd 2
        Status: Success (0x00)
< HCI Command: Unknown (0x08|0x0042) plen 6

                                           [hci0] 183.177988
        00 00 00 00 00 00                                ......
> HCI Event: Command Complete (0x0e) plen 4                                                                                                                                              [hci0] 183.345709
      Unknown (0x08|0x0042) ncmd 2
        Status: Success (0x00)
"

On Mon, Apr 12, 2021 at 4:41 PM nagesh shamnur <nagesh.shamnur@gmail.com> wrote:
>
> Hi Group,
>      I am trying to establish a 6LowPAN over BLE connection between my
> Ubuntu Laptop and Raspberry Pi 4B. Laptop is running Ubuntu
> 5.8.0-48-generic #54~20.04.1-Ubuntu and my RPi is running custom
> yocto-based Linux distro with kernel version 5.4.x version.
>
> I am facing an error of 0x12 when trying to establish to Rpi from the
> laptop as below:
>
> root@root1-Nitro-AN515-55:/home/root1# lsmod | grep 6low
> bluetooth_6lowpan      28672  0
> 6lowpan                40960  8
> nhc_fragment,nhc_dest,nhc_ipv6,bluetooth_6lowpan,nhc_hop,nhc_udp,nhc_mobility,nhc_routing
> bluetooth             581632  31
> btrtl,bluetooth_6lowpan,btintel,btbcm,bnep,btusb
> root@root1-Nitro-AN515-55:/home/root1# echo 1 >
> /sys/kernel/debug/bluetooth/6lowpan_enable
> root@root1-Nitro-AN515-55:/home/root1# dmesg
> root@root1-Nitro-AN515-55:/home/root1# echo "connect DC:A6:32:F2:CB:46
> 1" > /sys/kernel/debug/bluetooth/6lowpan_control runn
> root@root1-Nitro-AN515-55:/home/root1# dmesg
> [239155.542994] Bluetooth: hci0: request failed to create LE
> connection: status 0x12
>
> Running btmon in another shell resulted in the following log as attached.
>
> Additional Info: using bluetoothctl between my Laptop and RPi s
> successful but 6LowPAN is unable to go through.
>
> Any missing from my end?
>
> Thanks,
> Nagesh.

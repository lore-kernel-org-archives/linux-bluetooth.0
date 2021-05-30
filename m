Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691FAC47091
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 May 2021 11:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38E6C610C7
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 May 2021 11:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhE3L6n (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 30 May 2021 07:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhE3L6m (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 30 May 2021 07:58:42 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D328C061574
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 May 2021 04:57:04 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4FtH3125KHzQjXk
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 May 2021 13:57:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id 4Ft9p7C_RFXV for <linux-bluetooth@vger.kernel.org>;
        Sun, 30 May 2021 13:56:57 +0200 (CEST)
Message-ID: <0feae4a19f7afbecbcb233d169cf04d42d7bb3c6.camel@mailbox.org>
Subject: Audio playback over bluetooth stutters during scan
From:   Christian Stadelmann <dev@genodeftest.de>
To:     linux-bluetooth@vger.kernel.org
Date:   Sun, 30 May 2021 13:56:57 +0200
Content-Type: multipart/mixed; boundary="=-geCdgYwykuAjzbS13X+/"
MIME-Version: 1.0
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -3.09 / 15.00 / 15.00
X-Rspamd-Queue-Id: 0F2CA189A
X-Rspamd-UID: 020bef
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--=-geCdgYwykuAjzbS13X+/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Dear bluez developers,

whenever I start bluetooth scanning on my PC, any audio playback over
bluetooth stutters.

Example #1 with GUI tools:
https://gitlab.gnome.org/GNOME/gnome-control-center/-/issues/409

Example #2 with bluetoothctl:
1. Connect a bluetooth speaker or headphone to the PC
2. start audio playback (e.g. using totem)
3. run `bluetoothctl scan on`

What happens:
As long as bluetooth scan is runnig, audio playback stutters. Once I
kill `bluetoothctl scan on` or close gnome's control center, audio
playback is back to normal.

Would it be possible to modify the scanning behaviour in a way that it
does not make audio playback stutter? 


Software versions (Fedora 34):
bluez 5.58 (5.58-2.fc34.x86_64)
kernel 5.12.7 (5.12.7-300.fc34.x86_64)

PS: I've attached the output of `$ bluetoothctl info` and `$
bluetoothctl show` but I doubt it is relevant for this issue.

-- 
Kind Regards
Chris


--=-geCdgYwykuAjzbS13X+/
Content-Disposition: attachment; filename="bluetoothctl_info.txt"
Content-Type: text/plain; name="bluetoothctl_info.txt"; charset="UTF-8"
Content-Transfer-Encoding: base64

RGV2aWNlIDk0OkRCOjU2OltyZWRhY3RlZF0gKHB1YmxpYykKCU5hbWU6IFdILTEwMDBYTTMKCUFs
aWFzOiBXSC0xMDAwWE0zCglDbGFzczogMHgwMDI0MDQwNAoJSWNvbjogYXVkaW8tY2FyZAoJUGFp
cmVkOiB5ZXMKCVRydXN0ZWQ6IHllcwoJQmxvY2tlZDogbm8KCUNvbm5lY3RlZDogeWVzCglMZWdh
Y3lQYWlyaW5nOiBubwoJVVVJRDogVmVuZG9yIHNwZWNpZmljICAgICAgICAgICAoMDAwMDAwMDAt
ZGVjYS1mYWRlLWRlY2EtZGVhZmRlY2FjYWZmKQoJVVVJRDogSGVhZHNldCAgICAgICAgICAgICAg
ICAgICAoMDAwMDExMDgtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiKQoJVVVJRDogQXVkaW8g
U2luayAgICAgICAgICAgICAgICAoMDAwMDExMGItMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZi
KQoJVVVJRDogQS9WIFJlbW90ZSBDb250cm9sIFRhcmdldCAoMDAwMDExMGMtMDAwMC0xMDAwLTgw
MDAtMDA4MDVmOWIzNGZiKQoJVVVJRDogQS9WIFJlbW90ZSBDb250cm9sICAgICAgICAoMDAwMDEx
MGUtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiKQoJVVVJRDogSGFuZHNmcmVlICAgICAgICAg
ICAgICAgICAoMDAwMDExMWUtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiKQoJVVVJRDogUG5Q
IEluZm9ybWF0aW9uICAgICAgICAgICAoMDAwMDEyMDAtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIz
NGZiKQoJVVVJRDogVmVuZG9yIHNwZWNpZmljICAgICAgICAgICAoN2IyNjViMGUtMjIzMi00ZDQ1
LWJlZjQtYmI4YWU2MmY4MTNkKQoJVVVJRDogVmVuZG9yIHNwZWNpZmljICAgICAgICAgICAoODFj
MmU3MmEtMDU5MS00NDNlLWExZmYtMDVmOTg4NTkzMzUxKQoJVVVJRDogVmVuZG9yIHNwZWNpZmlj
ICAgICAgICAgICAoOTMxYzdlOGEtNTQwZi00Njg2LWI3OTgtZThkZjBhMmFkOWY3KQoJVVVJRDog
VmVuZG9yIHNwZWNpZmljICAgICAgICAgICAoOTZjYzIwM2UtNTA2OC00NmFkLWIzMmQtZTMxNmY1
ZTA2OWJhKQoJVVVJRDogVmVuZG9yIHNwZWNpZmljICAgICAgICAgICAoYjliMjEzY2UtZWVhYi00
OWU0LThmZDktYWE0NzhlZDFiMjZiKQoJVVVJRDogVmVuZG9yIHNwZWNpZmljICAgICAgICAgICAo
ZjhkMWZiZTQtNzk2Ni00MzM0LTgwMjQtZmY5NmM5MzMwZTE1KQoJTW9kYWxpYXM6IHVzYjp2MDU0
Q3AwQ0QzZDA0NTIK


--=-geCdgYwykuAjzbS13X+/
Content-Disposition: attachment; filename="bluetoothctl_show.txt"
Content-Type: text/plain; name="bluetoothctl_show.txt"; charset="UTF-8"
Content-Transfer-Encoding: base64

Q29udHJvbGxlciAwMDpEQjpERjpbcmVkYWN0ZWRdIChwdWJsaWMpCglOYW1lOiBbcmVkYWN0ZWRd
CglBbGlhczogW3JlZGFjdGVkXQoJQ2xhc3M6IDB4MDA3YzAxMGMKCVBvd2VyZWQ6IHllcwoJRGlz
Y292ZXJhYmxlOiB5ZXMKCURpc2NvdmVyYWJsZVRpbWVvdXQ6IDB4MDAwMDAwMDAKCVBhaXJhYmxl
OiBubwoJVVVJRDogQS9WIFJlbW90ZSBDb250cm9sICAgICAgICAoMDAwMDExMGUtMDAwMC0xMDAw
LTgwMDAtMDA4MDVmOWIzNGZiKQoJVVVJRDogQXVkaW8gU291cmNlICAgICAgICAgICAgICAoMDAw
MDExMGEtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiKQoJVVVJRDogUG5QIEluZm9ybWF0aW9u
ICAgICAgICAgICAoMDAwMDEyMDAtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiKQoJVVVJRDog
QXVkaW8gU2luayAgICAgICAgICAgICAgICAoMDAwMDExMGItMDAwMC0xMDAwLTgwMDAtMDA4MDVm
OWIzNGZiKQoJVVVJRDogSGVhZHNldCAgICAgICAgICAgICAgICAgICAoMDAwMDExMDgtMDAwMC0x
MDAwLTgwMDAtMDA4MDVmOWIzNGZiKQoJVVVJRDogTWVzc2FnZSBOb3RpZmljYXRpb24gU2UuLiAo
MDAwMDExMzMtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiKQoJVVVJRDogQS9WIFJlbW90ZSBD
b250cm9sIFRhcmdldCAoMDAwMDExMGMtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiKQoJVVVJ
RDogSGFuZHNmcmVlIEF1ZGlvIEdhdGV3YXkgICAoMDAwMDExMWYtMDAwMC0xMDAwLTgwMDAtMDA4
MDVmOWIzNGZiKQoJVVVJRDogTWVzc2FnZSBBY2Nlc3MgU2VydmVyICAgICAoMDAwMDExMzItMDAw
MC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiKQoJVVVJRDogT0JFWCBGaWxlIFRyYW5zZmVyICAgICAg
ICAoMDAwMDExMDYtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiKQoJVVVJRDogUGhvbmVib29r
IEFjY2VzcyBTZXJ2ZXIgICAoMDAwMDExMmYtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiKQoJ
VVVJRDogSXJNQyBTeW5jICAgICAgICAgICAgICAgICAoMDAwMDExMDQtMDAwMC0xMDAwLTgwMDAt
MDA4MDVmOWIzNGZiKQoJVVVJRDogT0JFWCBPYmplY3QgUHVzaCAgICAgICAgICAoMDAwMDExMDUt
MDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiKQoJTW9kYWxpYXM6IHVzYjp2MUQ2QnAwMjQ2ZDA1
M0EKCURpc2NvdmVyaW5nOiBubwo=


--=-geCdgYwykuAjzbS13X+/--


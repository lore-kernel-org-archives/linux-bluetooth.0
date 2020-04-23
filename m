Return-Path: <SRS0=6Duj=6H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317F9C54FCB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 17:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 146C02076C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 17:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbgDWR76 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Apr 2020 13:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729991AbgDWR76 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Apr 2020 13:59:58 -0400
X-Greylist: delayed 396 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Apr 2020 10:59:58 PDT
Received: from kronos.mailus.de (kronos.mailus.de [IPv6:2a01:4f8:171:2684::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71240C09B042
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2020 10:59:58 -0700 (PDT)
Received: from [IPv6:2003:c0:7714:6b00:527b:9dff:febd:4d92] (p200300C077146B00527B9DFFFEBD4D92.dip0.t-ipconnect.de [IPv6:2003:c0:7714:6b00:527b:9dff:febd:4d92])
        by kronos.mailus.de (Postfix) with ESMTPSA id 0F9C2606DA
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2020 19:53:21 +0200 (CEST)
To:     linux-bluetooth@vger.kernel.org
From:   Erik Andresen <erik@vontaene.de>
Subject: HID device with multiple collections does not work
Message-ID: <319b239d-3739-63e9-9fe4-f8b4215097b2@vontaene.de>
Date:   Thu, 23 Apr 2020 19:53:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------67A6254BFE4B2AED16A829AE"
Content-Language: en-US
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This is a multi-part message in MIME format.
--------------67A6254BFE4B2AED16A829AE
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,


I have a simple bluetooth hid device which does work in Android but not with Linux 4.19/Bluez 5. It does have two collections in its hid description:
0xA1, 0x01,        // Collection (Application)
0x85, 0x02,        //   Report ID (2)
(...)
0xC0,              // End Collection
0xA1, 0x01,        // Collection (Application)
0x85, 0x01,        //   Report ID (1)
(...)
0xC0,              // End Collection

Complete description is attached.

Since there are multiple collections I understand that every report has to be prefixed with the id, so I send
[2,0,0,0x52,0,0,0,0,0] (9 bytes) for the keycode 0x52, ID is 2.

Output from btmon is:
> ACL Data RX: Handle 3585 flags 0x02 dlen 16                                                                                                                                                                                                            #2072 [hci0] 485.047387
       ATT: Handle Value Notification (0x1b) len 11
         Handle: 0x0015
           Data: 020000520000000000

This looks good for me so far, unfortunately Linux does not pick it up, in dmesg I get:
drivers/hid/hid-core.c: undefined report_id 0 received

cat /sys/kernel/debug/hid/0005:0000:0000.000­3/events # gives me:
report (size 10) (numbered) = 00 02 00 00 52 00 00 00 00 00
so I get 10 bytes instead the 9 I send

So far I traced it to hog-lib.c, report_value_cb() of bluez where this extra 0 is prepended in the if (hog->has_report_id) block.
report->id is 0 at this point. If I skip this extra addition of the zero or manually set id=2 here it works as expected. Does someone has an idea what I do wrong or what I'm missing?

greetings,
Erik Andresen

--------------67A6254BFE4B2AED16A829AE
Content-Type: text/plain; charset=UTF-8;
 name="hid_report_descriptor.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="hid_report_descriptor.txt"

MHgwNSwgMHgwMSwgICAgICAgIC8vIFVzYWdlIFBhZ2UgKEdlbmVyaWMgRGVza3RvcCBDdHJs
cykKMHgwOSwgMHgwNiwgICAgICAgIC8vIFVzYWdlIChLZXlib2FyZCkKMHhBMSwgMHgwMSwg
ICAgICAgIC8vIENvbGxlY3Rpb24gKEFwcGxpY2F0aW9uKQoweDg1LCAweDAyLCAgICAgICAg
Ly8gICBSZXBvcnQgSUQgKDIpCjB4MDUsIDB4MDcsICAgICAgICAvLyAgIFVzYWdlIFBhZ2Ug
KEticmQvS2V5cGFkKQoweDE5LCAweEUwLCAgICAgICAgLy8gICBVc2FnZSBNaW5pbXVtICgw
eEUwKQoweDI5LCAweEU3LCAgICAgICAgLy8gICBVc2FnZSBNYXhpbXVtICgweEU3KQoweDE1
LCAweDAwLCAgICAgICAgLy8gICBMb2dpY2FsIE1pbmltdW0gKDApCjB4MjUsIDB4MDEsICAg
ICAgICAvLyAgIExvZ2ljYWwgTWF4aW11bSAoMSkKMHg3NSwgMHgwMSwgICAgICAgIC8vICAg
UmVwb3J0IFNpemUgKDEpCjB4OTUsIDB4MDgsICAgICAgICAvLyAgIFJlcG9ydCBDb3VudCAo
OCkKMHg4MSwgMHgwMiwgICAgICAgIC8vICAgSW5wdXQgKERhdGEsVmFyLEFicyxObyBXcmFw
LExpbmVhcixQcmVmZXJyZWQgU3RhdGUsTm8gTnVsbCBQb3NpdGlvbikKCjB4OTUsIDB4MDEs
ICAgICAgICAvLyAgIFJlcG9ydCBDb3VudCAoMSkKMHg3NSwgMHgwOCwgICAgICAgIC8vICAg
UmVwb3J0IFNpemUgKDgpCjB4ODEsIDB4MDEsICAgICAgICAvLyAgIElucHV0IChDb25zdCxB
cnJheSxBYnMsTm8gV3JhcCxMaW5lYXIsUHJlZmVycmVkIFN0YXRlLE5vIE51bGwgUG9zaXRp
b24pCgoweDk1LCAweDA1LCAgICAgICAgLy8gICBSZXBvcnQgQ291bnQgKDUpCjB4NzUsIDB4
MDEsICAgICAgICAvLyAgIFJlcG9ydCBTaXplICgxKQoweDA1LCAweDA4LCAgICAgICAgLy8g
ICBVc2FnZSBQYWdlIChMRURzKQoweDE5LCAweDAxLCAgICAgICAgLy8gICBVc2FnZSBNaW5p
bXVtIChOdW0gTG9jaykKMHgyOSwgMHgwNSwgICAgICAgIC8vICAgVXNhZ2UgTWF4aW11bSAo
S2FuYSkKMHg5MSwgMHgwMiwgICAgICAgIC8vICAgT3V0cHV0IChEYXRhLFZhcixBYnMsTm8g
V3JhcCxMaW5lYXIsUHJlZmVycmVkIFN0YXRlLE5vIE51bGwgUG9zaXRpb24sTm9uLXZvbGF0
aWxlKQoKMHg5NSwgMHgwMSwgICAgICAgIC8vICAgUmVwb3J0IENvdW50ICgxKQoweDc1LCAw
eDAzLCAgICAgICAgLy8gICBSZXBvcnQgU2l6ZSAoMykKMHg5MSwgMHgwMSwgICAgICAgIC8v
ICAgT3V0cHV0IChDb25zdCxBcnJheSxBYnMsTm8gV3JhcCxMaW5lYXIsUHJlZmVycmVkIFN0
YXRlLE5vIE51bGwgUG9zaXRpb24sTm9uLXZvbGF0aWxlKQoKMHg5NSwgMHgwNiwgICAgICAg
IC8vICAgUmVwb3J0IENvdW50ICg2KQoweDc1LCAweDA4LCAgICAgICAgLy8gICBSZXBvcnQg
U2l6ZSAoOCkKMHgxNSwgMHgwMCwgICAgICAgIC8vICAgTG9naWNhbCBNaW5pbXVtICgwKQow
eDI1LCAweDczLCAgICAgICAgLy8gICBMb2dpY2FsIE1heGltdW0gKDExNSkKMHgwNSwgMHgw
NywgICAgICAgIC8vICAgVXNhZ2UgUGFnZSAoS2JyZC9LZXlwYWQpCjB4MTksIDB4MDAsICAg
ICAgICAvLyAgIFVzYWdlIE1pbmltdW0gKDB4MDApCjB4MjksIDB4NzMsICAgICAgICAvLyAg
IFVzYWdlIE1heGltdW0gKDB4NzMpCjB4ODEsIDB4MDAsICAgICAgICAvLyAgIElucHV0IChE
YXRhLEFycmF5LEFicyxObyBXcmFwLExpbmVhcixQcmVmZXJyZWQgU3RhdGUsTm8gTnVsbCBQ
b3NpdGlvbikKCjB4MDksIDB4MDUsICAgICAgICAvLyAgIFVzYWdlICgweDA1KQoweDE1LCAw
eDAwLCAgICAgICAgLy8gICBMb2dpY2FsIE1pbmltdW0gKDApCjB4MjYsIDB4RkYsIDB4MDAs
ICAvLyAgIExvZ2ljYWwgTWF4aW11bSAoMjU1KQoweDc1LCAweDA4LCAgICAgICAgLy8gICBS
ZXBvcnQgU2l6ZSAoOCkKMHg5NSwgMHgwMiwgICAgICAgIC8vICAgUmVwb3J0IENvdW50ICgy
KQoweEIxLCAweDAyLCAgICAgICAgLy8gICBGZWF0dXJlIChEYXRhLFZhcixBYnMsTm8gV3Jh
cCxMaW5lYXIsUHJlZmVycmVkIFN0YXRlLE5vIE51bGwgUG9zaXRpb24sTm9uLXZvbGF0aWxl
KQoweEMwLCAgICAgICAgICAgICAgLy8gRW5kIENvbGxlY3Rpb24KMHgwNSwgMHgwQywgICAg
ICAgIC8vIFVzYWdlIFBhZ2UgKENvbnN1bWVyKQoweDA5LCAweDAxLCAgICAgICAgLy8gVXNh
Z2UgKENvbnN1bWVyIENvbnRyb2wpCjB4QTEsIDB4MDEsICAgICAgICAvLyBDb2xsZWN0aW9u
IChBcHBsaWNhdGlvbikKMHg4NSwgMHgwMSwgICAgICAgIC8vICAgUmVwb3J0IElEICgxKQow
eDE1LCAweDAwLCAgICAgICAgLy8gICBMb2dpY2FsIE1pbmltdW0gKDApCjB4MjUsIDB4MDEs
ICAgICAgICAvLyAgIExvZ2ljYWwgTWF4aW11bSAoMSkKMHg3NSwgMHgwMSwgICAgICAgIC8v
ICAgUmVwb3J0IFNpemUgKDEpCjB4OTUsIDB4MDEsICAgICAgICAvLyAgIFJlcG9ydCBDb3Vu
dCAoMSkKMHgwOSwgMHhCNSwgICAgICAgIC8vICAgVXNhZ2UgKFNjYW4gTmV4dCBUcmFjaykK
MHg4MSwgMHgwMiwgICAgICAgIC8vICAgSW5wdXQgKERhdGEsVmFyLEFicyxObyBXcmFwLExp
bmVhcixQcmVmZXJyZWQgU3RhdGUsTm8gTnVsbCBQb3NpdGlvbikKCjB4MDksIDB4QjYsICAg
ICAgICAvLyAgIFVzYWdlIChTY2FuIFByZXZpb3VzIFRyYWNrKQoweDgxLCAweDAyLCAgICAg
ICAgLy8gICBJbnB1dCAoRGF0YSxWYXIsQWJzLE5vIFdyYXAsTGluZWFyLFByZWZlcnJlZCBT
dGF0ZSxObyBOdWxsIFBvc2l0aW9uKQoKMHgwOSwgMHhCNywgICAgICAgIC8vICAgVXNhZ2Ug
KFN0b3ApCjB4ODEsIDB4MDIsICAgICAgICAvLyAgIElucHV0IChEYXRhLFZhcixBYnMsTm8g
V3JhcCxMaW5lYXIsUHJlZmVycmVkIFN0YXRlLE5vIE51bGwgUG9zaXRpb24pCgoweDA5LCAw
eEI4LCAgICAgICAgLy8gICBVc2FnZSAoRWplY3QpCjB4ODEsIDB4MDIsICAgICAgICAvLyAg
IElucHV0IChEYXRhLFZhcixBYnMsTm8gV3JhcCxMaW5lYXIsUHJlZmVycmVkIFN0YXRlLE5v
IE51bGwgUG9zaXRpb24pCgoweDA5LCAweENELCAgICAgICAgLy8gICBVc2FnZSAoUGxheS9Q
YXVzZSkKMHg4MSwgMHgwMiwgICAgICAgIC8vICAgSW5wdXQgKERhdGEsVmFyLEFicyxObyBX
cmFwLExpbmVhcixQcmVmZXJyZWQgU3RhdGUsTm8gTnVsbCBQb3NpdGlvbikKCjB4MDksIDB4
RTIsICAgICAgICAvLyAgIFVzYWdlIChNdXRlKQoweDgxLCAweDAyLCAgICAgICAgLy8gICBJ
bnB1dCAoRGF0YSxWYXIsQWJzLE5vIFdyYXAsTGluZWFyLFByZWZlcnJlZCBTdGF0ZSxObyBO
dWxsIFBvc2l0aW9uKQoKMHgwOSwgMHhFOSwgICAgICAgIC8vICAgVXNhZ2UgKFZvbHVtZSBJ
bmNyZW1lbnQpCjB4ODEsIDB4MDIsICAgICAgICAvLyAgIElucHV0IChEYXRhLFZhcixBYnMs
Tm8gV3JhcCxMaW5lYXIsUHJlZmVycmVkIFN0YXRlLE5vIE51bGwgUG9zaXRpb24pCgoweDA5
LCAweEVBLCAgICAgICAgLy8gICBVc2FnZSAoVm9sdW1lIERlY3JlbWVudCkKMHg4MSwgMHgw
MiwgICAgICAgIC8vICAgSW5wdXQgKERhdGEsVmFyLEFicyxObyBXcmFwLExpbmVhcixQcmVm
ZXJyZWQgU3RhdGUsTm8gTnVsbCBQb3NpdGlvbikKCjB4QzAsICAgICAgICAgICAgICAvLyBF
bmQgQ29sbGVjdGlvbgoKLy8gMTI3IGJ5dGVzCg==
--------------67A6254BFE4B2AED16A829AE--

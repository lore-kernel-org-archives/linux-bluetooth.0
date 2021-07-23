Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8D7C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 02:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBBB060EBE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 02:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbhGWBsi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 21:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbhGWBsi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 21:48:38 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BC6C061575
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 19:29:11 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id a14so1576662plh.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 19:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=X1YkidyQUeEJWIWTqWnmPMZyT+l1KayuxUYUzCX1Lak=;
        b=rDP1vTnuv2C/gzVivvcpwCQ74nmg/Jz86ErjxsqwXwYuxcQOhisY8aWsaWOMS/ZDLA
         89dEiFWT06AQEwn5yEiTxBu9e10c8kuZq/xw3Yx3HRK3BdaUizYI1B3j8pRZfppQR/Yo
         I+Hgj8qG8Maa8O8GKBevfFeyErTCLftKzW33g40hGKAdWeKxoEVrBpijbzTPzHCIBmry
         kNS3NY/Nq+0Xxhys80QVmzaIE9utTWnVOdenb4/Ula9RBF1uRDu2WVjsFnWYUxIOVn74
         coqrrMUmJUxSTtD/MzLpRltsKt/U628PDiTNRmg76qEnpy/GkWrtA3REYmPtsWr47MB/
         SlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=X1YkidyQUeEJWIWTqWnmPMZyT+l1KayuxUYUzCX1Lak=;
        b=R+FJy9nim7pEvd2e/v7nKlS6eF1ILYPIdrFPtycZ8M24FeJ6cEz06k5jaWAphtdRVE
         nN+1VegjdOGxPs+7Qfq3T39CgGqK6FaDmOcuNbD3Yjos3tTwf7SE6pTtJ2mGBkjfENcA
         KJJPGYAJaJ/EuR59v8o+wNpWlCHTV6U3UqiWarMMJZ6Yx52UfvkoHkbofvxCAWwTifAl
         RX3FZ/id7fp5a1Hdd8fDHBcG6eqWkB6B9Pb3tW15lSYx+jfuD9rYCnK6a18fecw47dnZ
         hg/13pzc3Al6fBmX+Ed5/0LXO1LYwhuEUD2wJdcPyS2/4c6SkYDgkd9P7sDWsRGX3C2W
         BLMw==
X-Gm-Message-State: AOAM532K1TCEKYL/1gy9bXiqPMmIXa4EpGuRkXvG5Hp/q0qYNBEoPkcN
        RjqJhMSKqqAIs2HBWQvMmwsJUH0rImQ=
X-Google-Smtp-Source: ABdhPJzH3QfslcKYgMsXkwVc28KnVw+Ew4LP8mDSZn7RsC8wSnd+IGQtTGznTMZ4QqilMJb3O3lpkg==
X-Received: by 2002:a17:90a:530e:: with SMTP id x14mr2571123pjh.128.1627007351184;
        Thu, 22 Jul 2021 19:29:11 -0700 (PDT)
Received: from [172.17.0.2] ([52.183.124.114])
        by smtp.gmail.com with ESMTPSA id c14sm35261190pgv.86.2021.07.22.19.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 19:29:10 -0700 (PDT)
Message-ID: <60fa2976.1c69fb81.ff8b5.e015@mx.google.com>
Date:   Thu, 22 Jul 2021 19:29:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3556486951166115177=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wangyouwan@uniontech.com
Subject: =?utf-8?q?RE=3A_bluez=3Afix_btmon_tools_=E2=80=9CAllow_slave=E2=80=9D_to_=22Central_Or_Peripheral=22_=23431_=5Bhci0=5D_99=2E922927?=
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210723020337.31128-1-wangyouwan@uniontech.com>
References: <20210723020337.31128-1-wangyouwan@uniontech.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3556486951166115177==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NTIwMDUxCgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBGQUlMICAgICAgMC4zNiBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIEZB
SUwgICAgICAwLjEyIHNlY29uZHMKUHJlcCAtIFNldHVwIEVMTCAgICAgICAgICAgICAgUEFTUyAg
ICAgIDQ0LjIwIHNlY29uZHMKQnVpbGQgLSBQcmVwICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDAuMTQgc2Vjb25kcwpCdWlsZCAtIENvbmZpZ3VyZSAgICAgICAgICAgICBQQVNTICAgICAgNy44
NCBzZWNvbmRzCkJ1aWxkIC0gTWFrZSAgICAgICAgICAgICAgICAgIFBBU1MgICAgICAxOTkuNzAg
c2Vjb25kcwpNYWtlIENoZWNrICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgOS4zMiBzZWNv
bmRzCk1ha2UgRGlzdGNoZWNrICAgICAgICAgICAgICAgIFBBU1MgICAgICAyMzIuNjYgc2Vjb25k
cwpCdWlsZCB3L2V4dCBFTEwgLSBDb25maWd1cmUgICBQQVNTICAgICAgNy44NyBzZWNvbmRzCkJ1
aWxkIHcvZXh0IEVMTCAtIE1ha2UgICAgICAgIFBBU1MgICAgICAxOTAuNTMgc2Vjb25kcwoKRGV0
YWlscwojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tQYXRjaCAtIEZB
SUwKRGVzYzogUnVuIGNoZWNrcGF0Y2gucGwgc2NyaXB0IHdpdGggcnVsZSBpbiAuY2hlY2twYXRj
aC5jb25mCk91dHB1dDoKYmx1ZXo6Zml4IGJ0bW9uIHRvb2xzIOKAnEFsbG93IHNsYXZl4oCdIHRv
ICJDZW50cmFsIE9yIFBlcmlwaGVyYWwiICM0MzEgW2hjaTBdIDk5LjkyMjkyNwpXQVJOSU5HOkNP
TU1JVF9MT0dfTE9OR19MSU5FOiBQb3NzaWJsZSB1bndyYXBwZWQgY29tbWl0IGRlc2NyaXB0aW9u
IChwcmVmZXIgYSBtYXhpbXVtIDc1IGNoYXJzIHBlciBsaW5lKQojMTQ6IArigKIgQSByb2xlIHN3
aXRjaCBpcyBuZWNlc3NhcnkgaW4gb3JkZXIgdG8gbWFrZSBhIHBhZ2luZyBkZXZpY2UgYSBQZXJp
cGhlcmFsCgotIHRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywgOCBsaW5lcyBjaGVja2VkCgpO
T1RFOiBGb3Igc29tZSBvZiB0aGUgcmVwb3J0ZWQgZGVmZWN0cywgY2hlY2twYXRjaCBtYXkgYmUg
YWJsZSB0bwogICAgICBtZWNoYW5pY2FsbHkgY29udmVydCB0byB0aGUgdHlwaWNhbCBzdHlsZSB1
c2luZyAtLWZpeCBvciAtLWZpeC1pbnBsYWNlLgoKIltQQVRDSF0gPT9VVEYtOD9xP2JsdWV6OmZp
eD0yMGJ0bW9uPTIwdG9vbHM9MjA9RTI9ODA9OUNBbGxvdz0yMHNsPz0iIGhhcyBzdHlsZSBwcm9i
bGVtcywgcGxlYXNlIHJldmlldy4KCk5PVEU6IElnbm9yZWQgbWVzc2FnZSB0eXBlczogQ09NTUlU
X01FU1NBR0UgQ09NUExFWF9NQUNSTyBDT05TVF9TVFJVQ1QgRklMRV9QQVRIX0NIQU5HRVMgTUlT
U0lOR19TSUdOX09GRiBQUkVGRVJfUEFDS0VEIFNQRFhfTElDRU5TRV9UQUcgU1BMSVRfU1RSSU5H
IFNTQ0FORl9UT19LU1RSVE8KCk5PVEU6IElmIGFueSBvZiB0aGUgZXJyb3JzIGFyZSBmYWxzZSBw
b3NpdGl2ZXMsIHBsZWFzZSByZXBvcnQKICAgICAgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2Vl
IENIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjClRlc3Q6IEdpdExpbnQgLSBGQUlMCkRlc2M6IFJ1biBnaXRsaW50IHdpdGggcnVsZSBpbiAu
Z2l0bGludApPdXRwdXQ6CmJsdWV6OmZpeCBidG1vbiB0b29scyDigJxBbGxvdyBzbGF2ZeKAnSB0
byAiQ2VudHJhbCBPciBQZXJpcGhlcmFsIiAjNDMxIFtoY2kwXSA5OS45MjI5MjcKMTogVDEgVGl0
bGUgZXhjZWVkcyBtYXggbGVuZ3RoICg4ND43Mik6ICJibHVlejpmaXggYnRtb24gdG9vbHMg4oCc
QWxsb3cgc2xhdmXigJ0gdG8gIkNlbnRyYWwgT3IgUGVyaXBoZXJhbCIgIzQzMSBbaGNpMF0gOTku
OTIyOTI3IgoKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBQcmVwIC0gU2V0
dXAgRUxMIC0gUEFTUwpEZXNjOiBDbG9uZSwgYnVpbGQsIGFuZCBpbnN0YWxsIEVMTAoKIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEJ1aWxkIC0gUHJlcCAtIFBBU1MKRGVzYzog
UHJlcGFyZSBlbnZpcm9ubWVudCBmb3IgYnVpbGQKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIwpUZXN0OiBCdWlsZCAtIENvbmZpZ3VyZSAtIFBBU1MKRGVzYzogQ29uZmlndXJlIHRoZSBC
bHVlWiBzb3VyY2UgdHJlZQoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEJ1
aWxkIC0gTWFrZSAtIFBBU1MKRGVzYzogQnVpbGQgdGhlIEJsdWVaIHNvdXJjZSB0cmVlCgojIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogTWFrZSBDaGVjayAtIFBBU1MKRGVzYzog
UnVuICdtYWtlIGNoZWNrJwoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IE1h
a2UgRGlzdGNoZWNrIC0gUEFTUwpEZXNjOiBSdW4gZGlzdGNoZWNrIHRvIGNoZWNrIHRoZSBkaXN0
cmlidXRpb24KCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBCdWlsZCB3L2V4
dCBFTEwgLSBDb25maWd1cmUgLSBQQVNTCkRlc2M6IENvbmZpZ3VyZSBCbHVlWiBzb3VyY2Ugd2l0
aCAnLS1lbmFibGUtZXh0ZXJuYWwtZWxsJyBjb25maWd1cmF0aW9uCgojIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMKVGVzdDogQnVpbGQgdy9leHQgRUxMIC0gTWFrZSAtIFBBU1MKRGVzYzog
QnVpbGQgQmx1ZVogc291cmNlIHdpdGggJy0tZW5hYmxlLWV4dGVybmFsLWVsbCcgY29uZmlndXJh
dGlvbgoKCgotLS0KUmVnYXJkcywKTGludXggQmx1ZXRvb3RoCgo=

--===============3556486951166115177==--

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1DBC6377A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 03:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 098E960FF3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 03:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhGVCVd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Jul 2021 22:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbhGVCVc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Jul 2021 22:21:32 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47929C061575
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jul 2021 20:02:08 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 23so4238395qke.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jul 2021 20:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=rhL4FKuGQNAbRDpGWs8PM00DwKnOBCuZqRv16du04+0=;
        b=YSLQNYDTUSc5FneDU+wSCmt/S0Vjr3KTK07SczKCgGTv5pcVGOPO0f0LuxBEqAtspJ
         hX4n4Sa33hhClPFShRvta9IzVo5LT2MVR6qwPnJxUmAtiYwiqYggzOQpBsza4/+CckzE
         44Wt2S9IilVWuwnD0XrBPK9ux3ljKBa8MGvzjRrInXm5HWV69P5UN4jZqPpoGc0QHYWE
         vGvNJeeNoway39kwZDVUzOcwKB+MI9GfiuDt5PFu5Y48OLWkAoZsEIMmCtnA7QPKwwFA
         W4BFQ3zTa3cs48kRw9O/1dIeEqwTRkw23N+XabPZlKX28lKkLDqYqGz/Pox1Uz6lZuGP
         AGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=rhL4FKuGQNAbRDpGWs8PM00DwKnOBCuZqRv16du04+0=;
        b=pmHR0Uew9+LWuxks0WNksIjqaOamy5vBmvgiJblfNtJ6TNor4QpwHsMdP+OPwkV4hF
         xStE4mnkA/pTUFKGsEe9B4/eiLhpRsi/dFaQU9JRN3TkJ1ivNCwo2vI4zLC/Uj1TL/ce
         gN+OYgM26J0oyWSK8HMRrFI6rrPd2yBrYyV5p6fAwQ9laP6748IOrMTptObwMvErybc/
         +HrQvYzqQ2fB/31mG5hIe1nYQNtgavA2dMLMiv3HiNTR3ha6MMX74wW0M49aN4hkaBNi
         JfIZm1/ak/t2dC7zyOzGyDF0KvkZfxqgdHHgcClIilnFNdDunBZ7tYLbm4ZNEXxVvusF
         MRbw==
X-Gm-Message-State: AOAM533y1qxYPUlXIJqJv3q5GTogvXEAATr5NbYR1Dl7QJTo6NDDcYZz
        VA5rX5cwmx3xsbXS7HCRSWOvyTsVjc9tXQ==
X-Google-Smtp-Source: ABdhPJxXfmE6cYActLmtVn++Bws+otuHvJRxY1RU33CzglgeVDqCJMClRhU+Id1xhpxGHMjEMaqkxw==
X-Received: by 2002:a37:8387:: with SMTP id f129mr38587315qkd.79.1626922927308;
        Wed, 21 Jul 2021 20:02:07 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.226.120])
        by smtp.gmail.com with ESMTPSA id j12sm10097153qtv.81.2021.07.21.20.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 20:02:06 -0700 (PDT)
Message-ID: <60f8dfae.1c69fb81.db54d.e55d@mx.google.com>
Date:   Wed, 21 Jul 2021 20:02:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3643358647893014240=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wangyouwan@uniontech.com
Subject: =?utf-8?q?RE=3A_bluez=3Afix_btmon_tools_=E2=80=9CAllow_slave=E2=80=9D_to_=22Master_Or_Slave=22_=23431_=5Bhci0=5D_99=2E922927?=
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210722021952.18260-1-wangyouwan@uniontech.com>
References: <20210722021952.18260-1-wangyouwan@uniontech.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3643358647893014240==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NTE5Mzk3CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBGQUlMICAgICAgMC4yNiBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIEZB
SUwgICAgICAwLjExIHNlY29uZHMKUHJlcCAtIFNldHVwIEVMTCAgICAgICAgICAgICAgUEFTUyAg
ICAgIDQwLjA3IHNlY29uZHMKQnVpbGQgLSBQcmVwICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDAuMDkgc2Vjb25kcwpCdWlsZCAtIENvbmZpZ3VyZSAgICAgICAgICAgICBQQVNTICAgICAgNi45
MSBzZWNvbmRzCkJ1aWxkIC0gTWFrZSAgICAgICAgICAgICAgICAgIFBBU1MgICAgICAxNzMuNzMg
c2Vjb25kcwpNYWtlIENoZWNrICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgOC45NSBzZWNv
bmRzCk1ha2UgRGlzdGNoZWNrICAgICAgICAgICAgICAgIFBBU1MgICAgICAyMDUuNTUgc2Vjb25k
cwpCdWlsZCB3L2V4dCBFTEwgLSBDb25maWd1cmUgICBQQVNTICAgICAgNy4wNCBzZWNvbmRzCkJ1
aWxkIHcvZXh0IEVMTCAtIE1ha2UgICAgICAgIFBBU1MgICAgICAxNjMuNjUgc2Vjb25kcwoKRGV0
YWlscwojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tQYXRjaCAtIEZB
SUwKRGVzYzogUnVuIGNoZWNrcGF0Y2gucGwgc2NyaXB0IHdpdGggcnVsZSBpbiAuY2hlY2twYXRj
aC5jb25mCk91dHB1dDoKYmx1ZXo6Zml4IGJ0bW9uIHRvb2xzIOKAnEFsbG93IHNsYXZl4oCdIHRv
ICJNYXN0ZXIgT3IgU2xhdmUiICM0MzEgW2hjaTBdIDk5LjkyMjkyNwpXQVJOSU5HOkNPTU1JVF9M
T0dfTE9OR19MSU5FOiBQb3NzaWJsZSB1bndyYXBwZWQgY29tbWl0IGRlc2NyaXB0aW9uIChwcmVm
ZXIgYSBtYXhpbXVtIDc1IGNoYXJzIHBlciBsaW5lKQojMTE6IApJIHdhbnQgdG8gZXhwbGFpbiBp
dCBhc+OAgOKAnE1hc3RlciBPciBTbGF2ZeKAnSwgYmVjYXVzZSB0aGlzIGlzIGV4cGxhaW5lZCBp
biB0aGUgQ29yZV92NS4yCgotIHRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywgOCBsaW5lcyBj
aGVja2VkCgpOT1RFOiBGb3Igc29tZSBvZiB0aGUgcmVwb3J0ZWQgZGVmZWN0cywgY2hlY2twYXRj
aCBtYXkgYmUgYWJsZSB0bwogICAgICBtZWNoYW5pY2FsbHkgY29udmVydCB0byB0aGUgdHlwaWNh
bCBzdHlsZSB1c2luZyAtLWZpeCBvciAtLWZpeC1pbnBsYWNlLgoKIltQQVRDSF0gPT9VVEYtOD9x
P2JsdWV6OmZpeD0yMGJ0bW9uPTIwdG9vbHM9MjA9RTI9ODA9OUNBbGxvdz0yMHNsPz0iIGhhcyBz
dHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4KCk5PVEU6IElnbm9yZWQgbWVzc2FnZSB0eXBl
czogQ09NTUlUX01FU1NBR0UgQ09NUExFWF9NQUNSTyBDT05TVF9TVFJVQ1QgRklMRV9QQVRIX0NI
QU5HRVMgTUlTU0lOR19TSUdOX09GRiBQUkVGRVJfUEFDS0VEIFNQRFhfTElDRU5TRV9UQUcgU1BM
SVRfU1RSSU5HIFNTQ0FORl9UT19LU1RSVE8KCk5PVEU6IElmIGFueSBvZiB0aGUgZXJyb3JzIGFy
ZSBmYWxzZSBwb3NpdGl2ZXMsIHBsZWFzZSByZXBvcnQKICAgICAgdGhlbSB0byB0aGUgbWFpbnRh
aW5lciwgc2VlIENIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgoKIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjClRlc3Q6IEdpdExpbnQgLSBGQUlMCkRlc2M6IFJ1biBnaXRsaW50IHdpdGgg
cnVsZSBpbiAuZ2l0bGludApPdXRwdXQ6CmJsdWV6OmZpeCBidG1vbiB0b29scyDigJxBbGxvdyBz
bGF2ZeKAnSB0byAiTWFzdGVyIE9yIFNsYXZlIiAjNDMxIFtoY2kwXSA5OS45MjI5MjcKMTogVDEg
VGl0bGUgZXhjZWVkcyBtYXggbGVuZ3RoICg3OD43Mik6ICJibHVlejpmaXggYnRtb24gdG9vbHMg
4oCcQWxsb3cgc2xhdmXigJ0gdG8gIk1hc3RlciBPciBTbGF2ZSIgIzQzMSBbaGNpMF0gOTkuOTIy
OTI3IgozOiBCMSBMaW5lIGV4Y2VlZHMgbWF4IGxlbmd0aCAoODU+ODApOiAiSSB3YW50IHRvIGV4
cGxhaW4gaXQgYXPjgIDigJxNYXN0ZXIgT3IgU2xhdmXigJ0sIGJlY2F1c2UgdGhpcyBpcyBleHBs
YWluZWQgaW4gdGhlIENvcmVfdjUuMiIKODogQjEgTGluZSBleGNlZWRzIG1heCBsZW5ndGggKDgz
PjgwKTogIiAgICBqb2luaW5nIGFuIGV4aXN0aW5nIHBpY29uZXQsIHNpbmNlIGJ5IGRlZmluaXRp
b24gdGhlIHBhZ2luZyBkZXZpY2UgaXMgaW5pdGlhbGx5IgoxMTogQjEgTGluZSBleGNlZWRzIG1h
eCBsZW5ndGggKDg2PjgwKTogIiAgICDigKIgQSByb2xlIHN3aXRjaCBpcyBuZWNlc3NhcnkgaW4g
b3JkZXIgZm9yIGEgc2xhdmUgaW4gYW4gZXhpc3RpbmcgcGljb25ldCB0byBzZXQgdXAiCjEyOiBC
MSBMaW5lIGV4Y2VlZHMgbWF4IGxlbmd0aCAoODE+ODApOiAiICAgIGEgbmV3IHBpY29uZXQgd2l0
aCBpdHNlbGYgYXMgbWFzdGVyIGFuZCB0aGUgb3JpZ2luYWwgcGljb25ldCBtYXN0ZXIgYXMgc2xh
dmUuIgoKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBQcmVwIC0gU2V0dXAg
RUxMIC0gUEFTUwpEZXNjOiBDbG9uZSwgYnVpbGQsIGFuZCBpbnN0YWxsIEVMTAoKIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEJ1aWxkIC0gUHJlcCAtIFBBU1MKRGVzYzogUHJl
cGFyZSBlbnZpcm9ubWVudCBmb3IgYnVpbGQKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IwpUZXN0OiBCdWlsZCAtIENvbmZpZ3VyZSAtIFBBU1MKRGVzYzogQ29uZmlndXJlIHRoZSBCbHVl
WiBzb3VyY2UgdHJlZQoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEJ1aWxk
IC0gTWFrZSAtIFBBU1MKRGVzYzogQnVpbGQgdGhlIEJsdWVaIHNvdXJjZSB0cmVlCgojIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogTWFrZSBDaGVjayAtIFBBU1MKRGVzYzogUnVu
ICdtYWtlIGNoZWNrJwoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IE1ha2Ug
RGlzdGNoZWNrIC0gUEFTUwpEZXNjOiBSdW4gZGlzdGNoZWNrIHRvIGNoZWNrIHRoZSBkaXN0cmli
dXRpb24KCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBCdWlsZCB3L2V4dCBF
TEwgLSBDb25maWd1cmUgLSBQQVNTCkRlc2M6IENvbmZpZ3VyZSBCbHVlWiBzb3VyY2Ugd2l0aCAn
LS1lbmFibGUtZXh0ZXJuYWwtZWxsJyBjb25maWd1cmF0aW9uCgojIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMKVGVzdDogQnVpbGQgdy9leHQgRUxMIC0gTWFrZSAtIFBBU1MKRGVzYzogQnVp
bGQgQmx1ZVogc291cmNlIHdpdGggJy0tZW5hYmxlLWV4dGVybmFsLWVsbCcgY29uZmlndXJhdGlv
bgoKCgotLS0KUmVnYXJkcywKTGludXggQmx1ZXRvb3RoCgo=

--===============3643358647893014240==--

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE394C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 22:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FBC560EFE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 22:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbhHQWvy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Aug 2021 18:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbhHQWvx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Aug 2021 18:51:53 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A39C061764
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 15:51:20 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id q2so605653plr.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 15:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=hKJo6y58TM7AXzLuCFCmWqi/mFAqYrLctmOjBqcaFnk=;
        b=bdmoH2j0xDB3NA+9m9z21M8rg77OYy3Bgjkh9wVUidnP3zgJUzklbkl3nSMHpQPdQL
         R1zFHTCftBHvOA6dHCjq2CfuJU+c608gyr9VzrcZmGHaJ5P9rdDoYoIJ41j8zMGfg2rD
         69FyKZzwZinMKc+tLBK7M1IReUkvBCUd0Od/A6ywHliM6aehNlQRhVQfUDf+ep/J4f4m
         IdvU6bnsDxFRxzPPPZ8f3TKgCphXQgCJXm5td4hUt4KZGqwY/YqfJ+cEpY3rHegLRb7Z
         5PHVAkUs4P1+oyPr5b2ClvkZ7uvCQtYz88BZ4hh64DyNDib+qzdrX2ZUq0qiBI5rTAx0
         5g8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=hKJo6y58TM7AXzLuCFCmWqi/mFAqYrLctmOjBqcaFnk=;
        b=tJT2gzwzEeBtjv24Yg4DbWM3Dj1YklWHz2cOISARs7jmdj4cwoQrQIyWSmhkE8CEkT
         bL7IozFSUBEQWLw0YLb1rxHF0HG6OsVGMdLNgrqBhXP8f1L4X6S+IvnzmhmoVDuIQIcQ
         mFeIidXaTeE08wqyo56T3EwnDGScBUKslAS+zCMWocHC28CpTBDddzOMlrvl8E5QLir2
         gdNuSjfkdqMeETcjhtrn5IylmVFnEqGGkbyNiYzM53GCgnVFRqaCPmXjQueS0QLH9TKV
         o8PnVVI/MEU3R/LfeonQR0sywPsIUPZd1W5ftsqLWgQSnMKKJl0xA/RaqKWJm3nuUSM+
         hb/g==
X-Gm-Message-State: AOAM533FLSskRyF2ZSdj8bYyXtgF9JVsrG2NIyWsvT2w49WBS7iQcHG+
        OnUn5pMI3hsROqu0hf0GcQ0mcPlActE=
X-Google-Smtp-Source: ABdhPJzCG9hCUkcCwvy7ecMXBoSGBr4XZVVXxVowPqxhcYbcgtZeirrie3axMYXCwyHHskTA3dsOlQ==
X-Received: by 2002:a17:90a:3849:: with SMTP id l9mr5768333pjf.7.1629240679653;
        Tue, 17 Aug 2021 15:51:19 -0700 (PDT)
Received: from [172.17.0.2] ([51.143.96.102])
        by smtp.gmail.com with ESMTPSA id y1sm4449251pga.50.2021.08.17.15.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 15:51:18 -0700 (PDT)
Message-ID: <611c3d66.1c69fb81.8cc78.d2db@mx.google.com>
Date:   Tue, 17 Aug 2021 15:51:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7957867906639885817=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,v9,1/2] emulator: Add support to config the white and resolve list
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210817223437.411624-1-hj.tedd.an@gmail.com>
References: <20210817223437.411624-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7957867906639885817==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NTMzMDA1CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBGQUlMICAgICAgMi40NiBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjI3IHNlY29uZHMKUHJlcCAtIFNldHVwIEVMTCAgICAgICAgICAgICAgUEFTUyAg
ICAgIDUxLjA5IHNlY29uZHMKQnVpbGQgLSBQcmVwICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDAuMTUgc2Vjb25kcwpCdWlsZCAtIENvbmZpZ3VyZSAgICAgICAgICAgICBQQVNTICAgICAgOS4x
MCBzZWNvbmRzCkJ1aWxkIC0gTWFrZSAgICAgICAgICAgICAgICAgIEZBSUwgICAgICA4MC42NSBz
ZWNvbmRzCk1ha2UgQ2hlY2sgICAgICAgICAgICAgICAgICAgIEZBSUwgICAgICAwLjg2IHNlY29u
ZHMKTWFrZSBEaXN0Y2hlY2sgICAgICAgICAgICAgICAgRkFJTCAgICAgIDE0OC43MCBzZWNvbmRz
CkJ1aWxkIHcvZXh0IEVMTCAtIENvbmZpZ3VyZSAgIFBBU1MgICAgICA5LjAyIHNlY29uZHMKQnVp
bGQgdy9leHQgRUxMIC0gTWFrZSAgICAgICAgRkFJTCAgICAgIDY3LjEzIHNlY29uZHMKCkRldGFp
bHMKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNrUGF0Y2ggLSBGQUlM
CkRlc2M6IFJ1biBjaGVja3BhdGNoLnBsIHNjcmlwdCB3aXRoIHJ1bGUgaW4gLmNoZWNrcGF0Y2gu
Y29uZgpPdXRwdXQ6CnRvb2xzL21nbXQtdGVzdGVyOiBBZGQgTEwgUHJpdmFjeSB0ZXN0IGNhc2Vz
CldBUk5JTkc6TE9OR19MSU5FOiBsaW5lIGxlbmd0aCBvZiA4MSBleGNlZWRzIDgwIGNvbHVtbnMK
IzM3MTogRklMRTogZW11bGF0b3IvaGNpZW11Lmg6Njc6Citjb25zdCB1aW50OF90ICpoY2llbXVf
Z2V0X21hc3Rlcl9hZHZfYWRkcihzdHJ1Y3QgaGNpZW11ICpoY2llbXUsIHVpbnQ4X3QgaGFuZGxl
KTsKCi0gdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCAyMzI0IGxpbmVzIGNoZWNrZWQKCk5P
VEU6IEZvciBzb21lIG9mIHRoZSByZXBvcnRlZCBkZWZlY3RzLCBjaGVja3BhdGNoIG1heSBiZSBh
YmxlIHRvCiAgICAgIG1lY2hhbmljYWxseSBjb252ZXJ0IHRvIHRoZSB0eXBpY2FsIHN0eWxlIHVz
aW5nIC0tZml4IG9yIC0tZml4LWlucGxhY2UuCgoiW1BBVENIXSB0b29scy9tZ210LXRlc3Rlcjog
QWRkIExMIFByaXZhY3kgdGVzdCBjYXNlcyIgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2
aWV3LgoKTk9URTogSWdub3JlZCBtZXNzYWdlIHR5cGVzOiBDT01NSVRfTUVTU0FHRSBDT01QTEVY
X01BQ1JPIENPTlNUX1NUUlVDVCBGSUxFX1BBVEhfQ0hBTkdFUyBNSVNTSU5HX1NJR05fT0ZGIFBS
RUZFUl9QQUNLRUQgU1BEWF9MSUNFTlNFX1RBRyBTUExJVF9TVFJJTkcgU1NDQU5GX1RPX0tTVFJU
TwoKTk9URTogSWYgYW55IG9mIHRoZSBlcnJvcnMgYXJlIGZhbHNlIHBvc2l0aXZlcywgcGxlYXNl
IHJlcG9ydAogICAgICB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUgQ0hFQ0tQQVRDSCBpbiBN
QUlOVEFJTkVSUy4KCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogR2l0TGlu
dCAtIFBBU1MKRGVzYzogUnVuIGdpdGxpbnQgd2l0aCBydWxlIGluIC5naXRsaW50CgojIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogUHJlcCAtIFNldHVwIEVMTCAtIFBBU1MKRGVz
YzogQ2xvbmUsIGJ1aWxkLCBhbmQgaW5zdGFsbCBFTEwKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIwpUZXN0OiBCdWlsZCAtIFByZXAgLSBQQVNTCkRlc2M6IFByZXBhcmUgZW52aXJvbm1l
bnQgZm9yIGJ1aWxkCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQnVpbGQg
LSBDb25maWd1cmUgLSBQQVNTCkRlc2M6IENvbmZpZ3VyZSB0aGUgQmx1ZVogc291cmNlIHRyZWUK
CiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBCdWlsZCAtIE1ha2UgLSBGQUlM
CkRlc2M6IEJ1aWxkIHRoZSBCbHVlWiBzb3VyY2UgdHJlZQpPdXRwdXQ6CmVtdWxhdG9yL2J0aG9z
dC5jOiBJbiBmdW5jdGlvbiDigJhldnRfbGVfZXh0X2Fkdl9yZXBvcnTigJk6CmVtdWxhdG9yL2J0
aG9zdC5jOjEzNTA6MzogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKA
mGJ0aG9zdF9kZWJ1Z+KAmTsgZGlkIHlvdSBtZWFuIOKAmGJ0aG9zdF9zZXRfZGVidWfigJk/IFst
V2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogMTM1MCB8ICAgYnRob3N0X2Rl
YnVnKGJ0aG9zdCwgImxlIGV4dCBhZHYgcmVwb3J0OiAlcyAoMHglMDJ4KSIsCiAgICAgIHwgICBe
fn5+fn5+fn5+fn4KICAgICAgfCAgIGJ0aG9zdF9zZXRfZGVidWcKY2MxOiBhbGwgd2FybmluZ3Mg
YmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsxXTogKioqIFtNYWtlZmlsZTo2OTU1OiBlbXVs
YXRvci9idGhvc3Qub10gRXJyb3IgMQptYWtlOiAqKiogW01ha2VmaWxlOjQxNDc6IGFsbF0gRXJy
b3IgMgoKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBNYWtlIENoZWNrIC0g
RkFJTApEZXNjOiBSdW4gJ21ha2UgY2hlY2snCk91dHB1dDoKZW11bGF0b3IvYnRob3N0LmM6IElu
IGZ1bmN0aW9uIOKAmGV2dF9sZV9leHRfYWR2X3JlcG9ydOKAmToKZW11bGF0b3IvYnRob3N0LmM6
MTM1MDozOiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYYnRob3N0
X2RlYnVn4oCZOyBkaWQgeW91IG1lYW4g4oCYYnRob3N0X3NldF9kZWJ1Z+KAmT8gWy1XZXJyb3I9
aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCiAxMzUwIHwgICBidGhvc3RfZGVidWcoYnRo
b3N0LCAibGUgZXh0IGFkdiByZXBvcnQ6ICVzICgweCUwMngpIiwKICAgICAgfCAgIF5+fn5+fn5+
fn5+fgogICAgICB8ICAgYnRob3N0X3NldF9kZWJ1ZwpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0
cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiogW01ha2VmaWxlOjY5NTU6IGVtdWxhdG9yL2J0
aG9zdC5vXSBFcnJvciAxCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTA0MzY6IGNoZWNrXSBFcnJvciAy
CgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IE1ha2UgRGlzdGNoZWNrIC0g
RkFJTApEZXNjOiBSdW4gZGlzdGNoZWNrIHRvIGNoZWNrIHRoZSBkaXN0cmlidXRpb24KT3V0cHV0
OgouLi8uLi9lbXVsYXRvci9idGhvc3QuYzogSW4gZnVuY3Rpb24g4oCYZXZ0X2xlX2V4dF9hZHZf
cmVwb3J04oCZOgouLi8uLi9lbXVsYXRvci9idGhvc3QuYzoxMzUwOjM6IHdhcm5pbmc6IGltcGxp
Y2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmGJ0aG9zdF9kZWJ1Z+KAmTsgZGlkIHlvdSBt
ZWFuIOKAmGJ0aG9zdF9zZXRfZGVidWfigJk/IFstV2ltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0
aW9uXQogMTM1MCB8ICAgYnRob3N0X2RlYnVnKGJ0aG9zdCwgImxlIGV4dCBhZHYgcmVwb3J0OiAl
cyAoMHglMDJ4KSIsCiAgICAgIHwgICBefn5+fn5+fn5+fn4KICAgICAgfCAgIGJ0aG9zdF9zZXRf
ZGVidWcKL3Vzci9iaW4vbGQ6IGVtdWxhdG9yL2FuZHJvaWRfYW5kcm9pZF90ZXN0ZXItYnRob3N0
Lm86IGluIGZ1bmN0aW9uIGBldnRfbGVfZXh0X2Fkdl9yZXBvcnQnOgovZ2l0aHViL3dvcmtzcGFj
ZS9zcmMvYmx1ZXotNS42MC9fYnVpbGQvc3ViLy4uLy4uL2VtdWxhdG9yL2J0aG9zdC5jOjEzNTA6
IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGJ0aG9zdF9kZWJ1ZycKY29sbGVjdDI6IGVycm9yOiBs
ZCByZXR1cm5lZCAxIGV4aXQgc3RhdHVzCm1ha2VbMl06ICoqKiBbTWFrZWZpbGU6NDc4NDogYW5k
cm9pZC9hbmRyb2lkLXRlc3Rlcl0gRXJyb3IgMQptYWtlWzFdOiAqKiogW01ha2VmaWxlOjQxNDc6
IGFsbF0gRXJyb3IgMgptYWtlOiAqKiogW01ha2VmaWxlOjEwMzU3OiBkaXN0Y2hlY2tdIEVycm9y
IDEKCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQnVpbGQgdy9leHQgRUxM
IC0gQ29uZmlndXJlIC0gUEFTUwpEZXNjOiBDb25maWd1cmUgQmx1ZVogc291cmNlIHdpdGggJy0t
ZW5hYmxlLWV4dGVybmFsLWVsbCcgY29uZmlndXJhdGlvbgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjClRlc3Q6IEJ1aWxkIHcvZXh0IEVMTCAtIE1ha2UgLSBGQUlMCkRlc2M6IEJ1aWxk
IEJsdWVaIHNvdXJjZSB3aXRoICctLWVuYWJsZS1leHRlcm5hbC1lbGwnIGNvbmZpZ3VyYXRpb24K
T3V0cHV0OgplbXVsYXRvci9idGhvc3QuYzogSW4gZnVuY3Rpb24g4oCYZXZ0X2xlX2V4dF9hZHZf
cmVwb3J04oCZOgplbXVsYXRvci9idGhvc3QuYzoxMzUwOjM6IGVycm9yOiBpbXBsaWNpdCBkZWNs
YXJhdGlvbiBvZiBmdW5jdGlvbiDigJhidGhvc3RfZGVidWfigJk7IGRpZCB5b3UgbWVhbiDigJhi
dGhvc3Rfc2V0X2RlYnVn4oCZPyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlv
bl0KIDEzNTAgfCAgIGJ0aG9zdF9kZWJ1ZyhidGhvc3QsICJsZSBleHQgYWR2IHJlcG9ydDogJXMg
KDB4JTAyeCkiLAogICAgICB8ICAgXn5+fn5+fn5+fn5+CiAgICAgIHwgICBidGhvc3Rfc2V0X2Rl
YnVnCmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMV06ICoq
KiBbTWFrZWZpbGU6Njk1NTogZW11bGF0b3IvYnRob3N0Lm9dIEVycm9yIDEKbWFrZTogKioqIFtN
YWtlZmlsZTo0MTQ3OiBhbGxdIEVycm9yIDIKCgoKCi0tLQpSZWdhcmRzLApMaW51eCBCbHVldG9v
dGgKCg==

--===============7957867906639885817==--

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7896DC07E99
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Jul 2021 13:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59ECA61151
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Jul 2021 13:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbhGLNQt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Jul 2021 09:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbhGLNQs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Jul 2021 09:16:48 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF1CC0613DD
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jul 2021 06:14:00 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id 9so17846852qkf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jul 2021 06:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=uG+xUQMmXcxIju8zDpU8Nmi5qN/XW0dBhPs6qdNacXw=;
        b=jrf832t3hPOkiLv8kkxpsvq4NuuzZ/4JgCa3YyhpEgV4zLRFDurie38XbOyBiciaVF
         nAokWMexE2Bx5J/kC99lyiSSMOESazkxqEIWbXRq3R7wt18IiPc+AU7jLfnGojQiB1JL
         MpYBUd47i69137dLSUnNSelnGsPjE2MZcuNt5YgK5r/wYa26dIUZtwhpUjPE9Pc0H0gg
         sbYsszgI52w9LFmdQTlOw2heIupTm4vio29qFoIeLoq6/urbT2xppvUSNoiEaqFJ02r2
         Qgx3Ee3OVGp6VzxHQ0nIfjPwKso6tLgDuxIBdLc9XZ7CMIfbSipmgsvAsdx0lLH8g5sX
         XkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=uG+xUQMmXcxIju8zDpU8Nmi5qN/XW0dBhPs6qdNacXw=;
        b=ExVB9A6crQkSOtOcNsrsI+toMJGI6wwPciiGttO+tgCdhHNCusxJFSjkDjDhGPUhj/
         xLhewOi5N/0aZPGdo4KaZ0BJSz0LrcLDTcr4D7a8jN6wmrnhiCI8Davm6nzZwoBrVRLM
         YUOmSWf8g6/ZLXIx+tw8ytWMHkE0ZfncicTb/R+HKkl6thVGwJmZ8RSLtWbhgClwRoqK
         NtprMPbEZC4uP7VblSH9IG1uf1gR/VhAv9iZHF2kK/0MErov7hJgQ3IWz9KZJ8PKHA6C
         8yqQoXPtjtfsiUzP1/i4FZdiuYdw57VRqqCi1zEmnjXoNJrJbe+omwhrwSMfPBoj38b0
         Lf1g==
X-Gm-Message-State: AOAM532uidtbxzcTTlHjsPOBDs2MNiu0/wY+rKrQKxJYPb0N10wgM/mg
        BFqg3oPB0rDf9g7XFVQ/e40rbOSrGDujzg==
X-Google-Smtp-Source: ABdhPJxfUlOgHwRQX3WjvgUcJaSJWA+rp0iwS0DWExFcFivJZHvmtS1Bov1dcVvNC6kGL6fdFmEM9w==
X-Received: by 2002:a37:68c1:: with SMTP id d184mr39352543qkc.302.1626095639432;
        Mon, 12 Jul 2021 06:13:59 -0700 (PDT)
Received: from [172.17.0.2] ([40.79.85.101])
        by smtp.gmail.com with ESMTPSA id j20sm5531619qtq.14.2021.07.12.06.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 06:13:59 -0700 (PDT)
Message-ID: <60ec4017.1c69fb81.64131.2256@mx.google.com>
Date:   Mon, 12 Jul 2021 06:13:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8942664394025073251=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [Bluez,v1] a2dp: Fix crash in channel_free while waiting cmd resp
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210712203813.Bluez.v1.1.Id7aa1152377161d17b442bf258773d9b6c624ca3@changeid>
References: <20210712203813.Bluez.v1.1.Id7aa1152377161d17b442bf258773d9b6c624ca3@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8942664394025073251==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NTE0MDI1CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMC4yNyBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIEZB
SUwgICAgICAwLjEwIHNlY29uZHMKUHJlcCAtIFNldHVwIEVMTCAgICAgICAgICAgICAgUEFTUyAg
ICAgIDM5LjM4IHNlY29uZHMKQnVpbGQgLSBQcmVwICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDAuMDkgc2Vjb25kcwpCdWlsZCAtIENvbmZpZ3VyZSAgICAgICAgICAgICBQQVNTICAgICAgNi45
MiBzZWNvbmRzCkJ1aWxkIC0gTWFrZSAgICAgICAgICAgICAgICAgIEZBSUwgICAgICAxMzAuMzUg
c2Vjb25kcwpNYWtlIENoZWNrICAgICAgICAgICAgICAgICAgICBGQUlMICAgICAgMS4wOSBzZWNv
bmRzCk1ha2UgRGlzdGNoZWNrICAgICAgICAgICAgICAgIFBBU1MgICAgICAyMDIuMTMgc2Vjb25k
cwpCdWlsZCB3L2V4dCBFTEwgLSBDb25maWd1cmUgICBQQVNTICAgICAgNi45OSBzZWNvbmRzCkJ1
aWxkIHcvZXh0IEVMTCAtIE1ha2UgICAgICAgIEZBSUwgICAgICAxMjAuMjUgc2Vjb25kcwoKRGV0
YWlscwojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tQYXRjaCAtIFBB
U1MKRGVzYzogUnVuIGNoZWNrcGF0Y2gucGwgc2NyaXB0IHdpdGggcnVsZSBpbiAuY2hlY2twYXRj
aC5jb25mCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogR2l0TGludCAtIEZB
SUwKRGVzYzogUnVuIGdpdGxpbnQgd2l0aCBydWxlIGluIC5naXRsaW50Ck91dHB1dDoKYTJkcDog
Rml4IGNyYXNoIGluIGNoYW5uZWxfZnJlZSB3aGlsZSB3YWl0aW5nIGNtZCByZXNwCjE0OiBCMyBM
aW5lIGNvbnRhaW5zIGhhcmQgdGFiIGNoYXJhY3RlcnMgKFx0KTogIjB4MDAwMDU5ZjAxOTQzZTY4
OAkoYmx1ZXRvb3RoZCAtYXZkdHAuYzozNjkwKSIKMTY6IEIzIExpbmUgY29udGFpbnMgaGFyZCB0
YWIgY2hhcmFjdGVycyAoXHQpOiAiMHgwMDAwNTlmMDE5NDM5MjhhCShibHVldG9vdGhkIC1hMmRw
LmM6MzA2OSkiCjE4OiBCMyBMaW5lIGNvbnRhaW5zIGhhcmQgdGFiIGNoYXJhY3RlcnMgKFx0KTog
IjB4MDAwMDU5ZjAxOTQzNzdmYQkoYmx1ZXRvb3RoZCAtc2luay5jOjMyNCkiCjIwOiBCMyBMaW5l
IGNvbnRhaW5zIGhhcmQgdGFiIGNoYXJhY3RlcnMgKFx0KTogIjB4MDAwMDU5ZjAxOTQ4NzE1YQko
Ymx1ZXRvb3RoZCAtc2VydmljZS5jOjE3NykiCjIyOiBCMyBMaW5lIGNvbnRhaW5zIGhhcmQgdGFi
IGNoYXJhY3RlcnMgKFx0KTogIjB4MDAwMDU5ZjAxOTQ4ZDc3YwkoYmx1ZXRvb3RoZCAtZGV2aWNl
LmM6NTM0NikiCjI0OiBCMyBMaW5lIGNvbnRhaW5zIGhhcmQgdGFiIGNoYXJhY3RlcnMgKFx0KTog
IjB4MDAwMDU5ZjAxOTQ3NmQxNAkoYmx1ZXRvb3RoZCAtYWRhcHRlci5jOjcyMDIpIgoyNjogQjMg
TGluZSBjb250YWlucyBoYXJkIHRhYiBjaGFyYWN0ZXJzIChcdCk6ICIweDAwMDA1OWYwMTk0NzZj
M2UJKGJsdWV0b290aGQgLWFkYXB0ZXIuYzoxMDgyNykiCjI4OiBCMyBMaW5lIGNvbnRhaW5zIGhh
cmQgdGFiIGNoYXJhY3RlcnMgKFx0KTogIjB4MDAwMDU5ZjAxOTQ5ZDhkNwkoYmx1ZXRvb3RoZCAt
bWFpbi5jOjExMTQpCQltYWluIgoyOTogQjMgTGluZSBjb250YWlucyBoYXJkIHRhYiBjaGFyYWN0
ZXJzIChcdCk6ICIweDAwMDA3ODdiMzYxODVkNzQJKGxpYmMuc28uNiAtbGliYy1zdGFydC5jOjMw
OCkiCjMxOiBCMyBMaW5lIGNvbnRhaW5zIGhhcmQgdGFiIGNoYXJhY3RlcnMgKFx0KTogIjB4MDAw
MDU5ZjAxOTQzM2UzOQkoYmx1ZXRvb3RoZCArIDB4MDAwMjZlMzkpCQlfc3RhcnQiCgoKIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IFByZXAgLSBTZXR1cCBFTEwgLSBQQVNTCkRl
c2M6IENsb25lLCBidWlsZCwgYW5kIGluc3RhbGwgRUxMCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMKVGVzdDogQnVpbGQgLSBQcmVwIC0gUEFTUwpEZXNjOiBQcmVwYXJlIGVudmlyb25t
ZW50IGZvciBidWlsZAoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEJ1aWxk
IC0gQ29uZmlndXJlIC0gUEFTUwpEZXNjOiBDb25maWd1cmUgdGhlIEJsdWVaIHNvdXJjZSB0cmVl
CgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQnVpbGQgLSBNYWtlIC0gRkFJ
TApEZXNjOiBCdWlsZCB0aGUgQmx1ZVogc291cmNlIHRyZWUKT3V0cHV0Ogpwcm9maWxlcy9hdWRp
by9hMmRwLmM6IEluIGZ1bmN0aW9uIOKAmGNoYW5uZWxfZnJlZeKAmToKcHJvZmlsZXMvYXVkaW8v
YTJkcC5jOjE1NDQ6NDI6IGVycm9yOiBwYXNzaW5nIGFyZ3VtZW50IDMgb2Yg4oCYZmluYWxpemVf
c2V0dXBfZXJybm/igJkgZnJvbSBpbmNvbXBhdGlibGUgcG9pbnRlciB0eXBlIFstV2Vycm9yPWlu
Y29tcGF0aWJsZS1wb2ludGVyLXR5cGVzXQogMTU0NCB8ICAgZmluYWxpemVfc2V0dXBfZXJybm8o
c2V0dXAsIC1FTk9UQ09OTiwgZmluYWxpemVfZGlzY292ZXIsCiAgICAgIHwgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fgogICAgICB8ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfAogICAgICB8ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAoKikoc3RydWN0IGEyZHBfc2V0
dXAgKikKcHJvZmlsZXMvYXVkaW8vYTJkcC5jOjI2MjoxODogbm90ZTogZXhwZWN0ZWQg4oCYR1Nv
dXJjZUZ1bmPigJkge2FrYSDigJhpbnQgKCopKHZvaWQgKinigJl9IGJ1dCBhcmd1bWVudCBpcyBv
ZiB0eXBlIOKAmHZvaWQgKCopKHN0cnVjdCBhMmRwX3NldHVwICop4oCZCiAgMjYyIHwgICAgICBH
U291cmNlRnVuYyBjYjEsIC4uLikKICAgICAgfCAgICAgIH5+fn5+fn5+fn5+fl5+fgpjYzE6IGFs
bCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiogW01ha2VmaWxl
Ojg1MzE6IHByb2ZpbGVzL2F1ZGlvL2JsdWV0b290aGQtYTJkcC5vXSBFcnJvciAxCm1ha2U6ICoq
KiBbTWFrZWZpbGU6NDEzNDogYWxsXSBFcnJvciAyCgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjClRlc3Q6IE1ha2UgQ2hlY2sgLSBGQUlMCkRlc2M6IFJ1biAnbWFrZSBjaGVjaycKT3V0
cHV0Ogpwcm9maWxlcy9hdWRpby9hMmRwLmM6IEluIGZ1bmN0aW9uIOKAmGNoYW5uZWxfZnJlZeKA
mToKcHJvZmlsZXMvYXVkaW8vYTJkcC5jOjE1NDQ6NDI6IGVycm9yOiBwYXNzaW5nIGFyZ3VtZW50
IDMgb2Yg4oCYZmluYWxpemVfc2V0dXBfZXJybm/igJkgZnJvbSBpbmNvbXBhdGlibGUgcG9pbnRl
ciB0eXBlIFstV2Vycm9yPWluY29tcGF0aWJsZS1wb2ludGVyLXR5cGVzXQogMTU0NCB8ICAgZmlu
YWxpemVfc2V0dXBfZXJybm8oc2V0dXAsIC1FTk9UQ09OTiwgZmluYWxpemVfZGlzY292ZXIsCiAg
ICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+
fn5+fn5+fgogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fAogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAo
Kikoc3RydWN0IGEyZHBfc2V0dXAgKikKcHJvZmlsZXMvYXVkaW8vYTJkcC5jOjI2MjoxODogbm90
ZTogZXhwZWN0ZWQg4oCYR1NvdXJjZUZ1bmPigJkge2FrYSDigJhpbnQgKCopKHZvaWQgKinigJl9
IGJ1dCBhcmd1bWVudCBpcyBvZiB0eXBlIOKAmHZvaWQgKCopKHN0cnVjdCBhMmRwX3NldHVwICop
4oCZCiAgMjYyIHwgICAgICBHU291cmNlRnVuYyBjYjEsIC4uLikKICAgICAgfCAgICAgIH5+fn5+
fn5+fn5+fl5+fgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtl
WzFdOiAqKiogW01ha2VmaWxlOjg1MzE6IHByb2ZpbGVzL2F1ZGlvL2JsdWV0b290aGQtYTJkcC5v
XSBFcnJvciAxCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTA0MDY6IGNoZWNrXSBFcnJvciAyCgoKIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IE1ha2UgRGlzdGNoZWNrIC0gUEFTUwpE
ZXNjOiBSdW4gZGlzdGNoZWNrIHRvIGNoZWNrIHRoZSBkaXN0cmlidXRpb24KCiMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBCdWlsZCB3L2V4dCBFTEwgLSBDb25maWd1cmUgLSBQ
QVNTCkRlc2M6IENvbmZpZ3VyZSBCbHVlWiBzb3VyY2Ugd2l0aCAnLS1lbmFibGUtZXh0ZXJuYWwt
ZWxsJyBjb25maWd1cmF0aW9uCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDog
QnVpbGQgdy9leHQgRUxMIC0gTWFrZSAtIEZBSUwKRGVzYzogQnVpbGQgQmx1ZVogc291cmNlIHdp
dGggJy0tZW5hYmxlLWV4dGVybmFsLWVsbCcgY29uZmlndXJhdGlvbgpPdXRwdXQ6CnByb2ZpbGVz
L2F1ZGlvL2EyZHAuYzogSW4gZnVuY3Rpb24g4oCYY2hhbm5lbF9mcmVl4oCZOgpwcm9maWxlcy9h
dWRpby9hMmRwLmM6MTU0NDo0MjogZXJyb3I6IHBhc3NpbmcgYXJndW1lbnQgMyBvZiDigJhmaW5h
bGl6ZV9zZXR1cF9lcnJub+KAmSBmcm9tIGluY29tcGF0aWJsZSBwb2ludGVyIHR5cGUgWy1XZXJy
b3I9aW5jb21wYXRpYmxlLXBvaW50ZXItdHlwZXNdCiAxNTQ0IHwgICBmaW5hbGl6ZV9zZXR1cF9l
cnJubyhzZXR1cCwgLUVOT1RDT05OLCBmaW5hbGl6ZV9kaXNjb3ZlciwKICAgICAgfCAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+CiAgICAg
IHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8CiAgICAgIHwgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lkICgqKShzdHJ1Y3QgYTJk
cF9zZXR1cCAqKQpwcm9maWxlcy9hdWRpby9hMmRwLmM6MjYyOjE4OiBub3RlOiBleHBlY3RlZCDi
gJhHU291cmNlRnVuY+KAmSB7YWthIOKAmGludCAoKikodm9pZCAqKeKAmX0gYnV0IGFyZ3VtZW50
IGlzIG9mIHR5cGUg4oCYdm9pZCAoKikoc3RydWN0IGEyZHBfc2V0dXAgKinigJkKICAyNjIgfCAg
ICAgIEdTb3VyY2VGdW5jIGNiMSwgLi4uKQogICAgICB8ICAgICAgfn5+fn5+fn5+fn5+Xn5+CmNj
MTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMV06ICoqKiBbTWFr
ZWZpbGU6ODUzMTogcHJvZmlsZXMvYXVkaW8vYmx1ZXRvb3RoZC1hMmRwLm9dIEVycm9yIDEKbWFr
ZTogKioqIFtNYWtlZmlsZTo0MTM0OiBhbGxdIEVycm9yIDIKCgoKCi0tLQpSZWdhcmRzLApMaW51
eCBCbHVldG9vdGgKCg==

--===============8942664394025073251==--

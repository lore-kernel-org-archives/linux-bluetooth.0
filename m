Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1B3C433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 23:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5BA86008E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 23:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbhELXha (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 May 2021 19:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376813AbhELXKM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 May 2021 19:10:12 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74555C06138A
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 May 2021 16:06:54 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id q10so19789526qkc.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 May 2021 16:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=xM6c9CbJojaAV5XpHfz+nUw31ZJNy1Epw2fvVchHTG4=;
        b=Zbu6snLiHcGgAa6XdJhSZQiLgLG/ZEStkxL0kOSrQ87SmIBWFfbA/Bwe7EQMDg47Wq
         s/0h80tGdoxOcjQKdC3BWK+Ivb2y+U0CuLO4FGDpQuCr9moA/uLlddOQ/Vg7MGs0cKgz
         8Jd/aTFXJkTmhz7QXGQm2hX15mpewphymc2jcV0fhAQxkRWKBXQdlQnpwooPy8PPhxbx
         6nQ4GMVVN41LRQdCZPOVBFj2QmwWGsra1BbAZoqYo5sGnaEMCMDbGAleoobDn08d3SCS
         9GKqE/9fXM1eh0+lZkLq3s31PnMSlBpf2Ra1HayTqyPX0hf81lfiVLFsb+vCsv6FtS66
         DBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=xM6c9CbJojaAV5XpHfz+nUw31ZJNy1Epw2fvVchHTG4=;
        b=nPbW9N6Y5sS3/G5JEPw46K3DdjfkBX74lv4tMeN1uZ/mUzCIiiP5bGcLNkOJV/1Vt8
         zrd+ax6Vt8MLVGfguIzdA98eIwWyUkcY10QXa6uhi2iljSducb7See09u6v/4Y1vVY/O
         2btUAiXjLjbwX2pAD64Tq1wbMqJCAUCnCL8hU4aaoKqcUXdEkf/2TOC8SOipImJkVRC6
         PM1fVfg0rjzLPwHys0srmKTQx29myG2ilwTI4F6/9f6UnO0R9CCNEvpK0pJ4z2JoAj24
         4PTZajNtkF3lleNRKBVuBudMEW4JV8SMOwcxtlkwOG2jrSQCROCcoTve7nTDxrtZz+63
         ZYgQ==
X-Gm-Message-State: AOAM531JtYjp1EpoMl8q31yUgCJq9+oF2CZUTB+VXJYvXVssYnJ0PQUk
        mKMjiMvW0vm0uGZCKEiZadY8DHhQDau8kg==
X-Google-Smtp-Source: ABdhPJwIVebZdKiy+7nD2fnm+o/fRw7m+8//WdWL04phquKG5wCgIe5+WEOS4/5cqt9/Ukxj/mjTXQ==
X-Received: by 2002:a37:68c5:: with SMTP id d188mr23241866qkc.287.1620860813333;
        Wed, 12 May 2021 16:06:53 -0700 (PDT)
Received: from [172.17.0.2] ([104.208.138.141])
        by smtp.gmail.com with ESMTPSA id d11sm1068123qkk.110.2021.05.12.16.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 16:06:52 -0700 (PDT)
Message-ID: <609c5f8c.1c69fb81.3fc3d.8a60@mx.google.com>
Date:   Wed, 12 May 2021 16:06:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2808671635921503598=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sgrubb@redhat.com
Subject: RE: Fix various memory leaks
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210512173523.622e0ade@ivy-bridge>
References: <20210512173523.622e0ade@ivy-bridge>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2808671635921503598==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NDgxNTMxCgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMS4xMCBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjYxIHNlY29uZHMKUHJlcCAtIFNldHVwIEVMTCAgICAgICAgICAgICAgUEFTUyAg
ICAgIDQwLjM1IHNlY29uZHMKQnVpbGQgLSBQcmVwICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDAuMTAgc2Vjb25kcwpCdWlsZCAtIENvbmZpZ3VyZSAgICAgICAgICAgICBQQVNTICAgICAgNi45
OCBzZWNvbmRzCkJ1aWxkIC0gTWFrZSAgICAgICAgICAgICAgICAgIEZBSUwgICAgICAxNTQuMjAg
c2Vjb25kcwpNYWtlIENoZWNrICAgICAgICAgICAgICAgICAgICBGQUlMICAgICAgMC42MyBzZWNv
bmRzCk1ha2UgRGlzdGNoZWNrICAgICAgICAgICAgICAgIFBBU1MgICAgICAyMDguNjggc2Vjb25k
cwpCdWlsZCB3L2V4dCBFTEwgLSBDb25maWd1cmUgICBQQVNTICAgICAgNy4xNyBzZWNvbmRzCkJ1
aWxkIHcvZXh0IEVMTCAtIE1ha2UgICAgICAgIEZBSUwgICAgICAxNDUuOTYgc2Vjb25kcwoKRGV0
YWlscwojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tQYXRjaCAtIFBB
U1MKRGVzYzogUnVuIGNoZWNrcGF0Y2gucGwgc2NyaXB0IHdpdGggcnVsZSBpbiAuY2hlY2twYXRj
aC5jb25mCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogR2l0TGludCAtIFBB
U1MKRGVzYzogUnVuIGdpdGxpbnQgd2l0aCBydWxlIGluIC5naXRsaW50CgojIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogUHJlcCAtIFNldHVwIEVMTCAtIFBBU1MKRGVzYzogQ2xv
bmUsIGJ1aWxkLCBhbmQgaW5zdGFsbCBFTEwKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IwpUZXN0OiBCdWlsZCAtIFByZXAgLSBQQVNTCkRlc2M6IFByZXBhcmUgZW52aXJvbm1lbnQgZm9y
IGJ1aWxkCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQnVpbGQgLSBDb25m
aWd1cmUgLSBQQVNTCkRlc2M6IENvbmZpZ3VyZSB0aGUgQmx1ZVogc291cmNlIHRyZWUKCiMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBCdWlsZCAtIE1ha2UgLSBGQUlMCkRlc2M6
IEJ1aWxkIHRoZSBCbHVlWiBzb3VyY2UgdHJlZQpPdXRwdXQ6Cm9iZXhkL3BsdWdpbnMvZmlsZXN5
c3RlbS5jOiBJbiBmdW5jdGlvbiDigJhjYXBhYmlsaXR5X29wZW7igJk6Cm9iZXhkL3BsdWdpbnMv
ZmlsZXN5c3RlbS5jOjQxODoxODogZXJyb3I6IGFzc2lnbm1lbnQgdG8g4oCYR1N0cmluZyAq4oCZ
IHtha2Eg4oCYc3RydWN0IF9HU3RyaW5nICrigJl9IGZyb20gaW5jb21wYXRpYmxlIHBvaW50ZXIg
dHlwZSDigJhjaGFyICrigJkgWy1XZXJyb3I9aW5jb21wYXRpYmxlLXBvaW50ZXItdHlwZXNdCiAg
NDE4IHwgICBvYmplY3QtPmJ1ZmZlciA9IGJ1ZjsKICAgICAgfCAgICAgICAgICAgICAgICAgIF4K
Y2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsxXTogKioqIFtN
YWtlZmlsZTo3OTA3OiBvYmV4ZC9wbHVnaW5zL29iZXhkLWZpbGVzeXN0ZW0ub10gRXJyb3IgMQpt
YWtlOiAqKiogW01ha2VmaWxlOjQxMjg6IGFsbF0gRXJyb3IgMgoKCiMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIwpUZXN0OiBNYWtlIENoZWNrIC0gRkFJTApEZXNjOiBSdW4gJ21ha2UgY2hl
Y2snCk91dHB1dDoKb2JleGQvcGx1Z2lucy9maWxlc3lzdGVtLmM6IEluIGZ1bmN0aW9uIOKAmGNh
cGFiaWxpdHlfb3BlbuKAmToKb2JleGQvcGx1Z2lucy9maWxlc3lzdGVtLmM6NDE4OjE4OiBlcnJv
cjogYXNzaWdubWVudCB0byDigJhHU3RyaW5nICrigJkge2FrYSDigJhzdHJ1Y3QgX0dTdHJpbmcg
KuKAmX0gZnJvbSBpbmNvbXBhdGlibGUgcG9pbnRlciB0eXBlIOKAmGNoYXIgKuKAmSBbLVdlcnJv
cj1pbmNvbXBhdGlibGUtcG9pbnRlci10eXBlc10KICA0MTggfCAgIG9iamVjdC0+YnVmZmVyID0g
YnVmOwogICAgICB8ICAgICAgICAgICAgICAgICAgXgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0
cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiogW01ha2VmaWxlOjc5MDc6IG9iZXhkL3BsdWdp
bnMvb2JleGQtZmlsZXN5c3RlbS5vXSBFcnJvciAxCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTAzOTg6
IGNoZWNrXSBFcnJvciAyCgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IE1h
a2UgRGlzdGNoZWNrIC0gUEFTUwpEZXNjOiBSdW4gZGlzdGNoZWNrIHRvIGNoZWNrIHRoZSBkaXN0
cmlidXRpb24KCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBCdWlsZCB3L2V4
dCBFTEwgLSBDb25maWd1cmUgLSBQQVNTCkRlc2M6IENvbmZpZ3VyZSBCbHVlWiBzb3VyY2Ugd2l0
aCAnLS1lbmFibGUtZXh0ZXJuYWwtZWxsJyBjb25maWd1cmF0aW9uCgojIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMKVGVzdDogQnVpbGQgdy9leHQgRUxMIC0gTWFrZSAtIEZBSUwKRGVzYzog
QnVpbGQgQmx1ZVogc291cmNlIHdpdGggJy0tZW5hYmxlLWV4dGVybmFsLWVsbCcgY29uZmlndXJh
dGlvbgpPdXRwdXQ6Cm9iZXhkL3BsdWdpbnMvZmlsZXN5c3RlbS5jOiBJbiBmdW5jdGlvbiDigJhj
YXBhYmlsaXR5X29wZW7igJk6Cm9iZXhkL3BsdWdpbnMvZmlsZXN5c3RlbS5jOjQxODoxODogZXJy
b3I6IGFzc2lnbm1lbnQgdG8g4oCYR1N0cmluZyAq4oCZIHtha2Eg4oCYc3RydWN0IF9HU3RyaW5n
ICrigJl9IGZyb20gaW5jb21wYXRpYmxlIHBvaW50ZXIgdHlwZSDigJhjaGFyICrigJkgWy1XZXJy
b3I9aW5jb21wYXRpYmxlLXBvaW50ZXItdHlwZXNdCiAgNDE4IHwgICBvYmplY3QtPmJ1ZmZlciA9
IGJ1ZjsKICAgICAgfCAgICAgICAgICAgICAgICAgIF4KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcg
dHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsxXTogKioqIFtNYWtlZmlsZTo3OTA3OiBvYmV4ZC9wbHVn
aW5zL29iZXhkLWZpbGVzeXN0ZW0ub10gRXJyb3IgMQptYWtlOiAqKiogW01ha2VmaWxlOjQxMjg6
IGFsbF0gRXJyb3IgMgoKCgoKLS0tClJlZ2FyZHMsCkxpbnV4IEJsdWV0b290aAoK

--===============2808671635921503598==--

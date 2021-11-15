Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739ACC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 09:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 505DB61BE6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 09:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhKOJ6l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Nov 2021 04:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236795AbhKOJ6g (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Nov 2021 04:58:36 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7929DC061766
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Nov 2021 01:55:35 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id g1so9306592qvd.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Nov 2021 01:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=MX/XoXFf6C0cZhLSeCc83ZNuHZQ6Y7cdCcnzAArzi5A=;
        b=WX2LwUJ8UIDNK7BVv07r2uoBSFpGbJnJPDeJhFjw2TXbBgpJw3t0vdDMtcg+FWun+Y
         VEMfgD64e3i+NYWR9650lIoOPiy5PiOfEESGGueDw/3Ckb8AOHDk48hjzPkICy17O2bm
         TKeyjRTV4qasCY1n7E6eAGSNHaqvm6+MwLIHVXjUHhlWyRFIqxaFOk5liPXN/6Vmnw7f
         nVtUwtmxiYCIfWAi5pf3aYnJBXAVQfaROhUXh9Rfx7or6Tj2YlaJ7ZaTuTh+5yyy54po
         PSEouJ0T5nww7OGxPkjRiBmED6PmkG2b1P6vggmFEpdaLC0ALagBiR66mqllytnaURxD
         7Mnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=MX/XoXFf6C0cZhLSeCc83ZNuHZQ6Y7cdCcnzAArzi5A=;
        b=i/+GyPlaznSmL1xx1bz6m00Q5Jk9bU/DhK1KIpr7+75URmskZR4T6Fx6nw1xajHCMe
         8ay7i7SYU/qrpVwg3kaVjR6Rvw1ALekieqWOqi/rlUSYxyN1oByaKi9BsbomUd4IDOb5
         2u1d6kFmbSdaWK7Ku9x3CNGEzTTCIojKmAzAGXQJ/kXqgTwVOtxHV8YYesBXB5CjL1Sx
         QXKOPueC8t2Ij9R05Q9Vnr13FugBR9f6anD5c7xL1fhij+sdpEm4diJTTbGL7EYADBUo
         tN2wZlV6qVHgnm/Vjo6UIrGuy01gyViH92r6Uw+OTVpv9W2YRi45vNpQ6IJio7G+CmDx
         jS2w==
X-Gm-Message-State: AOAM532S2xyG+CGZgDIJXE10ux6sTgqFOFMZXRBXjcW3Ba2f4H5EPZoB
        N6RF1SxTooYH6D7sMuvvssWVRA/ZtM54vA==
X-Google-Smtp-Source: ABdhPJwdJJudDgWrKfL6B5YetGZ5pwJ+Lvd34gfOzA22+YQgZIMBOlN0PegYXaGGhmSiCEcAHLpGfQ==
X-Received: by 2002:a05:6214:16ca:: with SMTP id d10mr35257199qvz.14.1636970133966;
        Mon, 15 Nov 2021 01:55:33 -0800 (PST)
Received: from [172.17.0.2] ([20.98.207.15])
        by smtp.gmail.com with ESMTPSA id u17sm4612312qki.2.2021.11.15.01.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 01:55:33 -0800 (PST)
Message-ID: <61922e95.1c69fb81.3ebbc.88e4@mx.google.com>
Date:   Mon, 15 Nov 2021 01:55:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2614700480713007655=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1,1/5] avdtp: Add a flag in struct avdtp to control a2dp offload
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211115094108.24331-1-kiran.k@intel.com>
References: <20211115094108.24331-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2614700480713007655==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NTgwMDE5CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgNy4yMSBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICA0LjgxIHNlY29uZHMKUHJlcCAtIFNldHVwIEVMTCAgICAgICAgICAgICAgUEFTUyAg
ICAgIDQyLjE5IHNlY29uZHMKQnVpbGQgLSBQcmVwICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDAuNTMgc2Vjb25kcwpCdWlsZCAtIENvbmZpZ3VyZSAgICAgICAgICAgICBQQVNTICAgICAgNy45
MSBzZWNvbmRzCkJ1aWxkIC0gTWFrZSAgICAgICAgICAgICAgICAgIEZBSUwgICAgICAxMzguNTUg
c2Vjb25kcwpNYWtlIENoZWNrICAgICAgICAgICAgICAgICAgICBGQUlMICAgICAgMS42MCBzZWNv
bmRzCk1ha2UgRGlzdGNoZWNrICAgICAgICAgICAgICAgIFBBU1MgICAgICAyMTQuNjMgc2Vjb25k
cwpCdWlsZCB3L2V4dCBFTEwgLSBDb25maWd1cmUgICBQQVNTICAgICAgOC4wNCBzZWNvbmRzCkJ1
aWxkIHcvZXh0IEVMTCAtIE1ha2UgICAgICAgIEZBSUwgICAgICAxMjguODcgc2Vjb25kcwoKRGV0
YWlscwojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQnVpbGQgLSBNYWtlIC0g
RkFJTApEZXNjOiBCdWlsZCB0aGUgQmx1ZVogc291cmNlIHRyZWUKT3V0cHV0Ogpwcm9maWxlcy9h
dWRpby9hdmR0cC5jOiBJbiBmdW5jdGlvbiDigJhhdmR0cF9jb25uZWN0X2Ni4oCZOgpwcm9maWxl
cy9hdWRpby9hdmR0cC5jOjIzNzQ6NjogZXJyb3I6IOKAmGNhcOKAmSBtYXkgYmUgdXNlZCB1bmlu
aXRpYWxpemVkIGluIHRoaXMgZnVuY3Rpb24gWy1XZXJyb3I9bWF5YmUtdW5pbml0aWFsaXplZF0K
IDIzNzQgfCAgaWYgKHNldHNvY2tvcHQoc29jaywgU09MX0JMVUVUT09USCwgQlRfTVNGVF9PUEVO
LCBjYXAsCiAgICAgIHwgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fgogMjM3NSB8ICAgICAgICAgIHNpemVvZigqY2FwKSArIGNhcC0+bGVuZ3Ro
KSkKICAgICAgfCAgICAgICAgICB+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KcHJvZmlsZXMv
YXVkaW8vYXZkdHAuYzoyMzU4OjM1OiBub3RlOiDigJhjYXDigJkgd2FzIGRlY2xhcmVkIGhlcmUK
IDIzNTggfCAgc3RydWN0IGF2ZHRwX3NlcnZpY2VfY2FwYWJpbGl0eSAqY2FwOwogICAgICB8ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn4KY2MxOiBhbGwgd2FybmluZ3MgYmVp
bmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsxXTogKioqIFtNYWtlZmlsZTo4NjQwOiBwcm9maWxl
cy9hdWRpby9ibHVldG9vdGhkLWF2ZHRwLm9dIEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmlsZTo0
MTc1OiBhbGxdIEVycm9yIDIKCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDog
TWFrZSBDaGVjayAtIEZBSUwKRGVzYzogUnVuICdtYWtlIGNoZWNrJwpPdXRwdXQ6CnByb2ZpbGVz
L2F1ZGlvL2F2ZHRwLmM6IEluIGZ1bmN0aW9uIOKAmGF2ZHRwX2Nvbm5lY3RfY2LigJk6CnByb2Zp
bGVzL2F1ZGlvL2F2ZHRwLmM6MjM3NDo2OiBlcnJvcjog4oCYY2Fw4oCZIG1heSBiZSB1c2VkIHVu
aW5pdGlhbGl6ZWQgaW4gdGhpcyBmdW5jdGlvbiBbLVdlcnJvcj1tYXliZS11bmluaXRpYWxpemVk
XQogMjM3NCB8ICBpZiAoc2V0c29ja29wdChzb2NrLCBTT0xfQkxVRVRPT1RILCBCVF9NU0ZUX09Q
RU4sIGNhcCwKICAgICAgfCAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+CiAyMzc1IHwgICAgICAgICAgc2l6ZW9mKCpjYXApICsgY2FwLT5sZW5n
dGgpKQogICAgICB8ICAgICAgICAgIH5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgpwcm9maWxl
cy9hdWRpby9hdmR0cC5jOjIzNTg6MzU6IG5vdGU6IOKAmGNhcOKAmSB3YXMgZGVjbGFyZWQgaGVy
ZQogMjM1OCB8ICBzdHJ1Y3QgYXZkdHBfc2VydmljZV9jYXBhYmlsaXR5ICpjYXA7CiAgICAgIHwg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fgpjYzE6IGFsbCB3YXJuaW5ncyBi
ZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiogW01ha2VmaWxlOjg2NDA6IHByb2Zp
bGVzL2F1ZGlvL2JsdWV0b290aGQtYXZkdHAub10gRXJyb3IgMQptYWtlOiAqKiogW01ha2VmaWxl
OjEwNTAxOiBjaGVja10gRXJyb3IgMgoKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpU
ZXN0OiBCdWlsZCB3L2V4dCBFTEwgLSBNYWtlIC0gRkFJTApEZXNjOiBCdWlsZCBCbHVlWiBzb3Vy
Y2Ugd2l0aCAnLS1lbmFibGUtZXh0ZXJuYWwtZWxsJyBjb25maWd1cmF0aW9uCk91dHB1dDoKcHJv
ZmlsZXMvYXVkaW8vYXZkdHAuYzogSW4gZnVuY3Rpb24g4oCYYXZkdHBfY29ubmVjdF9jYuKAmToK
cHJvZmlsZXMvYXVkaW8vYXZkdHAuYzoyMzc0OjY6IGVycm9yOiDigJhjYXDigJkgbWF5IGJlIHVz
ZWQgdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uIFstV2Vycm9yPW1heWJlLXVuaW5pdGlh
bGl6ZWRdCiAyMzc0IHwgIGlmIChzZXRzb2Nrb3B0KHNvY2ssIFNPTF9CTFVFVE9PVEgsIEJUX01T
RlRfT1BFTiwgY2FwLAogICAgICB8ICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn4KIDIzNzUgfCAgICAgICAgICBzaXplb2YoKmNhcCkgKyBjYXAt
Pmxlbmd0aCkpCiAgICAgIHwgICAgICAgICAgfn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CnBy
b2ZpbGVzL2F1ZGlvL2F2ZHRwLmM6MjM1ODozNTogbm90ZTog4oCYY2Fw4oCZIHdhcyBkZWNsYXJl
ZCBoZXJlCiAyMzU4IHwgIHN0cnVjdCBhdmR0cF9zZXJ2aWNlX2NhcGFiaWxpdHkgKmNhcDsKICAg
ICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+CmNjMTogYWxsIHdhcm5p
bmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6ODY0MDog
cHJvZmlsZXMvYXVkaW8vYmx1ZXRvb3RoZC1hdmR0cC5vXSBFcnJvciAxCm1ha2U6ICoqKiBbTWFr
ZWZpbGU6NDE3NTogYWxsXSBFcnJvciAyCgoKCgotLS0KUmVnYXJkcywKTGludXggQmx1ZXRvb3Ro
Cgo=

--===============2614700480713007655==--

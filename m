Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2B9C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Oct 2022 03:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiJND1N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Oct 2022 23:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiJND1L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Oct 2022 23:27:11 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3D0133300
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Oct 2022 20:27:09 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id s125-20020a4a5183000000b0047fbaf2fcbcso1541475ooa.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Oct 2022 20:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U46zVUHFWESRiQ/bNT1cJqHbzmBh4wbVN+KoJv2dfBo=;
        b=ZCSXQmlKO458RpBPvaCUvmT1eu9sGKQ4fwXk6jsLqrJjtm8WAuPM+AHVF1MKuPVwKG
         KpYAEidl7qT0cKHnTuHv/sW+zZjnp/6a4SJ4tXtClXv04xka0KS2DVBlWXiFMiwvjCqY
         WpdcrkKKRpkijiJ7XAdQS7NqP5zA49x9f8d2TH2AwHJC5R7FlT8La6dYwOFo8hFUZQ8j
         40Z0L0IxJL0/5vwgUCWG5rgAVdEGhSBxWMsNjN9v7Y0v8rUhqPPm9JUtCkODUpCZ4Cjq
         NuPRqVoWdpaCDF04UIg9tTPrVo6xg+kVDqJH0/UlLrU789ATjU0HV5PQi0kSKR27r1xS
         2gnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U46zVUHFWESRiQ/bNT1cJqHbzmBh4wbVN+KoJv2dfBo=;
        b=I6rcSNhRHacEp46tRmrfAzPESVpAoGtiqsTgOyeaJCwMDQGoMpAVI2kaLimDxFHhx6
         eJAttl7Am49LSEVtph+DYBjEN+7soCmZs3I9y4SJV57N+iuQvpU8JXp6w6iOT5TWw0WS
         IbYMp0/VzwX5aXjsTVKTY3BIGbCC26jbD0+/oeiB127I8OG/jbaMr3klkiEN9yfEzExz
         b0jdczYvEcCjyDsPlyqqU+TkF+6aBy0UGxO6EenxHndSj0QOxT1oIo4BNb/eU/FYO5Ar
         mSA4HSlTTvwQ6gxuW5hbdEOxUIcLUERGxOpIhuFObk8InMIYPXVTB1EGPSflJPRRL46z
         kdGQ==
X-Gm-Message-State: ACrzQf3Hwf7L9mKDsVWUQV7hE5O7QSWSgFJyX2LuqB5lGmbHpUIwhS0g
        Tll5AkiueBrwFwNNjxGd8Yk12KvAXkDAwQ==
X-Google-Smtp-Source: AMsMyM7lNcFf7Hs2jPPa6A5cmOawl5KagonOffeq5kp8TGU/FIqS5mTrkCTcS86HyJ0HwaCsvbQovw==
X-Received: by 2002:a4a:97a5:0:b0:475:fa71:731e with SMTP id w34-20020a4a97a5000000b00475fa71731emr1178863ooi.38.1665718028614;
        Thu, 13 Oct 2022 20:27:08 -0700 (PDT)
Received: from [172.17.0.2] ([20.165.52.97])
        by smtp.gmail.com with ESMTPSA id a19-20020a056808129300b00354b619a375sm668604oiw.0.2022.10.13.20.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 20:27:08 -0700 (PDT)
Message-ID: <6348d70c.050a0220.f29cf.31f2@mx.google.com>
Date:   Thu, 13 Oct 2022 20:27:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4686177761020392431=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ] monitor: Fix incorrect vendor name for vendor cmd and evt
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221014020246.1035012-1-hj.tedd.an@gmail.com>
References: <20221014020246.1035012-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4686177761020392431==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9Njg1MjUzCgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMS4wNiBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjc0IHNlY29uZHMKUHJlcCAtIFNldHVwIEVMTCAgICAgICAgICAgICAgUEFTUyAg
ICAgIDI2LjE4IHNlY29uZHMKQnVpbGQgLSBQcmVwICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDAuNjcgc2Vjb25kcwpCdWlsZCAtIENvbmZpZ3VyZSAgICAgICAgICAgICBQQVNTICAgICAgOC4x
MyBzZWNvbmRzCkJ1aWxkIC0gTWFrZSAgICAgICAgICAgICAgICAgIEZBSUwgICAgICAxNDUuOTIg
c2Vjb25kcwpNYWtlIENoZWNrICAgICAgICAgICAgICAgICAgICBGQUlMICAgICAgMTIuNTkgc2Vj
b25kcwpNYWtlIENoZWNrIHcvVmFsZ3JpbmQgICAgICAgICBGQUlMICAgICAgMTExLjk0IHNlY29u
ZHMKTWFrZSBEaXN0Y2hlY2sgICAgICAgICAgICAgICAgUEFTUyAgICAgIDIzMy40MiBzZWNvbmRz
CkJ1aWxkIHcvZXh0IEVMTCAtIENvbmZpZ3VyZSAgIFBBU1MgICAgICA4LjE4IHNlY29uZHMKQnVp
bGQgdy9leHQgRUxMIC0gTWFrZSAgICAgICAgRkFJTCAgICAgIDU0Ljc3IHNlY29uZHMKSW5jcmVt
ZW50YWwgQnVpbGQgdy8gcGF0Y2hlcyAgUEFTUyAgICAgIDAuMDAgc2Vjb25kcwpTY2FuIEJ1aWxk
ICAgICAgICAgICAgICAgICAgICBGQUlMICAgICAgNDcyLjA0IHNlY29uZHMKCkRldGFpbHMKIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEJ1aWxkIC0gTWFrZSAtIEZBSUwKRGVz
YzogQnVpbGQgdGhlIEJsdWVaIHNvdXJjZSB0cmVlCk91dHB1dDoKdG9vbHMvbWdtdC10ZXN0ZXIu
YzogSW4gZnVuY3Rpb24g4oCYbWFpbuKAmToKdG9vbHMvbWdtdC10ZXN0ZXIuYzoxMjUxNDo1OiBu
b3RlOiB2YXJpYWJsZSB0cmFja2luZyBzaXplIGxpbWl0IGV4Y2VlZGVkIHdpdGgg4oCYLWZ2YXIt
dHJhY2tpbmctYXNzaWdubWVudHPigJksIHJldHJ5aW5nIHdpdGhvdXQKMTI1MTQgfCBpbnQgbWFp
bihpbnQgYXJnYywgY2hhciAqYXJndltdKQogICAgICB8ICAgICBefn5+Cm1vbml0b3IvcGFja2V0
LmM6IEluIGZ1bmN0aW9uIOKAmGN1cnJlbnRfdmVuZG9yX2V2dOKAmToKbW9uaXRvci9wYWNrZXQu
Yzo5ODgxOjI1OiBlcnJvcjogdmFyaWFibGUg4oCYbXNmdF9vcGNvZGXigJkgc2V0IGJ1dCBub3Qg
dXNlZCBbLVdlcnJvcj11bnVzZWQtYnV0LXNldC12YXJpYWJsZV0KIDk4ODEgfCAgdWludDE2X3Qg
bWFudWZhY3R1cmVyLCBtc2Z0X29wY29kZTsKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAg
ICBefn5+fn5+fn5+fgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwpt
YWtlWzFdOiAqKiogW01ha2VmaWxlOjc0OTA6IG1vbml0b3IvcGFja2V0Lm9dIEVycm9yIDEKbWFr
ZVsxXTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KbWFrZTogKioqIFtNYWtl
ZmlsZTo0NDUwOiBhbGxdIEVycm9yIDIKCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMK
VGVzdDogTWFrZSBDaGVjayAtIEZBSUwKRGVzYzogUnVuICdtYWtlIGNoZWNrJwpPdXRwdXQ6Cm1v
bml0b3IvcGFja2V0LmM6IEluIGZ1bmN0aW9uIOKAmGN1cnJlbnRfdmVuZG9yX2V2dOKAmToKbW9u
aXRvci9wYWNrZXQuYzo5ODgxOjI1OiBlcnJvcjogdmFyaWFibGUg4oCYbXNmdF9vcGNvZGXigJkg
c2V0IGJ1dCBub3QgdXNlZCBbLVdlcnJvcj11bnVzZWQtYnV0LXNldC12YXJpYWJsZV0KIDk4ODEg
fCAgdWludDE2X3QgbWFudWZhY3R1cmVyLCBtc2Z0X29wY29kZTsKICAgICAgfCAgICAgICAgICAg
ICAgICAgICAgICAgICBefn5+fn5+fn5+fgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVk
IGFzIGVycm9ycwptYWtlWzFdOiAqKiogW01ha2VmaWxlOjc0OTA6IG1vbml0b3IvcGFja2V0Lm9d
IEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmlsZToxMTU4NzogY2hlY2tdIEVycm9yIDIKCgojIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogTWFrZSBDaGVjayB3L1ZhbGdyaW5kIC0g
RkFJTApEZXNjOiBSdW4gJ21ha2UgY2hlY2snIHdpdGggVmFsZ3JpbmQKT3V0cHV0Ogp0b29scy9t
Z210LXRlc3Rlci5jOiBJbiBmdW5jdGlvbiDigJhtYWlu4oCZOgp0b29scy9tZ210LXRlc3Rlci5j
OjEyNTE0OjU6IG5vdGU6IHZhcmlhYmxlIHRyYWNraW5nIHNpemUgbGltaXQgZXhjZWVkZWQgd2l0
aCDigJgtZnZhci10cmFja2luZy1hc3NpZ25tZW50c+KAmSwgcmV0cnlpbmcgd2l0aG91dAoxMjUx
NCB8IGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCiAgICAgIHwgICAgIF5+fn4KbW9u
aXRvci9wYWNrZXQuYzogSW4gZnVuY3Rpb24g4oCYY3VycmVudF92ZW5kb3JfZXZ04oCZOgptb25p
dG9yL3BhY2tldC5jOjk4ODE6MjU6IGVycm9yOiB2YXJpYWJsZSDigJhtc2Z0X29wY29kZeKAmSBz
ZXQgYnV0IG5vdCB1c2VkIFstV2Vycm9yPXVudXNlZC1idXQtc2V0LXZhcmlhYmxlXQogOTg4MSB8
ICB1aW50MTZfdCBtYW51ZmFjdHVyZXIsIG1zZnRfb3Bjb2RlOwogICAgICB8ICAgICAgICAgICAg
ICAgICAgICAgICAgIF5+fn5+fn5+fn5+CmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQg
YXMgZXJyb3JzCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6NzQ5MDogbW9uaXRvci9wYWNrZXQub10g
RXJyb3IgMQptYWtlWzFdOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgptYWtl
OiAqKiogW01ha2VmaWxlOjQ0NTA6IGFsbF0gRXJyb3IgMgoKCiMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIwpUZXN0OiBCdWlsZCB3L2V4dCBFTEwgLSBNYWtlIC0gRkFJTApEZXNjOiBCdWls
ZCBCbHVlWiBzb3VyY2Ugd2l0aCAnLS1lbmFibGUtZXh0ZXJuYWwtZWxsJyBjb25maWd1cmF0aW9u
Ck91dHB1dDoKbW9uaXRvci9wYWNrZXQuYzogSW4gZnVuY3Rpb24g4oCYY3VycmVudF92ZW5kb3Jf
ZXZ04oCZOgptb25pdG9yL3BhY2tldC5jOjk4ODE6MjU6IGVycm9yOiB2YXJpYWJsZSDigJhtc2Z0
X29wY29kZeKAmSBzZXQgYnV0IG5vdCB1c2VkIFstV2Vycm9yPXVudXNlZC1idXQtc2V0LXZhcmlh
YmxlXQogOTg4MSB8ICB1aW50MTZfdCBtYW51ZmFjdHVyZXIsIG1zZnRfb3Bjb2RlOwogICAgICB8
ICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+CmNjMTogYWxsIHdhcm5pbmdzIGJl
aW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6NzQ5MDogbW9uaXRv
ci9wYWNrZXQub10gRXJyb3IgMQptYWtlWzFdOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBq
b2JzLi4uLgptYWtlOiAqKiogW01ha2VmaWxlOjQ0NTA6IGFsbF0gRXJyb3IgMgoKCiMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBTY2FuIEJ1aWxkIC0gRkFJTApEZXNjOiBSdW4g
U2NhbiBCdWlsZCB3aXRoIHBhdGNoZXMKT3V0cHV0Ogptb25pdG9yL3BhY2tldC5jOiBJbiBmdW5j
dGlvbiDigJhjdXJyZW50X3ZlbmRvcl9ldnTigJk6Cm1vbml0b3IvcGFja2V0LmM6OTg4MToyNTog
ZXJyb3I6IHZhcmlhYmxlIOKAmG1zZnRfb3Bjb2Rl4oCZIHNldCBidXQgbm90IHVzZWQgWy1XZXJy
b3I9dW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdCiA5ODgxIHwgIHVpbnQxNl90IG1hbnVmYWN0dXJl
ciwgbXNmdF9vcGNvZGU7CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+
fn4KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsxXTogKioq
IFtNYWtlZmlsZTo3NDkwOiBtb25pdG9yL3BhY2tldC5vXSBFcnJvciAxCm1ha2U6ICoqKiBbTWFr
ZWZpbGU6NDQ1MDogYWxsXSBFcnJvciAyCgoKCgotLS0KUmVnYXJkcywKTGludXggQmx1ZXRvb3Ro
Cgo=

--===============4686177761020392431==--

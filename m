Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3F9C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Dec 2021 01:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhLUBxG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Dec 2021 20:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhLUBxF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Dec 2021 20:53:05 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A835EC061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Dec 2021 17:53:05 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id j13so27217plx.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Dec 2021 17:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Tvzj18j+SpRQuWSieOp2Sh0bcV/dmsIF6sVT/QlbLiY=;
        b=nNGt5k7A9IM3xnTAod/+8phpCLutFemcUexhFyN40Tulf7bTILqAWjv81cZWIlYRes
         +RthPjdVQSCigZ/NVQq5sh3y0fCd4nYS/MN43/f8zwUIyDFKSHuJ11S8wq0QVX2pKlwq
         /RBdIhwS2NB0otOUtdDZM/Soj0+EM4CnZ0u0xZfJECH6n6f8Fjc+Jo+eZOuZ2y87jlI3
         nPQ7H4QUThn7j01G5L0mAY63+H8yKnDqqWOKWUyL+NL/jgQ0enGFZngAsvsS2tiYcH+k
         QNVQNX3XvJOOvE+l0fwxf6eCXUY1zcwIV2sBgxJpT/TsRsAz0hqpHiPxeIEz42XuBxwM
         iRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Tvzj18j+SpRQuWSieOp2Sh0bcV/dmsIF6sVT/QlbLiY=;
        b=NAzck5o2M/nU8LXwEz5w0xyISLbOUr8Uf4SnmvicW2d28RBxFJkFMVZQIUORnL4vzJ
         lyHWlVTsEO7/4izkCv37vs7RevGnZdWMYRJBKAuOWI7IIo/parwTLp1w8GciwAsQy1hK
         +GV1iHgIMpzgLa90xVdivYSoxEGmyqBvl0eetFabp7xWGxS7YQPYEO8PTPImDptLz79x
         Z3u09uI4h5qniqcf5iaW3yaF4VzdmQjLEXGlz2SUr2eZ7Byq9E0WZAuyrNkMAAzSLo+R
         4GtgaIQJ/FPiTPBa75g+9jqge9AKCaGsGlqmfdBxEYxDsEs3h3UyirHjscahDKCwqDhn
         +FUQ==
X-Gm-Message-State: AOAM532ITUwfjE/4zB4z+Fnfk4GsudctdiGl4WXKMbmJ0ovYLew9Iape
        EQHEvSHeaBZgt9MS3qqB9TaAGRNidf0=
X-Google-Smtp-Source: ABdhPJwn80eK/E+asCXFHLvHs4f1rCnBkGVuaAxL+dlscpuId6kU9WUnY24dglwgtZj913GkIBKRGQ==
X-Received: by 2002:a17:902:da8e:b0:148:a2f7:9d40 with SMTP id j14-20020a170902da8e00b00148a2f79d40mr699050plx.95.1640051584615;
        Mon, 20 Dec 2021 17:53:04 -0800 (PST)
Received: from [172.17.0.2] ([20.112.111.159])
        by smtp.gmail.com with ESMTPSA id d23sm18263693pgm.37.2021.12.20.17.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 17:53:04 -0800 (PST)
Message-ID: <61c13380.1c69fb81.22395.3916@mx.google.com>
Date:   Mon, 20 Dec 2021 17:53:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4025319542515489087=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/3] build: Add sanitizer options
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211220235924.349373-1-luiz.dentz@gmail.com>
References: <20211220235924.349373-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4025319542515489087==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NTk4NTM5CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMS41MSBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjk0IHNlY29uZHMKUHJlcCAtIFNldHVwIEVMTCAgICAgICAgICAgICAgUEFTUyAg
ICAgIDUzLjAxIHNlY29uZHMKQnVpbGQgLSBQcmVwICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDAuNDQgc2Vjb25kcwpCdWlsZCAtIENvbmZpZ3VyZSAgICAgICAgICAgICBQQVNTICAgICAgMTAu
NDQgc2Vjb25kcwpCdWlsZCAtIE1ha2UgICAgICAgICAgICAgICAgICBGQUlMICAgICAgMzAwLjQy
IHNlY29uZHMKTWFrZSBDaGVjayAgICAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDAuOTMgc2Vj
b25kcwpNYWtlIERpc3RjaGVjayAgICAgICAgICAgICAgICBQQVNTICAgICAgMzAzLjI3IHNlY29u
ZHMKQnVpbGQgdy9leHQgRUxMIC0gQ29uZmlndXJlICAgUEFTUyAgICAgIDEwLjYzIHNlY29uZHMK
QnVpbGQgdy9leHQgRUxMIC0gTWFrZSAgICAgICAgRkFJTCAgICAgIDI3MC4wOSBzZWNvbmRzCklu
Y3JlbWVudGFsIEJ1aWxkIHdpdGggcGF0Y2hlc0ZBSUwgICAgICA4NjIuNzkgc2Vjb25kcwoKRGV0
YWlscwojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQnVpbGQgLSBNYWtlIC0g
RkFJTApEZXNjOiBCdWlsZCB0aGUgQmx1ZVogc291cmNlIHRyZWUKT3V0cHV0Ogp0b29scy9tZ210
LXRlc3Rlci5jOiBJbiBmdW5jdGlvbiDigJhtYWlu4oCZOgp0b29scy9tZ210LXRlc3Rlci5jOjEy
MzY0OjU6IG5vdGU6IHZhcmlhYmxlIHRyYWNraW5nIHNpemUgbGltaXQgZXhjZWVkZWQgd2l0aCDi
gJgtZnZhci10cmFja2luZy1hc3NpZ25tZW50c+KAmSwgcmV0cnlpbmcgd2l0aG91dAoxMjM2NCB8
IGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCiAgICAgIHwgICAgIF5+fn4KSW4gZmls
ZSBpbmNsdWRlZCBmcm9tIC91c3IvaW5jbHVkZS9zdHJpbmcuaDo0OTUsCiAgICAgICAgICAgICAg
ICAgZnJvbSAvdXNyL2luY2x1ZGUvZ2xpYi0yLjAvZ2xpYi9ndGVzdHV0aWxzLmg6MzAsCiAgICAg
ICAgICAgICAgICAgZnJvbSAvdXNyL2luY2x1ZGUvZ2xpYi0yLjAvZ2xpYi5oOjg1LAogICAgICAg
ICAgICAgICAgIGZyb20gcHJvZmlsZXMvbmV0d29yay9ibmVwLmM6Mjc6CkluIGZ1bmN0aW9uIOKA
mHN0cm5jcHnigJksCiAgICBpbmxpbmVkIGZyb20g4oCYYm5lcF9jb25uYWRk4oCZIGF0IHByb2Zp
bGVzL25ldHdvcmsvYm5lcC5jOjExMToyOgovdXNyL2luY2x1ZGUveDg2XzY0LWxpbnV4LWdudS9i
aXRzL3N0cmluZ19mb3J0aWZpZWQuaDoxMDY6MTA6IGVycm9yOiDigJhfX2J1aWx0aW5fc3RybmNw
eeKAmSBzcGVjaWZpZWQgYm91bmQgMTYgZXF1YWxzIGRlc3RpbmF0aW9uIHNpemUgWy1XZXJyb3I9
c3RyaW5nb3AtdHJ1bmNhdGlvbl0KICAxMDYgfCAgIHJldHVybiBfX2J1aWx0aW5fX19zdHJuY3B5
X2NoayAoX19kZXN0LCBfX3NyYywgX19sZW4sIF9fYm9zIChfX2Rlc3QpKTsKICAgICAgfCAgICAg
ICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fgovdXNyL2luY2x1ZGUveDg2XzY0LWxpbnV4LWdudS9iaXRzL3N0cmluZ19mb3J0
aWZpZWQuaDoxMDY6MTA6IGVycm9yOiDigJhfX2J1aWx0aW5fc3RybmNweeKAmSBzcGVjaWZpZWQg
Ym91bmQgMTYgZXF1YWxzIGRlc3RpbmF0aW9uIHNpemUgWy1XZXJyb3I9c3RyaW5nb3AtdHJ1bmNh
dGlvbl0KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsxXTog
KioqIFtNYWtlZmlsZTo3MjcxOiBwcm9maWxlcy9uZXR3b3JrL2JuZXAub10gRXJyb3IgMQptYWtl
OiAqKiogW01ha2VmaWxlOjQzMDE6IGFsbF0gRXJyb3IgMgoKCiMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIwpUZXN0OiBNYWtlIENoZWNrIC0gRkFJTApEZXNjOiBSdW4gJ21ha2UgY2hlY2sn
Ck91dHB1dDoKSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC91c3IvaW5jbHVkZS9zdHJpbmcuaDo0OTUs
CiAgICAgICAgICAgICAgICAgZnJvbSAvdXNyL2luY2x1ZGUvZ2xpYi0yLjAvZ2xpYi9ndGVzdHV0
aWxzLmg6MzAsCiAgICAgICAgICAgICAgICAgZnJvbSAvdXNyL2luY2x1ZGUvZ2xpYi0yLjAvZ2xp
Yi5oOjg1LAogICAgICAgICAgICAgICAgIGZyb20gcHJvZmlsZXMvbmV0d29yay9ibmVwLmM6Mjc6
CkluIGZ1bmN0aW9uIOKAmHN0cm5jcHnigJksCiAgICBpbmxpbmVkIGZyb20g4oCYYm5lcF9jb25u
YWRk4oCZIGF0IHByb2ZpbGVzL25ldHdvcmsvYm5lcC5jOjExMToyOgovdXNyL2luY2x1ZGUveDg2
XzY0LWxpbnV4LWdudS9iaXRzL3N0cmluZ19mb3J0aWZpZWQuaDoxMDY6MTA6IGVycm9yOiDigJhf
X2J1aWx0aW5fc3RybmNweeKAmSBzcGVjaWZpZWQgYm91bmQgMTYgZXF1YWxzIGRlc3RpbmF0aW9u
IHNpemUgWy1XZXJyb3I9c3RyaW5nb3AtdHJ1bmNhdGlvbl0KICAxMDYgfCAgIHJldHVybiBfX2J1
aWx0aW5fX19zdHJuY3B5X2NoayAoX19kZXN0LCBfX3NyYywgX19sZW4sIF9fYm9zIChfX2Rlc3Qp
KTsKICAgICAgfCAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgovdXNyL2luY2x1ZGUveDg2XzY0LWxpbnV4LWdudS9i
aXRzL3N0cmluZ19mb3J0aWZpZWQuaDoxMDY6MTA6IGVycm9yOiDigJhfX2J1aWx0aW5fc3RybmNw
eeKAmSBzcGVjaWZpZWQgYm91bmQgMTYgZXF1YWxzIGRlc3RpbmF0aW9uIHNpemUgWy1XZXJyb3I9
c3RyaW5nb3AtdHJ1bmNhdGlvbl0KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBl
cnJvcnMKbWFrZVsxXTogKioqIFtNYWtlZmlsZTo3MjcxOiBwcm9maWxlcy9uZXR3b3JrL2JuZXAu
b10gRXJyb3IgMQptYWtlOiAqKiogW01ha2VmaWxlOjExMzA1OiBjaGVja10gRXJyb3IgMgoKCiMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBCdWlsZCB3L2V4dCBFTEwgLSBNYWtl
IC0gRkFJTApEZXNjOiBCdWlsZCBCbHVlWiBzb3VyY2Ugd2l0aCAnLS1lbmFibGUtZXh0ZXJuYWwt
ZWxsJyBjb25maWd1cmF0aW9uCk91dHB1dDoKdG9vbHMvbWdtdC10ZXN0ZXIuYzogSW4gZnVuY3Rp
b24g4oCYbWFpbuKAmToKdG9vbHMvbWdtdC10ZXN0ZXIuYzoxMjM2NDo1OiBub3RlOiB2YXJpYWJs
ZSB0cmFja2luZyBzaXplIGxpbWl0IGV4Y2VlZGVkIHdpdGgg4oCYLWZ2YXItdHJhY2tpbmctYXNz
aWdubWVudHPigJksIHJldHJ5aW5nIHdpdGhvdXQKMTIzNjQgfCBpbnQgbWFpbihpbnQgYXJnYywg
Y2hhciAqYXJndltdKQogICAgICB8ICAgICBefn5+CkluIGZpbGUgaW5jbHVkZWQgZnJvbSAvdXNy
L2luY2x1ZGUvc3RyaW5nLmg6NDk1LAogICAgICAgICAgICAgICAgIGZyb20gL3Vzci9pbmNsdWRl
L2dsaWItMi4wL2dsaWIvZ3Rlc3R1dGlscy5oOjMwLAogICAgICAgICAgICAgICAgIGZyb20gL3Vz
ci9pbmNsdWRlL2dsaWItMi4wL2dsaWIuaDo4NSwKICAgICAgICAgICAgICAgICBmcm9tIHByb2Zp
bGVzL25ldHdvcmsvYm5lcC5jOjI3OgpJbiBmdW5jdGlvbiDigJhzdHJuY3B54oCZLAogICAgaW5s
aW5lZCBmcm9tIOKAmGJuZXBfY29ubmFkZOKAmSBhdCBwcm9maWxlcy9uZXR3b3JrL2JuZXAuYzox
MTE6MjoKL3Vzci9pbmNsdWRlL3g4Nl82NC1saW51eC1nbnUvYml0cy9zdHJpbmdfZm9ydGlmaWVk
Lmg6MTA2OjEwOiBlcnJvcjog4oCYX19idWlsdGluX3N0cm5jcHnigJkgc3BlY2lmaWVkIGJvdW5k
IDE2IGVxdWFscyBkZXN0aW5hdGlvbiBzaXplIFstV2Vycm9yPXN0cmluZ29wLXRydW5jYXRpb25d
CiAgMTA2IHwgICByZXR1cm4gX19idWlsdGluX19fc3RybmNweV9jaGsgKF9fZGVzdCwgX19zcmMs
IF9fbGVuLCBfX2JvcyAoX19kZXN0KSk7CiAgICAgIHwgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KL3Vzci9pbmNs
dWRlL3g4Nl82NC1saW51eC1nbnUvYml0cy9zdHJpbmdfZm9ydGlmaWVkLmg6MTA2OjEwOiBlcnJv
cjog4oCYX19idWlsdGluX3N0cm5jcHnigJkgc3BlY2lmaWVkIGJvdW5kIDE2IGVxdWFscyBkZXN0
aW5hdGlvbiBzaXplIFstV2Vycm9yPXN0cmluZ29wLXRydW5jYXRpb25dCmNjMTogYWxsIHdhcm5p
bmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6NzI3MTog
cHJvZmlsZXMvbmV0d29yay9ibmVwLm9dIEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmlsZTo0MzAx
OiBhbGxdIEVycm9yIDIKCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogSW5j
cmVtZW50YWwgQnVpbGQgd2l0aCBwYXRjaGVzIC0gRkFJTApEZXNjOiBJbmNyZW1lbnRhbCBidWls
ZCBwZXIgcGF0Y2ggaW4gdGhlIHNlcmllcwpPdXRwdXQ6CnRvb2xzL21nbXQtdGVzdGVyLmM6IElu
IGZ1bmN0aW9uIOKAmG1haW7igJk6CnRvb2xzL21nbXQtdGVzdGVyLmM6MTIzNjQ6NTogbm90ZTog
dmFyaWFibGUgdHJhY2tpbmcgc2l6ZSBsaW1pdCBleGNlZWRlZCB3aXRoIOKAmC1mdmFyLXRyYWNr
aW5nLWFzc2lnbm1lbnRz4oCZLCByZXRyeWluZyB3aXRob3V0CjEyMzY0IHwgaW50IG1haW4oaW50
IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKICAgICAgfCAgICAgXn5+fgpJbiBmaWxlIGluY2x1ZGVkIGZy
b20gL3Vzci9pbmNsdWRlL3N0cmluZy5oOjQ5NSwKICAgICAgICAgICAgICAgICBmcm9tIC91c3Iv
aW5jbHVkZS9nbGliLTIuMC9nbGliL2d0ZXN0dXRpbHMuaDozMCwKICAgICAgICAgICAgICAgICBm
cm9tIC91c3IvaW5jbHVkZS9nbGliLTIuMC9nbGliLmg6ODUsCiAgICAgICAgICAgICAgICAgZnJv
bSBwcm9maWxlcy9uZXR3b3JrL2JuZXAuYzoyNzoKSW4gZnVuY3Rpb24g4oCYc3RybmNweeKAmSwK
ICAgIGlubGluZWQgZnJvbSDigJhibmVwX2Nvbm5hZGTigJkgYXQgcHJvZmlsZXMvbmV0d29yay9i
bmVwLmM6MTExOjI6Ci91c3IvaW5jbHVkZS94ODZfNjQtbGludXgtZ251L2JpdHMvc3RyaW5nX2Zv
cnRpZmllZC5oOjEwNjoxMDogZXJyb3I6IOKAmF9fYnVpbHRpbl9zdHJuY3B54oCZIHNwZWNpZmll
ZCBib3VuZCAxNiBlcXVhbHMgZGVzdGluYXRpb24gc2l6ZSBbLVdlcnJvcj1zdHJpbmdvcC10cnVu
Y2F0aW9uXQogIDEwNiB8ICAgcmV0dXJuIF9fYnVpbHRpbl9fX3N0cm5jcHlfY2hrIChfX2Rlc3Qs
IF9fc3JjLCBfX2xlbiwgX19ib3MgKF9fZGVzdCkpOwogICAgICB8ICAgICAgICAgIF5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+Ci91
c3IvaW5jbHVkZS94ODZfNjQtbGludXgtZ251L2JpdHMvc3RyaW5nX2ZvcnRpZmllZC5oOjEwNjox
MDogZXJyb3I6IOKAmF9fYnVpbHRpbl9zdHJuY3B54oCZIHNwZWNpZmllZCBib3VuZCAxNiBlcXVh
bHMgZGVzdGluYXRpb24gc2l6ZSBbLVdlcnJvcj1zdHJpbmdvcC10cnVuY2F0aW9uXQpjYzE6IGFs
bCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiogW01ha2VmaWxl
OjcyNzE6IHByb2ZpbGVzL25ldHdvcmsvYm5lcC5vXSBFcnJvciAxCm1ha2U6ICoqKiBbTWFrZWZp
bGU6NDMwMTogYWxsXSBFcnJvciAyCgoKCgotLS0KUmVnYXJkcywKTGludXggQmx1ZXRvb3RoCgo=

--===============4025319542515489087==--

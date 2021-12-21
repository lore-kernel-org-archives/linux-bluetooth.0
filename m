Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF910C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Dec 2021 22:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhLUWkX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Dec 2021 17:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhLUWkW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Dec 2021 17:40:22 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5E8C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Dec 2021 14:40:22 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id a11so501340qkh.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Dec 2021 14:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=6Ro6WRQzWKiOYKGXw8Wyi1zp6UJaadP5xc+LEhnx/U4=;
        b=BtWEiliGF70vCBDW6pi+eVexeqjDQHi2gl8kDFltunyB3BzQrxpeFD18ee6/RpNnMk
         jBZGFV8jI/0L971AdgilSGBgruNFf1EWlJjXBZmIl51yyUuVElMBHEYIQZi5331llfA6
         WXKsNOmRK0StKAzGTy7Vw4RkiYvXN+Hna1ABCWzv8ESHrBPMzkrt5hkDpeSRgGlCF1tg
         UXqaRFkqfYCI89j9HweX3FNNxe4LaC+Jur3tHKbWTzN7tIVt8shOcRmoMyu0i98cH827
         wGPr02iBnGEpQbsL900HU7sDgQDBxGBmsWECzQR0z+ZR6qrUm84XkPBKqeXqM/tz52rS
         Ztog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=6Ro6WRQzWKiOYKGXw8Wyi1zp6UJaadP5xc+LEhnx/U4=;
        b=muI7HWtuZbvMXgVy+SS9V4ABPL1l4vKwFRd6WHDBQxfHsMRv843TFNAgiLJT6+Polx
         qePTpStIhSQxaezVF55A/F5il/UDQOWc2Xg/IqwLGMadq0YzU0ZdrNi8JeFkEW5JV6zz
         C3yAOnRLLuZ2XatzhK+PiEDDayCTcJGzj5cSh2nCvx1286Bqx5hbo86L9aD59JinDhI9
         fea3GNjPq3piFkewc771TDc07jWtZzyKkGe5dWLGK5exQXbNMM2w5ogcaEudlUmsYkRr
         Kw0CqHs7EECo5EnKb0x3RELj6sSSXwXAyVSEIGMFLFWIz1Lr5TY2eYvL4SABJyWIi7Ku
         ycQg==
X-Gm-Message-State: AOAM5339ZTlB7AYhZO3wvoOMdzrQSsieEkXWA1Ad7l2YD6oI+ru0Sdz5
        STzAbVCxTIS2s9ylsCjBjzwmu9sQwj2nRw==
X-Google-Smtp-Source: ABdhPJwHQW8qeIr0iWyWAXN6W+XDH7f4eJCA25wrZvKTsaeyuprm4yO61qjaRRy1xB8pyyveD09sPw==
X-Received: by 2002:ae9:e905:: with SMTP id x5mr390581qkf.468.1640126421423;
        Tue, 21 Dec 2021 14:40:21 -0800 (PST)
Received: from [172.17.0.2] ([20.65.123.166])
        by smtp.gmail.com with ESMTPSA id x17sm228066qta.66.2021.12.21.14.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 14:40:21 -0800 (PST)
Message-ID: <61c257d5.1c69fb81.5f2cc.15dc@mx.google.com>
Date:   Tue, 21 Dec 2021 14:40:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0240413726983578947=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/4] build: Add sanitizer options
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211221205019.654432-1-luiz.dentz@gmail.com>
References: <20211221205019.654432-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0240413726983578947==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NTk5MDE1CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgNS41OSBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAzLjc4IHNlY29uZHMKUHJlcCAtIFNldHVwIEVMTCAgICAgICAgICAgICAgUEFTUyAg
ICAgIDQzLjYzIHNlY29uZHMKQnVpbGQgLSBQcmVwICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDAuNTkgc2Vjb25kcwpCdWlsZCAtIENvbmZpZ3VyZSAgICAgICAgICAgICBQQVNTICAgICAgOC42
NCBzZWNvbmRzCkJ1aWxkIC0gTWFrZSAgICAgICAgICAgICAgICAgIEZBSUwgICAgICAxMzYwLjY0
IHNlY29uZHMKTWFrZSBDaGVjayAgICAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDIuMjYgc2Vj
b25kcwpNYWtlIERpc3RjaGVjayAgICAgICAgICAgICAgICBQQVNTICAgICAgMjMzLjY3IHNlY29u
ZHMKQnVpbGQgdy9leHQgRUxMIC0gQ29uZmlndXJlICAgUEFTUyAgICAgIDguNzQgc2Vjb25kcwpC
dWlsZCB3L2V4dCBFTEwgLSBNYWtlICAgICAgICBGQUlMICAgICAgMTM1MS42NSBzZWNvbmRzCklu
Y3JlbWVudGFsIEJ1aWxkIHdpdGggcGF0Y2hlc0ZBSUwgICAgICAxNjI5LjM0IHNlY29uZHMKCkRl
dGFpbHMKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEJ1aWxkIC0gTWFrZSAt
IEZBSUwKRGVzYzogQnVpbGQgdGhlIEJsdWVaIHNvdXJjZSB0cmVlCk91dHB1dDoKdW5pdC90ZXN0
LWF2ZHRwLmM6IEluIGZ1bmN0aW9uIOKAmG1haW7igJk6CnVuaXQvdGVzdC1hdmR0cC5jOjc2Njo1
OiBub3RlOiB2YXJpYWJsZSB0cmFja2luZyBzaXplIGxpbWl0IGV4Y2VlZGVkIHdpdGgg4oCYLWZ2
YXItdHJhY2tpbmctYXNzaWdubWVudHPigJksIHJldHJ5aW5nIHdpdGhvdXQKICA3NjYgfCBpbnQg
bWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQogICAgICB8ICAgICBefn5+CnVuaXQvdGVzdC1h
dnJjcC5jOiBJbiBmdW5jdGlvbiDigJhtYWlu4oCZOgp1bml0L3Rlc3QtYXZyY3AuYzo5ODk6NTog
bm90ZTogdmFyaWFibGUgdHJhY2tpbmcgc2l6ZSBsaW1pdCBleGNlZWRlZCB3aXRoIOKAmC1mdmFy
LXRyYWNraW5nLWFzc2lnbm1lbnRz4oCZLCByZXRyeWluZyB3aXRob3V0CiAgOTg5IHwgaW50IG1h
aW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKICAgICAgfCAgICAgXn5+fgpJbiBmaWxlIGluY2x1
ZGVkIGZyb20gL3Vzci9pbmNsdWRlL3N0cmluZy5oOjQ5NSwKICAgICAgICAgICAgICAgICBmcm9t
IC91c3IvaW5jbHVkZS9nbGliLTIuMC9nbGliL2d0ZXN0dXRpbHMuaDozMCwKICAgICAgICAgICAg
ICAgICBmcm9tIC91c3IvaW5jbHVkZS9nbGliLTIuMC9nbGliLmg6ODUsCiAgICAgICAgICAgICAg
ICAgZnJvbSBwcm9maWxlcy9hdWRpby9hdmN0cC5jOjMwOgpJbiBmdW5jdGlvbiDigJhzdHJuY3B5
4oCZLAogICAgaW5saW5lZCBmcm9tIOKAmHVpbnB1dF9jcmVhdGUuY29uc3Rwcm9w4oCZIGF0IHBy
b2ZpbGVzL2F1ZGlvL2F2Y3RwLmM6MTE4MDozOgovdXNyL2luY2x1ZGUveDg2XzY0LWxpbnV4LWdu
dS9iaXRzL3N0cmluZ19mb3J0aWZpZWQuaDoxMDY6MTA6IGVycm9yOiDigJhfX2J1aWx0aW5fc3Ry
bmNweeKAmSBzcGVjaWZpZWQgYm91bmQgODAgZXF1YWxzIGRlc3RpbmF0aW9uIHNpemUgWy1XZXJy
b3I9c3RyaW5nb3AtdHJ1bmNhdGlvbl0KICAxMDYgfCAgIHJldHVybiBfX2J1aWx0aW5fX19zdHJu
Y3B5X2NoayAoX19kZXN0LCBfX3NyYywgX19sZW4sIF9fYm9zIChfX2Rlc3QpKTsKICAgICAgfCAg
ICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwpt
YWtlWzFdOiAqKiogW01ha2VmaWxlOjk1MzA6IHByb2ZpbGVzL2F1ZGlvL2JsdWV0b290aGQtYXZj
dHAub10gRXJyb3IgMQptYWtlOiAqKiogW01ha2VmaWxlOjQzMTY6IGFsbF0gRXJyb3IgMgoKCiMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBNYWtlIENoZWNrIC0gRkFJTApEZXNj
OiBSdW4gJ21ha2UgY2hlY2snCk91dHB1dDoKSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC91c3IvaW5j
bHVkZS9zdHJpbmcuaDo0OTUsCiAgICAgICAgICAgICAgICAgZnJvbSAvdXNyL2luY2x1ZGUvZ2xp
Yi0yLjAvZ2xpYi9ndGVzdHV0aWxzLmg6MzAsCiAgICAgICAgICAgICAgICAgZnJvbSAvdXNyL2lu
Y2x1ZGUvZ2xpYi0yLjAvZ2xpYi5oOjg1LAogICAgICAgICAgICAgICAgIGZyb20gcHJvZmlsZXMv
YXVkaW8vYXZjdHAuYzozMDoKSW4gZnVuY3Rpb24g4oCYc3RybmNweeKAmSwKICAgIGlubGluZWQg
ZnJvbSDigJh1aW5wdXRfY3JlYXRlLmNvbnN0cHJvcOKAmSBhdCBwcm9maWxlcy9hdWRpby9hdmN0
cC5jOjExODA6MzoKL3Vzci9pbmNsdWRlL3g4Nl82NC1saW51eC1nbnUvYml0cy9zdHJpbmdfZm9y
dGlmaWVkLmg6MTA2OjEwOiBlcnJvcjog4oCYX19idWlsdGluX3N0cm5jcHnigJkgc3BlY2lmaWVk
IGJvdW5kIDgwIGVxdWFscyBkZXN0aW5hdGlvbiBzaXplIFstV2Vycm9yPXN0cmluZ29wLXRydW5j
YXRpb25dCiAgMTA2IHwgICByZXR1cm4gX19idWlsdGluX19fc3RybmNweV9jaGsgKF9fZGVzdCwg
X19zcmMsIF9fbGVuLCBfX2JvcyAoX19kZXN0KSk7CiAgICAgIHwgICAgICAgICAgXn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KY2Mx
OiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsxXTogKioqIFtNYWtl
ZmlsZTo5NTMwOiBwcm9maWxlcy9hdWRpby9ibHVldG9vdGhkLWF2Y3RwLm9dIEVycm9yIDEKbWFr
ZTogKioqIFtNYWtlZmlsZToxMTQxOTogY2hlY2tdIEVycm9yIDIKCgojIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMKVGVzdDogQnVpbGQgdy9leHQgRUxMIC0gTWFrZSAtIEZBSUwKRGVzYzog
QnVpbGQgQmx1ZVogc291cmNlIHdpdGggJy0tZW5hYmxlLWV4dGVybmFsLWVsbCcgY29uZmlndXJh
dGlvbgpPdXRwdXQ6CnVuaXQvdGVzdC1hdmR0cC5jOiBJbiBmdW5jdGlvbiDigJhtYWlu4oCZOgp1
bml0L3Rlc3QtYXZkdHAuYzo3NjY6NTogbm90ZTogdmFyaWFibGUgdHJhY2tpbmcgc2l6ZSBsaW1p
dCBleGNlZWRlZCB3aXRoIOKAmC1mdmFyLXRyYWNraW5nLWFzc2lnbm1lbnRz4oCZLCByZXRyeWlu
ZyB3aXRob3V0CiAgNzY2IHwgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKICAgICAg
fCAgICAgXn5+fgp1bml0L3Rlc3QtYXZyY3AuYzogSW4gZnVuY3Rpb24g4oCYbWFpbuKAmToKdW5p
dC90ZXN0LWF2cmNwLmM6OTg5OjU6IG5vdGU6IHZhcmlhYmxlIHRyYWNraW5nIHNpemUgbGltaXQg
ZXhjZWVkZWQgd2l0aCDigJgtZnZhci10cmFja2luZy1hc3NpZ25tZW50c+KAmSwgcmV0cnlpbmcg
d2l0aG91dAogIDk4OSB8IGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCiAgICAgIHwg
ICAgIF5+fn4KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC91c3IvaW5jbHVkZS9zdHJpbmcuaDo0OTUs
CiAgICAgICAgICAgICAgICAgZnJvbSAvdXNyL2luY2x1ZGUvZ2xpYi0yLjAvZ2xpYi9ndGVzdHV0
aWxzLmg6MzAsCiAgICAgICAgICAgICAgICAgZnJvbSAvdXNyL2luY2x1ZGUvZ2xpYi0yLjAvZ2xp
Yi5oOjg1LAogICAgICAgICAgICAgICAgIGZyb20gcHJvZmlsZXMvYXVkaW8vYXZjdHAuYzozMDoK
SW4gZnVuY3Rpb24g4oCYc3RybmNweeKAmSwKICAgIGlubGluZWQgZnJvbSDigJh1aW5wdXRfY3Jl
YXRlLmNvbnN0cHJvcOKAmSBhdCBwcm9maWxlcy9hdWRpby9hdmN0cC5jOjExODA6MzoKL3Vzci9p
bmNsdWRlL3g4Nl82NC1saW51eC1nbnUvYml0cy9zdHJpbmdfZm9ydGlmaWVkLmg6MTA2OjEwOiBl
cnJvcjog4oCYX19idWlsdGluX3N0cm5jcHnigJkgc3BlY2lmaWVkIGJvdW5kIDgwIGVxdWFscyBk
ZXN0aW5hdGlvbiBzaXplIFstV2Vycm9yPXN0cmluZ29wLXRydW5jYXRpb25dCiAgMTA2IHwgICBy
ZXR1cm4gX19idWlsdGluX19fc3RybmNweV9jaGsgKF9fZGVzdCwgX19zcmMsIF9fbGVuLCBfX2Jv
cyAoX19kZXN0KSk7CiAgICAgIHwgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KY2MxOiBhbGwgd2FybmluZ3MgYmVp
bmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsxXTogKioqIFtNYWtlZmlsZTo5NTMwOiBwcm9maWxl
cy9hdWRpby9ibHVldG9vdGhkLWF2Y3RwLm9dIEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmlsZTo0
MzE2OiBhbGxdIEVycm9yIDIKCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDog
SW5jcmVtZW50YWwgQnVpbGQgd2l0aCBwYXRjaGVzIC0gRkFJTApEZXNjOiBJbmNyZW1lbnRhbCBi
dWlsZCBwZXIgcGF0Y2ggaW4gdGhlIHNlcmllcwpPdXRwdXQ6CnVuaXQvdGVzdC1hdmR0cC5jOiBJ
biBmdW5jdGlvbiDigJhtYWlu4oCZOgp1bml0L3Rlc3QtYXZkdHAuYzo3NjY6NTogbm90ZTogdmFy
aWFibGUgdHJhY2tpbmcgc2l6ZSBsaW1pdCBleGNlZWRlZCB3aXRoIOKAmC1mdmFyLXRyYWNraW5n
LWFzc2lnbm1lbnRz4oCZLCByZXRyeWluZyB3aXRob3V0CiAgNzY2IHwgaW50IG1haW4oaW50IGFy
Z2MsIGNoYXIgKmFyZ3ZbXSkKICAgICAgfCAgICAgXn5+fgp1bml0L3Rlc3QtYXZyY3AuYzogSW4g
ZnVuY3Rpb24g4oCYbWFpbuKAmToKdW5pdC90ZXN0LWF2cmNwLmM6OTg5OjU6IG5vdGU6IHZhcmlh
YmxlIHRyYWNraW5nIHNpemUgbGltaXQgZXhjZWVkZWQgd2l0aCDigJgtZnZhci10cmFja2luZy1h
c3NpZ25tZW50c+KAmSwgcmV0cnlpbmcgd2l0aG91dAogIDk4OSB8IGludCBtYWluKGludCBhcmdj
LCBjaGFyICphcmd2W10pCiAgICAgIHwgICAgIF5+fn4KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC91
c3IvaW5jbHVkZS9zdHJpbmcuaDo0OTUsCiAgICAgICAgICAgICAgICAgZnJvbSAvdXNyL2luY2x1
ZGUvZ2xpYi0yLjAvZ2xpYi9ndGVzdHV0aWxzLmg6MzAsCiAgICAgICAgICAgICAgICAgZnJvbSAv
dXNyL2luY2x1ZGUvZ2xpYi0yLjAvZ2xpYi5oOjg1LAogICAgICAgICAgICAgICAgIGZyb20gcHJv
ZmlsZXMvYXVkaW8vYXZjdHAuYzozMDoKSW4gZnVuY3Rpb24g4oCYc3RybmNweeKAmSwKICAgIGlu
bGluZWQgZnJvbSDigJh1aW5wdXRfY3JlYXRlLmNvbnN0cHJvcOKAmSBhdCBwcm9maWxlcy9hdWRp
by9hdmN0cC5jOjExODA6MzoKL3Vzci9pbmNsdWRlL3g4Nl82NC1saW51eC1nbnUvYml0cy9zdHJp
bmdfZm9ydGlmaWVkLmg6MTA2OjEwOiBlcnJvcjog4oCYX19idWlsdGluX3N0cm5jcHnigJkgc3Bl
Y2lmaWVkIGJvdW5kIDgwIGVxdWFscyBkZXN0aW5hdGlvbiBzaXplIFstV2Vycm9yPXN0cmluZ29w
LXRydW5jYXRpb25dCiAgMTA2IHwgICByZXR1cm4gX19idWlsdGluX19fc3RybmNweV9jaGsgKF9f
ZGVzdCwgX19zcmMsIF9fbGVuLCBfX2JvcyAoX19kZXN0KSk7CiAgICAgIHwgICAgICAgICAgXn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn4KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsxXTogKioq
IFtNYWtlZmlsZTo5NTMwOiBwcm9maWxlcy9hdWRpby9ibHVldG9vdGhkLWF2Y3RwLm9dIEVycm9y
IDEKbWFrZTogKioqIFtNYWtlZmlsZTo0MzE2OiBhbGxdIEVycm9yIDIKCgoKCi0tLQpSZWdhcmRz
LApMaW51eCBCbHVldG9vdGgKCg==

--===============0240413726983578947==--

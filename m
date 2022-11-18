Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221EDC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 03:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240254AbiKRDrr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Nov 2022 22:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiKRDrq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Nov 2022 22:47:46 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3AE8F3D3
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 19:47:45 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-13ae8117023so4591155fac.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 19:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aiWdzT26A1RddVyS6Ep46YDDINA7VJAiM+5UPEkwT9w=;
        b=f7kPsHPkPUgfVWVYPTMMffWGmIxlkqbwC7u384Vvb51N8tFMJYHeGzSFenCLPyifOI
         J7YXWrAYNu0x+U1bNd2vuT2G0yyxq+6Wg0cIRikEtpd5CX3pJ5TjRTOU9vbqTIzsO0yb
         VfqXnN6oCgFfy8eqQIYBl7iIqKq9qv7m2scRxpS3ym6x0qXyO9MM911HamnzYAvQjODc
         IymCSBArNKdzLBAPpV/9NgRO+RimnXPQEy5pD5JUGB795I7qB2C6jm27WWtIx7PaLQbe
         1LbMU3cL49g51KLJu3F5W6Tx3K/8tzzjtAY72D19lWQhu+8VDxFBoIoo/L5ePV2m4y01
         wRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aiWdzT26A1RddVyS6Ep46YDDINA7VJAiM+5UPEkwT9w=;
        b=lzrHDsE0BhgoBSrZgZRmGbxaOP7gT91qp9xOcN+cazi8dir3wpvkKpcqu9CY2EpHsR
         qJ+IJSXZT+LjAiR6rhu/xZIM3hS7yAFk6AoSJzGN1UxkFxuJdOIQUbgNxWfJvXlzjC+2
         34FLBAj78G7skmGMy6WcanE3eyHuMlc7hdIB+/8OA7NdWawpNr3bHX81vkkh9QYkO5Kn
         swW+opDo3uU/zxJDb4d3BYtqc9ckoo83UZD2/LLYT1pr2czx73uCMH480GgsiF5rBDaf
         p1OqVtjf5hx3S7PK95j8TTbZDIFSXo2NGzIOFY+J12VcWwWS3h6KZJntwy0tIt7VFA3j
         14xA==
X-Gm-Message-State: ANoB5pklAam4hTX+ZvN6gPR5lXBi3IyyOphBal4YHza3gZfTpUkCw7C+
        RLCREfWLN03FafuX+iHJBObTvb/sp/U=
X-Google-Smtp-Source: AA0mqf6uCWT4EBLo/+xBwtQOInF4lptYpcySMZA2q0YSezsNZn1U0AyCGKrEO+veFFuH74sYEr+e6w==
X-Received: by 2002:a05:6870:fc84:b0:141:a5c8:352b with SMTP id ly4-20020a056870fc8400b00141a5c8352bmr3041348oab.224.1668743263369;
        Thu, 17 Nov 2022 19:47:43 -0800 (PST)
Received: from [172.17.0.2] ([20.45.36.248])
        by smtp.gmail.com with ESMTPSA id l32-20020a0568302b2000b00661b5e95173sm1128237otv.35.2022.11.17.19.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 19:47:43 -0800 (PST)
Message-ID: <6377005f.050a0220.beb06.54df@mx.google.com>
Date:   Thu, 17 Nov 2022 19:47:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4741637006396603744=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, rostedt@goodmis.org
Subject: RE: timers: Use timer_shutdown*() before freeing timers
In-Reply-To: <20221105060156.686027537@goodmis.org>
References: <20221105060156.686027537@goodmis.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4741637006396603744==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NjkyMzQ4CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMC44OCBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjI4IHNlY29uZHMKU3ViamVjdFByZWZpeCAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDAuMDkgc2Vjb25kcwpCdWlsZEtlcm5lbCAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MjUuNDUgc2Vjb25kcwpCdWlsZEtlcm5lbDMyICAgICAgICAgICAgICAgICBGQUlMICAgICAgMjEu
ODYgc2Vjb25kcwpUZXN0UnVubmVyU2V0dXAgICAgICAgICAgICAgICBQQVNTICAgICAgNDE1LjUy
IHNlY29uZHMKVGVzdFJ1bm5lcl9sMmNhcC10ZXN0ZXIgICAgICAgUEFTUyAgICAgIDE1LjM3IHNl
Y29uZHMKVGVzdFJ1bm5lcl9pc28tdGVzdGVyICAgICAgICAgUEFTUyAgICAgIDE0Ljg4IHNlY29u
ZHMKVGVzdFJ1bm5lcl9ibmVwLXRlc3RlciAgICAgICAgUEFTUyAgICAgIDUuMjQgc2Vjb25kcwpU
ZXN0UnVubmVyX21nbXQtdGVzdGVyICAgICAgICBQQVNTICAgICAgMTAyLjM3IHNlY29uZHMKVGVz
dFJ1bm5lcl9yZmNvbW0tdGVzdGVyICAgICAgUEFTUyAgICAgIDkuMDEgc2Vjb25kcwpUZXN0UnVu
bmVyX3Njby10ZXN0ZXIgICAgICAgICBQQVNTICAgICAgOC40OCBzZWNvbmRzClRlc3RSdW5uZXJf
aW9jdGwtdGVzdGVyICAgICAgIFBBU1MgICAgICA5LjcyIHNlY29uZHMKVGVzdFJ1bm5lcl9tZXNo
LXRlc3RlciAgICAgICAgUEFTUyAgICAgIDYuNTggc2Vjb25kcwpUZXN0UnVubmVyX3NtcC10ZXN0
ZXIgICAgICAgICBQQVNTICAgICAgOC40MiBzZWNvbmRzClRlc3RSdW5uZXJfdXNlcmNoYW4tdGVz
dGVyICAgIFBBU1MgICAgICA1LjUzIHNlY29uZHMKSW5jcmVtZW50YWxCdWlsZCAgICAgICAgICAg
ICAgRkFJTCAgICAgIDIzLjI3IHNlY29uZHMKCkRldGFpbHMKIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjClRlc3Q6IEJ1aWxkS2VybmVsIC0gRkFJTApEZXNjOiBCdWlsZCBLZXJuZWwgZm9y
IEJsdWV0b290aApPdXRwdXQ6Cgpkcml2ZXJzL2JsdWV0b290aC9oY2lfYmNzcC5jOiBJbiBmdW5j
dGlvbiDigJhiY3NwX2Nsb3Nl4oCZOgpkcml2ZXJzL2JsdWV0b290aC9oY2lfYmNzcC5jOjc0MDoy
OiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYdGltZXJfc2h1dGRv
d25fc3luY+KAmSBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KICA3NDAg
fCAgdGltZXJfc2h1dGRvd25fc3luYygmYmNzcC0+dGJjc3ApOwogICAgICB8ICBefn5+fn5+fn5+
fn5+fn5+fn5+CmNjMTogc29tZSB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtl
WzJdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6MjQ5OiBkcml2ZXJzL2JsdWV0b290aC9o
Y2lfYmNzcC5vXSBFcnJvciAxCm1ha2VbMl06ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpv
YnMuLi4uCm1ha2VbMV06ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5idWlsZDo0NjU6IGRyaXZlcnMv
Ymx1ZXRvb3RoXSBFcnJvciAyCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTg1MjogZHJpdmVyc10gRXJy
b3IgMgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQnVpbGRLZXJuZWwzMiAt
IEZBSUwKRGVzYzogQnVpbGQgMzJiaXQgS2VybmVsIGZvciBCbHVldG9vdGgKT3V0cHV0OgoKZHJp
dmVycy9ibHVldG9vdGgvaGNpX2Jjc3AuYzogSW4gZnVuY3Rpb24g4oCYYmNzcF9jbG9zZeKAmToK
ZHJpdmVycy9ibHVldG9vdGgvaGNpX2Jjc3AuYzo3NDA6MjogZXJyb3I6IGltcGxpY2l0IGRlY2xh
cmF0aW9uIG9mIGZ1bmN0aW9uIOKAmHRpbWVyX3NodXRkb3duX3N5bmPigJkgWy1XZXJyb3I9aW1w
bGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCiAgNzQwIHwgIHRpbWVyX3NodXRkb3duX3N5bmMo
JmJjc3AtPnRiY3NwKTsKICAgICAgfCAgXn5+fn5+fn5+fn5+fn5+fn5+fgpjYzE6IHNvbWUgd2Fy
bmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsyXTogKioqIFtzY3JpcHRzL01ha2Vm
aWxlLmJ1aWxkOjI0OTogZHJpdmVycy9ibHVldG9vdGgvaGNpX2Jjc3Aub10gRXJyb3IgMQptYWtl
WzJdOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgptYWtlWzFdOiAqKiogW3Nj
cmlwdHMvTWFrZWZpbGUuYnVpbGQ6NDY1OiBkcml2ZXJzL2JsdWV0b290aF0gRXJyb3IgMgptYWtl
OiAqKiogW01ha2VmaWxlOjE4NTI6IGRyaXZlcnNdIEVycm9yIDIKIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjClRlc3Q6IEluY3JlbWVudGFsQnVpbGQgLSBGQUlMCkRlc2M6IEluY3JlbWVu
dGFsIGJ1aWxkIHdpdGggdGhlIHBhdGNoZXMgaW4gdGhlIHNlcmllcwpPdXRwdXQ6Clt2NGEsMTAv
MzhdIHRpbWVyczogQmx1ZXRvb3RoOiBVc2UgdGltZXJfc2h1dGRvd25fc3luYygpIGJlZm9yZSBm
cmVlaW5nIHRpbWVyCgpkcml2ZXJzL2JsdWV0b290aC9oY2lfYmNzcC5jOiBJbiBmdW5jdGlvbiDi
gJhiY3NwX2Nsb3Nl4oCZOgpkcml2ZXJzL2JsdWV0b290aC9oY2lfYmNzcC5jOjc0MDoyOiBlcnJv
cjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYdGltZXJfc2h1dGRvd25fc3lu
Y+KAmSBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KICA3NDAgfCAgdGlt
ZXJfc2h1dGRvd25fc3luYygmYmNzcC0+dGJjc3ApOwogICAgICB8ICBefn5+fn5+fn5+fn5+fn5+
fn5+CmNjMTogc29tZSB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzJdOiAq
KiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6MjQ5OiBkcml2ZXJzL2JsdWV0b290aC9oY2lfYmNz
cC5vXSBFcnJvciAxCm1ha2VbMl06ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4u
Cm1ha2VbMV06ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5idWlsZDo0NjU6IGRyaXZlcnMvYmx1ZXRv
b3RoXSBFcnJvciAyCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTg1MjogZHJpdmVyc10gRXJyb3IgMgoK
Ci0tLQpSZWdhcmRzLApMaW51eCBCbHVldG9vdGgKCg==

--===============4741637006396603744==--

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B04BC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 08:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241476AbiKRIei (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 03:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241482AbiKRIeV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 03:34:21 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC1267111
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 00:33:35 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id fz10so2715367qtb.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 00:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qAVOJlLmlPhV6enYDCZ1ulU3o59FJCw/+W6/7+MKGRk=;
        b=ctVEN9wHg9xgMS3l9nV0iN0RtGCxZrUxlINZpSGox4JAlrjm3IW7aacarkHcsM4FYQ
         E9SM9r2fOJUD0pU41dmTuegyYnsErZBUUBgcRriLqu42/Hyj6AdheuqwYjQC3UCGXNy1
         nMI7Xub7kLfN5nD8hokxM2X3fPkGxD4o/q9CzCY7IUExk83nFQK+p5qUygInzzCAyvn2
         kmbCjFZfyU/m4acmABbDzuWKgjDuUGYIlHLhGRhMEQ2e3rAXZ3ojDXtYRsjDzR3YW4xj
         i+xnIaezn0WINgJ1OT3Ek6yChsEZ4W87A3RypDJ0lWSAkGF/IPSKSG5BzKcNh279XP6S
         k8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qAVOJlLmlPhV6enYDCZ1ulU3o59FJCw/+W6/7+MKGRk=;
        b=Pz+UpM9x7P7XvKCp3CSHPx/vG0M9+gr1Bq9LHoOvSqI6/kak+feqnG2ahFVePb9Pxd
         0kbSKTzAb/8Zt5xE4Zg61zqy4ms9NxKddeZ4t6fJrQXaO7KjE9EZ0FbPy22XcDN+Ns2T
         e5wZRGoYktiLBoHIRDsUINe26HoTLR8pzXaU86zXx8XygW3/mvpgxPIlGWLlKHgqL/hu
         gUVeldpPONOca+tpWaELrp+4n7H27/3tsLOewZICnWYdq1449k5kq3Aaf+h/9rykAE+m
         Z5icgP+vBFYqKh57RG5CqfuzFv0DnTkvp4ADQVcPDW07G1MI7FLX2WPv3KHGml2DX7F2
         RqRg==
X-Gm-Message-State: ANoB5pmUjibvb6HlrFtVIzvEzF0wvK7ARVC5Rc/FPzGszOhJJW88hqaP
        yWb59GOgT8cuL728EHySM1cGObWeWOdqZw==
X-Google-Smtp-Source: AA0mqf7AsgfQl1bOb722kOUNx2RvLcQaSVZ7iZAKt3o7duaQbtN2WOafYtOzjPunVvGcgU8KXC3ZFA==
X-Received: by 2002:a05:622a:1010:b0:3a6:329f:7f4d with SMTP id d16-20020a05622a101000b003a6329f7f4dmr45457qte.37.1668760408390;
        Fri, 18 Nov 2022 00:33:28 -0800 (PST)
Received: from [172.17.0.2] ([20.119.238.42])
        by smtp.gmail.com with ESMTPSA id p16-20020a05620a057000b006fb8239db65sm1903056qkp.43.2022.11.18.00.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 00:33:28 -0800 (PST)
Message-ID: <63774358.050a0220.7ea0f.8937@mx.google.com>
Date:   Fri, 18 Nov 2022 00:33:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9154800522197081098=="
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

--===============9154800522197081098==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NjkyMzQ4CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMC45NyBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjM0IHNlY29uZHMKU3ViamVjdFByZWZpeCAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDAuMTIgc2Vjb25kcwpCdWlsZEtlcm5lbCAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MjYuMjYgc2Vjb25kcwpCdWlsZEtlcm5lbDMyICAgICAgICAgICAgICAgICBGQUlMICAgICAgMjIu
NDYgc2Vjb25kcwpUZXN0UnVubmVyU2V0dXAgICAgICAgICAgICAgICBQQVNTICAgICAgNDE5LjE2
IHNlY29uZHMKVGVzdFJ1bm5lcl9sMmNhcC10ZXN0ZXIgICAgICAgUEFTUyAgICAgIDE1LjcwIHNl
Y29uZHMKVGVzdFJ1bm5lcl9pc28tdGVzdGVyICAgICAgICAgUEFTUyAgICAgIDE1LjAwIHNlY29u
ZHMKVGVzdFJ1bm5lcl9ibmVwLXRlc3RlciAgICAgICAgUEFTUyAgICAgIDUuMzEgc2Vjb25kcwpU
ZXN0UnVubmVyX21nbXQtdGVzdGVyICAgICAgICBQQVNTICAgICAgMTAzLjYzIHNlY29uZHMKVGVz
dFJ1bm5lcl9yZmNvbW0tdGVzdGVyICAgICAgUEFTUyAgICAgIDkuMDYgc2Vjb25kcwpUZXN0UnVu
bmVyX3Njby10ZXN0ZXIgICAgICAgICBQQVNTICAgICAgOC41NCBzZWNvbmRzClRlc3RSdW5uZXJf
aW9jdGwtdGVzdGVyICAgICAgIFBBU1MgICAgICA5LjY5IHNlY29uZHMKVGVzdFJ1bm5lcl9tZXNo
LXRlc3RlciAgICAgICAgUEFTUyAgICAgIDYuNjkgc2Vjb25kcwpUZXN0UnVubmVyX3NtcC10ZXN0
ZXIgICAgICAgICBQQVNTICAgICAgOC40MyBzZWNvbmRzClRlc3RSdW5uZXJfdXNlcmNoYW4tdGVz
dGVyICAgIFBBU1MgICAgICA1LjQ5IHNlY29uZHMKSW5jcmVtZW50YWxCdWlsZCAgICAgICAgICAg
ICAgRkFJTCAgICAgIDIzLjcyIHNlY29uZHMKCkRldGFpbHMKIyMjIyMjIyMjIyMjIyMjIyMjIyMj
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

--===============9154800522197081098==--

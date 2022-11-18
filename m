Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E2AC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 04:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbiKREeE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Nov 2022 23:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiKREeC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Nov 2022 23:34:02 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E30A12639
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 20:34:00 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id x21so2763025qkj.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 20:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AhjFYWSgdfOxZWTSClCiuDAUdFFE5rLZ242uQRwD4yk=;
        b=jvcDVLghlIJsZpib1MMidCD+wUBIW+5K50X7glEsamLocvs6HDG8KtkXjhDp0SpZzB
         SVscFMOR8S31no1Egs8c+3ucEFsW2L+V42HKIahz7csPi7Qsef6wCw6p0MPCARHedlCg
         niRFYyAaQSPI8oYxnmyp16ZkXY1cCSe2qG2rvz4LUm3hhZCxGLrBEStdhHXmCn4avoOX
         Onje/5eaTo79XgyDlZZrOKuDetQQOcEHUCI93onYVqUrucEW47UhLPmca+SXj0cp3pMm
         CfcTR0F5UQGUzbbzfmiw3IcXJ3h+j8wr05Xzrvy8B3Xg2S/Du3P8X09ADSe75lLowr3g
         WF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AhjFYWSgdfOxZWTSClCiuDAUdFFE5rLZ242uQRwD4yk=;
        b=6w3P6we5EbkfhMM6OfvxYu+MutU/54nIKjl8u860yAZcPZf2Yq4UrNvNCBC72a6FsZ
         57ckuUE/RphDaTNlFEKeTQ3gZvZBfIrl54iobFo/uMAu+sgbsWFI6MDWTGjh4bhWkOqu
         sQAwD1lotvmGWfgVdYYUmdtD7qqM9Il48y5wf2M+wkeqXnLW4dOThV6pix4fKNhtpZyL
         0miEJnXq0IvM2NzemmkTYvb4cFdUdQN9fEp8I+95ncYGVeQlvOPppf+V0FzG+0vCRlct
         QfjWvY2XwprU2sCHgahyiLVgzCFR5IbzLc4i+E47M3r09SDpouF+QHTXUZj3HwzdM69x
         2pug==
X-Gm-Message-State: ANoB5pkSQgHC1qDrOx4uMfbBXg9T3a8tmkVrDT8wBQIkx/D0oHzeiY+u
        9/53fdTbyiL/hcL3WwZZMHTYvls6JAyJMA==
X-Google-Smtp-Source: AA0mqf7xxfPL82bjygcmqWims468x5Sieju2bQFfw1nZMpWgDLz1AYnaQLYz6VHGZYbc2ooAOaexew==
X-Received: by 2002:a37:b901:0:b0:6ec:2b04:5099 with SMTP id j1-20020a37b901000000b006ec2b045099mr4589934qkf.501.1668746039351;
        Thu, 17 Nov 2022 20:33:59 -0800 (PST)
Received: from [172.17.0.2] ([20.114.227.45])
        by smtp.gmail.com with ESMTPSA id x22-20020a05622a001600b003a57f822157sm1493982qtw.90.2022.11.17.20.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 20:33:59 -0800 (PST)
Message-ID: <63770b37.050a0220.4ccea.723e@mx.google.com>
Date:   Thu, 17 Nov 2022 20:33:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8131056670658050459=="
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

--===============8131056670658050459==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NjkyMzQ4CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMC45NiBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjMzIHNlY29uZHMKU3ViamVjdFByZWZpeCAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDAuMTIgc2Vjb25kcwpCdWlsZEtlcm5lbCAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MjYuMDMgc2Vjb25kcwpCdWlsZEtlcm5lbDMyICAgICAgICAgICAgICAgICBGQUlMICAgICAgMjIu
Mzcgc2Vjb25kcwpUZXN0UnVubmVyU2V0dXAgICAgICAgICAgICAgICBQQVNTICAgICAgNDE3LjQ4
IHNlY29uZHMKVGVzdFJ1bm5lcl9sMmNhcC10ZXN0ZXIgICAgICAgUEFTUyAgICAgIDE1LjY5IHNl
Y29uZHMKVGVzdFJ1bm5lcl9pc28tdGVzdGVyICAgICAgICAgUEFTUyAgICAgIDE1LjE4IHNlY29u
ZHMKVGVzdFJ1bm5lcl9ibmVwLXRlc3RlciAgICAgICAgUEFTUyAgICAgIDUuMzUgc2Vjb25kcwpU
ZXN0UnVubmVyX21nbXQtdGVzdGVyICAgICAgICBQQVNTICAgICAgMTAzLjQ2IHNlY29uZHMKVGVz
dFJ1bm5lcl9yZmNvbW0tdGVzdGVyICAgICAgUEFTUyAgICAgIDkuMTcgc2Vjb25kcwpUZXN0UnVu
bmVyX3Njby10ZXN0ZXIgICAgICAgICBQQVNTICAgICAgOC40NiBzZWNvbmRzClRlc3RSdW5uZXJf
aW9jdGwtdGVzdGVyICAgICAgIFBBU1MgICAgICA5LjU5IHNlY29uZHMKVGVzdFJ1bm5lcl9tZXNo
LXRlc3RlciAgICAgICAgUEFTUyAgICAgIDYuNjIgc2Vjb25kcwpUZXN0UnVubmVyX3NtcC10ZXN0
ZXIgICAgICAgICBQQVNTICAgICAgOC40NSBzZWNvbmRzClRlc3RSdW5uZXJfdXNlcmNoYW4tdGVz
dGVyICAgIFBBU1MgICAgICA1LjUxIHNlY29uZHMKSW5jcmVtZW50YWxCdWlsZCAgICAgICAgICAg
ICAgRkFJTCAgICAgIDIzLjQzIHNlY29uZHMKCkRldGFpbHMKIyMjIyMjIyMjIyMjIyMjIyMjIyMj
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

--===============8131056670658050459==--

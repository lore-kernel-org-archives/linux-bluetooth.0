Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6511C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 09:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241931AbiKRJav (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 04:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241550AbiKRJas (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 04:30:48 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9F217A9D
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 01:30:47 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id d123so3409535iof.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 01:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5JyjKlFD29wJbWs74q6qQQk2t595oJAVAe1uiz2c9uA=;
        b=qStABCVrXucDWXuC9EUeNRBC6VCnRucSPAILI4k+JOkfWjDvWoEwnOwbUhZK/SyJsy
         ZhDZ4BcKlqHVB1UllBa/KROd7tCRkpq+hGK6aSo2I8ZqT0sXEjCjvMgPzANOhFLBRWvP
         FZO586HfN8ZA689NINoo5OWFpWarCxCLSNsB1NieHTwwP61XnxlYZMIs2cKj2yrEr6WT
         KbrsQ4l/I7FgZtRH1IrWpWgD4fafjtYBoMY9kP2ktTH9Q6Ms8n5PGuXw0mw7mWatDTUG
         vtTRrok5x6avlgLKbtDAi1ll8tIREZTJgN/extJRXiVgtm70EqPv0nMREMt4P0rXjcLX
         3gtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5JyjKlFD29wJbWs74q6qQQk2t595oJAVAe1uiz2c9uA=;
        b=l6hLnfpPb8fVsrXJecfY0L1QYAOub/3azVrnhy4hTZ8AVG/i39TrjB11KIYhOeCdvv
         6AyWAngHI5IlUJP0uR6nCGOCfSYFxt87fMMrFG7A4gxUDHsy7SvN+2xZD8L+YQ9YX0N1
         bOWTz7RTrtmy/I5oDLUrjnehZd8BuJmm8L/IGVBSKkgpqAjYI3nk1rLTDe+1vjPPgSC6
         nWItJnhtcrEKD+TpNuKPcmUyztUojKWIyKnSt5+h7VtGunx0dGOYKALT9yKdNqIYEnuc
         ae95ygVa9Y8MiMbgOAdc2LZePWuABNmkqRsQQD9EnC6zrpHxPQZN29YtPW4cTyq4I1Ju
         sguA==
X-Gm-Message-State: ANoB5plWd8QxVqr/OBgtD+OV5h3g5FhDoPZAT5s37E43vu0mokuR9D2S
        qIrpHIoqASNmm8TGLd/qgmaRpwiRmlc=
X-Google-Smtp-Source: AA0mqf4xTDsqLyzRlzAAwSEILC48ozBhDOW4YSUANHYZIzXAT9aVL/W5Dbi8lBmIV4g56Xz6ZH99GQ==
X-Received: by 2002:a02:cc2a:0:b0:372:bf99:b645 with SMTP id o10-20020a02cc2a000000b00372bf99b645mr2909461jap.278.1668763846606;
        Fri, 18 Nov 2022 01:30:46 -0800 (PST)
Received: from [172.17.0.2] ([20.9.37.120])
        by smtp.gmail.com with ESMTPSA id g95-20020a028568000000b00374fa5b600csm1101941jai.0.2022.11.18.01.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 01:30:46 -0800 (PST)
Message-ID: <637750c6.020a0220.fa06.26e8@mx.google.com>
Date:   Fri, 18 Nov 2022 01:30:46 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6595865099305477586=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, rostedt@goodmis.org
Subject: RE: timers: Use timer_shutdown*() before freeing timers
In-Reply-To: <20221104054913.358784408@goodmis.org>
References: <20221104054913.358784408@goodmis.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6595865099305477586==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NjkxOTQ0CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMC44OSBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjI4IHNlY29uZHMKU3ViamVjdFByZWZpeCAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDAuMDkgc2Vjb25kcwpCdWlsZEtlcm5lbCAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MjUuODEgc2Vjb25kcwpCdWlsZEtlcm5lbDMyICAgICAgICAgICAgICAgICBGQUlMICAgICAgMjEu
OTcgc2Vjb25kcwpUZXN0UnVubmVyU2V0dXAgICAgICAgICAgICAgICBQQVNTICAgICAgNDIxLjMw
IHNlY29uZHMKVGVzdFJ1bm5lcl9sMmNhcC10ZXN0ZXIgICAgICAgUEFTUyAgICAgIDE1LjcwIHNl
Y29uZHMKVGVzdFJ1bm5lcl9pc28tdGVzdGVyICAgICAgICAgUEFTUyAgICAgIDE0Ljk5IHNlY29u
ZHMKVGVzdFJ1bm5lcl9ibmVwLXRlc3RlciAgICAgICAgUEFTUyAgICAgIDUuMzUgc2Vjb25kcwpU
ZXN0UnVubmVyX21nbXQtdGVzdGVyICAgICAgICBQQVNTICAgICAgMTAzLjQwIHNlY29uZHMKVGVz
dFJ1bm5lcl9yZmNvbW0tdGVzdGVyICAgICAgUEFTUyAgICAgIDkuMTIgc2Vjb25kcwpUZXN0UnVu
bmVyX3Njby10ZXN0ZXIgICAgICAgICBQQVNTICAgICAgOC42MiBzZWNvbmRzClRlc3RSdW5uZXJf
aW9jdGwtdGVzdGVyICAgICAgIFBBU1MgICAgICA5Ljc4IHNlY29uZHMKVGVzdFJ1bm5lcl9tZXNo
LXRlc3RlciAgICAgICAgUEFTUyAgICAgIDYuNjUgc2Vjb25kcwpUZXN0UnVubmVyX3NtcC10ZXN0
ZXIgICAgICAgICBQQVNTICAgICAgOC4zMyBzZWNvbmRzClRlc3RSdW5uZXJfdXNlcmNoYW4tdGVz
dGVyICAgIFBBU1MgICAgICA1LjUwIHNlY29uZHMKSW5jcmVtZW50YWxCdWlsZCAgICAgICAgICAg
ICAgRkFJTCAgICAgIDIzLjIxIHNlY29uZHMKCkRldGFpbHMKIyMjIyMjIyMjIyMjIyMjIyMjIyMj
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
dGFsIGJ1aWxkIHdpdGggdGhlIHBhdGNoZXMgaW4gdGhlIHNlcmllcwpPdXRwdXQ6CltSRkMsdjMs
MDgvMzNdIHRpbWVyczogQmx1ZXRvb3RoOiBVc2UgdGltZXJfc2h1dGRvd25fc3luYygpIGJlZm9y
ZSBmcmVlaW5nIHRpbWVyCgpkcml2ZXJzL2JsdWV0b290aC9oY2lfYmNzcC5jOiBJbiBmdW5jdGlv
biDigJhiY3NwX2Nsb3Nl4oCZOgpkcml2ZXJzL2JsdWV0b290aC9oY2lfYmNzcC5jOjc0MDoyOiBl
cnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYdGltZXJfc2h1dGRvd25f
c3luY+KAmSBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KICA3NDAgfCAg
dGltZXJfc2h1dGRvd25fc3luYygmYmNzcC0+dGJjc3ApOwogICAgICB8ICBefn5+fn5+fn5+fn5+
fn5+fn5+CmNjMTogc29tZSB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzJd
OiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6MjQ5OiBkcml2ZXJzL2JsdWV0b290aC9oY2lf
YmNzcC5vXSBFcnJvciAxCm1ha2VbMl06ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMu
Li4uCm1ha2VbMV06ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5idWlsZDo0NjU6IGRyaXZlcnMvYmx1
ZXRvb3RoXSBFcnJvciAyCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTg1MjogZHJpdmVyc10gRXJyb3Ig
MgoKCi0tLQpSZWdhcmRzLApMaW51eCBCbHVldG9vdGgKCg==

--===============6595865099305477586==--

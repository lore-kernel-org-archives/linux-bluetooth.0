Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E13FC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 05:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240836AbiKRF3o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 00:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiKRF3m (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 00:29:42 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B0387A5C
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:29:41 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id x16so2051166ilm.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3avOA1sz11Fc0XOZ3JHlqvXV4eenARjE+Lu2TE6bqQ8=;
        b=H696YE/xmvVKpVBHR0N0T0xOaNhjn7rt/bk5m3A7mHE3KPLGMF06zSBw2hPj2BVS54
         7f8lldW+/soENsPOc8df1zmeWx4WmIk+eugxqgmlimDdXHTfjtCCrWi+bqGbA6t8F9wy
         NinuyV80T30H8p5hYLp/H0ScRI/RwczzHZYoSLczsH9WtWf+RyoX3EK+Rtp3eBCheiiq
         illuu7PEqzNtzE9ECDkCIEKat63CYW2Eb6e+PsKYeApETWrR98vjJd/75y1PYLygAgDy
         bb5t63uOMKvZXqPEIBlnwhT4mUR3wjiuIWUM/avS/AHA3TFwciiGOhvusc0HNkZm7ajp
         Ue8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3avOA1sz11Fc0XOZ3JHlqvXV4eenARjE+Lu2TE6bqQ8=;
        b=4QWzyBVxIRHRZRdOxm/QtFKWWSOYNs7mwOWACrnBmC/I7dajI30AiwhqCCWx1z90cz
         1bu/T5qSDaJC9W1HeZ+KFy772uwqaxBQPzW5kHP8Wc6mtKVgrDuskxYmvT0wt8LeYwdW
         WQFJutqb1HMGpC+Tr7KXArl95V4sOdcQr0C+c0vlf5p74NfowH1UfkJtL6ri6tTRRRz9
         t/CMzntl4kyG30BnZVjDuVsy5BY2fQTu5b9+gKgzkc2khVaxDv/fsN1cKY0ASi2Bm/gc
         ir4UaBZSb5Nj7dyGcYW6xvFfXta7W/DIeNL3f3oPKEQgY6GL06WgT7uglIFVW9CoY9S1
         6Yag==
X-Gm-Message-State: ANoB5pmE8J52iEUn1D192ub9Xf33ye4y7q0oA+FR0xXeIzdTEiTdC2oe
        haBMqMbd/hrPMut5GK2hJ+vSrQeYSjA=
X-Google-Smtp-Source: AA0mqf4bIIyaTtXrxyRYKwKjI6XuRxwt7smg+bDOTtDT/GIoNUMLSDp8HrRSn6Sw9RiOTdi2jQcN/Q==
X-Received: by 2002:a92:d0d1:0:b0:300:ec43:a81f with SMTP id y17-20020a92d0d1000000b00300ec43a81fmr2650732ila.279.1668749381095;
        Thu, 17 Nov 2022 21:29:41 -0800 (PST)
Received: from [172.17.0.2] ([20.12.217.203])
        by smtp.gmail.com with ESMTPSA id q23-20020a05663810d700b0037532823a17sm924475jad.122.2022.11.17.21.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 21:29:40 -0800 (PST)
Message-ID: <63771844.050a0220.8802.240d@mx.google.com>
Date:   Thu, 17 Nov 2022 21:29:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0798612476146947008=="
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

--===============0798612476146947008==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NjkxOTQ0CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMC44NyBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjI3IHNlY29uZHMKU3ViamVjdFByZWZpeCAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDAuMDkgc2Vjb25kcwpCdWlsZEtlcm5lbCAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MjUuMDAgc2Vjb25kcwpCdWlsZEtlcm5lbDMyICAgICAgICAgICAgICAgICBGQUlMICAgICAgMjEu
NDggc2Vjb25kcwpUZXN0UnVubmVyU2V0dXAgICAgICAgICAgICAgICBQQVNTICAgICAgNDE2LjYw
IHNlY29uZHMKVGVzdFJ1bm5lcl9sMmNhcC10ZXN0ZXIgICAgICAgUEFTUyAgICAgIDE1LjY1IHNl
Y29uZHMKVGVzdFJ1bm5lcl9pc28tdGVzdGVyICAgICAgICAgUEFTUyAgICAgIDE0Ljk5IHNlY29u
ZHMKVGVzdFJ1bm5lcl9ibmVwLXRlc3RlciAgICAgICAgUEFTUyAgICAgIDUuMjUgc2Vjb25kcwpU
ZXN0UnVubmVyX21nbXQtdGVzdGVyICAgICAgICBQQVNTICAgICAgMTAyLjM5IHNlY29uZHMKVGVz
dFJ1bm5lcl9yZmNvbW0tdGVzdGVyICAgICAgUEFTUyAgICAgIDkuMDYgc2Vjb25kcwpUZXN0UnVu
bmVyX3Njby10ZXN0ZXIgICAgICAgICBQQVNTICAgICAgOC40OSBzZWNvbmRzClRlc3RSdW5uZXJf
aW9jdGwtdGVzdGVyICAgICAgIFBBU1MgICAgICA5LjYzIHNlY29uZHMKVGVzdFJ1bm5lcl9tZXNo
LXRlc3RlciAgICAgICAgUEFTUyAgICAgIDYuNjIgc2Vjb25kcwpUZXN0UnVubmVyX3NtcC10ZXN0
ZXIgICAgICAgICBQQVNTICAgICAgOC40MCBzZWNvbmRzClRlc3RSdW5uZXJfdXNlcmNoYW4tdGVz
dGVyICAgIFBBU1MgICAgICA1LjUzIHNlY29uZHMKSW5jcmVtZW50YWxCdWlsZCAgICAgICAgICAg
ICAgRkFJTCAgICAgIDIzLjIwIHNlY29uZHMKCkRldGFpbHMKIyMjIyMjIyMjIyMjIyMjIyMjIyMj
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

--===============0798612476146947008==--

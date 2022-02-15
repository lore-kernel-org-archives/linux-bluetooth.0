Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8DAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Feb 2022 15:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240927AbiBOP6v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Feb 2022 10:58:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238710AbiBOP6u (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Feb 2022 10:58:50 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA4CBD2FE
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 07:58:39 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id o25so17671325qkj.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 07:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=+hc1zzrhy7nVKMbyjCVbT1O6+Xy1C3dOHk8pGa7qXEA=;
        b=LBTmlZBHE0e9OpKpunZ8kkQV/x/NXaCDM2oi9XcmkwxUgsVDgai5eQq/vBoJ4r/+TE
         oJQR3IqkERdnZUx/hYTe24Ss14sJmzsvyLErdaz9R8UYuNLGqwWeitMQvnT1ttl0YJsy
         eSVsnh7yft0gpHTY1jXvCk6VbWGatXJ0J/1cxFOx3+g2lY0U0yVWl1QoZNwABdBVzfPe
         FW2rqaiLrmOQpogEc+At/RGLDwwwTqiFeRXv/FO+eu4IrkURkhT9qdPTLBrLfftZogKL
         +HUua1z2CpSJ5ZoynZRTwPa7IrgApoRmFakmYijXdixMMrzBZpjZJVkNfCteeIIHbq8U
         0AXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=+hc1zzrhy7nVKMbyjCVbT1O6+Xy1C3dOHk8pGa7qXEA=;
        b=6heq2dC6Ly3hCf+73UBlKu6uvxBQpS0qp/0vAE9Q2U/5kQVxChYeYpngeTD8YfamYj
         v8auFUEvShbwzftVmaON7M27H/KASBnBcRHtQ6nlHIyHQ+ucc/Ycdk1chg5JtdCULWQY
         VEMGvxXmL4S9MPSKr0L5/rchRA/A5iAPJJQNx0jVoeg0cZ0akkOJtkHZsKlNi4mUFwGg
         yC7BDoazaV67wFCMBJILeA7aFewMn3XwB8BaQmuzvH+U1oMQh8eH0iPNjlolSZhczrJ5
         QydkRDtV5Jz+XLS/VLN11bqsv3DGvl4BFDUPG6ntw/qqEDWgPmbXVRPPcAlpIkoNTnph
         6rtA==
X-Gm-Message-State: AOAM530uwHtmXDjIwbvKqqhfTncWUZmMlnfVj3SEh1fXuIuI1KsL4sJA
        m4Jks7s9D7uvaaJCKqQeNeYr4uRlhvg=
X-Google-Smtp-Source: ABdhPJy2v+RhqCLl17QKsdSc+BXKF6liW0PCgaahks8EsJWdz2EHero6H2BC6kljip3FK6zvN4Vwdg==
X-Received: by 2002:a37:9ad8:: with SMTP id c207mr846936qke.169.1644940718268;
        Tue, 15 Feb 2022 07:58:38 -0800 (PST)
Received: from [172.17.0.2] ([52.167.130.126])
        by smtp.gmail.com with ESMTPSA id p6sm7207608qkg.33.2022.02.15.07.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 07:58:37 -0800 (PST)
Message-ID: <620bcdad.1c69fb81.5bcba.62d5@mx.google.com>
Date:   Tue, 15 Feb 2022 07:58:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1023872737738294163=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, josephsih@chromium.org
Subject: RE: [BlueZ,v4,1/8] doc: Introduce the quality report command and event
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220215133636.2827039-1-josephsih@chromium.org>
References: <20220215133636.2827039-1-josephsih@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1023872737738294163==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NjE0NTM4CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMTIuMjggc2Vjb25kcwpHaXRMaW50ICAgICAgICAgICAgICAgICAgICAgICBG
QUlMICAgICAgOC4xOSBzZWNvbmRzClByZXAgLSBTZXR1cCBFTEwgICAgICAgICAgICAgIFBBU1Mg
ICAgICA0Ni40OSBzZWNvbmRzCkJ1aWxkIC0gUHJlcCAgICAgICAgICAgICAgICAgIFBBU1MgICAg
ICAwLjc0IHNlY29uZHMKQnVpbGQgLSBDb25maWd1cmUgICAgICAgICAgICAgUEFTUyAgICAgIDku
NTQgc2Vjb25kcwpCdWlsZCAtIE1ha2UgICAgICAgICAgICAgICAgICBQQVNTICAgICAgMTQ1OS4x
NyBzZWNvbmRzCk1ha2UgQ2hlY2sgICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICAxMi4wOCBz
ZWNvbmRzCk1ha2UgQ2hlY2sgdy9WYWxncmluZCAgICAgICAgIFBBU1MgICAgICA1MjMuNTAgc2Vj
b25kcwpNYWtlIERpc3RjaGVjayAgICAgICAgICAgICAgICBQQVNTICAgICAgMjY0LjAxIHNlY29u
ZHMKQnVpbGQgdy9leHQgRUxMIC0gQ29uZmlndXJlICAgUEFTUyAgICAgIDkuOTggc2Vjb25kcwpC
dWlsZCB3L2V4dCBFTEwgLSBNYWtlICAgICAgICBQQVNTICAgICAgMTM5Mi42MiBzZWNvbmRzCklu
Y3JlbWVudGFsIEJ1aWxkIHdpdGggcGF0Y2hlc0ZBSUwgICAgICA0Mzc4LjA0IHNlY29uZHMKCkRl
dGFpbHMKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEdpdExpbnQgLSBGQUlM
CkRlc2M6IFJ1biBnaXRsaW50IHdpdGggcnVsZSBpbiAuZ2l0bGludApPdXRwdXQ6CltCbHVlWix2
NCwyLzhdIGxpYjogQWRkIHN0cnVjdHVyZXMgYW5kIGNvbnN0YW50cyBmb3IgcXVhbGl0eSByZXBv
cnQgY29tbWFuZCBhbmQgZXZlbnQKMTogVDEgVGl0bGUgZXhjZWVkcyBtYXggbGVuZ3RoICg4NT44
MCk6ICJbQmx1ZVosdjQsMi84XSBsaWI6IEFkZCBzdHJ1Y3R1cmVzIGFuZCBjb25zdGFudHMgZm9y
IHF1YWxpdHkgcmVwb3J0IGNvbW1hbmQgYW5kIGV2ZW50IgoKCiMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIwpUZXN0OiBJbmNyZW1lbnRhbCBCdWlsZCB3aXRoIHBhdGNoZXMgLSBGQUlMCkRl
c2M6IEluY3JlbWVudGFsIGJ1aWxkIHBlciBwYXRjaCBpbiB0aGUgc2VyaWVzCk91dHB1dDoKdG9v
bHMvbWdtdC10ZXN0ZXIuYzogSW4gZnVuY3Rpb24g4oCYbWFpbuKAmToKdG9vbHMvbWdtdC10ZXN0
ZXIuYzoxMjM2NDo1OiBub3RlOiB2YXJpYWJsZSB0cmFja2luZyBzaXplIGxpbWl0IGV4Y2VlZGVk
IHdpdGgg4oCYLWZ2YXItdHJhY2tpbmctYXNzaWdubWVudHPigJksIHJldHJ5aW5nIHdpdGhvdXQK
MTIzNjQgfCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQogICAgICB8ICAgICBefn5+
CnVuaXQvdGVzdC1hdmR0cC5jOiBJbiBmdW5jdGlvbiDigJhtYWlu4oCZOgp1bml0L3Rlc3QtYXZk
dHAuYzo3NjY6NTogbm90ZTogdmFyaWFibGUgdHJhY2tpbmcgc2l6ZSBsaW1pdCBleGNlZWRlZCB3
aXRoIOKAmC1mdmFyLXRyYWNraW5nLWFzc2lnbm1lbnRz4oCZLCByZXRyeWluZyB3aXRob3V0CiAg
NzY2IHwgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKICAgICAgfCAgICAgXn5+fgp1
bml0L3Rlc3QtYXZyY3AuYzogSW4gZnVuY3Rpb24g4oCYbWFpbuKAmToKdW5pdC90ZXN0LWF2cmNw
LmM6OTg5OjU6IG5vdGU6IHZhcmlhYmxlIHRyYWNraW5nIHNpemUgbGltaXQgZXhjZWVkZWQgd2l0
aCDigJgtZnZhci10cmFja2luZy1hc3NpZ25tZW50c+KAmSwgcmV0cnlpbmcgd2l0aG91dAogIDk4
OSB8IGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCiAgICAgIHwgICAgIF5+fn4Kc3Jj
L2FkYXB0ZXIuYzo5NzQ0OjY6IGVycm9yOiBubyBwcmV2aW91cyBkZWNsYXJhdGlvbiBmb3Ig4oCY
aXNfcXVhbGl0eV9yZXBvcnRfc3VwcG9ydGVk4oCZIFstV2Vycm9yPW1pc3NpbmctZGVjbGFyYXRp
b25zXQogOTc0NCB8IGJvb2wgaXNfcXVhbGl0eV9yZXBvcnRfc3VwcG9ydGVkKHN0cnVjdCBidGRf
YWRhcHRlciAqYWRhcHRlcikKICAgICAgfCAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiog
W01ha2VmaWxlOjEwMTg3OiBzcmMvYmx1ZXRvb3RoZC1hZGFwdGVyLm9dIEVycm9yIDEKbWFrZTog
KioqIFtNYWtlZmlsZTo0MzA4OiBhbGxdIEVycm9yIDIKCgoKCi0tLQpSZWdhcmRzLApMaW51eCBC
bHVldG9vdGgKCg==

--===============1023872737738294163==--

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4385DC48BCF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Jun 2021 09:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E837611CE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Jun 2021 09:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhFLJ6u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Jun 2021 05:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhFLJ6u (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Jun 2021 05:58:50 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD39C061574
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Jun 2021 02:56:50 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id q16so7661882qkm.9
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Jun 2021 02:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=SFdGm7tgrmep95Df2cDnKv9hknuw6aNzDzAnczoRpg0=;
        b=q2HqeQscrQ7wEELSCpY1uy4L0txEJoyZDLUOa68veiNtObRzPTYWRNsqWepmgZFash
         BJhGr3nPr1Z0Dd0CK7y1iFcZyi9PX6KRG1lCLautRp0ozkkBdE4AyMlNBvTUaBO4JMCt
         5KsY6sSnVZCYEokk/Ll9LuhArw9PshZKCDTj2FXGrhjFq8mZRu2HTKTsn9zwCmNyQh8d
         Y+/lmzKpSXHPAHxR5FOCvVb/cKDU2ChSI9vBHFm+T4USJSA56i04uj5sELodn4OPYqDn
         Zvjs4egUMideFh1rmbtn52Xf4JQXoDWaSIJjTX41eIX7HBBholeWOSpB9gXhmO69YcRo
         Un6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=SFdGm7tgrmep95Df2cDnKv9hknuw6aNzDzAnczoRpg0=;
        b=UFadM6Quzi8FFWEpaur1mmLfL6Ls7oxz3wT7GmnTrOuHBieILY400ZoEix57sNcLtW
         bI5LVzsX+LrBP2z7PRPWljUrKsPgr12ZjuTucbfM7BmSN0rCau6cNgZ6ZRN3Xm5bQovY
         EoHxildtinek8ejs7iX5dsmod/+QIbjdDsvc4HPpN/gfoT5p+prbpC7HZjg/xmWc63Ej
         qXDRLDi4kNsNWKm/mmtQ0nSYQp20mR3MeNRV/qFdC3EsZE1DhVa6odE4u1exudqjxzw5
         Et3f2/73YrqdDFxybyZar9wpjbYcxR2CedQmbpe4VNGcf8RV3Qu7Our2xCgvb94rohZ1
         BT9Q==
X-Gm-Message-State: AOAM532rTqueuwKfO7smleL8CvISqlPNigYL+sJ7WspR5W5xGz9RgrRn
        hoU0BpX1drsM79qGbxc38GW2fxrn0tfy3A==
X-Google-Smtp-Source: ABdhPJyXZmYt55pFRABinUUSBLOvhjNPoqqOCmIYFomcyzwokcN3TdOrbQaz98dhcfrpxjFQbxBy5A==
X-Received: by 2002:a05:620a:20d6:: with SMTP id f22mr7751434qka.117.1623491809376;
        Sat, 12 Jun 2021 02:56:49 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.59.205])
        by smtp.gmail.com with ESMTPSA id g19sm6033078qto.49.2021.06.12.02.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 02:56:48 -0700 (PDT)
Message-ID: <60c484e0.1c69fb81.c8dcd.c325@mx.google.com>
Date:   Sat, 12 Jun 2021 02:56:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9203955976962357654=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, surban@surban.net
Subject: RE: [BlueZ] gatt-server: Flush notify multiple buffer when full and fix overflow
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210612093236.5293-1-surban@surban.net>
References: <20210612093236.5293-1-surban@surban.net>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9203955976962357654==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NDk5MjkxCgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMC41MiBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjEyIHNlY29uZHMKUHJlcCAtIFNldHVwIEVMTCAgICAgICAgICAgICAgUEFTUyAg
ICAgIDQ3Ljg5IHNlY29uZHMKQnVpbGQgLSBQcmVwICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDAuMTUgc2Vjb25kcwpCdWlsZCAtIENvbmZpZ3VyZSAgICAgICAgICAgICBQQVNTICAgICAgOC4x
MSBzZWNvbmRzCkJ1aWxkIC0gTWFrZSAgICAgICAgICAgICAgICAgIEZBSUwgICAgICAxMC4xNiBz
ZWNvbmRzCk1ha2UgQ2hlY2sgICAgICAgICAgICAgICAgICAgIEZBSUwgICAgICAwLjU3IHNlY29u
ZHMKTWFrZSBEaXN0Y2hlY2sgICAgICAgICAgICAgICAgUEFTUyAgICAgIDI0My4wMiBzZWNvbmRz
CkJ1aWxkIHcvZXh0IEVMTCAtIENvbmZpZ3VyZSAgIFBBU1MgICAgICA4LjE0IHNlY29uZHMKQnVp
bGQgdy9leHQgRUxMIC0gTWFrZSAgICAgICAgRkFJTCAgICAgIDkuNjYgc2Vjb25kcwoKRGV0YWls
cwojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tQYXRjaCAtIFBBU1MK
RGVzYzogUnVuIGNoZWNrcGF0Y2gucGwgc2NyaXB0IHdpdGggcnVsZSBpbiAuY2hlY2twYXRjaC5j
b25mCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogR2l0TGludCAtIFBBU1MK
RGVzYzogUnVuIGdpdGxpbnQgd2l0aCBydWxlIGluIC5naXRsaW50CgojIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMKVGVzdDogUHJlcCAtIFNldHVwIEVMTCAtIFBBU1MKRGVzYzogQ2xvbmUs
IGJ1aWxkLCBhbmQgaW5zdGFsbCBFTEwKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpU
ZXN0OiBCdWlsZCAtIFByZXAgLSBQQVNTCkRlc2M6IFByZXBhcmUgZW52aXJvbm1lbnQgZm9yIGJ1
aWxkCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQnVpbGQgLSBDb25maWd1
cmUgLSBQQVNTCkRlc2M6IENvbmZpZ3VyZSB0aGUgQmx1ZVogc291cmNlIHRyZWUKCiMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBCdWlsZCAtIE1ha2UgLSBGQUlMCkRlc2M6IEJ1
aWxkIHRoZSBCbHVlWiBzb3VyY2UgdHJlZQpPdXRwdXQ6CnNyYy9zaGFyZWQvZ2F0dC1zZXJ2ZXIu
YzoxNjkzOjY6IGVycm9yOiBubyBwcmV2aW91cyBkZWNsYXJhdGlvbiBmb3Ig4oCYbm90aWZ5X2Fw
cGVuZF9sZTE24oCZIFstV2Vycm9yPW1pc3NpbmctZGVjbGFyYXRpb25zXQogMTY5MyB8IGJvb2wg
bm90aWZ5X2FwcGVuZF9sZTE2KHN0cnVjdCBuZnlfbXVsdF9kYXRhICpkYXRhLCB1aW50MTZfdCB2
YWx1ZSkKICAgICAgfCAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fgpjYzE6IGFsbCB3YXJuaW5ncyBi
ZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiogW01ha2VmaWxlOjY5NTU6IHNyYy9z
aGFyZWQvZ2F0dC1zZXJ2ZXIubG9dIEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmlsZTo0MTM0OiBh
bGxdIEVycm9yIDIKCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogTWFrZSBD
aGVjayAtIEZBSUwKRGVzYzogUnVuICdtYWtlIGNoZWNrJwpPdXRwdXQ6CnNyYy9zaGFyZWQvZ2F0
dC1zZXJ2ZXIuYzoxNjkzOjY6IGVycm9yOiBubyBwcmV2aW91cyBkZWNsYXJhdGlvbiBmb3Ig4oCY
bm90aWZ5X2FwcGVuZF9sZTE24oCZIFstV2Vycm9yPW1pc3NpbmctZGVjbGFyYXRpb25zXQogMTY5
MyB8IGJvb2wgbm90aWZ5X2FwcGVuZF9sZTE2KHN0cnVjdCBuZnlfbXVsdF9kYXRhICpkYXRhLCB1
aW50MTZfdCB2YWx1ZSkKICAgICAgfCAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fgpjYzE6IGFsbCB3
YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiogW01ha2VmaWxlOjY5
NTU6IHNyYy9zaGFyZWQvZ2F0dC1zZXJ2ZXIubG9dIEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmls
ZToxMDQwNjogY2hlY2tdIEVycm9yIDIKCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMK
VGVzdDogTWFrZSBEaXN0Y2hlY2sgLSBQQVNTCkRlc2M6IFJ1biBkaXN0Y2hlY2sgdG8gY2hlY2sg
dGhlIGRpc3RyaWJ1dGlvbgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEJ1
aWxkIHcvZXh0IEVMTCAtIENvbmZpZ3VyZSAtIFBBU1MKRGVzYzogQ29uZmlndXJlIEJsdWVaIHNv
dXJjZSB3aXRoICctLWVuYWJsZS1leHRlcm5hbC1lbGwnIGNvbmZpZ3VyYXRpb24KCiMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBCdWlsZCB3L2V4dCBFTEwgLSBNYWtlIC0gRkFJ
TApEZXNjOiBCdWlsZCBCbHVlWiBzb3VyY2Ugd2l0aCAnLS1lbmFibGUtZXh0ZXJuYWwtZWxsJyBj
b25maWd1cmF0aW9uCk91dHB1dDoKc3JjL3NoYXJlZC9nYXR0LXNlcnZlci5jOjE2OTM6NjogZXJy
b3I6IG5vIHByZXZpb3VzIGRlY2xhcmF0aW9uIGZvciDigJhub3RpZnlfYXBwZW5kX2xlMTbigJkg
Wy1XZXJyb3I9bWlzc2luZy1kZWNsYXJhdGlvbnNdCiAxNjkzIHwgYm9vbCBub3RpZnlfYXBwZW5k
X2xlMTYoc3RydWN0IG5meV9tdWx0X2RhdGEgKmRhdGEsIHVpbnQxNl90IHZhbHVlKQogICAgICB8
ICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+CmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQg
YXMgZXJyb3JzCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6Njk1NTogc3JjL3NoYXJlZC9nYXR0LXNl
cnZlci5sb10gRXJyb3IgMQptYWtlOiAqKiogW01ha2VmaWxlOjQxMzQ6IGFsbF0gRXJyb3IgMgoK
CgoKLS0tClJlZ2FyZHMsCkxpbnV4IEJsdWV0b290aAoK

--===============9203955976962357654==--

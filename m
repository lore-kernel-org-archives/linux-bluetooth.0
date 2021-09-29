Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A702C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 18:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C9E961216
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 18:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346260AbhI2Skq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Sep 2021 14:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346132AbhI2Skp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Sep 2021 14:40:45 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AA4C06161C
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 11:39:04 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id 73so3307668qki.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 11:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=utzt33YJ55WjI86+EMNe0psvDzO+LvYHhqGHvI26frc=;
        b=XRLNvHC3U0v1cEerd002K1xQIbg86gyX1FgpeJ5eeMfBtKgWvDdbmG5HF/umg89qUi
         KcQ2SMn5fJLsamgqQqxhHtdL0XLQj5NMffrUB/hI+vHOdxNCo2Ckw2udvP8xc+Rc6gz6
         jVwLvxiVZUWe+T0oZjWppAYqN8QGPdeQHxkyKPlf/gDozrY/NRbY/hRi2GS8sZEVRJP+
         +1eTGstwTs+p1LKJts27fbEwCSFR4v0m04dyYWCwMObzl+RXSbVfQ1wGoouBn8ELboy/
         FkojaubPNfcW+N8v3MpHvqSDYwb5l9udm5eMETacuPHZe1dBr9e8YG/gH1mJhSZEhyQR
         CS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=utzt33YJ55WjI86+EMNe0psvDzO+LvYHhqGHvI26frc=;
        b=Ft7hl4Zeo0bAeFSOVjpTdiGMfxLt9xt75LsVzrcxK/G+ZaY0xTDzMEBauoRDlecnJC
         JuTNVKdntG1tm4azeZV+CX2rJfx3yA+1OarWEKCeEpIFTHs7B9RRZY892qeZT+YJsoRb
         KUXuZT7uGDJryPvd9pAQKBmOoAu0imCdgFpgZNteAlqsnla1eukv4regaTGjzMV27qL5
         toToaJ/Hwb2BZeBPOZSHp3zOXNTEGgKYNzaBd7Bzd1+GJ3EInSa9s3OIln8XvpGFpuN9
         EUxb+giR9JJcNkrucF/ZQfN08tnHOt3387GOI+aN/4iMzsJSFIz2/Z43H/fUsMEfsXHB
         c2Xg==
X-Gm-Message-State: AOAM533p+zHIbS24IL3EFEALIrrTSZlt3iRkev2K9QhkYEe2lJ9jPW+Q
        ++lZ7dxs43GfkomSjvWtXrftR+sjShONT4u2
X-Google-Smtp-Source: ABdhPJxxoOPlyupx4FpHI9J+kHE3WsJ8FlSTFvwSpw9LVDpnT/oOJZ4qy9Rvl2th0xqzwqLLVI1BCA==
X-Received: by 2002:a37:f90c:: with SMTP id l12mr1207641qkj.514.1632940743601;
        Wed, 29 Sep 2021 11:39:03 -0700 (PDT)
Received: from [172.17.0.2] ([104.209.153.162])
        by smtp.gmail.com with ESMTPSA id d3sm362278qke.36.2021.09.29.11.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 11:39:03 -0700 (PDT)
Message-ID: <6154b2c7.1c69fb81.1c2a0.3333@mx.google.com>
Date:   Wed, 29 Sep 2021 11:39:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5932063536660408877=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dmartinez@starry.com
Subject: RE: Optionally require security for notify/indicate
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210929180031.417090-2-dmartinez@starry.com>
References: <20210929180031.417090-2-dmartinez@starry.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5932063536660408877==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NTU1MTY5CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMi42NCBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAxLjkwIHNlY29uZHMKUHJlcCAtIFNldHVwIEVMTCAgICAgICAgICAgICAgUEFTUyAg
ICAgIDQyLjE3IHNlY29uZHMKQnVpbGQgLSBQcmVwICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDAuNDYgc2Vjb25kcwpCdWlsZCAtIENvbmZpZ3VyZSAgICAgICAgICAgICBQQVNTICAgICAgNy44
MSBzZWNvbmRzCkJ1aWxkIC0gTWFrZSAgICAgICAgICAgICAgICAgIEZBSUwgICAgICAxNDkuNTMg
c2Vjb25kcwpNYWtlIENoZWNrICAgICAgICAgICAgICAgICAgICBGQUlMICAgICAgMS41NyBzZWNv
bmRzCk1ha2UgRGlzdGNoZWNrICAgICAgICAgICAgICAgIFBBU1MgICAgICAyMTMuMTEgc2Vjb25k
cwpCdWlsZCB3L2V4dCBFTEwgLSBDb25maWd1cmUgICBQQVNTICAgICAgNy45MSBzZWNvbmRzCkJ1
aWxkIHcvZXh0IEVMTCAtIE1ha2UgICAgICAgIEZBSUwgICAgICAxNDEuNDYgc2Vjb25kcwoKRGV0
YWlscwojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQnVpbGQgLSBNYWtlIC0g
RkFJTApEZXNjOiBCdWlsZCB0aGUgQmx1ZVogc291cmNlIHRyZWUKT3V0cHV0OgpzcmMvZ2F0dC1k
YXRhYmFzZS5jOiBJbiBmdW5jdGlvbiDigJhzZXJ2aWNlX2FkZF9jY2PigJk6CnNyYy9nYXR0LWRh
dGFiYXNlLmM6MTA2MDoyOiBlcnJvcjogSVNPIEM5MCBmb3JiaWRzIG1peGVkIGRlY2xhcmF0aW9u
cyBhbmQgY29kZSBbLVdlcnJvcj1kZWNsYXJhdGlvbi1hZnRlci1zdGF0ZW1lbnRdCiAxMDYwIHwg
IHVpbnQzMl90IHBlcm1pc3Npb25zID0gQlRfQVRUX1BFUk1fUkVBRCB8IEJUX0FUVF9QRVJNX1dS
SVRFOwogICAgICB8ICBefn5+fn5+fgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFz
IGVycm9ycwptYWtlWzFdOiAqKiogW01ha2VmaWxlOjkyMTI6IHNyYy9ibHVldG9vdGhkLWdhdHQt
ZGF0YWJhc2Uub10gRXJyb3IgMQptYWtlOiAqKiogW01ha2VmaWxlOjQxNTE6IGFsbF0gRXJyb3Ig
MgoKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBNYWtlIENoZWNrIC0gRkFJ
TApEZXNjOiBSdW4gJ21ha2UgY2hlY2snCk91dHB1dDoKc3JjL2dhdHQtZGF0YWJhc2UuYzogSW4g
ZnVuY3Rpb24g4oCYc2VydmljZV9hZGRfY2Nj4oCZOgpzcmMvZ2F0dC1kYXRhYmFzZS5jOjEwNjA6
MjogZXJyb3I6IElTTyBDOTAgZm9yYmlkcyBtaXhlZCBkZWNsYXJhdGlvbnMgYW5kIGNvZGUgWy1X
ZXJyb3I9ZGVjbGFyYXRpb24tYWZ0ZXItc3RhdGVtZW50XQogMTA2MCB8ICB1aW50MzJfdCBwZXJt
aXNzaW9ucyA9IEJUX0FUVF9QRVJNX1JFQUQgfCBCVF9BVFRfUEVSTV9XUklURTsKICAgICAgfCAg
Xn5+fn5+fn4KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsx
XTogKioqIFtNYWtlZmlsZTo5MjEyOiBzcmMvYmx1ZXRvb3RoZC1nYXR0LWRhdGFiYXNlLm9dIEVy
cm9yIDEKbWFrZTogKioqIFtNYWtlZmlsZToxMDQ0MzogY2hlY2tdIEVycm9yIDIKCgojIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQnVpbGQgdy9leHQgRUxMIC0gTWFrZSAtIEZB
SUwKRGVzYzogQnVpbGQgQmx1ZVogc291cmNlIHdpdGggJy0tZW5hYmxlLWV4dGVybmFsLWVsbCcg
Y29uZmlndXJhdGlvbgpPdXRwdXQ6CnNyYy9nYXR0LWRhdGFiYXNlLmM6IEluIGZ1bmN0aW9uIOKA
mHNlcnZpY2VfYWRkX2NjY+KAmToKc3JjL2dhdHQtZGF0YWJhc2UuYzoxMDYwOjI6IGVycm9yOiBJ
U08gQzkwIGZvcmJpZHMgbWl4ZWQgZGVjbGFyYXRpb25zIGFuZCBjb2RlIFstV2Vycm9yPWRlY2xh
cmF0aW9uLWFmdGVyLXN0YXRlbWVudF0KIDEwNjAgfCAgdWludDMyX3QgcGVybWlzc2lvbnMgPSBC
VF9BVFRfUEVSTV9SRUFEIHwgQlRfQVRUX1BFUk1fV1JJVEU7CiAgICAgIHwgIF5+fn5+fn5+CmNj
MTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMV06ICoqKiBbTWFr
ZWZpbGU6OTIxMjogc3JjL2JsdWV0b290aGQtZ2F0dC1kYXRhYmFzZS5vXSBFcnJvciAxCm1ha2U6
ICoqKiBbTWFrZWZpbGU6NDE1MTogYWxsXSBFcnJvciAyCgoKCgotLS0KUmVnYXJkcywKTGludXgg
Qmx1ZXRvb3RoCgo=

--===============5932063536660408877==--

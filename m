Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A91C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 16:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8504F61440
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 16:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346126AbhI2QvC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Sep 2021 12:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346064AbhI2QvB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Sep 2021 12:51:01 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BDCC06161C
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 09:49:20 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id u1-20020a17090ae00100b0019ec31d3ba2so4656714pjy.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 09:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=YACVxRPp/xKW/D7Kxv/vsPNKjOTH44+9SYNfFhxt2qA=;
        b=dlh0Ihaqp7Sq7ND/pt370z6Os3JG3xTVEyfFsXgbq0SSS+F2P/md0xPfZJnztMPaSf
         7+3lU7s85YjKF3ooFWj75IBaij1XIv0o6h5dfUoTgHNzlf5lfNgH9ApJm2b4sI0HMPS5
         rju3v5+cv84CTvxSmPtARRJK8b/sRhR/d6V/90his4TP/eoVsvgWSl2fF23dX4PCNyMz
         m+HD/YooQDfZcCrJXaqRRbzXqbGyw8dj7arKWR9joT0I1+hsCsVKai9A6FvLztOrZpac
         D/X4qpyddPPy4+qh6THBzwAc8NMxPa2MGXTcUTXJ3thnRonm/CyhvUC011SKV3iEgql7
         yPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=YACVxRPp/xKW/D7Kxv/vsPNKjOTH44+9SYNfFhxt2qA=;
        b=unzLMPBNny2cBa0i4fCTDxNT3/+fFLUM82AMP2aJ0seB3yq9Cms8bJEC04NDkVoRNF
         cTgGTXV+zDjc0NES39d0vD+xdnv+pY2zttiZpAQzinvmr9gcwLid/lcm+c8/uzluQPyO
         n+iRPrjy0FbxaNWTqespkeKfITbWn9+aGj4fdopDafwFi1jZHjmLE3UsiQzATLe8jYx/
         GHY6RY0C4vrHZTRIccAM0IEYgfzLN/b6LTnkhuebtmvJIVE3zQDroBrOmvKO+G40ppXE
         P6mn40mpiQIJDzfkFxyziql2mrL2QoQJUu/9n7El+ySQ86hprS+fooS6EkJ2kUotMVaa
         nQ8g==
X-Gm-Message-State: AOAM530LgewieMzz55BReVU3OKr6+D+fvb6r9xJqizQ/57loSkaqmCnZ
        sli44MH6duOgx1pkEPNQV8esW8Ybqia5MA==
X-Google-Smtp-Source: ABdhPJw4nqZdHCqjwz+fE24FrIcGOKX02wWmqMLMV6UvXyozrdONorUzb/w7vxzHPfsv0o46gW/dZg==
X-Received: by 2002:a17:902:8bc4:b029:12b:8470:e29e with SMTP id r4-20020a1709028bc4b029012b8470e29emr916831plo.2.1632934159471;
        Wed, 29 Sep 2021 09:49:19 -0700 (PDT)
Received: from [172.17.0.2] ([52.183.125.110])
        by smtp.gmail.com with ESMTPSA id n66sm341056pfd.21.2021.09.29.09.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 09:49:18 -0700 (PDT)
Message-ID: <6154990e.1c69fb81.e6ab8.1394@mx.google.com>
Date:   Wed, 29 Sep 2021 09:49:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9094165789134873668=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dmartinez@starry.com
Subject: RE: Optionally require security for notify/indicate
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210929161656.413300-2-dmartinez@starry.com>
References: <20210929161656.413300-2-dmartinez@starry.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9094165789134873668==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NTU1MTEzCgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBGQUlMICAgICAgMC44OCBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjU5IHNlY29uZHMKUHJlcCAtIFNldHVwIEVMTCAgICAgICAgICAgICAgUEFTUyAg
ICAgIDQ0Ljg2IHNlY29uZHMKQnVpbGQgLSBQcmVwICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDAuMTggc2Vjb25kcwpCdWlsZCAtIENvbmZpZ3VyZSAgICAgICAgICAgICBQQVNTICAgICAgNy45
MCBzZWNvbmRzCkJ1aWxkIC0gTWFrZSAgICAgICAgICAgICAgICAgIEZBSUwgICAgICAxNjEuNDIg
c2Vjb25kcwpNYWtlIENoZWNrICAgICAgICAgICAgICAgICAgICBGQUlMICAgICAgMS4zNyBzZWNv
bmRzCk1ha2UgRGlzdGNoZWNrICAgICAgICAgICAgICAgIFBBU1MgICAgICAyMjMuMjkgc2Vjb25k
cwpCdWlsZCB3L2V4dCBFTEwgLSBDb25maWd1cmUgICBQQVNTICAgICAgNy43OSBzZWNvbmRzCkJ1
aWxkIHcvZXh0IEVMTCAtIE1ha2UgICAgICAgIEZBSUwgICAgICAxNDMuMDggc2Vjb25kcwoKRGV0
YWlscwojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tQYXRjaCAtIEZB
SUwKRGVzYzogUnVuIGNoZWNrcGF0Y2gucGwgc2NyaXB0IHdpdGggcnVsZSBpbiAuY2hlY2twYXRj
aC5jb25mCk91dHB1dDoKW0JsdWVaLDEvMl0gZ2F0dDogYWxsb3cgR0FUVCBzZXJ2ZXIgdG8gZGlj
YXRlIENDQyBwZXJtaXNzaW9ucwpXQVJOSU5HOkxPTkdfTElORTogbGluZSBsZW5ndGggb2YgODEg
ZXhjZWVkcyA4MCBjb2x1bW5zCiMxNDQ6IEZJTEU6IHNyYy9nYXR0LWRhdGFiYXNlLmM6MTIyOToK
KwkJCQkJCQkJCTAsIE5VTEwpOwoKV0FSTklORzpMT05HX0xJTkU6IGxpbmUgbGVuZ3RoIG9mIDgx
IGV4Y2VlZHMgODAgY29sdW1ucwojMTU0OiBGSUxFOiBzcmMvZ2F0dC1kYXRhYmFzZS5jOjE2OTQ6
CisJCX0gZWxzZSBpZiAoIXN0cmNtcCgiZW5jcnlwdC1hdXRoZW50aWNhdGVkLWFzeW5jaHJvbm91
cyIsIGZsYWcpKSB7CgpXQVJOSU5HOkxPTkdfTElORTogbGluZSBsZW5ndGggb2YgODYgZXhjZWVk
cyA4MCBjb2x1bW5zCiMxNjY6IEZJTEU6IHNyYy9nYXR0LWRhdGFiYXNlLmM6Mjc5NzoKKwkJCQkJ
CWNjY193cml0ZV9jYiwgY2hyYywgY2hyYy0+cGVybSwgTlVMTCk7CgovZ2l0aHViL3dvcmtzcGFj
ZS9zcmMvMTI1MjYyNzUucGF0Y2ggdG90YWw6IDAgZXJyb3JzLCAzIHdhcm5pbmdzLCA3MCBsaW5l
cyBjaGVja2VkCgpOT1RFOiBGb3Igc29tZSBvZiB0aGUgcmVwb3J0ZWQgZGVmZWN0cywgY2hlY2tw
YXRjaCBtYXkgYmUgYWJsZSB0bwogICAgICBtZWNoYW5pY2FsbHkgY29udmVydCB0byB0aGUgdHlw
aWNhbCBzdHlsZSB1c2luZyAtLWZpeCBvciAtLWZpeC1pbnBsYWNlLgoKL2dpdGh1Yi93b3Jrc3Bh
Y2Uvc3JjLzEyNTI2Mjc1LnBhdGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4K
Ck5PVEU6IElnbm9yZWQgbWVzc2FnZSB0eXBlczogQ09NTUlUX01FU1NBR0UgQ09NUExFWF9NQUNS
TyBDT05TVF9TVFJVQ1QgRklMRV9QQVRIX0NIQU5HRVMgTUlTU0lOR19TSUdOX09GRiBQUkVGRVJf
UEFDS0VEIFNQRFhfTElDRU5TRV9UQUcgU1BMSVRfU1RSSU5HIFNTQ0FORl9UT19LU1RSVE8KCk5P
VEU6IElmIGFueSBvZiB0aGUgZXJyb3JzIGFyZSBmYWxzZSBwb3NpdGl2ZXMsIHBsZWFzZSByZXBv
cnQKICAgICAgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlIENIRUNLUEFUQ0ggaW4gTUFJTlRB
SU5FUlMuCgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEJ1aWxkIC0gTWFr
ZSAtIEZBSUwKRGVzYzogQnVpbGQgdGhlIEJsdWVaIHNvdXJjZSB0cmVlCk91dHB1dDoKc3JjL2dh
dHQtZGF0YWJhc2UuYzogSW4gZnVuY3Rpb24g4oCYc2VydmljZV9hZGRfY2Nj4oCZOgpzcmMvZ2F0
dC1kYXRhYmFzZS5jOjEwNjA6MjogZXJyb3I6IElTTyBDOTAgZm9yYmlkcyBtaXhlZCBkZWNsYXJh
dGlvbnMgYW5kIGNvZGUgWy1XZXJyb3I9ZGVjbGFyYXRpb24tYWZ0ZXItc3RhdGVtZW50XQogMTA2
MCB8ICB1aW50MzJfdCBwZXJtaXNzaW9ucyA9IEJUX0FUVF9QRVJNX1JFQUQgfCBCVF9BVFRfUEVS
TV9XUklURTsKICAgICAgfCAgXn5+fn5+fn4KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRl
ZCBhcyBlcnJvcnMKbWFrZVsxXTogKioqIFtNYWtlZmlsZTo5MjEyOiBzcmMvYmx1ZXRvb3RoZC1n
YXR0LWRhdGFiYXNlLm9dIEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmlsZTo0MTUxOiBhbGxdIEVy
cm9yIDIKCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogTWFrZSBDaGVjayAt
IEZBSUwKRGVzYzogUnVuICdtYWtlIGNoZWNrJwpPdXRwdXQ6CnNyYy9nYXR0LWRhdGFiYXNlLmM6
IEluIGZ1bmN0aW9uIOKAmHNlcnZpY2VfYWRkX2NjY+KAmToKc3JjL2dhdHQtZGF0YWJhc2UuYzox
MDYwOjI6IGVycm9yOiBJU08gQzkwIGZvcmJpZHMgbWl4ZWQgZGVjbGFyYXRpb25zIGFuZCBjb2Rl
IFstV2Vycm9yPWRlY2xhcmF0aW9uLWFmdGVyLXN0YXRlbWVudF0KIDEwNjAgfCAgdWludDMyX3Qg
cGVybWlzc2lvbnMgPSBCVF9BVFRfUEVSTV9SRUFEIHwgQlRfQVRUX1BFUk1fV1JJVEU7CiAgICAg
IHwgIF5+fn5+fn5+CmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1h
a2VbMV06ICoqKiBbTWFrZWZpbGU6OTIxMjogc3JjL2JsdWV0b290aGQtZ2F0dC1kYXRhYmFzZS5v
XSBFcnJvciAxCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTA0NDM6IGNoZWNrXSBFcnJvciAyCgoKIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEJ1aWxkIHcvZXh0IEVMTCAtIE1ha2Ug
LSBGQUlMCkRlc2M6IEJ1aWxkIEJsdWVaIHNvdXJjZSB3aXRoICctLWVuYWJsZS1leHRlcm5hbC1l
bGwnIGNvbmZpZ3VyYXRpb24KT3V0cHV0OgpzcmMvZ2F0dC1kYXRhYmFzZS5jOiBJbiBmdW5jdGlv
biDigJhzZXJ2aWNlX2FkZF9jY2PigJk6CnNyYy9nYXR0LWRhdGFiYXNlLmM6MTA2MDoyOiBlcnJv
cjogSVNPIEM5MCBmb3JiaWRzIG1peGVkIGRlY2xhcmF0aW9ucyBhbmQgY29kZSBbLVdlcnJvcj1k
ZWNsYXJhdGlvbi1hZnRlci1zdGF0ZW1lbnRdCiAxMDYwIHwgIHVpbnQzMl90IHBlcm1pc3Npb25z
ID0gQlRfQVRUX1BFUk1fUkVBRCB8IEJUX0FUVF9QRVJNX1dSSVRFOwogICAgICB8ICBefn5+fn5+
fgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiog
W01ha2VmaWxlOjkyMTI6IHNyYy9ibHVldG9vdGhkLWdhdHQtZGF0YWJhc2Uub10gRXJyb3IgMQpt
YWtlOiAqKiogW01ha2VmaWxlOjQxNTE6IGFsbF0gRXJyb3IgMgoKCgoKLS0tClJlZ2FyZHMsCkxp
bnV4IEJsdWV0b290aAoK

--===============9094165789134873668==--

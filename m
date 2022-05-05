Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2238FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 May 2022 04:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240555AbiEEEVX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 May 2022 00:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiEEEVW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 May 2022 00:21:22 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0811FA6B
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 May 2022 21:17:44 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id hf18so2415985qtb.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 May 2022 21:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=QllhM2g8RaxXX8blYXIpblqD/d0V3SZhsjLhXHf4wRc=;
        b=i5SAVaNahCUPtdZMjBrt78alrQDx+2qpIK/4PqW2Jj4l3qhxd6xAe3mtNw7bzx1gtf
         AqQnB0K5SYAoN4gNGaxY+Sr50GT2lAQGjlvzd34oLpg3v5ZsiGN7JjhAyKhiA7yqcmfd
         iH/eTLJkczSuQi8qOCUjJ/+YgRwZnEiBnnFYtfPOyc6amMFLmf7uuktXNIb8QaBXFJ+7
         K0qcZ6DztSIZMa+nscq0c37cMpFvGgAtZzN0uNRQ2tu21STibHb1CyrCjuL9d8OISTex
         onWZrWAXjm2uqLjTqQ7NeNI1OnGvmRBQLJe3iqu8iqPxRMN6SOpQwr9Qu8n6VVSYVJVY
         /A+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=QllhM2g8RaxXX8blYXIpblqD/d0V3SZhsjLhXHf4wRc=;
        b=ex4Dwl4r3pBTsgywk/8wAUxzn+MKuRAa1HaPXZpa6pwJQfhuCOiMp+QLVy/L90m9sZ
         oHKpmlfb8iko7Il9v0ErGJZ0Gi/DT4muzHDFmP8KH80F2CLCuLFJK2/MhpPc7G6n6HTa
         DJ6RWSCmet/4U98cUpEAVaBSBzPbEKEbw4V3XruNOgqDTXWZtc+jgYpg0c4A2nlBIZA5
         GCq6dXaXasuEbRICtDgFyCXVUBaAY5LXYBzY3EDaayRRUJzT3iDlh1mMvkM1BJEiFeZJ
         HUMibNU0juckfHrXYAW9DP4AnL5XFQg474VQ4mqRc8fPROQLFLHqBEtDir2RE3LBqm0A
         nDsA==
X-Gm-Message-State: AOAM530Y9p/5+SC022MeHi0bkKL/qFkMEdf663YL66FdtxKp0ggmtZQS
        CUJt2FkYwbaakKzJgfcmdJRkztgLwaHUjg==
X-Google-Smtp-Source: ABdhPJzvDri5HDJtxEjUsNjEPADkW9EkRc85IDoPspKLpErcJtcMD+lF3LLV6zGeepQlZCoV+yfOTg==
X-Received: by 2002:ac8:5c8d:0:b0:2f3:537a:b4f2 with SMTP id r13-20020ac85c8d000000b002f3537ab4f2mr22013529qta.384.1651724263196;
        Wed, 04 May 2022 21:17:43 -0700 (PDT)
Received: from [172.17.0.2] ([20.185.245.156])
        by smtp.gmail.com with ESMTPSA id 69-20020a370448000000b0069fc13ce231sm250540qke.98.2022.05.04.21.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 21:17:42 -0700 (PDT)
Message-ID: <62734fe6.1c69fb81.1297c.12f8@mx.google.com>
Date:   Wed, 04 May 2022 21:17:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2614449167202488532=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luozhongyao@gmail.com
Subject: RE: btmon: discard corrupt data
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220505033745.3242729-2-LuoZhongYao@gmail.com>
References: <20220505033745.3242729-2-LuoZhongYao@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2614449167202488532==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NjM4NTU1CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMS40NSBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAxLjA3IHNlY29uZHMKUHJlcCAtIFNldHVwIEVMTCAgICAgICAgICAgICAgUEFTUyAg
ICAgIDQwLjUzIHNlY29uZHMKQnVpbGQgLSBQcmVwICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDAuNjQgc2Vjb25kcwpCdWlsZCAtIENvbmZpZ3VyZSAgICAgICAgICAgICBQQVNTICAgICAgNy45
NyBzZWNvbmRzCkJ1aWxkIC0gTWFrZSAgICAgICAgICAgICAgICAgIEZBSUwgICAgICAyNS40NiBz
ZWNvbmRzCk1ha2UgQ2hlY2sgICAgICAgICAgICAgICAgICAgIEZBSUwgICAgICAxLjEyIHNlY29u
ZHMKTWFrZSBDaGVjayB3L1ZhbGdyaW5kICAgICAgICAgRkFJTCAgICAgIDI3LjI1IHNlY29uZHMK
TWFrZSBEaXN0Y2hlY2sgICAgICAgICAgICAgICAgUEFTUyAgICAgIDIxOC4zMiBzZWNvbmRzCkJ1
aWxkIHcvZXh0IEVMTCAtIENvbmZpZ3VyZSAgIFBBU1MgICAgICA4LjEyIHNlY29uZHMKQnVpbGQg
dy9leHQgRUxMIC0gTWFrZSAgICAgICAgRkFJTCAgICAgIDI2LjE4IHNlY29uZHMKSW5jcmVtZW50
YWwgQnVpbGQgd2l0aCBwYXRjaGVzUEFTUyAgICAgIDAuMDAgc2Vjb25kcwoKRGV0YWlscwojIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQnVpbGQgLSBNYWtlIC0gRkFJTApEZXNj
OiBCdWlsZCB0aGUgQmx1ZVogc291cmNlIHRyZWUKT3V0cHV0Ogptb25pdG9yL2NvbnRyb2wuYzog
SW4gZnVuY3Rpb24g4oCYcHJvY2Vzc19kYXRh4oCZOgptb25pdG9yL2NvbnRyb2wuYzoxMzA5OjIw
OiBlcnJvcjogY29tcGFyaXNvbiBvZiBpbnRlZ2VyIGV4cHJlc3Npb25zIG9mIGRpZmZlcmVudCBz
aWduZWRuZXNzOiDigJhpbnTigJkgYW5kIOKAmGxvbmcgdW5zaWduZWQgaW504oCZIFstV2Vycm9y
PXNpZ24tY29tcGFyZV0KIDEzMDkgfCAgIGlmIChkYXRhX2xlbiArIDIgPiBzaXplb2YoZGF0YS0+
YnVmKSkgewogICAgICB8ICAgICAgICAgICAgICAgICAgICBeCmNjMTogYWxsIHdhcm5pbmdzIGJl
aW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6NzI3NzogbW9uaXRv
ci9jb250cm9sLm9dIEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmlsZTo0MzEwOiBhbGxdIEVycm9y
IDIKCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogTWFrZSBDaGVjayAtIEZB
SUwKRGVzYzogUnVuICdtYWtlIGNoZWNrJwpPdXRwdXQ6Cm1vbml0b3IvY29udHJvbC5jOiBJbiBm
dW5jdGlvbiDigJhwcm9jZXNzX2RhdGHigJk6Cm1vbml0b3IvY29udHJvbC5jOjEzMDk6MjA6IGVy
cm9yOiBjb21wYXJpc29uIG9mIGludGVnZXIgZXhwcmVzc2lvbnMgb2YgZGlmZmVyZW50IHNpZ25l
ZG5lc3M6IOKAmGludOKAmSBhbmQg4oCYbG9uZyB1bnNpZ25lZCBpbnTigJkgWy1XZXJyb3I9c2ln
bi1jb21wYXJlXQogMTMwOSB8ICAgaWYgKGRhdGFfbGVuICsgMiA+IHNpemVvZihkYXRhLT5idWYp
KSB7CiAgICAgIHwgICAgICAgICAgICAgICAgICAgIF4KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcg
dHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsxXTogKioqIFtNYWtlZmlsZTo3Mjc3OiBtb25pdG9yL2Nv
bnRyb2wub10gRXJyb3IgMQptYWtlOiAqKiogW01ha2VmaWxlOjExMjgzOiBjaGVja10gRXJyb3Ig
MgoKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBNYWtlIENoZWNrIHcvVmFs
Z3JpbmQgLSBGQUlMCkRlc2M6IFJ1biAnbWFrZSBjaGVjaycgd2l0aCBWYWxncmluZApPdXRwdXQ6
Cm1vbml0b3IvY29udHJvbC5jOiBJbiBmdW5jdGlvbiDigJhwcm9jZXNzX2RhdGHigJk6Cm1vbml0
b3IvY29udHJvbC5jOjEzMDk6MjA6IGVycm9yOiBjb21wYXJpc29uIG9mIGludGVnZXIgZXhwcmVz
c2lvbnMgb2YgZGlmZmVyZW50IHNpZ25lZG5lc3M6IOKAmGludOKAmSBhbmQg4oCYbG9uZyB1bnNp
Z25lZCBpbnTigJkgWy1XZXJyb3I9c2lnbi1jb21wYXJlXQogMTMwOSB8ICAgaWYgKGRhdGFfbGVu
ICsgMiA+IHNpemVvZihkYXRhLT5idWYpKSB7CiAgICAgIHwgICAgICAgICAgICAgICAgICAgIF4K
Y2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsxXTogKioqIFtN
YWtlZmlsZTo3Mjc3OiBtb25pdG9yL2NvbnRyb2wub10gRXJyb3IgMQptYWtlOiAqKiogW01ha2Vm
aWxlOjQzMTA6IGFsbF0gRXJyb3IgMgoKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpU
ZXN0OiBCdWlsZCB3L2V4dCBFTEwgLSBNYWtlIC0gRkFJTApEZXNjOiBCdWlsZCBCbHVlWiBzb3Vy
Y2Ugd2l0aCAnLS1lbmFibGUtZXh0ZXJuYWwtZWxsJyBjb25maWd1cmF0aW9uCk91dHB1dDoKbW9u
aXRvci9jb250cm9sLmM6IEluIGZ1bmN0aW9uIOKAmHByb2Nlc3NfZGF0YeKAmToKbW9uaXRvci9j
b250cm9sLmM6MTMwOToyMDogZXJyb3I6IGNvbXBhcmlzb24gb2YgaW50ZWdlciBleHByZXNzaW9u
cyBvZiBkaWZmZXJlbnQgc2lnbmVkbmVzczog4oCYaW504oCZIGFuZCDigJhsb25nIHVuc2lnbmVk
IGludOKAmSBbLVdlcnJvcj1zaWduLWNvbXBhcmVdCiAxMzA5IHwgICBpZiAoZGF0YV9sZW4gKyAy
ID4gc2l6ZW9mKGRhdGEtPmJ1ZikpIHsKICAgICAgfCAgICAgICAgICAgICAgICAgICAgXgpjYzE6
IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiogW01ha2Vm
aWxlOjcyNzc6IG1vbml0b3IvY29udHJvbC5vXSBFcnJvciAxCm1ha2U6ICoqKiBbTWFrZWZpbGU6
NDMxMDogYWxsXSBFcnJvciAyCgoKCgotLS0KUmVnYXJkcywKTGludXggQmx1ZXRvb3RoCgo=

--===============2614449167202488532==--

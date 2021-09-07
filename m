Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6276C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Sep 2021 10:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B33E9610C8
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Sep 2021 10:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343596AbhIGKh5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Sep 2021 06:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343582AbhIGKh4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Sep 2021 06:37:56 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30335C061575
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Sep 2021 03:36:50 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id a12so726190qvz.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Sep 2021 03:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=0CRbHLrOZUwJGgFNyC5X/X1ESGUKy6A1F2WR7/26Mbk=;
        b=gysBHAzXHvhtptWjB8U0oYrfy+35nh63+tCiNl0E96sGmMxJhDBRrKLlT5R8701hkg
         BpT3KudAmuyVXg97jtH4CCaAfcGFLZssF8lFhlgA96E+KPP59IykSHronohm8PjMb8J9
         Xo1EMigoACuiJZAEzK5OOJPlxFa9Hk8yms12ykRReVLzF24hX8q801Zt4cq7/Jro76nw
         7MLEx91G9OjivBtlk35uT3g0SYJyGxPg9tYP9Blt+57BGlBajUPIVFqHXN5z3qTAiTqb
         zJ1rUApV+cfKkG3ZRleTo3Z5LWnd+O7wR5XcDri3akyu3uZbmnWooE3codva6ght4Ek8
         LN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=0CRbHLrOZUwJGgFNyC5X/X1ESGUKy6A1F2WR7/26Mbk=;
        b=APnIx8PLkKKu+woc/AWAykp+x0xJVQjGgdnZQBHvHa7/6nbhWsOmhMw7ZI5T9v13Ia
         23r/EWbpJ5rOLwoqULil9GgayufFC36IjZvO7ejVHopq1HapofD51yuX+OHdsAvDOZwS
         ofCO4BbuF9HOOHNzyObxJvFTG9L+aWoDtw/G4ozmVeUjp0Hq/NzSMwfOEbIYWDK29JMu
         P69Tb2poLNZG33x4grJNvO90QwiP3UhUPF8Xis5kCWEK55OxIzrMo6Qfq95miIuJPSBS
         Dc4zt6djrx+iEVVN9IC/KmWhR21nxCMP03s9hhUBE5YhnCZghTowHwjdzlOzzE4/ZWSM
         1EKg==
X-Gm-Message-State: AOAM533bzey4FXGGxWuaXPknWKiDu5cFuIWZpvXmo1aj2fwxaPtCgPeR
        S0mxNhP1rvGxd7gMV56qukE3RV/2Yuk=
X-Google-Smtp-Source: ABdhPJxDJhYxSHJQ36E/kCUcyzl3MMkbdZtSaZewcJmiBpaWOU/JSp2u5ZQgnr7l6E0ILAa1wczFgA==
X-Received: by 2002:a0c:d450:: with SMTP id r16mr15690226qvh.30.1631011009201;
        Tue, 07 Sep 2021 03:36:49 -0700 (PDT)
Received: from [172.17.0.2] ([52.149.160.157])
        by smtp.gmail.com with ESMTPSA id s28sm8433938qkm.43.2021.09.07.03.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 03:36:48 -0700 (PDT)
Message-ID: <613740c0.1c69fb81.ba8f.e5e9@mx.google.com>
Date:   Tue, 07 Sep 2021 03:36:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2742871935301458381=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1,1/3] tools/sco-tester: add test cases to get offload codecs
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210907101520.8473-1-kiran.k@intel.com>
References: <20210907101520.8473-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2742871935301458381==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NTQzMDM3CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBGQUlMICAgICAgMC45NyBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjQzIHNlY29uZHMKUHJlcCAtIFNldHVwIEVMTCAgICAgICAgICAgICAgUEFTUyAg
ICAgIDUzLjMxIHNlY29uZHMKQnVpbGQgLSBQcmVwICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDAuMTYgc2Vjb25kcwpCdWlsZCAtIENvbmZpZ3VyZSAgICAgICAgICAgICBQQVNTICAgICAgOS4z
MSBzZWNvbmRzCkJ1aWxkIC0gTWFrZSAgICAgICAgICAgICAgICAgIEZBSUwgICAgICA5MS43NyBz
ZWNvbmRzCk1ha2UgQ2hlY2sgICAgICAgICAgICAgICAgICAgIEZBSUwgICAgICAwLjU0IHNlY29u
ZHMKTWFrZSBEaXN0Y2hlY2sgICAgICAgICAgICAgICAgUEFTUyAgICAgIDI4MC44NiBzZWNvbmRz
CkJ1aWxkIHcvZXh0IEVMTCAtIENvbmZpZ3VyZSAgIFBBU1MgICAgICA5LjY2IHNlY29uZHMKQnVp
bGQgdy9leHQgRUxMIC0gTWFrZSAgICAgICAgRkFJTCAgICAgIDc4LjQyIHNlY29uZHMKCkRldGFp
bHMKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNrUGF0Y2ggLSBGQUlM
CkRlc2M6IFJ1biBjaGVja3BhdGNoLnBsIHNjcmlwdCB3aXRoIHJ1bGUgaW4gLmNoZWNrcGF0Y2gu
Y29uZgpPdXRwdXQ6CnRvb2xzL3Njby10ZXN0ZXI6IGFkZCB0ZXN0IGNhc2VzIHRvIGdldCBvZmZs
b2FkIGNvZGVjcwpXQVJOSU5HOlBSRUZFUl9ERUZJTkVEX0FUVFJJQlVURV9NQUNSTzogUHJlZmVy
IF9fcGFja2VkIG92ZXIgX19hdHRyaWJ1dGVfXygocGFja2VkKSkKIzI3OiBGSUxFOiBsaWIvYmx1
ZXRvb3RoLmg6MTU0OgorfSBfX2F0dHJpYnV0ZV9fKChwYWNrZWQpKTsKCldBUk5JTkc6UFJFRkVS
X0RFRklORURfQVRUUklCVVRFX01BQ1JPOiBQcmVmZXIgX19wYWNrZWQgb3ZlciBfX2F0dHJpYnV0
ZV9fKChwYWNrZWQpKQojMzI6IEZJTEU6IGxpYi9ibHVldG9vdGguaDoxNTk6Cit9IF9fYXR0cmli
dXRlX18oKHBhY2tlZCkpOwoKLSB0b3RhbDogMCBlcnJvcnMsIDIgd2FybmluZ3MsIDE1MiBsaW5l
cyBjaGVja2VkCgpOT1RFOiBGb3Igc29tZSBvZiB0aGUgcmVwb3J0ZWQgZGVmZWN0cywgY2hlY2tw
YXRjaCBtYXkgYmUgYWJsZSB0bwogICAgICBtZWNoYW5pY2FsbHkgY29udmVydCB0byB0aGUgdHlw
aWNhbCBzdHlsZSB1c2luZyAtLWZpeCBvciAtLWZpeC1pbnBsYWNlLgoKIltQQVRDSF0gdG9vbHMv
c2NvLXRlc3RlcjogYWRkIHRlc3QgY2FzZXMgdG8gZ2V0IG9mZmxvYWQgY29kZWNzIiBoYXMgc3R5
bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuCgpOT1RFOiBJZ25vcmVkIG1lc3NhZ2UgdHlwZXM6
IENPTU1JVF9NRVNTQUdFIENPTVBMRVhfTUFDUk8gQ09OU1RfU1RSVUNUIEZJTEVfUEFUSF9DSEFO
R0VTIE1JU1NJTkdfU0lHTl9PRkYgUFJFRkVSX1BBQ0tFRCBTUERYX0xJQ0VOU0VfVEFHIFNQTElU
X1NUUklORyBTU0NBTkZfVE9fS1NUUlRPCgpOT1RFOiBJZiBhbnkgb2YgdGhlIGVycm9ycyBhcmUg
ZmFsc2UgcG9zaXRpdmVzLCBwbGVhc2UgcmVwb3J0CiAgICAgIHRoZW0gdG8gdGhlIG1haW50YWlu
ZXIsIHNlZSBDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKCiMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIwpUZXN0OiBHaXRMaW50IC0gUEFTUwpEZXNjOiBSdW4gZ2l0bGludCB3aXRoIHJ1
bGUgaW4gLmdpdGxpbnQKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBQcmVw
IC0gU2V0dXAgRUxMIC0gUEFTUwpEZXNjOiBDbG9uZSwgYnVpbGQsIGFuZCBpbnN0YWxsIEVMTAoK
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEJ1aWxkIC0gUHJlcCAtIFBBU1MK
RGVzYzogUHJlcGFyZSBlbnZpcm9ubWVudCBmb3IgYnVpbGQKCiMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIwpUZXN0OiBCdWlsZCAtIENvbmZpZ3VyZSAtIFBBU1MKRGVzYzogQ29uZmlndXJl
IHRoZSBCbHVlWiBzb3VyY2UgdHJlZQoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRl
c3Q6IEJ1aWxkIC0gTWFrZSAtIEZBSUwKRGVzYzogQnVpbGQgdGhlIEJsdWVaIHNvdXJjZSB0cmVl
Ck91dHB1dDoKdG9vbHMvc2NvLXRlc3Rlci5jOiBJbiBmdW5jdGlvbiDigJhlbmFibGVfY29kZWNf
Y2FsbGJhY2vigJk6CnRvb2xzL3Njby10ZXN0ZXIuYzoxMzE6MjA6IGVycm9yOiB1bnVzZWQgdmFy
aWFibGUg4oCYZGF0YeKAmSBbLVdlcnJvcj11bnVzZWQtdmFyaWFibGVdCiAgMTMxIHwgIHN0cnVj
dCB0ZXN0X2RhdGEgKmRhdGEgPSB0ZXN0ZXJfZ2V0X2RhdGEoKTsKICAgICAgfCAgICAgICAgICAg
ICAgICAgICAgXn5+fgp0b29scy9zY28tdGVzdGVyLmM6IEluIGZ1bmN0aW9uIOKAmHRlc3RfY29k
ZWNzX2dldHNvY2tvcHTigJk6CnRvb2xzL3Njby10ZXN0ZXIuYzozNTQ6MjA6IGVycm9yOiB1bnVz
ZWQgdmFyaWFibGUg4oCYY29kZWNz4oCZIFstV2Vycm9yPXVudXNlZC12YXJpYWJsZV0KICAzNTQg
fCAgc3RydWN0IGJ0X2NvZGVjcyAqY29kZWNzOwogICAgICB8ICAgICAgICAgICAgICAgICAgICBe
fn5+fn4KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsxXTog
KioqIFtNYWtlZmlsZTo2OTYyOiB0b29scy9zY28tdGVzdGVyLm9dIEVycm9yIDEKbWFrZTogKioq
IFtNYWtlZmlsZTo0MTUxOiBhbGxdIEVycm9yIDIKCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMKVGVzdDogTWFrZSBDaGVjayAtIEZBSUwKRGVzYzogUnVuICdtYWtlIGNoZWNrJwpPdXRw
dXQ6CnRvb2xzL3Njby10ZXN0ZXIuYzogSW4gZnVuY3Rpb24g4oCYZW5hYmxlX2NvZGVjX2NhbGxi
YWNr4oCZOgp0b29scy9zY28tdGVzdGVyLmM6MTMxOjIwOiBlcnJvcjogdW51c2VkIHZhcmlhYmxl
IOKAmGRhdGHigJkgWy1XZXJyb3I9dW51c2VkLXZhcmlhYmxlXQogIDEzMSB8ICBzdHJ1Y3QgdGVz
dF9kYXRhICpkYXRhID0gdGVzdGVyX2dldF9kYXRhKCk7CiAgICAgIHwgICAgICAgICAgICAgICAg
ICAgIF5+fn4KdG9vbHMvc2NvLXRlc3Rlci5jOiBJbiBmdW5jdGlvbiDigJh0ZXN0X2NvZGVjc19n
ZXRzb2Nrb3B04oCZOgp0b29scy9zY28tdGVzdGVyLmM6MzU0OjIwOiBlcnJvcjogdW51c2VkIHZh
cmlhYmxlIOKAmGNvZGVjc+KAmSBbLVdlcnJvcj11bnVzZWQtdmFyaWFibGVdCiAgMzU0IHwgIHN0
cnVjdCBidF9jb2RlY3MgKmNvZGVjczsKICAgICAgfCAgICAgICAgICAgICAgICAgICAgXn5+fn5+
CmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMV06ICoqKiBb
TWFrZWZpbGU6Njk2MjogdG9vbHMvc2NvLXRlc3Rlci5vXSBFcnJvciAxCm1ha2U6ICoqKiBbTWFr
ZWZpbGU6MTA0NDM6IGNoZWNrXSBFcnJvciAyCgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjClRlc3Q6IE1ha2UgRGlzdGNoZWNrIC0gUEFTUwpEZXNjOiBSdW4gZGlzdGNoZWNrIHRvIGNo
ZWNrIHRoZSBkaXN0cmlidXRpb24KCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0
OiBCdWlsZCB3L2V4dCBFTEwgLSBDb25maWd1cmUgLSBQQVNTCkRlc2M6IENvbmZpZ3VyZSBCbHVl
WiBzb3VyY2Ugd2l0aCAnLS1lbmFibGUtZXh0ZXJuYWwtZWxsJyBjb25maWd1cmF0aW9uCgojIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQnVpbGQgdy9leHQgRUxMIC0gTWFrZSAt
IEZBSUwKRGVzYzogQnVpbGQgQmx1ZVogc291cmNlIHdpdGggJy0tZW5hYmxlLWV4dGVybmFsLWVs
bCcgY29uZmlndXJhdGlvbgpPdXRwdXQ6CnRvb2xzL3Njby10ZXN0ZXIuYzogSW4gZnVuY3Rpb24g
4oCYZW5hYmxlX2NvZGVjX2NhbGxiYWNr4oCZOgp0b29scy9zY28tdGVzdGVyLmM6MTMxOjIwOiBl
cnJvcjogdW51c2VkIHZhcmlhYmxlIOKAmGRhdGHigJkgWy1XZXJyb3I9dW51c2VkLXZhcmlhYmxl
XQogIDEzMSB8ICBzdHJ1Y3QgdGVzdF9kYXRhICpkYXRhID0gdGVzdGVyX2dldF9kYXRhKCk7CiAg
ICAgIHwgICAgICAgICAgICAgICAgICAgIF5+fn4KdG9vbHMvc2NvLXRlc3Rlci5jOiBJbiBmdW5j
dGlvbiDigJh0ZXN0X2NvZGVjc19nZXRzb2Nrb3B04oCZOgp0b29scy9zY28tdGVzdGVyLmM6MzU0
OjIwOiBlcnJvcjogdW51c2VkIHZhcmlhYmxlIOKAmGNvZGVjc+KAmSBbLVdlcnJvcj11bnVzZWQt
dmFyaWFibGVdCiAgMzU0IHwgIHN0cnVjdCBidF9jb2RlY3MgKmNvZGVjczsKICAgICAgfCAgICAg
ICAgICAgICAgICAgICAgXn5+fn5+CmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMg
ZXJyb3JzCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6Njk2MjogdG9vbHMvc2NvLXRlc3Rlci5vXSBF
cnJvciAxCm1ha2U6ICoqKiBbTWFrZWZpbGU6NDE1MTogYWxsXSBFcnJvciAyCgoKCgotLS0KUmVn
YXJkcywKTGludXggQmx1ZXRvb3RoCgo=

--===============2742871935301458381==--

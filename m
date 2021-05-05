Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C48CC433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 May 2021 09:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BC8D613EC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 May 2021 09:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbhEEJlZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 May 2021 05:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbhEEJlZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 May 2021 05:41:25 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509DAC061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 May 2021 02:40:29 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id n22so647568qtk.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 May 2021 02:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=kTyY0whcTSq4jkaygSCNMn8qbr7jkNCOQ1u4HnqL3gE=;
        b=UaP0uU9noR3QcanFgVeYgHb0vDrJlS/cQxmrShbv2veawuTPltbJbSAuZAEMUo4sf5
         B0DpcmXTj3v84XxWzkCzeFqkfBnqCBN+GNLzqCDKCmhQg0ROafKarVI0EkQ6y5ValGmV
         3V3jBu6br22fKkyNk/bWPgIq0V4Zkrr+/sqQSlvNIn4RlV2Gdtqj5G9H1+H01ANsVxeF
         gkdJvcl0TeDdd96jl8eXkV8TrtjXCNKhdBCuwwSiY5MF8SLKBjt+cbpuPUduDtrOfewp
         rWPdeDCeWQJUa8mPUWxrlwl1FwF2bUFcGZS8jBSUSn6pdtiB0iEkU2GnZF7a0+jegvLs
         L73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=kTyY0whcTSq4jkaygSCNMn8qbr7jkNCOQ1u4HnqL3gE=;
        b=KAAAfdjIUfPJxUNzI3XGoAuY+b7kkNrTyU7WiIAqMHAGNSlomRJiWPF5dPaYV7ZtM/
         CmSY5xP6U6/rLZdaQVdonosHR0xbedwqMOdvBnhwXNvzllO9+PPeIELexqU3WCwTTZGR
         dC9G+d6BgrW30Md0JNOZSeOmCa1LEJ5V4sISwQjHE1XI45DMWwFnBOMLMldJjTSXykeD
         8Z7je+PYlaCFE0hoOIzYWseTgHbVRDzLNi8zf0PT0/uknergqx73re8PfqeLF6B8oV8d
         4zKWICskHcSq/9A0nvyqzT9zSilHQZEYbdFSqqDUPnXqDjBPsjqKyhh1GFwQtSKAyDen
         anYw==
X-Gm-Message-State: AOAM532KsYOeRSkEhiL3CRacN6bSWNNTaLi/d4/0v4WGj29ZD6vMxK0K
        0TOruGDULC6LRf5Geq5n25p/nzUwRfw=
X-Google-Smtp-Source: ABdhPJzekbtblYj8BmjOKIo3MqlZNjdsXbq0v9GG6eL1d/9OUnhEHxKQgH76cwHnJnrujCq4Op45nw==
X-Received: by 2002:a05:622a:1746:: with SMTP id l6mr26388581qtk.318.1620207628363;
        Wed, 05 May 2021 02:40:28 -0700 (PDT)
Received: from [172.17.0.2] ([52.177.220.2])
        by smtp.gmail.com with ESMTPSA id y84sm9333582qkb.134.2021.05.05.02.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 02:40:27 -0700 (PDT)
Message-ID: <6092680b.1c69fb81.e7cb2.5dcc@mx.google.com>
Date:   Wed, 05 May 2021 02:40:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6927787957966315080=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez,v2,1/2] PRE-UPSTREAM: unit/gobex: remove timer only when it's not removed yet
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210505170318.Bluez.v2.1.I462ae10efbf980757258cabcce883b212259a793@changeid>
References: <20210505170318.Bluez.v2.1.I462ae10efbf980757258cabcce883b212259a793@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6927787957966315080==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NDc3MTg1CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMS43MSBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjI3IHNlY29uZHMKUHJlcCAtIFNldHVwIEVMTCAgICAgICAgICAgICAgUEFTUyAg
ICAgIDQ5Ljc2IHNlY29uZHMKQnVpbGQgLSBQcmVwICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDAuMTQgc2Vjb25kcwpCdWlsZCAtIENvbmZpZ3VyZSAgICAgICAgICAgICBQQVNTICAgICAgOC43
OSBzZWNvbmRzCkJ1aWxkIC0gTWFrZSAgICAgICAgICAgICAgICAgIEZBSUwgICAgICAxNDQuOTUg
c2Vjb25kcwpNYWtlIENoZWNrICAgICAgICAgICAgICAgICAgICBGQUlMICAgICAgMC43NCBzZWNv
bmRzCk1ha2UgRGlzdCAgICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICAxMS45MyBzZWNvbmRz
Ck1ha2UgRGlzdCAtIENvbmZpZ3VyZSAgICAgICAgIFBBU1MgICAgICA1LjI3IHNlY29uZHMKTWFr
ZSBEaXN0IC0gTWFrZSAgICAgICAgICAgICAgUEFTUyAgICAgIDgzLjI1IHNlY29uZHMKQnVpbGQg
dy9leHQgRUxMIC0gQ29uZmlndXJlICAgUEFTUyAgICAgIDguMTQgc2Vjb25kcwpCdWlsZCB3L2V4
dCBFTEwgLSBNYWtlICAgICAgICBGQUlMICAgICAgMTMxLjU1IHNlY29uZHMKCkRldGFpbHMKIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNrUGF0Y2ggLSBQQVNTCkRlc2M6
IFJ1biBjaGVja3BhdGNoLnBsIHNjcmlwdCB3aXRoIHJ1bGUgaW4gLmNoZWNrcGF0Y2guY29uZgoK
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEdpdExpbnQgLSBQQVNTCkRlc2M6
IFJ1biBnaXRsaW50IHdpdGggcnVsZSBpbiAuZ2l0bGludAoKIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjClRlc3Q6IFByZXAgLSBTZXR1cCBFTEwgLSBQQVNTCkRlc2M6IENsb25lLCBidWls
ZCwgYW5kIGluc3RhbGwgRUxMCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDog
QnVpbGQgLSBQcmVwIC0gUEFTUwpEZXNjOiBQcmVwYXJlIGVudmlyb25tZW50IGZvciBidWlsZAoK
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEJ1aWxkIC0gQ29uZmlndXJlIC0g
UEFTUwpEZXNjOiBDb25maWd1cmUgdGhlIEJsdWVaIHNvdXJjZSB0cmVlCgojIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQnVpbGQgLSBNYWtlIC0gRkFJTApEZXNjOiBCdWlsZCB0
aGUgQmx1ZVogc291cmNlIHRyZWUKT3V0cHV0Ogp1bml0L3Rlc3QtZ29iZXguYzogSW4gZnVuY3Rp
b24g4oCYcmN2X2RhdGHigJk6CnVuaXQvdGVzdC1nb2JleC5jOjQ5OToxMzogZXJyb3I6IGNvbXBh
cmlzb24gb2YgaW50ZWdlciBleHByZXNzaW9ucyBvZiBkaWZmZXJlbnQgc2lnbmVkbmVzczog4oCY
Z3NpemXigJkge2FrYSDigJhsb25nIHVuc2lnbmVkIGludOKAmX0gYW5kIOKAmGdzc2l6ZeKAmSB7
YWthIOKAmGxvbmcgaW504oCZfSBbLVdlcnJvcj1zaWduLWNvbXBhcmVdCiAgNDk5IHwgIGlmIChy
Ynl0ZXMgIT0gYi0+bGVuKSB7CiAgICAgIHwgICAgICAgICAgICAgXn4KY2MxOiBhbGwgd2Fybmlu
Z3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsxXTogKioqIFtNYWtlZmlsZTo2OTMwOiB1
bml0L3Rlc3QtZ29iZXgub10gRXJyb3IgMQptYWtlOiAqKiogW01ha2VmaWxlOjQxMjc6IGFsbF0g
RXJyb3IgMgoKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBNYWtlIENoZWNr
IC0gRkFJTApEZXNjOiBSdW4gJ21ha2UgY2hlY2snCk91dHB1dDoKdW5pdC90ZXN0LWdvYmV4LmM6
IEluIGZ1bmN0aW9uIOKAmHJjdl9kYXRh4oCZOgp1bml0L3Rlc3QtZ29iZXguYzo0OTk6MTM6IGVy
cm9yOiBjb21wYXJpc29uIG9mIGludGVnZXIgZXhwcmVzc2lvbnMgb2YgZGlmZmVyZW50IHNpZ25l
ZG5lc3M6IOKAmGdzaXpl4oCZIHtha2Eg4oCYbG9uZyB1bnNpZ25lZCBpbnTigJl9IGFuZCDigJhn
c3NpemXigJkge2FrYSDigJhsb25nIGludOKAmX0gWy1XZXJyb3I9c2lnbi1jb21wYXJlXQogIDQ5
OSB8ICBpZiAocmJ5dGVzICE9IGItPmxlbikgewogICAgICB8ICAgICAgICAgICAgIF5+CmNjMTog
YWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMV06ICoqKiBbTWFrZWZp
bGU6NjkzMDogdW5pdC90ZXN0LWdvYmV4Lm9dIEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmlsZTox
MDM5NzogY2hlY2tdIEVycm9yIDIKCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVz
dDogTWFrZSBEaXN0IC0gUEFTUwpEZXNjOiBSdW4gJ21ha2UgZGlzdCcgYW5kIGJ1aWxkIHRoZSBk
aXN0cmlidXRpb24gdGFyYmFsbAoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6
IE1ha2UgRGlzdCAtIENvbmZpZ3VyZSAtIFBBU1MKRGVzYzogQ29uZmlndXJlIHRoZSBzb3VyY2Ug
ZnJvbSBkaXN0cmlidXRpb24gdGFyYmFsbAoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
ClRlc3Q6IE1ha2UgRGlzdCAtIE1ha2UgLSBQQVNTCkRlc2M6IEJ1aWxkIHRoZSBzb3VyY2UgZnJv
bSBkaXN0cmlidXRpb24gdGFyYmFsbAoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRl
c3Q6IEJ1aWxkIHcvZXh0IEVMTCAtIENvbmZpZ3VyZSAtIFBBU1MKRGVzYzogQ29uZmlndXJlIEJs
dWVaIHNvdXJjZSB3aXRoICctLWVuYWJsZS1leHRlcm5hbC1lbGwnIGNvbmZpZ3VyYXRpb24KCiMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBCdWlsZCB3L2V4dCBFTEwgLSBNYWtl
IC0gRkFJTApEZXNjOiBCdWlsZCBCbHVlWiBzb3VyY2Ugd2l0aCAnLS1lbmFibGUtZXh0ZXJuYWwt
ZWxsJyBjb25maWd1cmF0aW9uCk91dHB1dDoKdW5pdC90ZXN0LWdvYmV4LmM6IEluIGZ1bmN0aW9u
IOKAmHJjdl9kYXRh4oCZOgp1bml0L3Rlc3QtZ29iZXguYzo0OTk6MTM6IGVycm9yOiBjb21wYXJp
c29uIG9mIGludGVnZXIgZXhwcmVzc2lvbnMgb2YgZGlmZmVyZW50IHNpZ25lZG5lc3M6IOKAmGdz
aXpl4oCZIHtha2Eg4oCYbG9uZyB1bnNpZ25lZCBpbnTigJl9IGFuZCDigJhnc3NpemXigJkge2Fr
YSDigJhsb25nIGludOKAmX0gWy1XZXJyb3I9c2lnbi1jb21wYXJlXQogIDQ5OSB8ICBpZiAocmJ5
dGVzICE9IGItPmxlbikgewogICAgICB8ICAgICAgICAgICAgIF5+CmNjMTogYWxsIHdhcm5pbmdz
IGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6NjkzMDogdW5p
dC90ZXN0LWdvYmV4Lm9dIEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmlsZTo0MTI3OiBhbGxdIEVy
cm9yIDIKCgoKCi0tLQpSZWdhcmRzLApMaW51eCBCbHVldG9vdGgKCg==

--===============6927787957966315080==--

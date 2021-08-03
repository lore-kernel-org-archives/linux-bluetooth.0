Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2EBC4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 22:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33DA061037
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 22:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbhHCWgw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Aug 2021 18:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbhHCWgp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Aug 2021 18:36:45 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305CEC06175F
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 15:36:33 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id b1-20020a17090a8001b029017700de3903so4003672pjn.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 15:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=rdN2JhIjOOQhRcYxKp5fxHXQUXSo2MwDmsRhS4RRhM0=;
        b=pCNb06U83uxKxeEujcPwuZ5N+l3js+hIj4kZdZFMEGIvhoy70aqS3QVEy1mpXe+Q1a
         OUUhCs6/gCJ3FJkyvyhxeK0+guJa4ehBEztzT7jC5ttuwMFSO4fUpkFwbEiTJs2Evbb0
         OH3he9ejcwqGnSG6ph8oWzGFhJ2ZrGgs22cIXm0nkXQFPO64I4fczon8IXDDvHVo61hf
         uZH2RO1YVqATDBDz60wXTdWvoLrdmna6qyHAc6oUNsqtQLZYvoYIyffr26vlRYE1zqqe
         LosatybsRLdUcX/0LS9BRG3erdADADnOVg954sE4N2EeLg8PviAEzZxKQ0LXIJIEBctw
         pN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=rdN2JhIjOOQhRcYxKp5fxHXQUXSo2MwDmsRhS4RRhM0=;
        b=mfjnUMH9iXxxOC1EfD7g3lBX7nLjYzFTA4wm5uOL0/zSZFzgLQJl6S0gYDiws3ACVz
         /SbYi8dpyk/0WLfSov45YGIrSri5SD3wf5VmzQc17veCQL8DIhOlpkQZ1ETIBI5S9793
         wrtXebZ8zqs0/ifVQy0sFF+Seatq2mkjfu4GLgdRVz/W4cD8gpDhZSpa1hD4VWmUNd1d
         Sk+upUOBquTA1bsLIQ3gZsGtw0YRzuKjWCkW5cnqxEWtKcdoLQJ3CclqW9RmZcLn4bL+
         pE1sOBTL/uU4tLdpBwO21AnuTREDXIdxjeDhJrh83a97zlb+2yUdGG6qubl1sb1Cxqnm
         o2vg==
X-Gm-Message-State: AOAM533+GjUYMXOV7zs3T6HRTBlcfyCW+DHNWTpoGJQcYd4VzPGeeYoq
        cPU3PNZQ74vWIGiW0dyzrplJ0H5waJs=
X-Google-Smtp-Source: ABdhPJwvZ0OAo7jm2Ph19AA5TqHwMEmh0wcpELJ18dc64xl/K44ZZsuwwUhHUzyO6iA+gylCPqZ2Tw==
X-Received: by 2002:aa7:8f05:0:b029:3b4:ff54:9a10 with SMTP id x5-20020aa78f050000b02903b4ff549a10mr18486033pfr.29.1628030192384;
        Tue, 03 Aug 2021 15:36:32 -0700 (PDT)
Received: from [172.17.0.2] ([52.183.119.12])
        by smtp.gmail.com with ESMTPSA id s39sm227887pfg.131.2021.08.03.15.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 15:36:31 -0700 (PDT)
Message-ID: <6109c4ef.1c69fb81.9a8c4.143e@mx.google.com>
Date:   Tue, 03 Aug 2021 15:36:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7005974465940057564=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC] a2dp: Invalidate cache if SetConfiguration fails
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210803214133.87090-1-luiz.dentz@gmail.com>
References: <20210803214133.87090-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7005974465940057564==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NTI1OTA1CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMC41MyBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjEzIHNlY29uZHMKUHJlcCAtIFNldHVwIEVMTCAgICAgICAgICAgICAgUEFTUyAg
ICAgIDUwLjc3IHNlY29uZHMKQnVpbGQgLSBQcmVwICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDAuMTQgc2Vjb25kcwpCdWlsZCAtIENvbmZpZ3VyZSAgICAgICAgICAgICBQQVNTICAgICAgOC43
NiBzZWNvbmRzCkJ1aWxkIC0gTWFrZSAgICAgICAgICAgICAgICAgIEZBSUwgICAgICAxNjguODMg
c2Vjb25kcwpNYWtlIENoZWNrICAgICAgICAgICAgICAgICAgICBGQUlMICAgICAgMS40OSBzZWNv
bmRzCk1ha2UgRGlzdGNoZWNrICAgICAgICAgICAgICAgIFBBU1MgICAgICAyNTguODUgc2Vjb25k
cwpCdWlsZCB3L2V4dCBFTEwgLSBDb25maWd1cmUgICBQQVNTICAgICAgOC43MyBzZWNvbmRzCkJ1
aWxkIHcvZXh0IEVMTCAtIE1ha2UgICAgICAgIEZBSUwgICAgICAxNTMuNjggc2Vjb25kcwoKRGV0
YWlscwojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tQYXRjaCAtIFBB
U1MKRGVzYzogUnVuIGNoZWNrcGF0Y2gucGwgc2NyaXB0IHdpdGggcnVsZSBpbiAuY2hlY2twYXRj
aC5jb25mCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogR2l0TGludCAtIFBB
U1MKRGVzYzogUnVuIGdpdGxpbnQgd2l0aCBydWxlIGluIC5naXRsaW50CgojIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogUHJlcCAtIFNldHVwIEVMTCAtIFBBU1MKRGVzYzogQ2xv
bmUsIGJ1aWxkLCBhbmQgaW5zdGFsbCBFTEwKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IwpUZXN0OiBCdWlsZCAtIFByZXAgLSBQQVNTCkRlc2M6IFByZXBhcmUgZW52aXJvbm1lbnQgZm9y
IGJ1aWxkCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQnVpbGQgLSBDb25m
aWd1cmUgLSBQQVNTCkRlc2M6IENvbmZpZ3VyZSB0aGUgQmx1ZVogc291cmNlIHRyZWUKCiMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBCdWlsZCAtIE1ha2UgLSBGQUlMCkRlc2M6
IEJ1aWxkIHRoZSBCbHVlWiBzb3VyY2UgdHJlZQpPdXRwdXQ6CnByb2ZpbGVzL2F1ZGlvL2F2ZHRw
LmM6IEluIGZ1bmN0aW9uIOKAmGF2ZHRwX3VucmVnaXN0ZXJfcmVtb3RlX3NlcOKAmToKcHJvZmls
ZXMvYXVkaW8vYXZkdHAuYzozMzc2OjE6IGVycm9yOiBjb250cm9sIHJlYWNoZXMgZW5kIG9mIG5v
bi12b2lkIGZ1bmN0aW9uIFstV2Vycm9yPXJldHVybi10eXBlXQogMzM3NiB8IH0KICAgICAgfCBe
CmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMV06ICoqKiBb
TWFrZWZpbGU6ODU1MzogcHJvZmlsZXMvYXVkaW8vYmx1ZXRvb3RoZC1hdmR0cC5vXSBFcnJvciAx
Cm1ha2U6ICoqKiBbTWFrZWZpbGU6NDE0MjogYWxsXSBFcnJvciAyCgoKIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjClRlc3Q6IE1ha2UgQ2hlY2sgLSBGQUlMCkRlc2M6IFJ1biAnbWFrZSBj
aGVjaycKT3V0cHV0Ogpwcm9maWxlcy9hdWRpby9hdmR0cC5jOiBJbiBmdW5jdGlvbiDigJhhdmR0
cF91bnJlZ2lzdGVyX3JlbW90ZV9zZXDigJk6CnByb2ZpbGVzL2F1ZGlvL2F2ZHRwLmM6MzM3Njox
OiBlcnJvcjogY29udHJvbCByZWFjaGVzIGVuZCBvZiBub24tdm9pZCBmdW5jdGlvbiBbLVdlcnJv
cj1yZXR1cm4tdHlwZV0KIDMzNzYgfCB9CiAgICAgIHwgXgpjYzE6IGFsbCB3YXJuaW5ncyBiZWlu
ZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiogW01ha2VmaWxlOjg1NTM6IHByb2ZpbGVz
L2F1ZGlvL2JsdWV0b290aGQtYXZkdHAub10gRXJyb3IgMQptYWtlOiAqKiogW01ha2VmaWxlOjEw
NDE0OiBjaGVja10gRXJyb3IgMgoKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0
OiBNYWtlIERpc3RjaGVjayAtIFBBU1MKRGVzYzogUnVuIGRpc3RjaGVjayB0byBjaGVjayB0aGUg
ZGlzdHJpYnV0aW9uCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQnVpbGQg
dy9leHQgRUxMIC0gQ29uZmlndXJlIC0gUEFTUwpEZXNjOiBDb25maWd1cmUgQmx1ZVogc291cmNl
IHdpdGggJy0tZW5hYmxlLWV4dGVybmFsLWVsbCcgY29uZmlndXJhdGlvbgoKIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEJ1aWxkIHcvZXh0IEVMTCAtIE1ha2UgLSBGQUlMCkRl
c2M6IEJ1aWxkIEJsdWVaIHNvdXJjZSB3aXRoICctLWVuYWJsZS1leHRlcm5hbC1lbGwnIGNvbmZp
Z3VyYXRpb24KT3V0cHV0Ogpwcm9maWxlcy9hdWRpby9hdmR0cC5jOiBJbiBmdW5jdGlvbiDigJhh
dmR0cF91bnJlZ2lzdGVyX3JlbW90ZV9zZXDigJk6CnByb2ZpbGVzL2F1ZGlvL2F2ZHRwLmM6MzM3
NjoxOiBlcnJvcjogY29udHJvbCByZWFjaGVzIGVuZCBvZiBub24tdm9pZCBmdW5jdGlvbiBbLVdl
cnJvcj1yZXR1cm4tdHlwZV0KIDMzNzYgfCB9CiAgICAgIHwgXgpjYzE6IGFsbCB3YXJuaW5ncyBi
ZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiogW01ha2VmaWxlOjg1NTM6IHByb2Zp
bGVzL2F1ZGlvL2JsdWV0b290aGQtYXZkdHAub10gRXJyb3IgMQptYWtlOiAqKiogW01ha2VmaWxl
OjQxNDI6IGFsbF0gRXJyb3IgMgoKCgoKLS0tClJlZ2FyZHMsCkxpbnV4IEJsdWV0b290aAoK

--===============7005974465940057564==--

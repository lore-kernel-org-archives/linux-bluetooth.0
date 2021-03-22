Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850DAC433C1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Mar 2021 08:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B66A61967
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Mar 2021 08:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhCVIEx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Mar 2021 04:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhCVIEl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Mar 2021 04:04:41 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B604C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Mar 2021 01:04:41 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id 94so11702981qtc.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Mar 2021 01:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=8/89NFkFgUu4uOa0qgiE5sL3l8tcKspELlk4731WEnA=;
        b=CdvoFPjjXMsOFVRBmCZl1y1bIyJKXp+Izsr3ZL2nfVdAeg880JvtBkC/OjNs+bmOzH
         qoHWexH1bsQ3A5mifWFTt2ITvxV40XG2aTeFMuBUMCf+ZrbWEVdVBq47FKAZ/oPagOCO
         KBLpfp/4xeMZnLnptXpOccyOFPz7UtEEKJ5xyepTDht13D1HT3yk7juPzr/hUqugaG24
         KkgdjhMVJbgZ3YKmuSllCliJ6JAUbKU2vDiIcqJByC6R2swemrmgHbfofEfwYBhud8IW
         op5as4rhWLg7gZ1wd49HgBmKSfo6a+0zS2yTpLYFeI1Q4l9fpoxNQ8AaKqwESQJPCw2I
         t4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=8/89NFkFgUu4uOa0qgiE5sL3l8tcKspELlk4731WEnA=;
        b=GUs5YxP+G3D+KVgfL7wcxRQ7ISmKuW8rZfT1+DhymAFSMIY5khRSxTc3QlIDAfdSzC
         lsQPegjyxWWDh0BGgCv+o72kx84QY39bnwvHlrywSAUUgSV5UQ9hYENV5RjLpamSrHni
         JGdS/krr3A+KU6eWB8zTVePDHWIadHINDYPHcXPzPUV0Ke0xcvINttVegWYDwh56EXnG
         vy5JG/cD8WBC247RQfWS+5Vv1CbOtgAdTKcqcOUYoJSsH8/Bk1CxEuzyzd43/XEGhfmW
         +cbIKPqFXS79R/x4MVz/t87yBUFt2iSmgfa4Wczr7FFaQF63wTP1dYS6RLTOkC6KaKGy
         /saA==
X-Gm-Message-State: AOAM531NXvj6co6cq1z4fBPSFgXQpQNfW9GXFlbnXGCD5ubUf5LdxHrH
        3f8XFgpAH5RIVMFUgx3bsLcWoIjBZ/hJpMTe
X-Google-Smtp-Source: ABdhPJwqOYR6V1zZv2fYS3Ab6uYRVRfLeyZ/hVyiZRFKrroD925zcZd/IElEC4khUfhjgoFh29n8qA==
X-Received: by 2002:aed:2fc6:: with SMTP id m64mr8583501qtd.267.1616400280032;
        Mon, 22 Mar 2021 01:04:40 -0700 (PDT)
Received: from [172.17.0.2] ([104.209.143.73])
        by smtp.gmail.com with ESMTPSA id g14sm10334611qkm.98.2021.03.22.01.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 01:04:39 -0700 (PDT)
Message-ID: <60584f97.1c69fb81.5f3b.c29d@mx.google.com>
Date:   Mon, 22 Mar 2021 01:04:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7510445489131632319=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez,v3,1/2] adv_monitor: split rssi_parameters into its own struct
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210322155118.Bluez.v3.1.I8797a75fcc7c1e997f177b08dc23a1df0272e0a5@changeid>
References: <20210322155118.Bluez.v3.1.I8797a75fcc7c1e997f177b08dc23a1df0272e0a5@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7510445489131632319==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NDUyNjQzCgotLS1U
ZXN0IHJlc3VsdC0tLQoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNr
UGF0Y2ggLSBQQVNTCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tH
aXRMaW50IC0gUEFTUwoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNr
QnVpbGQgLSBGQUlMCk91dHB1dDoKc3JjL2Fkdl9tb25pdG9yLmM6IEluIGZ1bmN0aW9uIOKAmG1v
bml0b3JfcHJveHlfYWRkZWRfY2LigJk6CnNyYy9hZHZfbW9uaXRvci5jOjEyMjI6NjogZXJyb3I6
IHBhc3NpbmcgYXJndW1lbnQgMiBvZiDigJhxdWV1ZV9maW5k4oCZIGZyb20gaW5jb21wYXRpYmxl
IHBvaW50ZXIgdHlwZSBbLVdlcnJvcj1pbmNvbXBhdGlibGUtcG9pbnRlci10eXBlc10KIDEyMjIg
fCAgICAgIG1lcmdlZF9wYXR0ZXJuX2lzX2VxdWFsLAogICAgICB8ICAgICAgXn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn4KICAgICAgfCAgICAgIHwKICAgICAgfCAgICAgIF9Cb29sICgqKShzdHJ1Y3Qg
YWR2X21vbml0b3JfbWVyZ2VkX3BhdHRlcm4gKiwgc3RydWN0IGFkdl9tb25pdG9yX21lcmdlZF9w
YXR0ZXJuICopCkluIGZpbGUgaW5jbHVkZWQgZnJvbSBzcmMvYWR2X21vbml0b3IuYzozMzoKLi9z
cmMvc2hhcmVkL3F1ZXVlLmg6Mzk6Nzogbm90ZTogZXhwZWN0ZWQg4oCYcXVldWVfbWF0Y2hfZnVu
Y1904oCZIHtha2Eg4oCYX0Jvb2wgKCopKGNvbnN0IHZvaWQgKiwgY29uc3Qgdm9pZCAqKeKAmX0g
YnV0IGFyZ3VtZW50IGlzIG9mIHR5cGUg4oCYX0Jvb2wgKCopKHN0cnVjdCBhZHZfbW9uaXRvcl9t
ZXJnZWRfcGF0dGVybiAqLCBzdHJ1Y3QgYWR2X21vbml0b3JfbWVyZ2VkX3BhdHRlcm4gKinigJkK
ICAgMzkgfCB2b2lkICpxdWV1ZV9maW5kKHN0cnVjdCBxdWV1ZSAqcXVldWUsIHF1ZXVlX21hdGNo
X2Z1bmNfdCBmdW5jdGlvbiwKICAgICAgfCAgICAgICBefn5+fn5+fn5+CmNjMTogYWxsIHdhcm5p
bmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6OTI3Njog
c3JjL2JsdWV0b290aGQtYWR2X21vbml0b3Iub10gRXJyb3IgMQptYWtlOiAqKiogW01ha2VmaWxl
OjQwMjg6IGFsbF0gRXJyb3IgMgoKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0
OiBNYWtlQ2hlY2sgLSBTS0lQUEVECk91dHB1dDoKY2hlY2tidWlsZCBub3Qgc3VjY2VzcwoKCgot
LS0KUmVnYXJkcywKTGludXggQmx1ZXRvb3RoCgo=

--===============7510445489131632319==--

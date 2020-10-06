Return-Path: <SRS0=Tswr=DN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0ECBC4727F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Oct 2020 01:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E2D72084C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Oct 2020 01:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHtSfjR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgJFBMW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Oct 2020 21:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgJFBMV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Oct 2020 21:12:21 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A209C0613CE
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2020 18:12:21 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id m9so10933927qth.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2020 18:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=fPr7ZTcd3zy73Q8RmM8pGDr7YaTCmPZjcxMenka1jIA=;
        b=IHtSfjR7jP1bAR1VmPQP7CT5fa9NrGqhQfs0+32jlUjH/GynMzH3EjLku27Z5E+k9n
         MuHeUVDiqi0t/ShtgDswugr1E0LsZ0VTsS6FHmiJzxQCiPUo/N8pp/l5A18J/Y3NCftt
         NK4Ex7UXniKxHlt/WY+qKuVMvQfvu2AtX/IPAHppkbatte0hjJ9A4+Z7qndWK5HZWl5K
         rdAubfw/PRiIFetHzF/Lud0uOTHGfRy/lPQfuVCM9XhPBjxj1ExjSayNYjs56Lt0JZWE
         hzebt86S46AtunAPcKnfh/T5e2v9p5nyoJ8YrThFP2yMCzZpBp1zS6EM341sKWavgjgi
         NsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=fPr7ZTcd3zy73Q8RmM8pGDr7YaTCmPZjcxMenka1jIA=;
        b=TF0sWSO3x162kSGnzRXXTMKhIp3FamD9M3+aHDUvXkuCA4A54ezyRKzClcFMiMMcaJ
         pJLTaXUWfEQ1QheNCnM1Nfn9XHknxuFsiIeUbeI1dvphV5siMbJveTypHKSKGl+EnA5y
         Ys3LXY7Vdi+xqyCA5uD29UfZhSJWZgXlR6RYqYhFtc98eFimMsedhNNulYFVUnxKB16u
         tTjAzzCnWmhCkL5fFEvpBFUfvp9U4rmGuroOFKd5Mex/og68WORXdO8KobcrSwC43M2R
         yQiNVVgIsR7TFAUAv+L7zmbcTXBOrTBtzKgxgcpnsh7SqgRhQMmj2kUS/SZc4D+I/bPv
         5EyQ==
X-Gm-Message-State: AOAM532/+EA65GoVz/XbFAkbSwH+eKXXYg71DPrx+5wBryZHkReCSa/B
        dVqH9fIWPXgB8MDJOp49a2fwlBuTc1qrmQ==
X-Google-Smtp-Source: ABdhPJz7/ur3bcm8MU/wAiIIHhfvVR4L45/FbamIT+N/oRgQLGrPPBF8vFpF09y4KYpRyqX47QUFng==
X-Received: by 2002:ac8:12c4:: with SMTP id b4mr2872233qtj.224.1601946740510;
        Mon, 05 Oct 2020 18:12:20 -0700 (PDT)
Received: from [172.17.0.2] ([20.44.64.237])
        by smtp.gmail.com with ESMTPSA id l25sm1249194qtf.18.2020.10.05.18.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 18:12:19 -0700 (PDT)
Message-ID: <5f7bc473.1c69fb81.e588e.337c@mx.google.com>
Date:   Mon, 05 Oct 2020 18:12:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2251213981832328963=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mcchou@chromium.org
Subject: RE: [BlueZ,v5,1/6] adv_monitor: Implement RSSI Filter logic for background scanning
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201005175052.BlueZ.v5.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
References: <20201005175052.BlueZ.v5.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2251213981832328963==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9MzYwMDc3CgotLS1U
ZXN0IHJlc3VsdC0tLQoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNr
UGF0Y2ggLSBQQVNTCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tH
aXRMaW50IC0gUEFTUwoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNr
QnVpbGQgLSBGQUlMCk91dHB1dDoKYXI6IGB1JyBtb2RpZmllciBpZ25vcmVkIHNpbmNlIGBEJyBp
cyB0aGUgZGVmYXVsdCAoc2VlIGBVJykKYXI6IGB1JyBtb2RpZmllciBpZ25vcmVkIHNpbmNlIGBE
JyBpcyB0aGUgZGVmYXVsdCAoc2VlIGBVJykKYXI6IGB1JyBtb2RpZmllciBpZ25vcmVkIHNpbmNl
IGBEJyBpcyB0aGUgZGVmYXVsdCAoc2VlIGBVJykKYXI6IGB1JyBtb2RpZmllciBpZ25vcmVkIHNp
bmNlIGBEJyBpcyB0aGUgZGVmYXVsdCAoc2VlIGBVJykKYXI6IGB1JyBtb2RpZmllciBpZ25vcmVk
IHNpbmNlIGBEJyBpcyB0aGUgZGVmYXVsdCAoc2VlIGBVJykKc3JjL2Fkdl9tb25pdG9yLmM6MTA5
MDoxMzogZXJyb3I6IOKAmGFkdl9tb25pdG9yX2ZpbHRlcl9yc3Np4oCZIGRlZmluZWQgYnV0IG5v
dCB1c2VkIFstV2Vycm9yPXVudXNlZC1mdW5jdGlvbl0KIDEwOTAgfCBzdGF0aWMgdm9pZCBhZHZf
bW9uaXRvcl9maWx0ZXJfcnNzaShzdHJ1Y3QgYWR2X21vbml0b3IgKm1vbml0b3IsCiAgICAgIHwg
ICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KY2MxOiBhbGwgd2FybmluZ3MgYmVp
bmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsxXTogKioqIFtNYWtlZmlsZTo5MjYwOiBzcmMvYmx1
ZXRvb3RoZC1hZHZfbW9uaXRvci5vXSBFcnJvciAxCm1ha2U6ICoqKiBbTWFrZWZpbGU6NDAyMDog
YWxsXSBFcnJvciAyCgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IE1ha2VD
aGVjayAtIFNLSVBQRUQKT3V0cHV0OgpjaGVja2J1aWxkIG5vdCBzdWNjZXNzCgoKCi0tLQpSZWdh
cmRzLApMaW51eCBCbHVldG9vdGgKCg==

--===============2251213981832328963==--

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F76AC433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 23:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6776664DD1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 23:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhA0XrG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Jan 2021 18:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbhA0Xou (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Jan 2021 18:44:50 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1637C0613D6
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jan 2021 15:44:09 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id c12so2862880qtv.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jan 2021 15:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=CknjbS4T+65K8nPGmer6de1Xj1UIb6t3J6tHluwaiM8=;
        b=C3tjXbGljL+anZXq0ZuEvGMEpqzXAR+7R6RWyvlo8RJhQxi4HUSl0a7UygMFV7/KP4
         dngWUo5TP7t7kr9pP1q+zst+bqstQdbms2HuWIzZX2nivRQi67kaxJFIUirO7s0uhaMe
         HYDY7LMsMZ3TrRr7FOuuhy+GTl+peBhx8sWg4c5+JhJbdPSrJa6BDRBOG30X7XsCaVCm
         dHYVgjV4VPH5KsiGgPCKl/ZDa9RRw/riKI94m7GN8jljU7H+bZb01zpCr4+Xy1U/xhw2
         n/RVuPkz7YD+98KlwS33aofPdoG8GOjii1Uq+nw7h/KIEOtzBbTsTRMjSURXrguuX0Q8
         tfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=CknjbS4T+65K8nPGmer6de1Xj1UIb6t3J6tHluwaiM8=;
        b=WLhxzOBf8vcybzP00y5YK11Cj6NDNn7dsvHYul1/HaaN1FMRsxqp0pp0Ak+f/hStSy
         WjFEMd8NXrVcpbAhmv7E9Mr5W4/8MKn8pNZS6jivqH3vAF6caWuJlaeSsaLcZwJ0WqNo
         l1QVfBToJPVQW+GzK9rFJR1uR1bOgW7ZVpIT9cNm0zJiT7j5dVZJ5xtRbyEPw8ubmibO
         M5NtK+OvBEuBIiwhUn18JzAYcjOUh0Kpfs61kQKr5vK6wz0AMktjaAvvdW0HBbJoFsJ8
         AkAk3EVOiNAQZmT2Mtz7Vfk1esrkeF8KYPoYHPha1494TlVXzoKjurggRU5/+mJbUTmy
         qcng==
X-Gm-Message-State: AOAM531+IPeOWW3ZU1FGDu6ZkJa2n/hOZcyriZiPV9Mj9iw9lcREoJ71
        HCNcvhr4+FSv3BOpBlg5kV+vBWqzQSBVNg==
X-Google-Smtp-Source: ABdhPJwu2vReTgEX4qrNmHIbm5224Xqjz81FOnJf4L8IyLXEkCgVPzaL2zaEYUn7+gJqhFIY32YQ8g==
X-Received: by 2002:ac8:6f54:: with SMTP id n20mr11838460qtv.65.1611791048991;
        Wed, 27 Jan 2021 15:44:08 -0800 (PST)
Received: from [172.17.0.2] ([20.190.240.125])
        by smtp.gmail.com with ESMTPSA id 17sm2631855qtu.23.2021.01.27.15.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 15:44:08 -0800 (PST)
Message-ID: <6011fac8.1c69fb81.9bc93.1857@mx.google.com>
Date:   Wed, 27 Jan 2021 15:44:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7041670181033407889=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: Fix 32 bit Compiler Errors
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210127231005.1579325-2-brian.gix@intel.com>
References: <20210127231005.1579325-2-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7041670181033407889==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NDIzMjU5CgotLS1U
ZXN0IHJlc3VsdC0tLQoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNr
UGF0Y2ggLSBGQUlMCk91dHB1dDoKYWR2ZXJ0aXNpbmc6IEZpeCBmb3JtYXRlciBmb3Igc2l6ZV90
IGRhdGEgdHlwZQpXQVJOSU5HOkNPTU1JVF9MT0dfTE9OR19MSU5FOiBQb3NzaWJsZSB1bndyYXBw
ZWQgY29tbWl0IGRlc2NyaXB0aW9uIChwcmVmZXIgYSBtYXhpbXVtIDc1IGNoYXJzIHBlciBsaW5l
KQojMTc6IAp1bnNpZ25lZCBpbnTigJksIGJ1dCBhcmd1bWVudCA1IGhhcyB0eXBlIOKAmHVuc2ln
bmVkIGludOKAmSBbLVdlcnJvcj1mb3JtYXQ9XQoKLSB0b3RhbDogMCBlcnJvcnMsIDEgd2Fybmlu
Z3MsIDggbGluZXMgY2hlY2tlZAoKTk9URTogRm9yIHNvbWUgb2YgdGhlIHJlcG9ydGVkIGRlZmVj
dHMsIGNoZWNrcGF0Y2ggbWF5IGJlIGFibGUgdG8KICAgICAgbWVjaGFuaWNhbGx5IGNvbnZlcnQg
dG8gdGhlIHR5cGljYWwgc3R5bGUgdXNpbmcgLS1maXggb3IgLS1maXgtaW5wbGFjZS4KCiJbUEFU
Q0hdIGFkdmVydGlzaW5nOiBGaXggZm9ybWF0ZXIgZm9yIHNpemVfdCBkYXRhIHR5cGUiIGhhcyBz
dHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4KCk5PVEU6IElnbm9yZWQgbWVzc2FnZSB0eXBl
czogQ09NTUlUX01FU1NBR0UgQ09NUExFWF9NQUNSTyBDT05TVF9TVFJVQ1QgRklMRV9QQVRIX0NI
QU5HRVMgTUlTU0lOR19TSUdOX09GRiBQUkVGRVJfUEFDS0VEIFNQTElUX1NUUklORyBTU0NBTkZf
VE9fS1NUUlRPCgpOT1RFOiBJZiBhbnkgb2YgdGhlIGVycm9ycyBhcmUgZmFsc2UgcG9zaXRpdmVz
LCBwbGVhc2UgcmVwb3J0CiAgICAgIHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZSBDSEVDS1BB
VENIIGluIE1BSU5UQUlORVJTLgoKdG9vbHMvbWdtdC10ZXN0ZXI6IEZpeCBmb3JtYXR0ZXIgZm9y
IHNpemVfdCB2YWx1ZQpXQVJOSU5HOkNPTU1JVF9MT0dfTE9OR19MSU5FOiBQb3NzaWJsZSB1bndy
YXBwZWQgY29tbWl0IGRlc2NyaXB0aW9uIChwcmVmZXIgYSBtYXhpbXVtIDc1IGNoYXJzIHBlciBs
aW5lKQojMTY6IArigJhsb25nIHVuc2lnbmVkIGludOKAmSwgYnV0IGFyZ3VtZW50IDIgaGFzIHR5
cGUg4oCYdW5zaWduZWQgaW504oCZIFstV2Vycm9yPWZvcm1hdD1dCgotIHRvdGFsOiAwIGVycm9y
cywgMSB3YXJuaW5ncywgOCBsaW5lcyBjaGVja2VkCgpOT1RFOiBGb3Igc29tZSBvZiB0aGUgcmVw
b3J0ZWQgZGVmZWN0cywgY2hlY2twYXRjaCBtYXkgYmUgYWJsZSB0bwogICAgICBtZWNoYW5pY2Fs
bHkgY29udmVydCB0byB0aGUgdHlwaWNhbCBzdHlsZSB1c2luZyAtLWZpeCBvciAtLWZpeC1pbnBs
YWNlLgoKIltQQVRDSF0gdG9vbHMvbWdtdC10ZXN0ZXI6IEZpeCBmb3JtYXR0ZXIgZm9yIHNpemVf
dCB2YWx1ZSIgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LgoKTk9URTogSWdub3Jl
ZCBtZXNzYWdlIHR5cGVzOiBDT01NSVRfTUVTU0FHRSBDT01QTEVYX01BQ1JPIENPTlNUX1NUUlVD
VCBGSUxFX1BBVEhfQ0hBTkdFUyBNSVNTSU5HX1NJR05fT0ZGIFBSRUZFUl9QQUNLRUQgU1BMSVRf
U1RSSU5HIFNTQ0FORl9UT19LU1RSVE8KCk5PVEU6IElmIGFueSBvZiB0aGUgZXJyb3JzIGFyZSBm
YWxzZSBwb3NpdGl2ZXMsIHBsZWFzZSByZXBvcnQKICAgICAgdGhlbSB0byB0aGUgbWFpbnRhaW5l
ciwgc2VlIENIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjClRlc3Q6IENoZWNrR2l0TGludCAtIFBBU1MKCiMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIwpUZXN0OiBDaGVja0J1aWxkIC0gUEFTUwoKIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjClRlc3Q6IE1ha2VDaGVjayAtIFBBU1MKCgoKLS0tClJlZ2FyZHMsCkxpbnV4IEJs
dWV0b290aAoK

--===============7041670181033407889==--

Return-Path: <SRS0=6MVD=75=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00154C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 00:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D36772074D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 00:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gj6qirZ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgFPANw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Jun 2020 20:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgFPANv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Jun 2020 20:13:51 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87C6C061A0E
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 17:13:49 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id dp10so8658034qvb.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 17:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=di6vSDYtyjyjdvksPaySKrQaM5rYisw6RcOthPYfrZQ=;
        b=gj6qirZ1hUwEDP4vi3HI3TRH/O0HpnINidZpsfSLZ6ODU9sQOBGnU6Cfg1tlv81Enx
         QJRabrbjYXeeefRQl7Hwe0f2Clni2yzLge262+iMiJVMUcCM6mnxyhlHHksPGVXDDzb6
         ToDObRHFixCVFJls20Gfqzs8+d1CeqpuEJHUXqWGw8LpEVjqTJrYmQcJVUTT1y3luJ9O
         H8L2uhl0GpPyOcDmi1T1lpkrD+Jo46bLp619fd1U+FltinahOIzqyRV6zqG9RB/jqSY3
         KZLJTvXg5StuvwyEcZ2H7t5i6DwhPgesFPPDyHD5AIq9DBPlhg457vuFNV10MdI5pmjI
         SzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=di6vSDYtyjyjdvksPaySKrQaM5rYisw6RcOthPYfrZQ=;
        b=naZS4FQCaEquYUYwpQbLxNUgc3uiRMJomaQKEb0a2SK+1sn+7y9Eq6bUwz8CR5mh00
         uvlGhhKImkF+RZwnEVK59bMHQnz1QmaLVv4c66FHex73FQA36XFtiNVxXHaZ4UsIGkw5
         zzsQs/LD5Gm+oCNZiU8jGuM5uA/sKyk6un15FkqQaHwVj7qPj0ttj4eMNYDAts9IlcdH
         1g/bT1jHlpprCMjbl2XoTi7fHPhulhO3nOz3wsHjrLv5GCS0CDUrJjiQ/gDShE7k3TQs
         lBPn8Pj8srH3SSmxSP8hAkFRKERfHuMYXNHfxxVCTFohQmN3i42HumniL/9CahBvBRkx
         N6dg==
X-Gm-Message-State: AOAM532Kpl240i2tgXKIjC3enRDqMF1Gc+3xhZ876Fq9UfQD01nRi2Oa
        sDqPycAsElQwjtzNvV/Fe9Ep+IYN
X-Google-Smtp-Source: ABdhPJz6R8ciq3yVmgUBL+lfGkO7nplG339MuRSMpWUiKUEXl3l+UAQ8O+6oDsSehbFkmZuAw9bMzA==
X-Received: by 2002:a0c:f3ce:: with SMTP id f14mr349132qvm.68.1592266428789;
        Mon, 15 Jun 2020 17:13:48 -0700 (PDT)
Received: from [172.17.0.2] ([20.36.191.240])
        by smtp.gmail.com with ESMTPSA id w3sm13149336qkb.85.2020.06.15.17.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 17:13:48 -0700 (PDT)
Message-ID: <5ee80ebc.1c69fb81.d99e6.ba46@mx.google.com>
Date:   Mon, 15 Jun 2020 17:13:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5560753200112618724=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, michaelfsun@google.com
Subject: RE: Add new commands in btmgmt to support adv monitor
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200616000318.42664-2-michaelfsun@google.com>
References: <20200616000318.42664-2-michaelfsun@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5560753200112618724==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

ClRoaXMgaXMgYXV0b21hdGVkIGVtYWlsIGFuZCBwbGVhc2UgZG8gbm90IHJlcGx5IHRvIHRoaXMg
ZW1haWwhCgpEZWFyIHN1Ym1pdHRlciwKClRoYW5rIHlvdSBmb3Igc3VibWl0dGluZyB0aGUgcGF0
Y2hlcyB0byB0aGUgbGludXggYmx1ZXRvb3RoIG1haWxpbmcgbGlzdC4KV2hpbGUgd2UgYXJlIHBy
ZXBhcmluZyBmb3IgcmV2aWV3aW5nIHRoZSBwYXRjaGVzLCB3ZSBmb3VuZCB0aGUgZm9sbG93aW5n
Cmlzc3VlL3dhcm5pbmcuCgpUZXN0IFJlc3VsdDoKY2hlY2tidWlsZCBGYWlsZWQKCk91dHB1dHM6
CmFyOiBgdScgbW9kaWZpZXIgaWdub3JlZCBzaW5jZSBgRCcgaXMgdGhlIGRlZmF1bHQgKHNlZSBg
VScpCmFyOiBgdScgbW9kaWZpZXIgaWdub3JlZCBzaW5jZSBgRCcgaXMgdGhlIGRlZmF1bHQgKHNl
ZSBgVScpCmFyOiBgdScgbW9kaWZpZXIgaWdub3JlZCBzaW5jZSBgRCcgaXMgdGhlIGRlZmF1bHQg
KHNlZSBgVScpCmFyOiBgdScgbW9kaWZpZXIgaWdub3JlZCBzaW5jZSBgRCcgaXMgdGhlIGRlZmF1
bHQgKHNlZSBgVScpCmFyOiBgdScgbW9kaWZpZXIgaWdub3JlZCBzaW5jZSBgRCcgaXMgdGhlIGRl
ZmF1bHQgKHNlZSBgVScpCnRvb2xzL2J0bWdtdC5jOiBJbiBmdW5jdGlvbiDigJhhZHZtb25fZmVh
dHVyZXMyc3Ry4oCZOgp0b29scy9idG1nbXQuYzo0NjA4OjE2OiBlcnJvcjogY29tcGFyaXNvbiBv
ZiBpbnRlZ2VyIGV4cHJlc3Npb25zIG9mIGRpZmZlcmVudCBzaWduZWRuZXNzOiDigJhpbnTigJkg
YW5kIOKAmGxvbmcgdW5zaWduZWQgaW504oCZIFstV2Vycm9yPXNpZ24tY29tcGFyZV0KIDQ2MDgg
fCAgZm9yIChpID0gMDsgaSA8IE5FTEVNKGFkdm1vbl9mZWF0dXJlc19zdHIpOyBpKyspIHsKICAg
ICAgfCAgICAgICAgICAgICAgICBeCnRvb2xzL2J0bWdtdC5jOjQ2MDk6NDE6IGVycm9yOiBjb21w
YXJpc29uIG9mIGludGVnZXIgZXhwcmVzc2lvbnMgb2YgZGlmZmVyZW50IHNpZ25lZG5lc3M6IOKA
mGludOKAmSBhbmQg4oCYbG9uZyB1bnNpZ25lZCBpbnTigJkgWy1XZXJyb3I9c2lnbi1jb21wYXJl
XQogNDYwOSB8ICAgaWYgKChmZWF0dXJlcyAmICgxIDw8IGkpKSAhPSAwICYmIG9mZiA8IHNpemVv
ZihzdHIpKQogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBe
CnRvb2xzL2J0bWdtdC5jOiBJbiBmdW5jdGlvbiDigJhzdHIycGF0dGVybuKAmToKdG9vbHMvYnRt
Z210LmM6NDY5Mjo0NDogZXJyb3I6IHVudXNlZCB2YXJpYWJsZSDigJhsZW5ndGjigJkgWy1XZXJy
b3I9dW51c2VkLXZhcmlhYmxlXQogNDY5MiB8ICBpbnQgdHlwZV9sZW4sIG9mZnNldF9sZW4sIG9m
ZnNldF9lbmRfcG9zLCBsZW5ndGgsIHN0cl9sZW47CiAgICAgIHwgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fgp0b29scy9idG1nbXQuYzogSW4gZnVuY3Rp
b24g4oCYY21kX2Fkdm1vbl9hZGTigJk6CnRvb2xzL2J0bWdtdC5jOjQ3NzE6MTI6IGVycm9yOiBp
bnZhbGlkIGFwcGxpY2F0aW9uIG9mIOKAmHNpemVvZuKAmSB0byBpbmNvbXBsZXRlIHR5cGUg4oCY
c3RydWN0IG1nbXRfY3BfYWRkX2Fkdl9wYXR0ZXJuc19tb25pdG9y4oCZCiA0NzcxIHwgICAgIHNp
emVvZihzdHJ1Y3QgbWdtdF9jcF9hZGRfYWR2X3BhdHRlcm5zX21vbml0b3IpICsKICAgICAgfCAg
ICAgICAgICAgIF5+fn5+fgp0b29scy9idG1nbXQuYzo0Nzc2OjY6IGVycm9yOiBkZXJlZmVyZW5j
aW5nIHBvaW50ZXIgdG8gaW5jb21wbGV0ZSB0eXBlIOKAmHN0cnVjdCBtZ210X2NwX2FkZF9hZHZf
cGF0dGVybnNfbW9uaXRvcuKAmQogNDc3NiB8ICAgICAgLT5wYXR0ZXJuX2NvdW50ID0gcGF0dGVy
bl9jb3VudDsKICAgICAgfCAgICAgIF5+CnRvb2xzL2J0bWdtdC5jOjQ3OTk6MjM6IGVycm9yOiDi
gJhNR01UX09QX0FERF9BRFZfUEFUVEVSTlNfTU9OSVRPUuKAmSB1bmRlY2xhcmVkIChmaXJzdCB1
c2UgaW4gdGhpcyBmdW5jdGlvbik7IGRpZCB5b3UgbWVhbiDigJhNR01UX09QX0FERF9BRFZfTU9O
SVRPUuKAmT8KIDQ3OTkgfCAgaWYgKCFtZ210X3NlbmQobWdtdCwgTUdNVF9PUF9BRERfQURWX1BB
VFRFUk5TX01PTklUT1IsIGluZGV4LCBjcF9sZW4sCiAgICAgIHwgICAgICAgICAgICAgICAgICAg
ICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CiAgICAgIHwgICAgICAgICAgICAg
ICAgICAgICAgIE1HTVRfT1BfQUREX0FEVl9NT05JVE9SCnRvb2xzL2J0bWdtdC5jOjQ3OTk6MjM6
IG5vdGU6IGVhY2ggdW5kZWNsYXJlZCBpZGVudGlmaWVyIGlzIHJlcG9ydGVkIG9ubHkgb25jZSBm
b3IgZWFjaCBmdW5jdGlvbiBpdCBhcHBlYXJzIGluCnRvb2xzL2J0bWdtdC5jOjQ3NDQ6MTE6IGVy
cm9yOiB1bnVzZWQgdmFyaWFibGUg4oCYaeKAmSBbLVdlcnJvcj11bnVzZWQtdmFyaWFibGVdCiA0
NzQ0IHwgIGludCBvcHQsIGk7CiAgICAgIHwgICAgICAgICAgIF4KY2MxOiBhbGwgd2FybmluZ3Mg
YmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsxXTogKioqIFtNYWtlZmlsZTo2NzkxOiB0b29s
cy9idG1nbXQub10gRXJyb3IgMQptYWtlOiAqKiogW01ha2VmaWxlOjQwMTA6IGFsbF0gRXJyb3Ig
MgoKCgotLS0KUmVnYXJkcywKTGludXggQmx1ZXRvb3RoCg==

--===============5560753200112618724==--

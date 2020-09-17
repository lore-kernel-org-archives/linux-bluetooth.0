Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28A6C43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 06:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2D7520707
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 06:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYunj8MX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgIQGeT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 02:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgIQGeS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 02:34:18 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252BFC06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 23:34:18 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id f142so1139753qke.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 23:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=MLZRku4DfRw64LX+GeeUW6eGps0g6UeTokwTfvlpdkE=;
        b=JYunj8MX256cj8JEvhLyhSlXrlY+NvFwhRC/g6h7lC4XBBy9+a+a3WQWGuj6q2M3AY
         kdX5zxQbSl28YPAyzY/cnHs560PoREqD4+LmKWzjPYnsY3Oy20eXtxMGuHb6CeFYg7dw
         QPU9FbY4xtmxTBL9R/YPfZgVbM7tM7Rc0wbTOoRuSutOfppzyyuJuCFh4OAegdxi9UOJ
         yHIdzCoEtJdYmeEUjFZ4ap1NqPXOm6SWr+vrFt9n+IjWrTwgC/CwFDTevMWJMnM5ax+6
         pGW5CMnO8WXYwTu2A5wTXCybRy+hYwu/D7Tg4T9XxEURF1qdfaOsk2xixpZKIentz0N7
         V+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=MLZRku4DfRw64LX+GeeUW6eGps0g6UeTokwTfvlpdkE=;
        b=Gp4U2pmu/t4j+SqJYQQDcJj6WqpvhLho/Vw4RtlF38PuJqEsr4zIERUrqn8O7P5+Oi
         6XFLDth7v5t1blLRoL8qOi+wE3VP2Cpfd427T0PNU3Wmg0aukrYOT7zo2wHMPT/6JtXW
         RhV4MeOhGG/Szftv89kCO6wHCadx2vM4KCxUCGVAwQoIpk3sqZ5XlTnkdnwo8FQ+Hl2e
         BgvDzBtky/M9iz9DRC2zxi8VXcTmMx007zlM5XA80gtuCuZxN6gxxeQp3lxF7m0XNZJ2
         b4K7kzJAiRe/TYkGyM6o+tjfb0aKl1mOApximYeYiHfyOk1C+EpNxzrarzaJMdrT6Ry3
         4haw==
X-Gm-Message-State: AOAM532fNTyGp+E4S8Nqv+KJBti2YgH3EiAa9VlMyyFCq2XEqsNWWazJ
        Bk6utlKo0Lu8JSzB//xlQXbq9qTvAKXgtg==
X-Google-Smtp-Source: ABdhPJzcPyl9HRhudLRTcl11qsf4bpVfBypHG3xmVmx9/B8DtNr8sa3SfHhQ/S5yakxah/23gJIOjw==
X-Received: by 2002:a37:6347:: with SMTP id x68mr27235254qkb.474.1600324457281;
        Wed, 16 Sep 2020 23:34:17 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.42.1])
        by smtp.gmail.com with ESMTPSA id p30sm19813557qtd.89.2020.09.16.23.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 23:34:16 -0700 (PDT)
Message-ID: <5f630368.1c69fb81.83a55.ad9c@mx.google.com>
Date:   Wed, 16 Sep 2020 23:34:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8624326796211237173=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mcchou@chromium.org
Subject: RE: [BlueZ,v2,1/8] adv_monitor: Implement RSSI Filter logic for background scanning
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200916231935.BlueZ.v2.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
References: <20200916231935.BlueZ.v2.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8624326796211237173==
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
ZmF1bHQgKHNlZSBgVScpCnNyYy9hZHZfbW9uaXRvci5jOiBJbiBmdW5jdGlvbiDigJhtb25pdG9y
X3Byb3h5X3JlbW92ZWRfY2LigJk6CnNyYy9hZHZfbW9uaXRvci5jOjc1NjoxNDogZXJyb3I6IHVu
dXNlZCB2YXJpYWJsZSDigJhwYXRo4oCZIFstV2Vycm9yPXVudXNlZC12YXJpYWJsZV0KICA3NTYg
fCAgY29uc3QgY2hhciAqcGF0aCA9IGdfZGJ1c19wcm94eV9nZXRfcGF0aChwcm94eSk7CiAgICAg
IHwgICAgICAgICAgICAgIF5+fn4Kc3JjL2Fkdl9tb25pdG9yLmM6IEluIGZ1bmN0aW9uIOKAmGFw
cF9yZW1vdmVfbW9uaXRvcuKAmToKc3JjL2Fkdl9tb25pdG9yLmM6MTAxNDozODogZXJyb3I6IHBh
c3NpbmcgYXJndW1lbnQgMiBvZiDigJhxdWV1ZV9maW5k4oCZIGZyb20gaW5jb21wYXRpYmxlIHBv
aW50ZXIgdHlwZSBbLVdlcnJvcj1pbmNvbXBhdGlibGUtcG9pbnRlci10eXBlc10KIDEwMTQgfCAg
bW9uaXRvciA9IHF1ZXVlX2ZpbmQoYXBwLT5tb25pdG9ycywgcmVtb3ZlZF9tb25pdG9yX21hdGNo
LCB1c2VyX2RhdGEpOwogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBefn5+fn5+fn5+fn5+fn5+fn5+fn4KICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfAogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBfQm9vbCAoKikodm9pZCAqLCB2b2lkICopCkluIGZpbGUgaW5jbHVkZWQgZnJvbSBzcmMvYWR2
X21vbml0b3IuYzo0MjoKLi9zcmMvc2hhcmVkL3F1ZXVlLmg6NTI6Nzogbm90ZTogZXhwZWN0ZWQg
4oCYcXVldWVfbWF0Y2hfZnVuY1904oCZIHtha2Eg4oCYX0Jvb2wgKCopKGNvbnN0IHZvaWQgKiwg
Y29uc3Qgdm9pZCAqKeKAmX0gYnV0IGFyZ3VtZW50IGlzIG9mIHR5cGUg4oCYX0Jvb2wgKCopKHZv
aWQgKiwgdm9pZCAqKeKAmQogICA1MiB8IHZvaWQgKnF1ZXVlX2ZpbmQoc3RydWN0IHF1ZXVlICpx
dWV1ZSwgcXVldWVfbWF0Y2hfZnVuY190IGZ1bmN0aW9uLAogICAgICB8ICAgICAgIF5+fn5+fn5+
fn4Kc3JjL2Fkdl9tb25pdG9yLmM6IEluIGZ1bmN0aW9uIOKAmGFkdl9tb25pdG9yX3JlbW92ZWRf
Y2FsbGJhY2vigJk6CnNyYy9hZHZfbW9uaXRvci5jOjEwMzE6NDM6IGVycm9yOiBpbml0aWFsaXph
dGlvbiBkaXNjYXJkcyDigJhjb25zdOKAmSBxdWFsaWZpZXIgZnJvbSBwb2ludGVyIHRhcmdldCB0
eXBlIFstV2Vycm9yPWRpc2NhcmRlZC1xdWFsaWZpZXJzXQogMTAzMSB8ICBzdHJ1Y3QgbWdtdF9l
dl9hZHZfbW9uaXRvcl9yZW1vdmVkICpldiA9IHBhcmFtOwogICAgICB8ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+CnNyYy9hZHZfbW9uaXRvci5jOiBJbiBm
dW5jdGlvbiDigJhhZHZfbWF0Y2hfcGVyX3BhdHRlcm7igJk6CnNyYy9hZHZfbW9uaXRvci5jOjEy
MzA6MTc6IGVycm9yOiB1bnVzZWQgdmFyaWFibGUg4oCYZWly4oCZIFstV2Vycm9yPXVudXNlZC12
YXJpYWJsZV0KIDEyMzAgfCAgY29uc3QgdWludDhfdCAqZWlyID0gaW5mby0+ZWlyOwogICAgICB8
ICAgICAgICAgICAgICAgICBefn4Kc3JjL2Fkdl9tb25pdG9yLmM6IEluIGZ1bmN0aW9uIOKAmGJ0
ZF9hZHZfbW9uaXRvcl9jb250ZW50X2ZpbHRlcuKAmToKc3JjL2Fkdl9tb25pdG9yLmM6MTI4Njoy
OiBlcnJvcjogSVNPIEM5MCBmb3JiaWRzIG1peGVkIGRlY2xhcmF0aW9ucyBhbmQgY29kZSBbLVdl
cnJvcj1kZWNsYXJhdGlvbi1hZnRlci1zdGF0ZW1lbnRdCiAxMjg2IHwgIHN0cnVjdCBhZHZfY29u
dGVudF9maWx0ZXJfaW5mbyBpbmZvID0gewogICAgICB8ICBefn5+fn4Kc3JjL2Fkdl9tb25pdG9y
LmM6IEluIGZ1bmN0aW9uIOKAmGJ0ZF9hZHZfbW9uaXRvcl9ub3RpZnlfbW9uaXRvcnPigJk6CnNy
Yy9hZHZfbW9uaXRvci5jOjEzMjI6MjogZXJyb3I6IElTTyBDOTAgZm9yYmlkcyBtaXhlZCBkZWNs
YXJhdGlvbnMgYW5kIGNvZGUgWy1XZXJyb3I9ZGVjbGFyYXRpb24tYWZ0ZXItc3RhdGVtZW50XQog
MTMyMiB8ICBzdHJ1Y3QgYWR2X3Jzc2lfZmlsdGVyX2luZm8gaW5mbyA9IHsKICAgICAgfCAgXn5+
fn5+CmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMV06ICoq
KiBbTWFrZWZpbGU6Njg2Mzogc3JjL2Fkdl9tb25pdG9yLm9dIEVycm9yIDEKbWFrZTogKioqIFtN
YWtlZmlsZTo0MDU2OiBhbGxdIEVycm9yIDIKCgoKLS0tClJlZ2FyZHMsCkxpbnV4IEJsdWV0b290
aAo=

--===============8624326796211237173==--

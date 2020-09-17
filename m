Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6544DC43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 07:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 114BF2072E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 07:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUffPafB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgIQHc0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 03:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgIQHcZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 03:32:25 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE3CC06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 00:32:24 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id q63so1309311qkf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 00:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=+NwzptSIXt/pdjgSqGbczzEDrsAWbpRNE2NRKc4DI/8=;
        b=XUffPafB161ORIcplYmDp04CoQFj9Kxt8FmsGhmefqxdTtnlgjsRuMW7i8WGzX2OUJ
         mGv+nz20RGtz1clCWINeaF0vzI5y4y4wTv6u29xKr9MKiQt2NYebRLLQcdamFiHB0DKO
         RTm0ASPkesC4rypeRZSk/RFzFi98f/rIVGmNKqXdPxe4VEvdwGEkr/ZnevEC+KpXnUMX
         yYuqMpoMToKzhFuBJtSnLbBkJGx9bG1K43IXGyZM54QLjK9zwjQmosLUjnL9q7pNiwnH
         LzCiSf33bzw/6CbjiXoW/tNtNxdaNC3PKslfL8KixECQ1E24Bwh/tpRqsgrRdzqPeG0G
         GmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=+NwzptSIXt/pdjgSqGbczzEDrsAWbpRNE2NRKc4DI/8=;
        b=KlFXEqWQykW3V6nlLnZpGozXRxAzIy2TQDxLQRH5gAoaDVVuhbESbYfrKHmoq4vIrD
         84m2TteU1fQoUC93McSFfgj8Po98ft9MOYlvMV6M/4NvmuaSmVWDatSKC5ufd1zpJ/b5
         EvZlYUDalieuAXhHOkG6uHbONm3F23NODwnE14iqX5wp5Ae142J/GJBQ5K6T2ndsA2QY
         OSSqe2WLYjP+9uooK9ZLUFulj1Mx/0xFqpnr/DocR+wyFOFzoiD9V0qUMa3kMbO0Zjwq
         6ExD49daCwccATAJZIj5feNzxJuAOYwCHWaJRwCRdzvLwbLisK5vl+ThsjWh2lX4x87b
         JROw==
X-Gm-Message-State: AOAM530GWpEpGDysHU+5z9S5miy5Y+qaSnsZL6xGbhxJ+pukS7j+i4eC
        iTkCus6ceE6x0hD5Zoc8kS++5bPPrHepPw==
X-Google-Smtp-Source: ABdhPJwxLCd9QtgPe2ErvbB+iIaDYtAJqqhNM/sqP4RDKb2Hl7i1fHyWOLu1uxDVUxeMToFzyyzC2g==
X-Received: by 2002:a37:a1cb:: with SMTP id k194mr26434459qke.354.1600327944074;
        Thu, 17 Sep 2020 00:32:24 -0700 (PDT)
Received: from [172.17.0.2] ([52.177.203.159])
        by smtp.gmail.com with ESMTPSA id m6sm20832528qkh.106.2020.09.17.00.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 00:32:23 -0700 (PDT)
Message-ID: <5f631107.1c69fb81.7353d.f98c@mx.google.com>
Date:   Thu, 17 Sep 2020 00:32:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6930316136080252613=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mcchou@chromium.org
Subject: RE: [BlueZ,v4,1/8] adv_monitor: Implement RSSI Filter logic for background scanning
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200917001020.BlueZ.v4.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
References: <20200917001020.BlueZ.v4.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6930316136080252613==
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
ZmF1bHQgKHNlZSBgVScpCnNyYy9hZHZfbW9uaXRvci5jOiBJbiBmdW5jdGlvbiDigJhhZHZfbW9u
aXRvcl9yZW1vdmVkX2NhbGxiYWNr4oCZOgpzcmMvYWR2X21vbml0b3IuYzoxMDMwOjMwOiBlcnJv
cjog4oCYbWFuYWdlcuKAmSB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbikK
IDEwMzAgfCAgY29uc3QgdWludDE2X3QgYWRhcHRlcl9pZCA9IG1hbmFnZXItPmFkYXB0ZXJfaWQ7
CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+CnNyYy9hZHZfbW9u
aXRvci5jOjEwMzA6MzA6IG5vdGU6IGVhY2ggdW5kZWNsYXJlZCBpZGVudGlmaWVyIGlzIHJlcG9y
dGVkIG9ubHkgb25jZSBmb3IgZWFjaCBmdW5jdGlvbiBpdCBhcHBlYXJzIGluCnNyYy9hZHZfbW9u
aXRvci5jOjEwNDE6NTE6IGVycm9yOiBwYXNzaW5nIGFyZ3VtZW50IDMgb2Yg4oCYcXVldWVfZm9y
ZWFjaOKAmSBkaXNjYXJkcyDigJhjb25zdOKAmSBxdWFsaWZpZXIgZnJvbSBwb2ludGVyIHRhcmdl
dCB0eXBlIFstV2Vycm9yPWRpc2NhcmRlZC1xdWFsaWZpZXJzXQogMTA0MSB8ICBxdWV1ZV9mb3Jl
YWNoKG1hbmFnZXItPmFwcHMsIGFwcF9yZW1vdmVfbW9uaXRvciwgZXYpOwogICAgICB8ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn4KSW4gZmlsZSBp
bmNsdWRlZCBmcm9tIHNyYy9hZHZfbW9uaXRvci5jOjQyOgouL3NyYy9zaGFyZWQvcXVldWUuaDo0
ODoxNDogbm90ZTogZXhwZWN0ZWQg4oCYdm9pZCAq4oCZIGJ1dCBhcmd1bWVudCBpcyBvZiB0eXBl
IOKAmGNvbnN0IHN0cnVjdCBtZ210X2V2X2Fkdl9tb25pdG9yX3JlbW92ZWQgKuKAmQogICA0OCB8
ICAgICAgICB2b2lkICp1c2VyX2RhdGEpOwogICAgICB8ICAgICAgICB+fn5+fn5efn5+fn5+fn4K
Y2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsxXTogKioqIFtN
YWtlZmlsZTo2ODYzOiBzcmMvYWR2X21vbml0b3Iub10gRXJyb3IgMQptYWtlOiAqKiogW01ha2Vm
aWxlOjQwNTY6IGFsbF0gRXJyb3IgMgoKCgotLS0KUmVnYXJkcywKTGludXggQmx1ZXRvb3RoCg==

--===============6930316136080252613==--

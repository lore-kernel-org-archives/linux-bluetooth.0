Return-Path: <SRS0=wtMD=CT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18860C43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 23:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1572208FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 23:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTLezDG/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725298AbgIJXa0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Sep 2020 19:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgIJXaW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Sep 2020 19:30:22 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C14FC061573
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2020 16:30:21 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id t20so6315306qtr.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2020 16:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=U+i5XPme3vC7jaZs/WDFR2wUocv1CUJ4TPmfGK9KY2E=;
        b=XTLezDG/JZuCpgWsq5zvIVBiUVAN+YgmfMpYvdqExrhfDExrl/ND0kesHJkVxpHR/G
         SBJj915893Yh7j6kReroHLI4KO2jtWFM/P2pTDOxL94Kuyyr+v2VlUfy++KvvoTYRPg3
         eNqqIIu/+wPUhFMkFw/8R+elNrDfHRiqnkBOCwPmcGgxRrFoMprekZfN5QwoH7zRlA3/
         3MMV8ar4QprAC92yn2geZliooXq2+i7LypXdgLCVvml5SmgtebwoGYbcO3GurvEhhIsd
         UBuiYxGNPkQgGu8wFuz8wLY2k9Kp/c9z7vAg9KSjsoPs4NV0ZyvxQQ/PbVbT5HZC0eVP
         3zow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=U+i5XPme3vC7jaZs/WDFR2wUocv1CUJ4TPmfGK9KY2E=;
        b=eXKluQX56xXDb1TkJGwWkHScPzCpvgFIPUdwGedjZ8mvqLO+cXeoghqGzHVKtLavdV
         MUBWLlQQcnRZeJiI6bH/X+gxCxikoHJG2IuhDf+AbZGBu+4FjJSdMW3jOFN2CAJis4A/
         3/byJugOBUTPmtu482rdKl8TmIc0FGoGWl+umoW6k5VEHTwItnDAsm8sM9zqiMl4UQa9
         VrL/4LzJRDtAWIXEP9BbYuaFtVRZK3soOuQ5i2fGMYunce4S7lwDfO7rjKKJBZzQO17A
         e7k27ja9DZwGsxqVzTWxnRATz6KqjMQ5bNn1BFmwF9pmV01HSaNkbXxw5OsKDKAIbwD3
         gn8g==
X-Gm-Message-State: AOAM532kURIIKkyA304oFrb6Iy6b8IuuUxoXxuIk4KthWlkh5th9jlVp
        0stQRwO4iQsQT5R5vgbw24UE08vOQAODqA==
X-Google-Smtp-Source: ABdhPJwq/xcsNxZhY02tkciQgjjpauc/6JPIq+IZnKj+p97jQdi05YpW1t7EKnWSPDWPPLuC9HRHGQ==
X-Received: by 2002:ac8:743:: with SMTP id k3mr10778540qth.182.1599780620689;
        Thu, 10 Sep 2020 16:30:20 -0700 (PDT)
Received: from [172.17.0.2] ([52.247.3.217])
        by smtp.gmail.com with ESMTPSA id x6sm646155qke.54.2020.09.10.16.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 16:30:20 -0700 (PDT)
Message-ID: <5f5ab70c.1c69fb81.12f26.3d94@mx.google.com>
Date:   Thu, 10 Sep 2020 16:30:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6985360745229033016=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mcchou@chromium.org
Subject: RE: [BlueZ,v4,1/8] adapter: Remove indirect dependency of headers
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200910161528.BlueZ.v4.1.Iaa9dc2a66de5fbfa97627e1dbeb800116d3aa91e@changeid>
References: <20200910161528.BlueZ.v4.1.Iaa9dc2a66de5fbfa97627e1dbeb800116d3aa91e@changeid>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6985360745229033016==
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
X21hdGNo4oCZOgpzcmMvYWR2X21vbml0b3IuYzoyNzY6MzU6IGVycm9yOiBwYXNzaW5nIGFyZ3Vt
ZW50IDEgb2Yg4oCYZ19kYnVzX3Byb3h5X2dldF9wYXRo4oCZIGRpc2NhcmRzIOKAmGNvbnN04oCZ
IHF1YWxpZmllciBmcm9tIHBvaW50ZXIgdGFyZ2V0IHR5cGUgWy1XZXJyb3I9ZGlzY2FyZGVkLXF1
YWxpZmllcnNdCiAgMjc2IHwgIGlmIChzdHJjbXAoZ19kYnVzX3Byb3h5X2dldF9wYXRoKHByb3h5
KSwgbW9uaXRvci0+cGF0aCkgIT0gMCkKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXn5+fn4KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIHNyYy9hZHZfbW9uaXRvci5jOjMx
OgouL2dkYnVzL2dkYnVzLmg6MzM2OjEzOiBub3RlOiBleHBlY3RlZCDigJhHREJ1c1Byb3h5ICri
gJkge2FrYSDigJhzdHJ1Y3QgR0RCdXNQcm94eSAq4oCZfSBidXQgYXJndW1lbnQgaXMgb2YgdHlw
ZSDigJhjb25zdCBHREJ1c1Byb3h5ICrigJkge2FrYSDigJhjb25zdCBzdHJ1Y3QgR0RCdXNQcm94
eSAq4oCZfQogIDMzNiB8IGNvbnN0IGNoYXIgKmdfZGJ1c19wcm94eV9nZXRfcGF0aChHREJ1c1By
b3h5ICpwcm94eSk7CiAgICAgIHwgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+CnNy
Yy9hZHZfbW9uaXRvci5jOiBJbiBmdW5jdGlvbiDigJhwYXJzZV9wYXR0ZXJuc+KAmToKc3JjL2Fk
dl9tb25pdG9yLmM6NDg1OjM2OiBlcnJvcjogc3VnZ2VzdCBwYXJlbnRoZXNlcyBhcm91bmQg4oCY
JibigJkgd2l0aGluIOKAmHx84oCZIFstV2Vycm9yPXBhcmVudGhlc2VzXQogIDQ4NSB8ICAgaWYg
KGFkX3R5cGUgPiBCVF9BRF8zRF9JTkZPX0RBVEEgJiYKc3JjL2Fkdl9tb25pdG9yLmM6NDI1OjEx
OiBlcnJvcjogdW51c2VkIHZhcmlhYmxlIOKAmG51bV9wYXR0ZXJuc+KAmSBbLVdlcnJvcj11bnVz
ZWQtdmFyaWFibGVdCiAgNDI1IHwgIHVpbnQxNl90IG51bV9wYXR0ZXJucyA9IDA7CiAgICAgIHwg
ICAgICAgICAgIF5+fn5+fn5+fn5+fgpzcmMvYWR2X21vbml0b3IuYzogSW4gZnVuY3Rpb24g4oCY
Z2V0X3N1cHBvcnRlZF9tb25pdG9yX3R5cGVz4oCZOgpzcmMvYWR2X21vbml0b3IuYzo3NTM6MzQ6
IGVycm9yOiB1bnVzZWQgdmFyaWFibGUg4oCYbWFuYWdlcuKAmSBbLVdlcnJvcj11bnVzZWQtdmFy
aWFibGVdCiAgNzUzIHwgIHN0cnVjdCBidGRfYWR2X21vbml0b3JfbWFuYWdlciAqbWFuYWdlciA9
IGRhdGE7CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fgpj
YzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiogW01h
a2VmaWxlOjkyNzI6IHNyYy9ibHVldG9vdGhkLWFkdl9tb25pdG9yLm9dIEVycm9yIDEKbWFrZTog
KioqIFtNYWtlZmlsZTo0MDE0OiBhbGxdIEVycm9yIDIKCgoKLS0tClJlZ2FyZHMsCkxpbnV4IEJs
dWV0b290aAo=

--===============6985360745229033016==--

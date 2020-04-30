Return-Path: <SRS0=orbE=6O=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DF3C83001
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Apr 2020 07:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE35F2186A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Apr 2020 07:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZEfTLqb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgD3HHz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Apr 2020 03:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726337AbgD3HHz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Apr 2020 03:07:55 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CBDC035494
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2020 00:07:55 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id t3so4744129qkg.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2020 00:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:in-reply-to:references;
        bh=VNQaaaE1ZPt5Ef7l7PhTMtX1W/DSVdY49QMFEvO+VWI=;
        b=IZEfTLqbQl56rT/pIOViJVlPirvOYkBH8hUYWmwtRunsY0c1BeP2qZ88wv6464L3cT
         NCYhpvFPLVAtTurJDLDJC55bqHjtQWp9kJcK8GUqJwQfnw4Xvz6UyMl6iwLD7XlSEifb
         gezqoEbxOviQsnryt4gOwxBlwKS45l/bW9EPrcA6Jfxj0lbRPJ2Bn0IsIFBLGW558eD1
         Tp/td38XcU5ugCbfohEu3/ugxDQrWNf5ewwh1lxdV9HVDteMzXOsMl/Nmy7bRo40t+vM
         1ZGR3jSvRnthmh+fmqZ9gnUCbsM3BhhSmc7YMHFDPVBkfT09MeH31EXOxOkm4JNLl4PV
         lJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :in-reply-to:references;
        bh=VNQaaaE1ZPt5Ef7l7PhTMtX1W/DSVdY49QMFEvO+VWI=;
        b=bSb29jhda7agGJSZe6wqUZ0cb1oFixSeCmjn1Yo1CQ0fE0G65xb2vqAavy6TLwnIYJ
         zI1TmfI2YUeg1gmdyr8NE8DN3Nv0oWnb2o9RPIJK4Mk7+IUM+sbuwEmtWTQORY2pqcEk
         Z/qkI8v5RqO3WJSo7N0emlsjpsk0hNnaGiRyBDacaINhF2XKZPlESNWm2Ahi8GWPheX7
         2XOlCVNJUbm5otHFNyJMzH942J9Xvhdy2mT99RCyDEBgOl6J92hBaegHHFPx6RHJH4PH
         G0TCW/WYrpQCDmbjnZ+n4AOjMuJZwPW1aiBSMqpmJrcveHRPiD3IF3O5fpxWCV2A8d5q
         16AA==
X-Gm-Message-State: AGi0PuY6rwMyokSpSZSlnI6g8jzAVwGQM814yJ/jqiKTIMqBQtI+10+U
        w1leydvmO8p459XjUAVipYpoIWQhKck=
X-Google-Smtp-Source: APiQypI+ugAPwK84zQisQPFB+FkGpc1+JcmrofR6+HngOWgNdDukE/89cMvMdIe1uS2RWziqvDx0jw==
X-Received: by 2002:a05:620a:b03:: with SMTP id t3mr2164041qkg.209.1588230474168;
        Thu, 30 Apr 2020 00:07:54 -0700 (PDT)
Received: from [172.17.0.2] ([13.68.21.112])
        by smtp.gmail.com with ESMTPSA id b3sm1382242qtp.12.2020.04.30.00.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 00:07:53 -0700 (PDT)
Message-ID: <5eaa7949.1c69fb81.28ac0.7f1e@mx.google.com>
Date:   Thu, 30 Apr 2020 00:07:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2340660203944417822=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez,v1] tools/l2cap-tester: Add test for waiting disconnection response
In-Reply-To: <20200430145105.Bluez.v1.1.I86c1e0e8933d92d8d76dcd95036bf325cfaeced0@changeid>
References: <20200430145105.Bluez.v1.1.I86c1e0e8933d92d8d76dcd95036bf325cfaeced0@changeid>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2340660203944417822==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

ClRoaXMgaXMgYXV0b21hdGVkIGVtYWlsIGFuZCBwbGVhc2UgZG8gbm90IHJlcGx5IHRvIHRoaXMg
ZW1haWwhCgpEZWFyIHN1Ym1pdHRlciwKClRoYW5rIHlvdSBmb3Igc3VibWl0dGluZyB0aGUgcGF0
Y2hlcyB0byB0aGUgbGludXggYmx1ZXRvb3RoIG1haWxpbmcgbGlzdC4KV2hpbGUgd2UgYXJlIHBy
ZXBhcmluZyBmb3IgcmV2aWV3aW5nIHRoZSBwYXRjaGVzLCB3ZSBmb3VuZCB0aGUgZm9sbG93aW5n
Cmlzc3VlL3dhcm5pbmcuCgoKVGVzdCBSZXN1bHQ6CkNoZWNrYnVpbGQgRmFpbGVkCgpQYXRjaCBT
ZXJpZXM6CltCbHVleix2MV0gdG9vbHMvbDJjYXAtdGVzdGVyOiBBZGQgdGVzdCBmb3Igd2FpdGlu
ZyBkaXNjb25uZWN0aW9uIHJlc3BvbnNlCgoKT3V0cHV0czoKYXI6IGB1JyBtb2RpZmllciBpZ25v
cmVkIHNpbmNlIGBEJyBpcyB0aGUgZGVmYXVsdCAoc2VlIGBVJykKYXI6IGB1JyBtb2RpZmllciBp
Z25vcmVkIHNpbmNlIGBEJyBpcyB0aGUgZGVmYXVsdCAoc2VlIGBVJykKYXI6IGB1JyBtb2RpZmll
ciBpZ25vcmVkIHNpbmNlIGBEJyBpcyB0aGUgZGVmYXVsdCAoc2VlIGBVJykKYXI6IGB1JyBtb2Rp
ZmllciBpZ25vcmVkIHNpbmNlIGBEJyBpcyB0aGUgZGVmYXVsdCAoc2VlIGBVJykKYXI6IGB1JyBt
b2RpZmllciBpZ25vcmVkIHNpbmNlIGBEJyBpcyB0aGUgZGVmYXVsdCAoc2VlIGBVJykKYW5kcm9p
ZC90ZXN0ZXItbWFpbi5jOiBJbiBmdW5jdGlvbiDigJhlbXVfYWRkX2wyY2FwX3NlcnZlcl9hY3Rp
b27igJk6CmFuZHJvaWQvdGVzdGVyLW1haW4uYzoyODY5OjI6IGVycm9yOiB0b28gZmV3IGFyZ3Vt
ZW50cyB0byBmdW5jdGlvbiDigJhidGhvc3RfYWRkX2wyY2FwX3NlcnZlcuKAmQogMjg2OSB8ICBi
dGhvc3RfYWRkX2wyY2FwX3NlcnZlcihidGhvc3QsIGwyY2FwX2RhdGEtPnBzbSwgbDJjYXBfZGF0
YS0+ZnVuYywKICAgICAgfCAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KSW4gZmlsZSBpbmNsdWRl
ZCBmcm9tIGFuZHJvaWQvdGVzdGVyLW1haW4uYzozMzoKLi9lbXVsYXRvci9idGhvc3QuaDoxMDU6
Njogbm90ZTogZGVjbGFyZWQgaGVyZQogIDEwNSB8IHZvaWQgYnRob3N0X2FkZF9sMmNhcF9zZXJ2
ZXIoc3RydWN0IGJ0aG9zdCAqYnRob3N0LCB1aW50MTZfdCBwc20sCiAgICAgIHwgICAgICBefn5+
fn5+fn5+fn5+fn5+fn5+fn5+fgptYWtlWzFdOiAqKiogW01ha2VmaWxlOjcxNjU6IGFuZHJvaWQv
YW5kcm9pZF90ZXN0ZXItdGVzdGVyLW1haW4ub10gRXJyb3IgMQptYWtlOiAqKiogW01ha2VmaWxl
OjQwMTA6IGFsbF0gRXJyb3IgMgoKCgotLS0KUmVnYXJkcywKTGludXggQmx1ZXRvb3RoCg==

--===============2340660203944417822==--

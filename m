Return-Path: <SRS0=4/QO=6J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0B7C2BA1A
	for <linux-bluetooth@archiver.kernel.org>; Sat, 25 Apr 2020 02:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56C292076C
	for <linux-bluetooth@archiver.kernel.org>; Sat, 25 Apr 2020 02:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQbJOcVJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgDYCgx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Apr 2020 22:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgDYCgw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Apr 2020 22:36:52 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C07CC09B049
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2020 19:36:52 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 20so12340503qkl.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2020 19:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:in-reply-to:references;
        bh=fj/HfCMmYa7CjTav7QUOLpKDuho58DutbBp0d7F2LgU=;
        b=GQbJOcVJ8mJK4YioOjGcyRXHTCtq9h1KlEuJB+K5gDF1AU5vuXRjBR5+sOuQp2lcR7
         gRCveQ84KgUjzj7HRrtjNCYIocOA3GF8FuGNdMjruIB5mliD2Mx81IJ3EgTCJZYo65F+
         TfsrZO+sod0eR2DCklPRKD66r3Nfl+lUnudFotcv/dB8GjnJqovB9khNLJUuiHnYd2Pi
         x1jg6oVuwQA1v6jApzp4SUYDPnNM11MWgt4+TfmBIBXuMVyGwVF2fJgNcx4PIaVQo6EK
         bWosaVpO/y6NL1Wa1Y8lZs8a8RpDhJPW4JuTUjaVTmoFiVmFqUVfhemr5GPBgrBn2ibf
         ealQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :in-reply-to:references;
        bh=fj/HfCMmYa7CjTav7QUOLpKDuho58DutbBp0d7F2LgU=;
        b=BBC97h1tez7BWkwOWbnyfgko3z4XbikgXVak+ynduGLr8b52dEqCPx4nUaz1scUxqc
         Wurw8Fx6W75MoTKB2sNMCn24okISlHwmBbf6gdswvDRecfwSzK2Po7pDEiTW84vBGAIB
         afxF54PmbOa9Ntv2mSGztFVDue78k5i34oTuA2GJ4/wMlpCMxMkJv57xxO4Vvjding4K
         aLcvsvE2Gw0/fsLP4B/SD522WWGfJ0pQLp+27a78rXjtVZdFDRfQq9ixEIZxgUOMoZxy
         m0Nn1iVOdRzROZ3GY6aX1ngeAvEyQRA28TVqxdrDGHW8jp3oTAWu2cO48xFITNNIRnOI
         ehbg==
X-Gm-Message-State: AGi0PuZGwks/+GOr019VKUWsc/txLwhSuacsrp1E92+goKqdhPzkwUl6
        uhketgrJTgqF6nilVfAiIp1aRk8SmBM=
X-Google-Smtp-Source: APiQypKsLsMfFkSgzjhc4Pft9axO+ueDF4z1QicJU6pV+n84WYmptd+tarOPzGDD46/49bABE1ohxA==
X-Received: by 2002:a37:7d0:: with SMTP id 199mr10351575qkh.499.1587782211711;
        Fri, 24 Apr 2020 19:36:51 -0700 (PDT)
Received: from [172.17.0.2] ([52.177.130.16])
        by smtp.gmail.com with ESMTPSA id h19sm5269055qtk.78.2020.04.24.19.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 19:36:51 -0700 (PDT)
Message-ID: <5ea3a243.1c69fb81.81de.2b47@mx.google.com>
Date:   Fri, 24 Apr 2020 19:36:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3678202515449161327=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tedd.an@linux.intel.com
Subject: RE: Test patch: build fail
In-Reply-To: <20200424231042.127237-1-tedd.an@linux.intel.com>
References: <20200424231042.127237-1-tedd.an@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3678202515449161327==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

ClRoaXMgaXMgYXV0b21hdGVkIGVtYWlsIGFuZCBwbGVhc2UgZG8gbm90IHJlcGxheSB0byB0aGlz
IGVtYWlsIQoKRGVhciBzdWJtaXR0ZXIsCgpUaGFuayB5b3UgZm9yIHN1Ym1pdHRpbmcgdGhlIHBh
dGNoZXMgdG8gdGhlIGxpbnV4IGJsdWV0b290aCBtYWlsaW5nIGxpc3QuCldoaWxlIHdlIGFyZSBw
cmVwYXJpbmcgZm9yIHJldmlld2luZyB0aGUgcGF0Y2hlcywgd2UgZm91bmQgdGhlIGZvbGxvd2lu
Zwppc3N1ZS93YXJuaW5nLgoKClRlc3QgUmVzdWx0OgpDaGVja2J1aWxkIEZhaWxlZAoKUGF0Y2gg
U2VyaWVzOgpUZXN0IHBhdGNoOiBidWlsZCBmYWlsCgoKT3V0cHV0czoKYXI6IGB1JyBtb2RpZmll
ciBpZ25vcmVkIHNpbmNlIGBEJyBpcyB0aGUgZGVmYXVsdCAoc2VlIGBVJykKYXI6IGB1JyBtb2Rp
ZmllciBpZ25vcmVkIHNpbmNlIGBEJyBpcyB0aGUgZGVmYXVsdCAoc2VlIGBVJykKYXI6IGB1JyBt
b2RpZmllciBpZ25vcmVkIHNpbmNlIGBEJyBpcyB0aGUgZGVmYXVsdCAoc2VlIGBVJykKYXI6IGB1
JyBtb2RpZmllciBpZ25vcmVkIHNpbmNlIGBEJyBpcyB0aGUgZGVmYXVsdCAoc2VlIGBVJykKYXI6
IGB1JyBtb2RpZmllciBpZ25vcmVkIHNpbmNlIGBEJyBpcyB0aGUgZGVmYXVsdCAoc2VlIGBVJykK
dG9vbHMvYnRwY2xpZW50LmM6IEluIGZ1bmN0aW9uIOKAmG1haW7igJk6CnRvb2xzL2J0cGNsaWVu
dC5jOjMyMTg6MTU6IGVycm9yOiBleHBlY3RlZCDigJg74oCZIGJlZm9yZSDigJhyZXR1cm7igJkK
IDMyMTggfCAgbF9tYWluX2V4aXQoKQogICAgICB8ICAgICAgICAgICAgICAgXgogICAgICB8ICAg
ICAgICAgICAgICAgOwogMzIxOSB8IAogMzIyMCB8ICByZXR1cm4gRVhJVF9TVUNDRVNTOwogICAg
ICB8ICB+fn5+fn4gICAgICAgIAptYWtlWzFdOiAqKiogW01ha2VmaWxlOjY3OTE6IHRvb2xzL2J0
cGNsaWVudC5vXSBFcnJvciAxCm1ha2U6ICoqKiBbTWFrZWZpbGU6NDAxMDogYWxsXSBFcnJvciAy
CgoKCi0tLQpSZWdhcmRzLApMaW51eCBCbHVldG9vdGgK

--===============3678202515449161327==--

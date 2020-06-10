Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0938EC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 15:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D31012072F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 15:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fS3KRKyo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgFJPiV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 11:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbgFJPiU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 11:38:20 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EA8C03E96B
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 08:38:19 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id v79so2408196qkb.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 08:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=BJEE4UK5QNVNpzNje4hGQm/f+z8K5+SYOiwO1DPoq9w=;
        b=fS3KRKyoovFAqN6TVRzosThFVVgDMVDG4Lb6w4ZAtlrM97AB8IjbJ/1fIDlioWGFx0
         N4wnaugIGPF4TLk77RAxsYHpSy/brEYd7DbZTdU4LNURxygglhjZxcIkIYpG1Lk2+v6z
         T5uKKF6O9yCloDiLw/sdFo4BJnLiKGWCbzzQPAg9uvq8CTkl5PStgKAsfUl5eax7/bxP
         fuyZfjpJ4JTXBJ4l0veJqT8ifYXLq9GiOmYkBpxOeYEBDVWoTQAHXPy6LElYI+WIqNYZ
         dYelPxY8jXjHvz65v4VUu7wZyq3WNRnZ4HaaHN66ZVmy2niixJRMFVP/KNW0NCQ03H6w
         9LPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=BJEE4UK5QNVNpzNje4hGQm/f+z8K5+SYOiwO1DPoq9w=;
        b=a81xKRsa+sx3SUBHRp9cpZtw+ZYJTONApnMlwVmVOopD7Z2d6++QP9hswNJhVmZB0J
         IxJL3QHl76H7ftePbWvnK7APVw3bzYhr2JjD8MlOAk9YIncU7gh0oAt80p91WN4CXpRL
         9IqEDMQnsVUtlxlFlD3orNY4xxgii+N9zfCIlUNiGu2xQywRIGWKnCbukjczoJY/bBlM
         uKnWIwfQzkl7JElVwq13uVRjtU6vRH3+6vVNrjERHry+EtDK5q5H0M4SUX1AcPWWkLDx
         G2960lfrl3WX/SOANg+q5qvEgWwhGpZDpYiH92r/zqljqLjfsavAK89pHKceSuX0DeSX
         AFHA==
X-Gm-Message-State: AOAM532lAshUy+tYS0VGuwd0F2d8VLRBxPZWEonli//3n8AtLsKzyEDA
        aVISyAjH93cTfyOY43xDwDjqrSm5mek=
X-Google-Smtp-Source: ABdhPJw6vIO5K2XqBcm7hbPTwA/zEWpK5Akr7PwCGTdfZwFEpELESxfWHayOrGIU+U9SQWcQok4oZg==
X-Received: by 2002:ae9:f80e:: with SMTP id x14mr3502427qkh.314.1591803498234;
        Wed, 10 Jun 2020 08:38:18 -0700 (PDT)
Received: from [172.17.0.2] ([52.179.153.76])
        by smtp.gmail.com with ESMTPSA id a82sm40523qkb.29.2020.06.10.08.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 08:38:16 -0700 (PDT)
Message-ID: <5ee0fe68.1c69fb81.b88df.0485@mx.google.com>
Date:   Wed, 10 Jun 2020 08:38:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0466509413499094413=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez,v1,1/2] device: add device_remove_bonding function
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200610230524.Bluez.v1.1.I1322f6745fa50365c1c88de3e2c50c9c5962c094@changeid>
References: <20200610230524.Bluez.v1.1.I1322f6745fa50365c1c88de3e2c50c9c5962c094@changeid>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0466509413499094413==
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
ZmF1bHQgKHNlZSBgVScpCnByb2ZpbGVzL2lucHV0L2RldmljZS5jOiBJbiBmdW5jdGlvbiDigJhp
bnZhbGlkYXRlX2JvbmRpbmfigJk6CnByb2ZpbGVzL2lucHV0L2RldmljZS5jOjE1NDoyNDogZXJy
b3I6IHBhc3NpbmcgYXJndW1lbnQgMSBvZiDigJhkZXZpY2VfcmVtb3ZlX2JvbmRpbmfigJkgZnJv
bSBpbmNvbXBhdGlibGUgcG9pbnRlciB0eXBlIFstV2Vycm9yPWluY29tcGF0aWJsZS1wb2ludGVy
LXR5cGVzXQogIDE1NCB8ICBkZXZpY2VfcmVtb3ZlX2JvbmRpbmcoZGV2aWNlX2dldF9hZGFwdGVy
KGlkZXYtPmRldmljZSksCiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgfAog
ICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGJ0ZF9hZGFwdGVyICoKSW4gZmls
ZSBpbmNsdWRlZCBmcm9tIHByb2ZpbGVzL2lucHV0L2RldmljZS5jOjQ4OgouL3NyYy9kZXZpY2Uu
aDo1Mjo0Nzogbm90ZTogZXhwZWN0ZWQg4oCYc3RydWN0IGJ0ZF9kZXZpY2UgKuKAmSBidXQgYXJn
dW1lbnQgaXMgb2YgdHlwZSDigJhzdHJ1Y3QgYnRkX2FkYXB0ZXIgKuKAmQogICA1MiB8IHZvaWQg
ZGV2aWNlX3JlbW92ZV9ib25kaW5nKHN0cnVjdCBidGRfZGV2aWNlICpkZXZpY2UsIHVpbnQ4X3Qg
YmRhZGRyX3R5cGUpOwogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgIH5+fn5+fn5+
fn5+fn5+fn5+fn5efn5+fn4KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJv
cnMKbWFrZVsxXTogKioqIFtNYWtlZmlsZTo4NTc5OiBwcm9maWxlcy9pbnB1dC9ibHVldG9vdGhk
LWRldmljZS5vXSBFcnJvciAxCm1ha2U6ICoqKiBbTWFrZWZpbGU6NDAxMDogYWxsXSBFcnJvciAy
CgoKCi0tLQpSZWdhcmRzLApMaW51eCBCbHVldG9vdGgK

--===============0466509413499094413==--

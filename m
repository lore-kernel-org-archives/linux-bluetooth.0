Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24963C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 15:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E89996508A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 15:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237687AbhCPPEJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 11:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237678AbhCPPDc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 11:03:32 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB134C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 08:03:28 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id l132so35507533qke.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 08:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Q1uOqWNDevL+O9hrZ59prfUuokWJ/lJsZj//5SERaQo=;
        b=HCbrN71hfXBSXC16vvjiUg26jcQWu7W4sRxQrzR3MfqXcetUSbI4W7yJqIZU5M+fsQ
         Fl4Fytw03r3bZJkIhO3L/RwWALaLekdAmfl6Fv+yQGUVJF9vqy2GltnLstB/i9quhIJ5
         iIerw/znND79/p0tnNOE2NlQFbrU4AqH19dMrE8/jjN5Ic8ofA8uc3jb7SSktk6mzuzk
         AfnroxrogyZt3XS8trygfAuPVOxS8bSg13B+yW+tqdXmoUTkpo9Fo/ddjeJ5cqOF0D/Y
         A/gAPd8H3umZauN2lFZdaGYO5s4nbEUxUJBQWpt55ZBNA6cCO+3QfsG3pPMNdqRTlS3C
         8TFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Q1uOqWNDevL+O9hrZ59prfUuokWJ/lJsZj//5SERaQo=;
        b=R4b4M88wDF/7riq/Rv3YgghMCkR3mHhQIcdZ54lVjVRPqEyioai4sFy+k5UAvAr4dJ
         jDQ7puZx05lRhnkyZwu+r/li2RogS90gBrBctgqg699KXexvF/9W0fGv6Yr/uBb+YWzE
         8E8eg7QBYbuEy+0xc3rNKikzhOiOyC8Sbk+xoYizULLSra5zikQ43CwBnf3IkhNhbSSz
         yCnUaqtu/DlT0QK0i6WatWo0qr8YGXYCAxvZzKDcKZrlf5c0ntGTVblrI3GwrWQna559
         9Zkv19S1BjqP2Qj9gMVlO0cvgC2gA0Fx5JltnQET06g/mGz1olRAnlpUtskdDiyXOozL
         /rjw==
X-Gm-Message-State: AOAM531Oy78zNwxowNryLHT5wC9k3Q6ajyw8oP+DzbZMZUqRzKPFhoos
        Cvc/5RoG2syY4hwMP0VPJq9TIFS3n2cesA==
X-Google-Smtp-Source: ABdhPJyZkJciPeN01PhrvDM0EK0xj2CkNcUREKShWMpXEd20DYMqsDim+lYu85idAr2wbDPQmacNrA==
X-Received: by 2002:a05:620a:1467:: with SMTP id j7mr40467qkl.136.1615907006687;
        Tue, 16 Mar 2021 08:03:26 -0700 (PDT)
Received: from [172.17.0.2] ([104.208.244.135])
        by smtp.gmail.com with ESMTPSA id d10sm13292265qtq.78.2021.03.16.08.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:03:26 -0700 (PDT)
Message-ID: <6050c8be.1c69fb81.680f3.60d3@mx.google.com>
Date:   Tue, 16 Mar 2021 08:03:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4381986991170864485=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, cdwhite13@gmail.com
Subject: RE: emulator: Add Create BIG command in emulator
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210316144136.410-2-cdwhite13@gmail.com>
References: <20210316144136.410-2-cdwhite13@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4381986991170864485==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NDQ5MTI1CgotLS1U
ZXN0IHJlc3VsdC0tLQoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNr
UGF0Y2ggLSBQQVNTCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tH
aXRMaW50IC0gUEFTUwoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNr
QnVpbGQgLSBGQUlMCk91dHB1dDoKZW11bGF0b3IvYnRkZXYuYzogSW4gZnVuY3Rpb24g4oCYY21k
X2NyZWF0ZV9iaWdfY29tcGxldGXigJk6CmVtdWxhdG9yL2J0ZGV2LmM6NDUyOTo2OiBlcnJvcjog
4oCYc3RydWN0IGJ0X2hjaV9ldnRfbGVfYmlnX2NvbXBsZXRl4oCZIGhhcyBubyBtZW1iZXIgbmFt
ZWQg4oCYYmlnX2lk4oCZCiA0NTI5IHwgICBldnQuYmlnX2lkID0gY21kLT5iaWdfaWQ7CiAgICAg
IHwgICAgICBeCmVtdWxhdG9yL2J0ZGV2LmM6NDUyOToxOTogZXJyb3I6IOKAmGNvbnN0IHN0cnVj
dCBidF9oY2lfY21kX2xlX2NyZWF0ZV9iaWfigJkgaGFzIG5vIG1lbWJlciBuYW1lZCDigJhiaWdf
aWTigJkKIDQ1MjkgfCAgIGV2dC5iaWdfaWQgPSBjbWQtPmJpZ19pZDsKICAgICAgfCAgICAgICAg
ICAgICAgICAgICBefgptYWtlWzFdOiAqKiogW01ha2VmaWxlOjY3OTQ6IGVtdWxhdG9yL2J0ZGV2
Lm9dIEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmlsZTo0MDIzOiBhbGxdIEVycm9yIDIKCgojIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogTWFrZUNoZWNrIC0gU0tJUFBFRApPdXRw
dXQ6CmNoZWNrYnVpbGQgbm90IHN1Y2Nlc3MKCgoKLS0tClJlZ2FyZHMsCkxpbnV4IEJsdWV0b290
aAoK

--===============4381986991170864485==--

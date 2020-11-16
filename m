Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FA9C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Nov 2020 18:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79CD020756
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Nov 2020 18:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCxXaJmi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731856AbgKPS1N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Nov 2020 13:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731107AbgKPS1M (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Nov 2020 13:27:12 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38311C0613CF
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2020 10:27:12 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id z17so9214222qvy.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2020 10:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=vibx0okebikpoOacxzSKNabpra0iBmYtPdZXC9dWG4E=;
        b=VCxXaJmidTyiEGR83CYrpqmGQREuM6oVxl7yclJv5gCa/cJNU8FdFMh299P9JyNWvY
         v9J332zXaeiiXTDWtuEGlM10V/7lAjB6ZZgDInE1RhhhGXSQyfuQm3qvBKV76JYTblkr
         LNCSjgRKNwYYzku7hj+jvAltCyT67j4oayM5Lq1J7Kk8F5SsWQCQ60lrRsOSLPF+JVlW
         l5UN7o1bMtmtC6UAD+vPeJ6M4G0+gpCskRcu+udbT7pSBWhwVFlBNqRoa6iQEDbOvYba
         Z4DwquKa+G9e7frJ21PrifX+KTk9AMemlUmYe+WC58jsYAL/L79HoxDWgru2uhIkRkKS
         niOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=vibx0okebikpoOacxzSKNabpra0iBmYtPdZXC9dWG4E=;
        b=DSCZaEPubT0CorJllUjSSZjmb1IWpgno73HzO8tB6d+DBIayf4byiM5MlNUwRUkL1x
         dP2VuR+II5MfANwtb3HeJDA3471n1cJ3CE53k+bRFOrdOUk615oppZX7cV+mGkRe3XFE
         a56jMPu7A/Sy0mAqrqKhMKALYWl3X9gzioS3hybLtpWlU51fwPSWCoGYC1DqoI8MKX3n
         DRHQVLaF6CI0MCy5Er5ZEZHelruwCxT4HGUA36+IW32rZf4nWzYCW0cvJ1k1cq1s8VcN
         3ShKrryVgcj/STSl1N3E0zZyDSGFtyRbhQ4fVqTqyLDHo+s1foDQOFUSX9BGudO/JTor
         ou1g==
X-Gm-Message-State: AOAM533JrnmJ2h3h3Rh5fhWZpcnUKkQqCTkoyxpRgAY58NC+/A+9OEOx
        +RH04qXdNOSLpyF2V66nviRz1aHrMko=
X-Google-Smtp-Source: ABdhPJyw1Qf7a1V+lU8wQ58hhLVxZwvcscb8dmZj98cZ3VVDXaFplt43LpROCi37dBAlQCvxMyHfEg==
X-Received: by 2002:a05:6214:21a2:: with SMTP id t2mr2527739qvc.38.1605551231176;
        Mon, 16 Nov 2020 10:27:11 -0800 (PST)
Received: from [172.17.0.2] ([104.209.145.112])
        by smtp.gmail.com with ESMTPSA id n21sm2596854qke.21.2020.11.16.10.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 10:27:10 -0800 (PST)
Message-ID: <5fb2c47e.1c69fb81.7cd1f.0cad@mx.google.com>
Date:   Mon, 16 Nov 2020 10:27:10 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3572773709092884420=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: [bluez,v1] adv_monitor: Fix remove monitor from the kernel
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201116093746.bluez.v1.1.If5b2e2990c2c57e237708d8cbbf038e376ad0c7a@changeid>
References: <20201116093746.bluez.v1.1.If5b2e2990c2c57e237708d8cbbf038e376ad0c7a@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3572773709092884420==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9Mzg1MzExCgotLS1U
ZXN0IHJlc3VsdC0tLQoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNr
UGF0Y2ggLSBQQVNTCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tH
aXRMaW50IC0gUEFTUwoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNr
QnVpbGQgLSBGQUlMCk91dHB1dDoKYXI6IGB1JyBtb2RpZmllciBpZ25vcmVkIHNpbmNlIGBEJyBp
cyB0aGUgZGVmYXVsdCAoc2VlIGBVJykKYXI6IGB1JyBtb2RpZmllciBpZ25vcmVkIHNpbmNlIGBE
JyBpcyB0aGUgZGVmYXVsdCAoc2VlIGBVJykKYXI6IGB1JyBtb2RpZmllciBpZ25vcmVkIHNpbmNl
IGBEJyBpcyB0aGUgZGVmYXVsdCAoc2VlIGBVJykKYXI6IGB1JyBtb2RpZmllciBpZ25vcmVkIHNp
bmNlIGBEJyBpcyB0aGUgZGVmYXVsdCAoc2VlIGBVJykKYXI6IGB1JyBtb2RpZmllciBpZ25vcmVk
IHNpbmNlIGBEJyBpcyB0aGUgZGVmYXVsdCAoc2VlIGBVJykKc3JjL2Fkdl9tb25pdG9yLmM6IElu
IGZ1bmN0aW9uIOKAmHJlbW92ZV9hZHZfbW9uaXRvcl9jYuKAmToKc3JjL2Fkdl9tb25pdG9yLmM6
MjA5OjM0OiBlcnJvcjogdW51c2VkIHZhcmlhYmxlIOKAmG1hbmFnZXLigJkgWy1XZXJyb3I9dW51
c2VkLXZhcmlhYmxlXQogIDIwOSB8ICBzdHJ1Y3QgYnRkX2Fkdl9tb25pdG9yX21hbmFnZXIgKm1h
bmFnZXIgPSB1c2VyX2RhdGE7CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgXn5+fn5+fgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtl
WzFdOiAqKiogW01ha2VmaWxlOjkyNjA6IHNyYy9ibHVldG9vdGhkLWFkdl9tb25pdG9yLm9dIEVy
cm9yIDEKbWFrZTogKioqIFtNYWtlZmlsZTo0MDIwOiBhbGxdIEVycm9yIDIKCgojIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogTWFrZUNoZWNrIC0gU0tJUFBFRApPdXRwdXQ6CmNo
ZWNrYnVpbGQgbm90IHN1Y2Nlc3MKCgoKLS0tClJlZ2FyZHMsCkxpbnV4IEJsdWV0b290aAoK

--===============3572773709092884420==--

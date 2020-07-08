Return-Path: <SRS0=eST2=AT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0154C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jul 2020 03:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89A3320738
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jul 2020 03:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nh0GMeRE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbgGHDuW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jul 2020 23:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbgGHDuV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jul 2020 23:50:21 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22D8C061755
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2020 20:50:21 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id g13so33494227qtv.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2020 20:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=oQ73hcC0RLyzUpoLxb3yCD8dQWRA/dbCO/y1l+UPuKA=;
        b=Nh0GMeRESx312cpmpYq95nn4YvhfKUmLiIu0g75kHhG2GmK2/rdGhFQO+aDLadNXfA
         p8LWtCYjhoLadqfgxfzkIG2baDZlTox+bUXF75HtGIJxXyCnGRSwzojOQX0EmRf9pN3Z
         hXrCmeHd/O0TNz61vbwIL7hMmJBE/e7N8sXJvdQCygqz+lBEh32N3Ee7V8SQxE73aMjv
         v1BwhkOQgpHxDI7UGBED5z+YrBlVsCnA6388J3b/G2KqXjJuqd/sdNAbP4D6YS9BpR5N
         6jtZYcCyuAi7AEugyWxuw1t1IiGYzs+PLU9eqJ3cz0tnIw7hm5VklZjW/UD5yyHXfn/8
         Ck3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=oQ73hcC0RLyzUpoLxb3yCD8dQWRA/dbCO/y1l+UPuKA=;
        b=U9djFM43pjb1zM3p2gZI0jBJW6l4wPattcSeIk/YrqCoqpEiH6JwwytbyV56GNdQGH
         ZQcntGBvzmmOfpe6OYfaksvoioJrn9PhKz0Shik4M6ML9cOWfbr29vDUnDcm1/ow2pAa
         Ve0ZZUCtPSmW4LYK3/L4jf+/XlsL5otEiKYyaIQLEWFMxQyevAn6lKJOUkOCAqbYxY7k
         g2QZhk/1gSFoAVI3VbU+gAVbTDVHtXEo7LxPk/DfTWTAIxCSbIzDyygtVxgkv3h4z4YX
         wKqLfdeqHDe5OKnRMC+Liwwa0z0Ew1cCQ8x6VS+wXwkgtIlINZfBfOtGLa/95eHDhcWu
         4pSA==
X-Gm-Message-State: AOAM531AeYL48eFPxv+Vd+ol8ssiqTMBaDNAjGwocat+Qi7UqjXGCLrq
        kLdieg/5SmUu2mEZr8hjvnJRclIYm0g=
X-Google-Smtp-Source: ABdhPJx0HhmFA5ckq8VB45rWgB9u6pqRkepJDbtDQS09JJh4bF3EYF6dcxF0HKbuDr5/HuD4aS3oeg==
X-Received: by 2002:ac8:2783:: with SMTP id w3mr7106032qtw.66.1594180220830;
        Tue, 07 Jul 2020 20:50:20 -0700 (PDT)
Received: from [172.17.0.2] ([104.209.191.168])
        by smtp.gmail.com with ESMTPSA id w11sm29423781qtk.35.2020.07.07.20.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 20:50:20 -0700 (PDT)
Message-ID: <5f05427c.1c69fb81.f61e.0992@mx.google.com>
Date:   Tue, 07 Jul 2020 20:50:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3475845981174350110=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [bluez,v1] avrcp: include all player settings in notif event
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200708113139.bluez.v1.1.I6076fdf5621a5ce59b7307967a8c997638c1d1c8@changeid>
References: <20200708113139.bluez.v1.1.I6076fdf5621a5ce59b7307967a8c997638c1d1c8@changeid>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3475845981174350110==
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
ZmF1bHQgKHNlZSBgVScpCnByb2ZpbGVzL2F1ZGlvL2F2cmNwLmM6IEluIGZ1bmN0aW9uIOKAmGF2
cmNwX3BsYXllcl9ldmVudOKAmToKcHJvZmlsZXMvYXVkaW8vYXZyY3AuYzo3ODY6NjogZXJyb3I6
IHVudXNlZCB2YXJpYWJsZSDigJh2YWzigJkgWy1XZXJyb3I9dW51c2VkLXZhcmlhYmxlXQogIDc4
NiB8ICBpbnQgdmFsOwogICAgICB8ICAgICAgXn5+CnByb2ZpbGVzL2F1ZGlvL2F2cmNwLmM6Nzg1
OjY6IGVycm9yOiB1bnVzZWQgdmFyaWFibGUg4oCYYXR0cuKAmSBbLVdlcnJvcj11bnVzZWQtdmFy
aWFibGVdCiAgNzg1IHwgIGludCBhdHRyOwogICAgICB8ICAgICAgXn5+fgpwcm9maWxlcy9hdWRp
by9hdnJjcC5jOjc4NDo5OiBlcnJvcjogdW51c2VkIHZhcmlhYmxlIOKAmHNldHRpbmdz4oCZIFst
V2Vycm9yPXVudXNlZC12YXJpYWJsZV0KICA3ODQgfCAgR0xpc3QgKnNldHRpbmdzOwogICAgICB8
ICAgICAgICAgXn5+fn5+fn4KcHJvZmlsZXMvYXVkaW8vYXZyY3AuYzogSW4gZnVuY3Rpb24g4oCY
YXZyY3BfaGFuZGxlX3JlZ2lzdGVyX25vdGlmaWNhdGlvbuKAmToKcHJvZmlsZXMvYXVkaW8vYXZy
Y3AuYzoxNjE3Ojk6IGVycm9yOiB1bnVzZWQgdmFyaWFibGUg4oCYc2V0dGluZ3PigJkgWy1XZXJy
b3I9dW51c2VkLXZhcmlhYmxlXQogMTYxNyB8ICBHTGlzdCAqc2V0dGluZ3M7CiAgICAgIHwgICAg
ICAgICBefn5+fn5+fgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwpt
YWtlWzFdOiAqKiogW01ha2VmaWxlOjg0Njc6IHByb2ZpbGVzL2F1ZGlvL2JsdWV0b290aGQtYXZy
Y3Aub10gRXJyb3IgMQptYWtlOiAqKiogW01ha2VmaWxlOjQwMTA6IGFsbF0gRXJyb3IgMgoKCgot
LS0KUmVnYXJkcywKTGludXggQmx1ZXRvb3RoCg==

--===============3475845981174350110==--

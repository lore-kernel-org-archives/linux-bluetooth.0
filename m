Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E239AC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Mar 2021 06:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99B2664F69
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Mar 2021 06:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbhCSGjV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Mar 2021 02:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbhCSGjN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Mar 2021 02:39:13 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A586C06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Mar 2021 23:39:13 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id s2so5992197qtx.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Mar 2021 23:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=3/PKbEAkrD6AhCy5iBaTWfaSjAqA9PIGuxPbM5nO9SA=;
        b=E10BxdBxKkJj1PcWL61wtbiuo0XjzgmxvKKi/HSULJXr3LTXwfOBVlXYxgYhNhFHGf
         0m2AqIiE4WQbRAScYvDiD5kE9dgsDGM1BRfRKS6ex52pcjRhMjzxhzEVcWYtye3DfzmC
         mG+o/FGou705Y7y5vCBPCf8+sDKnI7dULm4MYBM6Bd40fy9wgSbM0ag0YvJ74xUmLF0d
         P7heh8oPiaonu6yGYVwOiWjwvz3iUx/kqZRqb9gKCaiGv6CFvh9P7eReqablCxj3e7/q
         5NGxg2U+Cddq1YI4x9n2GRq0w8jnn8nqycI9OYCe/TbAoL5xb4FcySHIe+Gk+JSKlMbK
         XyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=3/PKbEAkrD6AhCy5iBaTWfaSjAqA9PIGuxPbM5nO9SA=;
        b=MzNf3VDvls9y3R+H4lWxmAnhNMjW19B3fWORbYi5kL1zlk9c8SoOD+mqq4nMkHFsZd
         +Yzw6xNOQhHhJoLeTB8939C9sik7OTp7erQ05eII2vYLlRuq6xX1RUwmXB7PpkKlw1nx
         z3PoOEJ/Zg/QVWtpxJIVL4mmYdnKNrY5dhKajm+iRSWYTrCMQCu1fv/sYd7ITV8TNLYI
         w+fRk4eSul1YlEYMoYml7N6PNZ3GaQIjDjZau0p8fyzgBNsA4EAaWivdiy2MhNgc/6qt
         mJ9+kp3oiwfOsKg8WET3UDVXp8qzHFhDUfKTlxTGTiiookOtgKu9g5qg2Ju2R0q4j1kr
         sZtA==
X-Gm-Message-State: AOAM533C/Gup6+IV1Cpf5jwuwSRDvvVOzoo2TbdUkhgGilvqce53zFRx
        2QDzjmWzOBVXE6uNHXZohGBk1oGwnRYsqg==
X-Google-Smtp-Source: ABdhPJyiEsPTCg0Vc6AmOo4ZQxureYKVoUgBI0fgK9YFXklKBJCdNTjw0RVlZ68Y781ZtKVZjYLOfw==
X-Received: by 2002:ac8:4406:: with SMTP id j6mr7008533qtn.180.1616135952430;
        Thu, 18 Mar 2021 23:39:12 -0700 (PDT)
Received: from [172.17.0.2] ([20.36.207.155])
        by smtp.gmail.com with ESMTPSA id k28sm3733309qki.101.2021.03.18.23.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 23:39:12 -0700 (PDT)
Message-ID: <60544710.1c69fb81.30e41.6ea0@mx.google.com>
Date:   Thu, 18 Mar 2021 23:39:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5368891168233235318=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez,1/2] adv_monitor: split rssi_parameters into its own struct
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210319135138.Bluez.1.I8797a75fcc7c1e997f177b08dc23a1df0272e0a5@changeid>
References: <20210319135138.Bluez.1.I8797a75fcc7c1e997f177b08dc23a1df0272e0a5@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5368891168233235318==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NDUxMzI5CgotLS1U
ZXN0IHJlc3VsdC0tLQoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNr
UGF0Y2ggLSBQQVNTCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tH
aXRMaW50IC0gUEFTUwoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNr
QnVpbGQgLSBGQUlMCk91dHB1dDoKc3JjL2Fkdl9tb25pdG9yLmM6MzM0OjM2OiBlcnJvcjogbm8g
cHJldmlvdXMgZGVjbGFyYXRpb24gZm9yIOKAmG1lcmdlZF9wYXR0ZXJuX2ZpbmTigJkgWy1XZXJy
b3I9bWlzc2luZy1kZWNsYXJhdGlvbnNdCiAgMzM0IHwgc3RydWN0IGFkdl9tb25pdG9yX21lcmdl
ZF9wYXR0ZXJuICptZXJnZWRfcGF0dGVybl9maW5kKAogICAgICB8ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fgpzcmMvYWR2X21vbml0b3IuYzog
SW4gZnVuY3Rpb24g4oCYcmVtb3ZlX21lcmdlZF9wYXR0ZXJu4oCZOgpzcmMvYWR2X21vbml0b3Iu
YzoxNTAyOjIyOiBlcnJvcjogdW51c2VkIHZhcmlhYmxlIOKAmG1vbml0b3LigJkgWy1XZXJyb3I9
dW51c2VkLXZhcmlhYmxlXQogMTUwMiB8ICBzdHJ1Y3QgYWR2X21vbml0b3IgKm1vbml0b3I7CiAg
ICAgIHwgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fgpjYzE6IGFsbCB3YXJuaW5ncyBiZWlu
ZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiogW01ha2VmaWxlOjkyNzE6IHNyYy9ibHVl
dG9vdGhkLWFkdl9tb25pdG9yLm9dIEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmlsZTo0MDI2OiBh
bGxdIEVycm9yIDIKCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogTWFrZUNo
ZWNrIC0gU0tJUFBFRApPdXRwdXQ6CmNoZWNrYnVpbGQgbm90IHN1Y2Nlc3MKCgoKLS0tClJlZ2Fy
ZHMsCkxpbnV4IEJsdWV0b290aAoK

--===============5368891168233235318==--

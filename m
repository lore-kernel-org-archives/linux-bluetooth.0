Return-Path: <SRS0=wtMD=CT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482DCC433E2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 04:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE4F42076C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 04:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkQglmNg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgIJEvU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Sep 2020 00:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgIJEvB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Sep 2020 00:51:01 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C241C061757
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2020 21:50:58 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id w186so4874488qkd.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2020 21:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=iyG2yc7oujFwDny2rBdGvywMFOjLXj5gCk7vHUEQnQI=;
        b=jkQglmNgAkv4mog5p8mSJcfdllHRMoWJvqz/2Io0FP76rhRRrfK2DZFlsXILkibfJ2
         NyCj0jMyW8gxiuuYmQvvr4JrUSKKMk5KNoUTPE53QJwZQMheHVTK4S2ZBURVrS//NMWv
         BRJvOTkxggX+/kt0Jnj8WRqt1C4iu6NRjsl7AXeghFx2gBYyKaCsQSka6Z0Prepc2mIt
         zL8oPK0SzZqHbr162mLXY3U9F/S/U1FW8STUj3y0RMHeVRa5WVOJgLExiEI5A1vtoPI2
         t/GvruxxM84xQ/6lLXtJtXFV5MxtWoSO1PYOvo+4NLbCvSNStLCcg92Kvs3h+/kacff7
         6H4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=iyG2yc7oujFwDny2rBdGvywMFOjLXj5gCk7vHUEQnQI=;
        b=ZSJ2eD4iCA6+WK3/De8lkZ79Kxoz+lBoATL1CH24yoIxu0xVCkB/ov/0cbvY5oD3AI
         G84N/ezLrbP+45qOialowoc6DUiu16uvnhYaXTTSomTJ1Ff/IIpsApHLpHC0PgHKZwyv
         XGAncIrnk9OZdsGswWEXxbH4xxkl4z9Q/5IeSRWaPa0CgCF6cjn/8QuhsnJtkECHy1C0
         E09w4NA0wAJwdLGD4lEVVJ5WaWO0yZqycLQsxfzrBUFY1BfMZCM5vNQBgYtei+kx8gxA
         aGsBlJleD7z7Mvo7itG2wKEw9gzaclTLDVE9Pc1UnVWLkmWou/CifKDeRl3LP0rOC/ed
         9oRw==
X-Gm-Message-State: AOAM533zzpMTWJZP7qmw88LNWOOjEOZ9PyoOhv4fUexTGGtn/tQkVCVS
        8kJkeZMIbl4UVrvsnFAUuHDXT511s2Oomw==
X-Google-Smtp-Source: ABdhPJykZlmYR9Ab7DMa6ELXcbfvHiGQdO341uBC8/wajNiA9Q5Ok9xOtgqkUZBsYT4MHQjXkbGfHA==
X-Received: by 2002:a05:620a:13e8:: with SMTP id h8mr6228300qkl.322.1599713457723;
        Wed, 09 Sep 2020 21:50:57 -0700 (PDT)
Received: from [172.17.0.2] ([52.254.71.168])
        by smtp.gmail.com with ESMTPSA id w59sm5637539qtd.1.2020.09.09.21.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 21:50:57 -0700 (PDT)
Message-ID: <5f59b0b1.1c69fb81.ec0c2.af3e@mx.google.com>
Date:   Wed, 09 Sep 2020 21:50:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5268216710086389930=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mcchou@chromium.org
Subject: RE: [BlueZ,v3,1/7] adv_monitor: Introduce org.bluez.AdvertisementMonitorManager1 interface
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200909214058.BlueZ.v3.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
References: <20200909214058.BlueZ.v3.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5268216710086389930==
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
X21hdGNo4oCZOgpzcmMvYWR2X21vbml0b3IuYzoyNzc6MzU6IGVycm9yOiBwYXNzaW5nIGFyZ3Vt
ZW50IDEgb2Yg4oCYZ19kYnVzX3Byb3h5X2dldF9wYXRo4oCZIGRpc2NhcmRzIOKAmGNvbnN04oCZ
IHF1YWxpZmllciBmcm9tIHBvaW50ZXIgdGFyZ2V0IHR5cGUgWy1XZXJyb3I9ZGlzY2FyZGVkLXF1
YWxpZmllcnNdCiAgMjc3IHwgIGlmIChzdHJjbXAoZ19kYnVzX3Byb3h5X2dldF9wYXRoKHByb3h5
KSwgbW9uaXRvci0+cGF0aCkgIT0gMCkKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXn5+fn4KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIHNyYy9hZHZfbW9uaXRvci5jOjMx
OgouL2dkYnVzL2dkYnVzLmg6MzM2OjEzOiBub3RlOiBleHBlY3RlZCDigJhHREJ1c1Byb3h5ICri
gJkge2FrYSDigJhzdHJ1Y3QgR0RCdXNQcm94eSAq4oCZfSBidXQgYXJndW1lbnQgaXMgb2YgdHlw
ZSDigJhjb25zdCBHREJ1c1Byb3h5ICrigJkge2FrYSDigJhjb25zdCBzdHJ1Y3QgR0RCdXNQcm94
eSAq4oCZfQogIDMzNiB8IGNvbnN0IGNoYXIgKmdfZGJ1c19wcm94eV9nZXRfcGF0aChHREJ1c1By
b3h5ICpwcm94eSk7CiAgICAgIHwgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+CnNy
Yy9hZHZfbW9uaXRvci5jOiBJbiBmdW5jdGlvbiDigJhwYXJzZV9wYXR0ZXJuc+KAmToKc3JjL2Fk
dl9tb25pdG9yLmM6NDg2OjM2OiBlcnJvcjogc3VnZ2VzdCBwYXJlbnRoZXNlcyBhcm91bmQg4oCY
JibigJkgd2l0aGluIOKAmHx84oCZIFstV2Vycm9yPXBhcmVudGhlc2VzXQogIDQ4NiB8ICAgaWYg
KGFkX3R5cGUgPiBCVF9BRF8zRF9JTkZPX0RBVEEgJiYKc3JjL2Fkdl9tb25pdG9yLmM6NDI2OjEx
OiBlcnJvcjogdW51c2VkIHZhcmlhYmxlIOKAmG51bV9wYXR0ZXJuc+KAmSBbLVdlcnJvcj11bnVz
ZWQtdmFyaWFibGVdCiAgNDI2IHwgIHVpbnQxNl90IG51bV9wYXR0ZXJucyA9IDA7CiAgICAgIHwg
ICAgICAgICAgIF5+fn5+fn5+fn5+fgpzcmMvYWR2X21vbml0b3IuYzogSW4gZnVuY3Rpb24g4oCY
Z2V0X3N1cHBvcnRlZF9tb25pdG9yX3R5cGVz4oCZOgpzcmMvYWR2X21vbml0b3IuYzo3NTQ6MzQ6
IGVycm9yOiB1bnVzZWQgdmFyaWFibGUg4oCYbWFuYWdlcuKAmSBbLVdlcnJvcj11bnVzZWQtdmFy
aWFibGVdCiAgNzU0IHwgIHN0cnVjdCBidGRfYWR2X21vbml0b3JfbWFuYWdlciAqbWFuYWdlciA9
IGRhdGE7CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fgpj
YzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiogW01h
a2VmaWxlOjkyNzI6IHNyYy9ibHVldG9vdGhkLWFkdl9tb25pdG9yLm9dIEVycm9yIDEKbWFrZTog
KioqIFtNYWtlZmlsZTo0MDE0OiBhbGxdIEVycm9yIDIKCgoKLS0tClJlZ2FyZHMsCkxpbnV4IEJs
dWV0b290aAo=

--===============5268216710086389930==--

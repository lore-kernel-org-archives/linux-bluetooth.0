Return-Path: <SRS0=Aqt4=BY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE87FC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 10:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8DE2207DA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 10:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="utlT8+NZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgHNK2z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Aug 2020 06:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgHNK2w (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Aug 2020 06:28:52 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721B0C061383
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2020 03:28:51 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id 2so7836263qkf.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2020 03:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=/1MLXCdEu7siuiOtoRF23IoFTdUDvY1mjVcwi3A7tJU=;
        b=utlT8+NZB2s1duBya1iLjwGVUaSqOy1FAUr044KBpr9ZCx6JUYw3kV7WvrRgVxjiZs
         +mT1A01tt0AvlvTaheqCiE5xjWWsxzlNIV3MBviQPO6/oXL+hrw2PHhkhqmt31MEcKwg
         n0WFuTn32N42D1y3evEoQCl/t4og4M27Z2oOiJQv5EKfn/vLiHNpnUyeur1KWOY/Q2QY
         R0JmBFwTdsYNTMb3vE6XwNJ5NxT7baN2DdEMqM2qxynbOE11P3PviiETw1OlQeaWWW1G
         EtiYDsLx9sf2YnfuvWVHevmmhXpgGJXjbKefdwJjfJAVab6bZefzBAtxBIlMJ5QLYwnt
         EWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=/1MLXCdEu7siuiOtoRF23IoFTdUDvY1mjVcwi3A7tJU=;
        b=jzzjdbZCe2YqXaFKdrBXsGGtmk+ZHmyduZE1CiQ8o7+sitZ+5B/hygs1kKFI5b/k+/
         oQuxf/iNBy3f+8YZp/SR6eb1f1Gg0IMKYVjuDusmzR9b7iLw6vq02t5NsP5WKo2fVNgp
         ONC53B2ICrXwfgIxTqHdS+7i62wNFvt6al8LryCrHwnRyq8Fm0q0LcVmBE9tkj+ygu0B
         IL+rr3gjs4eDXLDhf/PC8H5KZkU7bmhxr+Cd0sUHujXEkXiGdEBW9ulBjTEQvdwlqQHb
         9FpaGkxHNq7E+ti8DonzxuN1BclGb521Guc+btR9pcNKOS+aopjYfdV7QjyIjwxDiZxr
         LWDw==
X-Gm-Message-State: AOAM533XAsKRLK/Pi4TeZ1PNpyTdktb1hp+MdIVONqnVzcB4xzL195GR
        9MJk3/Qct73ZqGHuqlXgczpW5t8sbx22vA==
X-Google-Smtp-Source: ABdhPJyodE9G//HQ930auQcMl4tBw/YbK5btfavwnl6EFMPM7a+NjwgDGTJQ+kjuKp6f4r/pII45Iw==
X-Received: by 2002:a37:a503:: with SMTP id o3mr1312425qke.162.1597400929578;
        Fri, 14 Aug 2020 03:28:49 -0700 (PDT)
Received: from [172.17.0.2] ([52.254.74.102])
        by smtp.gmail.com with ESMTPSA id h20sm8225047qkk.79.2020.08.14.03.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 03:28:49 -0700 (PDT)
Message-ID: <5f366761.1c69fb81.53a96.12c8@mx.google.com>
Date:   Fri, 14 Aug 2020 03:28:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2568234707712340665=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, 515672508@qq.com
Subject: RE: [BlueZ] adapt:Set property mode failed,memory leak This patch will fix a memory leak,when set property mode,it will send a msg, but if failed,the data'memory do not free
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200814095433.10654-1-515672508@qq.com>
References: <20200814095433.10654-1-515672508@qq.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2568234707712340665==
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
ZmF1bHQgKHNlZSBgVScpCnNyYy9hZGFwdGVyLmM6IEluIGZ1bmN0aW9uIOKAmHByb3BlcnR5X3Nl
dF9tb2Rl4oCZOgpzcmMvYWRhcHRlci5jOjI5MTk6MjogZXJyb3I6IHRoaXMg4oCYaWbigJkgY2xh
dXNlIGRvZXMgbm90IGd1YXJkLi4uIFstV2Vycm9yPW1pc2xlYWRpbmctaW5kZW50YXRpb25dCiAy
OTE5IHwgIGlmIChtZ210X3NlbmQoYWRhcHRlci0+bWdtdCwgb3Bjb2RlLCBhZGFwdGVyLT5kZXZf
aWQsIGxlbiwgcGFyYW0sCiAgICAgIHwgIF5+CnNyYy9hZGFwdGVyLmM6MjkyMjozOiBub3RlOiAu
Li50aGlzIHN0YXRlbWVudCwgYnV0IHRoZSBsYXR0ZXIgaXMgbWlzbGVhZGluZ2x5IGluZGVudGVk
IGFzIGlmIGl0IHdlcmUgZ3VhcmRlZCBieSB0aGUg4oCYaWbigJkKIDI5MjIgfCAgIHJldHVybjsK
ICAgICAgfCAgIF5+fn5+fgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9y
cwptYWtlWzFdOiAqKiogW01ha2VmaWxlOjkxNjc6IHNyYy9ibHVldG9vdGhkLWFkYXB0ZXIub10g
RXJyb3IgMQptYWtlOiAqKiogW01ha2VmaWxlOjQwMTA6IGFsbF0gRXJyb3IgMgoKCgotLS0KUmVn
YXJkcywKTGludXggQmx1ZXRvb3RoCg==

--===============2568234707712340665==--

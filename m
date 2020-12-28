Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4640C433E6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 10:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E1CE229C4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 10:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgL1Knb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Dec 2020 05:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgL1Knb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Dec 2020 05:43:31 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA46C061798
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Dec 2020 02:42:51 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id r17so9078450ilo.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Dec 2020 02:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ESvq7JDM0AwglaYauxg9ODpqV9v4QxfRybd8x5hURkg=;
        b=lOvWcQzaw8w6ghkH0mK9T4R4X26UsTDZBLcilKORUKYqEuJ0wxg5gbsd24FtTBGSjO
         DIYcvfVBS17DAhJixSQ2OMadZBi9y++mJr2thbylANoyPky6d9FBdkbtAQeQMnMyBqsd
         /lwNVMWm/cHxXP92N6gvgQofzvjUTS4w+8doLPE9whiX2DABUDLXb5aE82mYmFkpYwXu
         t9T8opR4wLSgCMDmuX2WAiFldsQrgYdoat1ueKW2U5h0frW7g0wES8DVPg1rezeUs6D7
         60bBEuhd+KUTPDLN8IgwQ/ElVkaOl1nAaFFuE4jD4SydUjkHedp88zvutXuQZWWnW04h
         jsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ESvq7JDM0AwglaYauxg9ODpqV9v4QxfRybd8x5hURkg=;
        b=Lx6bAvSTmYcMoPQifq6FNNz7srNm1EHGCae/0IlGzahLIx8u4Ma2sEHA9jOk9DM2St
         qMcwhYHOOGtR48pHyHDIIlF2rda7E4CRmg1RrpUEBH/naTUqcoAJM8cEEOBMLFXirRv3
         LaGQ7ZZCo2IeTCRv4vv42FHu0uYMoNlRHWZnWR8tWm5K4M5vgmpEqXouaEFa+9DECRiG
         X1EWBP9584EEnp0vG8XJeg6IFIKtwYBBgDBV1ZtYDz+n4fGooH4uLxFIn+aT/ybipYsR
         /ZcHbKnxJ8ldrov2bdd//7fzdwqhu+68vmbETzYIvw0hRPlB/Gqg6tKSSw0urKPQ/rkL
         Pryg==
X-Gm-Message-State: AOAM533DqBCmrtbzGFlA8TT1ysAVUH1cqdcUOiEIQ973qrge1wY+Rx/0
        HDGCfZYOCLtUE6lD65vpcHGwJgoqFYE=
X-Google-Smtp-Source: ABdhPJxpdLwrEPT5pbjj2fpRU+mI/M1t3vB/iUiHaDIzgjbz782OR4LDyRZdz9JisfLj3ovQiSMZew==
X-Received: by 2002:a92:c6c3:: with SMTP id v3mr43161060ilm.281.1609152170347;
        Mon, 28 Dec 2020 02:42:50 -0800 (PST)
Received: from [172.17.0.2] ([137.116.58.25])
        by smtp.gmail.com with ESMTPSA id o11sm27067038ilt.23.2020.12.28.02.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 02:42:49 -0800 (PST)
Message-ID: <5fe9b6a9.1c69fb81.948f8.694f@mx.google.com>
Date:   Mon, 28 Dec 2020 02:42:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4355444511963207314=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [Bluez,v2,1/4] shared/mgmt: Add supports of parsing mgmt tlv list
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201228180429.Bluez.v2.1.Ie32770d0eed2e7739ce9d17d920766fb6aee8583@changeid>
References: <20201228180429.Bluez.v2.1.Ie32770d0eed2e7739ce9d17d920766fb6aee8583@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4355444511963207314==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NDA2NzA5CgotLS1U
ZXN0IHJlc3VsdC0tLQoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNr
UGF0Y2ggLSBGQUlMCk91dHB1dDoKYnRtZ210OiBBZGQgY29tbWFuZCBzZXQtc3lzY29uZmlnCldB
Uk5JTkc6TkFLRURfU1NDQU5GOiB1bmNoZWNrZWQgc3NjYW5mIHJldHVybiB2YWx1ZQojNDI6IEZJ
TEU6IHRvb2xzL2J0bWdtdC5jOjE4MTg6CisJCWlmICghc3NjYW5mKGlucHV0ICsgaSAqIDIsICIl
MmhoeCIsICZ2YWx1ZVtpXSkpCisJCQlyZXR1cm4gZmFsc2U7CgotIHRvdGFsOiAwIGVycm9ycywg
MSB3YXJuaW5ncywgMTIxIGxpbmVzIGNoZWNrZWQKCk5PVEU6IEZvciBzb21lIG9mIHRoZSByZXBv
cnRlZCBkZWZlY3RzLCBjaGVja3BhdGNoIG1heSBiZSBhYmxlIHRvCiAgICAgIG1lY2hhbmljYWxs
eSBjb252ZXJ0IHRvIHRoZSB0eXBpY2FsIHN0eWxlIHVzaW5nIC0tZml4IG9yIC0tZml4LWlucGxh
Y2UuCgoiW1BBVENIXSBidG1nbXQ6IEFkZCBjb21tYW5kIHNldC1zeXNjb25maWciIGhhcyBzdHls
ZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4KCk5PVEU6IElnbm9yZWQgbWVzc2FnZSB0eXBlczog
Q09NTUlUX01FU1NBR0UgQ09NUExFWF9NQUNSTyBDT05TVF9TVFJVQ1QgRklMRV9QQVRIX0NIQU5H
RVMgTUlTU0lOR19TSUdOX09GRiBQUkVGRVJfUEFDS0VEIFNQTElUX1NUUklORyBTU0NBTkZfVE9f
S1NUUlRPCgpOT1RFOiBJZiBhbnkgb2YgdGhlIGVycm9ycyBhcmUgZmFsc2UgcG9zaXRpdmVzLCBw
bGVhc2UgcmVwb3J0CiAgICAgIHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZSBDSEVDS1BBVENI
IGluIE1BSU5UQUlORVJTLgoKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBD
aGVja0dpdExpbnQgLSBQQVNTCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDog
Q2hlY2tCdWlsZCAtIEZBSUwKT3V0cHV0Ogp0b29scy9idG1nbXQuYzogSW4gZnVuY3Rpb24g4oCY
cmVhZF9zeXNjb25maWdfcnNw4oCZOgp0b29scy9idG1nbXQuYzoxNzY5OjE5OiBlcnJvcjogdW51
c2VkIHZhcmlhYmxlIOKAmGVudHJ54oCZIFstV2Vycm9yPXVudXNlZC12YXJpYWJsZV0KIDE3Njkg
fCAgc3RydWN0IG1nbXRfdGx2ICplbnRyeTsKICAgICAgfCAgICAgICAgICAgICAgICAgICBefn5+
fgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiog
W01ha2VmaWxlOjY3OTI6IHRvb2xzL2J0bWdtdC5vXSBFcnJvciAxCm1ha2U6ICoqKiBbTWFrZWZp
bGU6NDAyMzogYWxsXSBFcnJvciAyCgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRl
c3Q6IE1ha2VDaGVjayAtIFNLSVBQRUQKT3V0cHV0OgpjaGVja2J1aWxkIG5vdCBzdWNjZXNzCgoK
Ci0tLQpSZWdhcmRzLApMaW51eCBCbHVldG9vdGgKCg==

--===============4355444511963207314==--

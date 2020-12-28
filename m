Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FCAC433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 07:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5BB9207D1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 07:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgL1HJT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Dec 2020 02:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgL1HJT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Dec 2020 02:09:19 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6788C061794
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Dec 2020 23:08:38 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id q1so8720924ilt.6
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Dec 2020 23:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=aKr2WBK7mJDblrKHQzH/8XWXaNMwwW9MHEv1iJl3unY=;
        b=iXWDr86lti0VKx26E0ttv4wMyr6PuLsN0eMO1ZyQ/iK6S3rwpJ9hyT2/5rORKGzvKo
         nmX+EDCl/QpWiwT1nyLeywLtMHJAXuqZvmWiPJp8Lv3QnNeIpElOuzUN4f7QTb/5WIin
         2PapnE0oq3+SHT3OecG5hxcaD9xT+Zn4hCoLWSfL6/ml6WXbZB4Kf9Px3CqLR05Opg84
         gq2n02BONqs2FQPEYpkz8LCdnqvRcuuhFMJfO90umlT7Fe4XpHD034fRFTM7GVeRWe+t
         L2ptB4AHt01CwF9/OF28QuSKbLAxSXuByF9T5BpqTZ6fNZcRaYC04GtBQR5fEVlgnOft
         dxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=aKr2WBK7mJDblrKHQzH/8XWXaNMwwW9MHEv1iJl3unY=;
        b=gOZjV+CNdhlcH9PmkkoHjeov1OzSh+8071iNZpyBxs/20dA6HfDbnDWFtCZO4ptwMm
         +fczh4kLwha3Lel79vS71Nk+W0jaeuM0uQhCih4iNGNuLIkrUuclrYVHFtO6/L/bll/u
         WzCAGx0qxhlm5RxZZhsqqLMrwN9ouJLUB8giLR3pdxxdxy4gJ2ikcx02PmXhZ+qpLzhD
         Nk769VJjGj3xPTz/1NOOpXvkxNWjewd57n3yAJaJjbQJKGsBpRJrF3gvI8yrngAAjj0l
         bmNqd1IKDcnq+8kbPtxt/DeLKaCpwxHHGM0M+syjch52Nl634ElDz2a3EV71QQdKeTmw
         ON7w==
X-Gm-Message-State: AOAM533VXmml/Ts6w67aVvoPCbChmCMuYsbSykWA7S+J0i4CWnc3xm2n
        ZlUYkzV0R5EFGU1KtjU+aVH59Lefpas=
X-Google-Smtp-Source: ABdhPJwdH6eylJryxB1XJtEpp+pUN8tz3ZJ3Tjb7I3rSlNtGBHDetfW9YGd7ZBBElFOf3M4oJfDFzA==
X-Received: by 2002:a05:6e02:102f:: with SMTP id o15mr42745151ilj.142.1609139317814;
        Sun, 27 Dec 2020 23:08:37 -0800 (PST)
Received: from [172.17.0.2] ([20.185.34.75])
        by smtp.gmail.com with ESMTPSA id p3sm32316138iol.35.2020.12.27.23.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Dec 2020 23:08:37 -0800 (PST)
Message-ID: <5fe98475.1c69fb81.ff497.15c4@mx.google.com>
Date:   Sun, 27 Dec 2020 23:08:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8907483464826495419=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [Bluez,v1,1/4] shared/mgmt: Add supports of parsing mgmt tlv list
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201228144543.Bluez.v1.1.Ie32770d0eed2e7739ce9d17d920766fb6aee8583@changeid>
References: <20201228144543.Bluez.v1.1.Ie32770d0eed2e7739ce9d17d920766fb6aee8583@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8907483464826495419==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NDA2NjU5CgotLS1U
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
aGVja0dpdExpbnQgLSBGQUlMCk91dHB1dDoKYnRtZ210OiBBZGQgY29tbWFuZCBzZXQtc3lzY29u
ZmlnCjg6IEIzIExpbmUgY29udGFpbnMgaGFyZCB0YWIgY2hhcmFjdGVycyAoXHQpOiAiCS12IDx0
eXBlOmxlbmd0aDp2YWx1ZT4uLi4iCjEwOiBCMyBMaW5lIGNvbnRhaW5zIGhhcmQgdGFiIGNoYXJh
Y3RlcnMgKFx0KTogIglzZXQtc3lzY29uZmlnIC12IDAwMWE6MjoxMjM0IDAwMWY6MTowMCIKCgoj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tCdWlsZCAtIEZBSUwKT3V0
cHV0OgpzcmMvc2hhcmVkL21nbXQuYzogSW4gZnVuY3Rpb24g4oCYbWdtdF90bHZfbGlzdF9mcmVl
4oCZOgpzcmMvc2hhcmVkL21nbXQuYzo1OTg6Mzc6IGVycm9yOiBwYXNzaW5nIGFyZ3VtZW50IDIg
b2Yg4oCYcXVldWVfZGVzdHJveeKAmSBmcm9tIGluY29tcGF0aWJsZSBwb2ludGVyIHR5cGUgWy1X
ZXJyb3I9aW5jb21wYXRpYmxlLXBvaW50ZXItdHlwZXNdCiAgNTk4IHwgIHF1ZXVlX2Rlc3Ryb3ko
dGx2X2xpc3QtPnRsdl9xdWV1ZSwgbWdtdF90bHZfZnJlZSk7CiAgICAgIHwgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fgogICAgICB8ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB2b2lkICgqKShzdHJ1Y3QgbWdtdF90bHYgKikKSW4gZmlsZSBpbmNsdWRl
ZCBmcm9tIHNyYy9zaGFyZWQvbWdtdC5jOjI1OgouL3NyYy9zaGFyZWQvcXVldWUuaDoyMzo2Mjog
bm90ZTogZXhwZWN0ZWQg4oCYcXVldWVfZGVzdHJveV9mdW5jX3TigJkge2FrYSDigJh2b2lkICgq
KSh2b2lkICop4oCZfSBidXQgYXJndW1lbnQgaXMgb2YgdHlwZSDigJh2b2lkICgqKShzdHJ1Y3Qg
bWdtdF90bHYgKinigJkKICAgMjMgfCB2b2lkIHF1ZXVlX2Rlc3Ryb3koc3RydWN0IHF1ZXVlICpx
dWV1ZSwgcXVldWVfZGVzdHJveV9mdW5jX3QgZGVzdHJveSk7CiAgICAgIHwgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIH5+fn5+fn5+fn5+fn5+fn5+fn5+fl5+fn5+fn4K
c3JjL3NoYXJlZC9tZ210LmM6IEluIGZ1bmN0aW9uIOKAmG1nbXRfdGx2X2xpc3RfbG9hZF9mcm9t
X2J1ZuKAmToKc3JjL3NoYXJlZC9tZ210LmM6NjQxOjI4OiBlcnJvcjogaW5pdGlhbGl6YXRpb24g
b2Yg4oCYc3RydWN0IG1nbXRfdGx2ICrigJkgZnJvbSBpbmNvbXBhdGlibGUgcG9pbnRlciB0eXBl
IOKAmGNvbnN0IHVpbnQ4X3QgKuKAmSB7YWthIOKAmGNvbnN0IHVuc2lnbmVkIGNoYXIgKuKAmX0g
Wy1XZXJyb3I9aW5jb21wYXRpYmxlLXBvaW50ZXItdHlwZXNdCiAgNjQxIHwgICBzdHJ1Y3QgbWdt
dF90bHYgKmVudHJ5ID0gY3VyOwogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+
fgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiog
W01ha2VmaWxlOjY4MDg6IHNyYy9zaGFyZWQvbWdtdC5sb10gRXJyb3IgMQptYWtlOiAqKiogW01h
a2VmaWxlOjQwMjM6IGFsbF0gRXJyb3IgMgoKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IwpUZXN0OiBNYWtlQ2hlY2sgLSBTS0lQUEVECk91dHB1dDoKY2hlY2tidWlsZCBub3Qgc3VjY2Vz
cwoKCgotLS0KUmVnYXJkcywKTGludXggQmx1ZXRvb3RoCgo=

--===============8907483464826495419==--

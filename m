Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187E6C433E2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 04:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDB73206F7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 04:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGbEuOiN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgIQEwu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 00:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgIQEws (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 00:52:48 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E752EC06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 21:52:47 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id j3so368141qvi.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 21:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=nM8KYr/2ZlTZDc2W1I2j6QpgsiikYXp5ZZ/92MsC3yQ=;
        b=hGbEuOiNccTaS9tIqCGCVDnKRonPrFuQ/UqHolxa2Ko5e/6SysVw95avNRVtx/drRW
         gj2yI1B5LPomgiNSTZQ5FgZy3nLEerRm/gcKDGQpuqCyPX4RE4JEplxjhzDdPqqh/zAv
         e5+9D6PcvRR64P9g8La+7USeEv8F0QxMByI2qd/k/wi1OPmvJ0DApNhjoMXxBFmwkjHR
         B69VPgvytIVbcmxA40w97lyawGafuunk88xucM+QUPFiv9Y+yb3HmkVX7IYk1aSyjm0F
         KJ6KJ9MVeHI48yH0xHjP+gY8Ep6+NwJywlPwIBPE4s8HYq4ZsLhjdEF1KNeQyZrmZ25+
         apxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=nM8KYr/2ZlTZDc2W1I2j6QpgsiikYXp5ZZ/92MsC3yQ=;
        b=NFgYPzfuBQATSgl8NXA687FpwH4bl2wKlconJE5GUZwR/y5A7HVHKdUk91S7Oe+au4
         59thMI81SwJgS00EqGQP9rP56Kp3BfGQMRKAxcL1dkfzcQZ/ZGu/bgyb2otkziww90J8
         QKtMPfsE60ePoJtjDn/WX7qUvk+VJhDdTECAmxLUB82vT/cjsjUFJsR6b5ZP0cqyKFE9
         X87zC8bL79BHqCayQd/MC5iBXz6Xsxq7dTIsaiCszm/Wt4j8mafVcjDhwmPT8eli17D0
         jhtyI5k38TentgluqPPzu2bpJ1Vu0a7IMWTu1sHYsiJCWoNqR261Q5UEn8VKSLYtx42E
         Nrjg==
X-Gm-Message-State: AOAM5322/b7RJ/g83CL3OC64UEVGv7jv4D81X18h/++KRSrvZDHMsC5z
        P+wUGkQGikHXebwl4bZJf98w+EtttEQ2mQ==
X-Google-Smtp-Source: ABdhPJzS7tjsE6J2mPi1bFkNbXtfFBDoNjy56uwP4oogtvBPepV/9UUj+K/lh4MzbACRKaZpfwBkgA==
X-Received: by 2002:a0c:ac4c:: with SMTP id m12mr10618644qvb.39.1600318366933;
        Wed, 16 Sep 2020 21:52:46 -0700 (PDT)
Received: from [172.17.0.2] ([13.68.17.141])
        by smtp.gmail.com with ESMTPSA id 7sm21133680qkh.60.2020.09.16.21.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 21:52:46 -0700 (PDT)
Message-ID: <5f62eb9e.1c69fb81.2c581.2a2a@mx.google.com>
Date:   Wed, 16 Sep 2020 21:52:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6331770682660432333=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mcchou@chromium.org
Subject: RE: [BlueZ,v1,1/8] adv_monitor: Implement RSSI Filter logic for background scanning
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200916212926.BlueZ.v1.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
References: <20200916212926.BlueZ.v1.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6331770682660432333==
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
ZmF1bHQgKHNlZSBgVScpCnVuaXQvdGVzdC1hZHYtbW9uaXRvci5jOiBJbiBmdW5jdGlvbiDigJht
YWlu4oCZOgp1bml0L3Rlc3QtYWR2LW1vbml0b3IuYzo0NDozNDogZXJyb3I6IGFzc2lnbm1lbnQg
dG8g4oCYc3RydWN0IGNvbnRlbnRfZmlsdGVyX3Rlc3QgKuKAmSBmcm9tIGluY29tcGF0aWJsZSBw
b2ludGVyIHR5cGUg4oCYc3RydWN0IHJzc2lfZmlsdGVyX3Rlc3QgKuKAmSBbLVdlcnJvcj1pbmNv
bXBhdGlibGUtcG9pbnRlci10eXBlc10KICAgNDQgfCAgICB0ZXN0LmNvbnRlbnRfZmlsdGVyX3Rl
c3RfZGF0YSA9ICZkYXRhOyAgXAogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIF4KdW5pdC90ZXN0LWFkdi1tb25pdG9yLmM6NTE0OjI6IG5vdGU6IGluIGV4cGFuc2lvbiBv
ZiBtYWNybyDigJhkZWZpbmVfdGVzdOKAmQogIDUxNCB8ICBkZWZpbmVfdGVzdCgiL2Fkdm1vbi9y
c3NpLzEiLCBURVNUX1JTU0lfRklMVEVSLCByc3NpX2RhdGFfMSwKICAgICAgfCAgXn5+fn5+fn5+
fn4KdW5pdC90ZXN0LWFkdi1tb25pdG9yLmM6NDQ6MzQ6IGVycm9yOiBhc3NpZ25tZW50IHRvIOKA
mHN0cnVjdCBjb250ZW50X2ZpbHRlcl90ZXN0ICrigJkgZnJvbSBpbmNvbXBhdGlibGUgcG9pbnRl
ciB0eXBlIOKAmHN0cnVjdCByc3NpX2ZpbHRlcl90ZXN0ICrigJkgWy1XZXJyb3I9aW5jb21wYXRp
YmxlLXBvaW50ZXItdHlwZXNdCiAgIDQ0IHwgICAgdGVzdC5jb250ZW50X2ZpbHRlcl90ZXN0X2Rh
dGEgPSAmZGF0YTsgIFwKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBe
CnVuaXQvdGVzdC1hZHYtbW9uaXRvci5jOjUxNjoyOiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFj
cm8g4oCYZGVmaW5lX3Rlc3TigJkKICA1MTYgfCAgZGVmaW5lX3Rlc3QoIi9hZHZtb24vcnNzaS8y
IiwgVEVTVF9SU1NJX0ZJTFRFUiwgcnNzaV9kYXRhXzIsCiAgICAgIHwgIF5+fn5+fn5+fn5+CnVu
aXQvdGVzdC1hZHYtbW9uaXRvci5jOjQ0OjM0OiBlcnJvcjogYXNzaWdubWVudCB0byDigJhzdHJ1
Y3QgY29udGVudF9maWx0ZXJfdGVzdCAq4oCZIGZyb20gaW5jb21wYXRpYmxlIHBvaW50ZXIgdHlw
ZSDigJhzdHJ1Y3QgcnNzaV9maWx0ZXJfdGVzdCAq4oCZIFstV2Vycm9yPWluY29tcGF0aWJsZS1w
b2ludGVyLXR5cGVzXQogICA0NCB8ICAgIHRlc3QuY29udGVudF9maWx0ZXJfdGVzdF9kYXRhID0g
JmRhdGE7ICBcCiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgp1bml0
L3Rlc3QtYWR2LW1vbml0b3IuYzo1MTg6Mjogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKA
mGRlZmluZV90ZXN04oCZCiAgNTE4IHwgIGRlZmluZV90ZXN0KCIvYWR2bW9uL3Jzc2kvMyIsIFRF
U1RfUlNTSV9GSUxURVIsIHJzc2lfZGF0YV8zLAogICAgICB8ICBefn5+fn5+fn5+fgp1bml0L3Rl
c3QtYWR2LW1vbml0b3IuYzo0NDozNDogZXJyb3I6IGFzc2lnbm1lbnQgdG8g4oCYc3RydWN0IGNv
bnRlbnRfZmlsdGVyX3Rlc3QgKuKAmSBmcm9tIGluY29tcGF0aWJsZSBwb2ludGVyIHR5cGUg4oCY
c3RydWN0IHJzc2lfZmlsdGVyX3Rlc3QgKuKAmSBbLVdlcnJvcj1pbmNvbXBhdGlibGUtcG9pbnRl
ci10eXBlc10KICAgNDQgfCAgICB0ZXN0LmNvbnRlbnRfZmlsdGVyX3Rlc3RfZGF0YSA9ICZkYXRh
OyAgXAogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KdW5pdC90ZXN0
LWFkdi1tb25pdG9yLmM6NTIwOjI6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhkZWZp
bmVfdGVzdOKAmQogIDUyMCB8ICBkZWZpbmVfdGVzdCgiL2Fkdm1vbi9yc3NpLzQiLCBURVNUX1JT
U0lfRklMVEVSLCByc3NpX2RhdGFfNCwKICAgICAgfCAgXn5+fn5+fn5+fn4KdW5pdC90ZXN0LWFk
di1tb25pdG9yLmM6NDQ6MzQ6IGVycm9yOiBhc3NpZ25tZW50IHRvIOKAmHN0cnVjdCBjb250ZW50
X2ZpbHRlcl90ZXN0ICrigJkgZnJvbSBpbmNvbXBhdGlibGUgcG9pbnRlciB0eXBlIOKAmHN0cnVj
dCByc3NpX2ZpbHRlcl90ZXN0ICrigJkgWy1XZXJyb3I9aW5jb21wYXRpYmxlLXBvaW50ZXItdHlw
ZXNdCiAgIDQ0IHwgICAgdGVzdC5jb250ZW50X2ZpbHRlcl90ZXN0X2RhdGEgPSAmZGF0YTsgIFwK
ICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCnVuaXQvdGVzdC1hZHYt
bW9uaXRvci5jOjUyMjoyOiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCYZGVmaW5lX3Rl
c3TigJkKICA1MjIgfCAgZGVmaW5lX3Rlc3QoIi9hZHZtb24vcnNzaS81IiwgVEVTVF9SU1NJX0ZJ
TFRFUiwgcnNzaV9kYXRhXzUsCiAgICAgIHwgIF5+fn5+fn5+fn5+CnVuaXQvdGVzdC1hZHYtbW9u
aXRvci5jOjQxOjMxOiBlcnJvcjogYXNzaWdubWVudCB0byDigJhzdHJ1Y3QgcnNzaV9maWx0ZXJf
dGVzdCAq4oCZIGZyb20gaW5jb21wYXRpYmxlIHBvaW50ZXIgdHlwZSDigJhzdHJ1Y3QgY29udGVu
dF9maWx0ZXJfdGVzdCAq4oCZIFstV2Vycm9yPWluY29tcGF0aWJsZS1wb2ludGVyLXR5cGVzXQog
ICA0MSB8ICAgIHRlc3QucnNzaV9maWx0ZXJfdGVzdF9kYXRhID0gJmRhdGE7ICBcCiAgICAgIHwg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgp1bml0L3Rlc3QtYWR2LW1vbml0b3IuYzo1
MjU6Mjogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmGRlZmluZV90ZXN04oCZCiAgNTI1
IHwgIGRlZmluZV90ZXN0KCIvYWR2bW9uL2NvbnRlbnQvMSIsIFRFU1RfQ09OVEVOVF9GSUxURVIs
IGNvbnRlbnRfZGF0YV8xLAogICAgICB8ICBefn5+fn5+fn5+fgp1bml0L3Rlc3QtYWR2LW1vbml0
b3IuYzo0MTozMTogZXJyb3I6IGFzc2lnbm1lbnQgdG8g4oCYc3RydWN0IHJzc2lfZmlsdGVyX3Rl
c3QgKuKAmSBmcm9tIGluY29tcGF0aWJsZSBwb2ludGVyIHR5cGUg4oCYc3RydWN0IGNvbnRlbnRf
ZmlsdGVyX3Rlc3QgKuKAmSBbLVdlcnJvcj1pbmNvbXBhdGlibGUtcG9pbnRlci10eXBlc10KICAg
NDEgfCAgICB0ZXN0LnJzc2lfZmlsdGVyX3Rlc3RfZGF0YSA9ICZkYXRhOyAgXAogICAgICB8ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KdW5pdC90ZXN0LWFkdi1tb25pdG9yLmM6NTI3
OjI6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhkZWZpbmVfdGVzdOKAmQogIDUyNyB8
ICBkZWZpbmVfdGVzdCgiL2Fkdm1vbi9jb250ZW50LzIiLCBURVNUX0NPTlRFTlRfRklMVEVSLCBj
b250ZW50X2RhdGFfMiwKICAgICAgfCAgXn5+fn5+fn5+fn4KdW5pdC90ZXN0LWFkdi1tb25pdG9y
LmM6NDE6MzE6IGVycm9yOiBhc3NpZ25tZW50IHRvIOKAmHN0cnVjdCByc3NpX2ZpbHRlcl90ZXN0
ICrigJkgZnJvbSBpbmNvbXBhdGlibGUgcG9pbnRlciB0eXBlIOKAmHN0cnVjdCBjb250ZW50X2Zp
bHRlcl90ZXN0ICrigJkgWy1XZXJyb3I9aW5jb21wYXRpYmxlLXBvaW50ZXItdHlwZXNdCiAgIDQx
IHwgICAgdGVzdC5yc3NpX2ZpbHRlcl90ZXN0X2RhdGEgPSAmZGF0YTsgIFwKICAgICAgfCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBeCnVuaXQvdGVzdC1hZHYtbW9uaXRvci5jOjUyOToy
OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCYZGVmaW5lX3Rlc3TigJkKICA1MjkgfCAg
ZGVmaW5lX3Rlc3QoIi9hZHZtb24vY29udGVudC8zIiwgVEVTVF9DT05URU5UX0ZJTFRFUiwgY29u
dGVudF9kYXRhXzMsCiAgICAgIHwgIF5+fn5+fn5+fn5+CnVuaXQvdGVzdC1hZHYtbW9uaXRvci5j
OjQxOjMxOiBlcnJvcjogYXNzaWdubWVudCB0byDigJhzdHJ1Y3QgcnNzaV9maWx0ZXJfdGVzdCAq
4oCZIGZyb20gaW5jb21wYXRpYmxlIHBvaW50ZXIgdHlwZSDigJhzdHJ1Y3QgY29udGVudF9maWx0
ZXJfdGVzdCAq4oCZIFstV2Vycm9yPWluY29tcGF0aWJsZS1wb2ludGVyLXR5cGVzXQogICA0MSB8
ICAgIHRlc3QucnNzaV9maWx0ZXJfdGVzdF9kYXRhID0gJmRhdGE7ICBcCiAgICAgIHwgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXgp1bml0L3Rlc3QtYWR2LW1vbml0b3IuYzo1MzE6Mjog
bm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmGRlZmluZV90ZXN04oCZCiAgNTMxIHwgIGRl
ZmluZV90ZXN0KCIvYWR2bW9uL2NvbnRlbnQvNCIsIFRFU1RfQ09OVEVOVF9GSUxURVIsIGNvbnRl
bnRfZGF0YV80LAogICAgICB8ICBefn5+fn5+fn5+fgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0
cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiogW01ha2VmaWxlOjY4NjM6IHVuaXQvdGVzdC1h
ZHYtbW9uaXRvci5vXSBFcnJvciAxCm1ha2U6ICoqKiBbTWFrZWZpbGU6NDA1NjogYWxsXSBFcnJv
ciAyCgoKCi0tLQpSZWdhcmRzLApMaW51eCBCbHVldG9vdGgK

--===============6331770682660432333==--

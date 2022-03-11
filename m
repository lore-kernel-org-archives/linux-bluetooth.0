Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B4BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Mar 2022 03:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345839AbiCKDW5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Mar 2022 22:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243873AbiCKDWq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Mar 2022 22:22:46 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CFD1680A8
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Mar 2022 19:21:44 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id c7so6099243qka.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Mar 2022 19:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=eAoaYIQwBoD5YPTs3ug8nhHlDCFFPakpUiqhvAtUxOw=;
        b=mQRzleha+NqejnO20Zm4S0MiJJqe5SVdWhboLUX09PFNer3Jk28MelO5sddLS31NLc
         INMr6M8+j2v/SUagZsLuKMBzP+YO+f+neqcB+zMWwhsJY9K3qyYN4k6h31wrSz/sC5Yd
         EAxaTQNF6OvhZOyjy8qDE9HWG7cY1SU0rnh2Hwrgl9sqocNl17y8f7csvITWUeOxBL6e
         Rmny8L2vKdWF5ey9mDOSDmAuCrtAUq76VGh/HCb91GIj3ngWUp4RCDxlHUtglK6dZ2+C
         /xHPjPiAODEaP6lHlCCcTeQBwgDZpwhEu4ym5kPS+thUClmAwxeWeddWAGho3uD8n75C
         bEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=eAoaYIQwBoD5YPTs3ug8nhHlDCFFPakpUiqhvAtUxOw=;
        b=UBNjo/sQ1fCTawdOCagRJAm/ETZZUXrC9PvmGYyjfNoYGldj76rMbbZ7YpX/PA+znU
         cPjktCzyuNN1InjinQD/HSLskKeYOmkdTznArffCUdzpxYXohlYZg1P5w4cROx0fDE+3
         VFD9Dcbvn41Xlk2qJrPOYegzchErKg6m175vQpyZzytg0krGEQdyPXXaIFjnf+Exldl/
         YiDU3VeS0ONfsoy+SmqqEhRqTAy24tY5csJ+aDBNOJtCw2ZGVZZQYdMAQEpSwDwYN6H7
         P+Ncc8LnURgdGcfafRP14c8+MnScC6Owjp7EmSBLb3ywhazYgy9B40Hqu8av11woZwHi
         g5GA==
X-Gm-Message-State: AOAM531u55WFeLJl4oiBiwsMcwdHfLj0GnkRitkzK/nkauVniuTevZAD
        8BHBLb9fTxqsENzxdfm5eTYgCgWb5+Fwhg==
X-Google-Smtp-Source: ABdhPJy4w/Z6ae2TurgBgZi9bc+Vo6eU0FPCXqhlNHlqMtFpmCMquhWlCnzyQ74ePv0w276TsUlaZw==
X-Received: by 2002:a37:a9d3:0:b0:507:4eb:22b4 with SMTP id s202-20020a37a9d3000000b0050704eb22b4mr5423465qke.368.1646968903581;
        Thu, 10 Mar 2022 19:21:43 -0800 (PST)
Received: from [172.17.0.2] ([20.228.128.151])
        by smtp.gmail.com with ESMTPSA id j18-20020ac85c52000000b002e1b9897ae7sm1132283qtj.10.2022.03.10.19.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 19:21:43 -0800 (PST)
Message-ID: <622ac047.1c69fb81.ea82d.6b20@mx.google.com>
Date:   Thu, 10 Mar 2022 19:21:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8384824246446335072=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tangmeng@uniontech.com
Subject: RE: Bluetooth: btrtl: btmrvl: Fix firmware filename for rtl chipset
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220311021750.24021-1-tangmeng@uniontech.com>
References: <20220311021750.24021-1-tangmeng@uniontech.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8384824246446335072==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NjIyNDYzCgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMS43OCBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAxLjA0IHNlY29uZHMKU3ViamVjdFByZWZpeCAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDAuODggc2Vjb25kcwpCdWlsZEtlcm5lbCAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MzcuNjUgc2Vjb25kcwpCdWlsZEtlcm5lbDMyICAgICAgICAgICAgICAgICBGQUlMICAgICAgMzQu
NDMgc2Vjb25kcwpJbmNyZW1lbnRhbCBCdWlsZCB3aXRoIHBhdGNoZXNFUlJPUiAgICAgMC40MiBz
ZWNvbmRzClRlc3RSdW5uZXI6IFNldHVwICAgICAgICAgICAgIFBBU1MgICAgICA1OTkuMDYgc2Vj
b25kcwpUZXN0UnVubmVyOiBsMmNhcC10ZXN0ZXIgICAgICBQQVNTICAgICAgMTguMzggc2Vjb25k
cwpUZXN0UnVubmVyOiBibmVwLXRlc3RlciAgICAgICBQQVNTICAgICAgNy4zMyBzZWNvbmRzClRl
c3RSdW5uZXI6IG1nbXQtdGVzdGVyICAgICAgIFBBU1MgICAgICAxMTcuNDkgc2Vjb25kcwpUZXN0
UnVubmVyOiByZmNvbW0tdGVzdGVyICAgICBQQVNTICAgICAgOS45MiBzZWNvbmRzClRlc3RSdW5u
ZXI6IHNjby10ZXN0ZXIgICAgICAgIFBBU1MgICAgICA5LjUzIHNlY29uZHMKVGVzdFJ1bm5lcjog
c21wLXRlc3RlciAgICAgICAgUEFTUyAgICAgIDkuNDYgc2Vjb25kcwpUZXN0UnVubmVyOiB1c2Vy
Y2hhbi10ZXN0ZXIgICBQQVNTICAgICAgNy44NSBzZWNvbmRzCgpEZXRhaWxzCiMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBCdWlsZEtlcm5lbCAtIEZBSUwgLSAzNy42NSBzZWNv
bmRzCkJ1aWxkIEtlcm5lbCB3aXRoIG1pbmltYWwgY29uZmlndXJhdGlvbiBzdXBwb3J0cyBCbHVl
dG9vdGgKZHJpdmVycy9ibHVldG9vdGgvYnRydGwuYzoxODc6NDogZXJyb3I6IOKAmG7igJkgdW5k
ZWNsYXJlZCBoZXJlIChub3QgaW4gYSBmdW5jdGlvbikKICAxODcgfCAgICBuLmhhc19tc2Z0X2V4
dCA9IHRydWUsCiAgICAgIHwgICAgXgptYWtlWzJdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVp
bGQ6Mjg4OiBkcml2ZXJzL2JsdWV0b290aC9idHJ0bC5vXSBFcnJvciAxCm1ha2VbMl06ICoqKiBX
YWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCm1ha2VbMV06ICoqKiBbc2NyaXB0cy9NYWtl
ZmlsZS5idWlsZDo1NTA6IGRyaXZlcnMvYmx1ZXRvb3RoXSBFcnJvciAyCm1ha2U6ICoqKiBbTWFr
ZWZpbGU6MTgzMTogZHJpdmVyc10gRXJyb3IgMgoKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIwpUZXN0OiBCdWlsZEtlcm5lbDMyIC0gRkFJTCAtIDM0LjQzIHNlY29uZHMKQnVpbGQgMzJi
aXQgS2VybmVsIHdpdGggbWluaW1hbCBjb25maWd1cmF0aW9uIHN1cHBvcnRzIEJsdWV0b290aApk
cml2ZXJzL2JsdWV0b290aC9idHJ0bC5jOjE4Nzo0OiBlcnJvcjog4oCYbuKAmSB1bmRlY2xhcmVk
IGhlcmUgKG5vdCBpbiBhIGZ1bmN0aW9uKQogIDE4NyB8ICAgIG4uaGFzX21zZnRfZXh0ID0gdHJ1
ZSwKICAgICAgfCAgICBeCm1ha2VbMl06ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5idWlsZDoyODg6
IGRyaXZlcnMvYmx1ZXRvb3RoL2J0cnRsLm9dIEVycm9yIDEKbWFrZVsyXTogKioqIFdhaXRpbmcg
Zm9yIHVuZmluaXNoZWQgam9icy4uLi4KbWFrZVsxXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1
aWxkOjU1MDogZHJpdmVycy9ibHVldG9vdGhdIEVycm9yIDIKbWFrZTogKioqIFtNYWtlZmlsZTox
ODMxOiBkcml2ZXJzXSBFcnJvciAyCgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRl
c3Q6IEluY3JlbWVudGFsIEJ1aWxkIHdpdGggcGF0Y2hlcyAtIFNLSVBQRUQgLSAwLjQyIHNlY29u
ZHMKSW5jcmVtZW50YWwgYnVpbGQgcGVyIHBhdGNoIGluIHRoZSBzZXJpZXMKYnVpbGRrZXJuZWwg
ZmFpbGVkCgoKCi0tLQpSZWdhcmRzLApMaW51eCBCbHVldG9vdGgKCg==

--===============8384824246446335072==--

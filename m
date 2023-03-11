Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB978C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Mar 2023 11:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjCKL47 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 11 Mar 2023 06:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjCKL45 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 11 Mar 2023 06:56:57 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535ED112580
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Mar 2023 03:56:56 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id nn12so7712156pjb.5
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Mar 2023 03:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678535815;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/bghwRW/GN6pYYFVF9/LQqPyHTQ3O/BcCiBfM0jHsu8=;
        b=LySKhlKydq9u1H/ENhbxQ+hRTHlvLoITPZDp/WtVnDUgHL3yRsCfkyc5nyTfwBUC24
         m/pNBXjbFD4GFGPHATR2IRTAeSxn55NcMYuU5hcPDcv/3QkKN5UtdseWSFVCm8jZ9qij
         Sp3vTkyH95o6VABanjRnRH/jmfdoRqMFg4zFs1wX5BwgKlUUG3zb/iOFi8KAUzWw8zvq
         G843dnWc/kRe1pLQqy4v8sH9mwKUDZDqFBLHGryN4VIF2FMGGXPraS1P/B1chgP+Uo79
         lp4rc9K6E3BzslMGBT3+ZmugglxoH9ekVwJxUFUec/piJcio3Q4fvKScyk9pDslJOLL+
         g5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678535815;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/bghwRW/GN6pYYFVF9/LQqPyHTQ3O/BcCiBfM0jHsu8=;
        b=HCewhiWGYMa4PeB1jkg+wcAW78Cx71qY71NIX5/CvGFdUUcaX6N7wrSYyfB4V8DC5d
         wbCO2wfVBZWH/a7Enweb5i6mUxMzoAk8G6zcIa85aXZNBywgHhVUmXZOdLDkTNUgPOsO
         0HvDjHaCPWZat3EiAm3SaLKW4dC/lXOcJk4/hcSvqSBuFfKqwOXMa7DbE+J0RQQmGwLW
         K4/dLhGcB2De62+Fmzld7v72KlBj6MKUgieCuPZEaSmJ42NWvyHCVQYMSurf2wsKTi7L
         DiT+diBWMXYKrM25W/HpY1QvxWREOQ1vkQLoPKLP9eMED3MHs74ylEchw/nOkiOBuEYT
         aCdA==
X-Gm-Message-State: AO0yUKWmkzt9Fjj9DwsNHnU3c/R+uRo9Xh7jzUCsEVWi/KV/QuWnnNHz
        CfwAMAsFeTgTFVU0Lmxd5zuHrdtwZfo=
X-Google-Smtp-Source: AK7set93tdDkbxcEx5ty9vg3uDXnos8MFsEnMXszYtDrD9EC2tChSIcf4z7xAfFnhzv/DP37mw3P1A==
X-Received: by 2002:a17:903:230e:b0:19e:2d25:897e with SMTP id d14-20020a170903230e00b0019e2d25897emr30986778plh.13.1678535815498;
        Sat, 11 Mar 2023 03:56:55 -0800 (PST)
Received: from [172.17.0.2] ([20.171.107.104])
        by smtp.gmail.com with ESMTPSA id lh4-20020a170903290400b0019f1205bdcbsm1441007plb.147.2023.03.11.03.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:56:55 -0800 (PST)
Message-ID: <640c6c87.170a0220.f9611.2b6d@mx.google.com>
Date:   Sat, 11 Mar 2023 03:56:55 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2126536082590533776=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, krzysztof.kozlowski@linaro.org
Subject: RE: [1/4] Bluetooth: hci_ll: drop of_match_ptr for ID table
In-Reply-To: <20230311111354.251316-1-krzysztof.kozlowski@linaro.org>
References: <20230311111354.251316-1-krzysztof.kozlowski@linaro.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2126536082590533776==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NzI5MDI1CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMi4wNiBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIEZB
SUwgICAgICAxLjI5IHNlY29uZHMKU3ViamVjdFByZWZpeCAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDAuMzIgc2Vjb25kcwpCdWlsZEtlcm5lbCAgICAgICAgICAgICAgICAgICBQQVNTICAgICAg
MzEuMTcgc2Vjb25kcwpDaGVja0FsbFdhcm5pbmcgICAgICAgICAgICAgICBQQVNTICAgICAgMzQu
NDAgc2Vjb25kcwpDaGVja1NwYXJzZSAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgMzguMzcg
c2Vjb25kcwpDaGVja1NtYXRjaCAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgMTA2LjU3IHNl
Y29uZHMKQnVpbGRLZXJuZWwzMiAgICAgICAgICAgICAgICAgUEFTUyAgICAgIDI5LjgzIHNlY29u
ZHMKVGVzdFJ1bm5lclNldHVwICAgICAgICAgICAgICAgUEFTUyAgICAgIDQyOS43OSBzZWNvbmRz
ClRlc3RSdW5uZXJfbDJjYXAtdGVzdGVyICAgICAgIFBBU1MgICAgICAxNi40NCBzZWNvbmRzClRl
c3RSdW5uZXJfaXNvLXRlc3RlciAgICAgICAgIFBBU1MgICAgICAxNi4yNSBzZWNvbmRzClRlc3RS
dW5uZXJfYm5lcC10ZXN0ZXIgICAgICAgIFBBU1MgICAgICA1LjI4IHNlY29uZHMKVGVzdFJ1bm5l
cl9tZ210LXRlc3RlciAgICAgICAgUEFTUyAgICAgIDEwNi42MSBzZWNvbmRzClRlc3RSdW5uZXJf
cmZjb21tLXRlc3RlciAgICAgIFBBU1MgICAgICA4LjU5IHNlY29uZHMKVGVzdFJ1bm5lcl9zY28t
dGVzdGVyICAgICAgICAgUEFTUyAgICAgIDcuNzIgc2Vjb25kcwpUZXN0UnVubmVyX2lvY3RsLXRl
c3RlciAgICAgICBQQVNTICAgICAgOS4xMCBzZWNvbmRzClRlc3RSdW5uZXJfbWVzaC10ZXN0ZXIg
ICAgICAgIFBBU1MgICAgICA2LjcyIHNlY29uZHMKVGVzdFJ1bm5lcl9zbXAtdGVzdGVyICAgICAg
ICAgUEFTUyAgICAgIDcuNjggc2Vjb25kcwpUZXN0UnVubmVyX3VzZXJjaGFuLXRlc3RlciAgICBQ
QVNTICAgICAgNS41MiBzZWNvbmRzCkluY3JlbWVudGFsQnVpbGQgICAgICAgICAgICAgIFBBU1Mg
ICAgICA0MS4zNSBzZWNvbmRzCgpEZXRhaWxzCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IwpUZXN0OiBHaXRMaW50IC0gRkFJTApEZXNjOiBSdW4gZ2l0bGludApPdXRwdXQ6ClsxLzRdIEJs
dWV0b290aDogaGNpX2xsOiBkcm9wIG9mX21hdGNoX3B0ciBmb3IgSUQgdGFibGUKCldBUk5JTkc6
IEkzIC0gaWdub3JlLWJvZHktbGluZXM6IGdpdGxpbnQgd2lsbCBiZSBzd2l0Y2hpbmcgZnJvbSB1
c2luZyBQeXRob24gcmVnZXggJ21hdGNoJyAobWF0Y2ggYmVnaW5uaW5nKSB0byAnc2VhcmNoJyAo
bWF0Y2ggYW55d2hlcmUpIHNlbWFudGljcy4gUGxlYXNlIHJldmlldyB5b3VyIGlnbm9yZS1ib2R5
LWxpbmVzLnJlZ2V4IG9wdGlvbiBhY2NvcmRpbmdseS4gVG8gcmVtb3ZlIHRoaXMgd2FybmluZywg
c2V0IGdlbmVyYWwucmVnZXgtc3R5bGUtc2VhcmNoPVRydWUuIE1vcmUgZGV0YWlsczogaHR0cHM6
Ly9qb3Jpc3Jvb3ZlcnMuZ2l0aHViLmlvL2dpdGxpbnQvY29uZmlndXJhdGlvbi8jcmVnZXgtc3R5
bGUtc2VhcmNoCjc6IEIxIExpbmUgZXhjZWVkcyBtYXggbGVuZ3RoICgxMTU+ODApOiAiICBkcml2
ZXJzL2JsdWV0b290aC9oY2lfbGwuYzo3Njk6MzQ6IGVycm9yOiDigJhoY2lfdGlfb2ZfbWF0Y2ji
gJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XZXJyb3I9dW51c2VkLWNvbnN0LXZhcmlhYmxlPV0i
ClsyLzRdIEJsdWV0b290aDogYnRtcnZsX3NkaW86IG1hcmsgT0YgcmVsYXRlZCBkYXRhIGFzIG1h
eWJlIHVudXNlZAoKV0FSTklORzogSTMgLSBpZ25vcmUtYm9keS1saW5lczogZ2l0bGludCB3aWxs
IGJlIHN3aXRjaGluZyBmcm9tIHVzaW5nIFB5dGhvbiByZWdleCAnbWF0Y2gnIChtYXRjaCBiZWdp
bm5pbmcpIHRvICdzZWFyY2gnIChtYXRjaCBhbnl3aGVyZSkgc2VtYW50aWNzLiBQbGVhc2UgcmV2
aWV3IHlvdXIgaWdub3JlLWJvZHktbGluZXMucmVnZXggb3B0aW9uIGFjY29yZGluZ2x5LiBUbyBy
ZW1vdmUgdGhpcyB3YXJuaW5nLCBzZXQgZ2VuZXJhbC5yZWdleC1zdHlsZS1zZWFyY2g9VHJ1ZS4g
TW9yZSBkZXRhaWxzOiBodHRwczovL2pvcmlzcm9vdmVycy5naXRodWIuaW8vZ2l0bGludC9jb25m
aWd1cmF0aW9uLyNyZWdleC1zdHlsZS1zZWFyY2gKNjogQjEgTGluZSBleGNlZWRzIG1heCBsZW5n
dGggKDEzMD44MCk6ICIgIGRyaXZlcnMvYmx1ZXRvb3RoL2J0bXJ2bF9zZGlvLmM6NDM6MzQ6IGVy
cm9yOiDigJhidG1ydmxfc2Rpb19vZl9tYXRjaF90YWJsZeKAmSBkZWZpbmVkIGJ1dCBub3QgdXNl
ZCBbLVdlcnJvcj11bnVzZWQtY29uc3QtdmFyaWFibGU9XSIKWzMvNF0gQmx1ZXRvb3RoOiBoY2lf
cWNhOiBtYXJrIE9GIHJlbGF0ZWQgZGF0YSBhcyBtYXliZSB1bnVzZWQKCldBUk5JTkc6IEkzIC0g
aWdub3JlLWJvZHktbGluZXM6IGdpdGxpbnQgd2lsbCBiZSBzd2l0Y2hpbmcgZnJvbSB1c2luZyBQ
eXRob24gcmVnZXggJ21hdGNoJyAobWF0Y2ggYmVnaW5uaW5nKSB0byAnc2VhcmNoJyAobWF0Y2gg
YW55d2hlcmUpIHNlbWFudGljcy4gUGxlYXNlIHJldmlldyB5b3VyIGlnbm9yZS1ib2R5LWxpbmVz
LnJlZ2V4IG9wdGlvbiBhY2NvcmRpbmdseS4gVG8gcmVtb3ZlIHRoaXMgd2FybmluZywgc2V0IGdl
bmVyYWwucmVnZXgtc3R5bGUtc2VhcmNoPVRydWUuIE1vcmUgZGV0YWlsczogaHR0cHM6Ly9qb3Jp
c3Jvb3ZlcnMuZ2l0aHViLmlvL2dpdGxpbnQvY29uZmlndXJhdGlvbi8jcmVnZXgtc3R5bGUtc2Vh
cmNoCjY6IEIxIExpbmUgZXhjZWVkcyBtYXggbGVuZ3RoICgxMjI+ODApOiAiICBkcml2ZXJzL2Js
dWV0b290aC9oY2lfcWNhLmM6MTg2OTozNzogZXJyb3I6IOKAmHFjYV9zb2NfZGF0YV93Y242NzUw
4oCZIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV2Vycm9yPXVudXNlZC1jb25zdC12YXJpYWJsZT1d
Igo3OiBCMSBMaW5lIGV4Y2VlZHMgbWF4IGxlbmd0aCAoMTIyPjgwKTogIiAgZHJpdmVycy9ibHVl
dG9vdGgvaGNpX3FjYS5jOjE4NTM6Mzc6IGVycm9yOiDigJhxY2Ffc29jX2RhdGFfd2NuMzk5OOKA
mSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVdlcnJvcj11bnVzZWQtY29uc3QtdmFyaWFibGU9XSIK
ODogQjEgTGluZSBleGNlZWRzIG1heCBsZW5ndGggKDEyMj44MCk6ICIgIGRyaXZlcnMvYmx1ZXRv
b3RoL2hjaV9xY2EuYzoxODQxOjM3OiBlcnJvcjog4oCYcWNhX3NvY19kYXRhX3djbjM5OTHigJkg
ZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XZXJyb3I9dW51c2VkLWNvbnN0LXZhcmlhYmxlPV0iCjk6
IEIxIExpbmUgZXhjZWVkcyBtYXggbGVuZ3RoICgxMjI+ODApOiAiICBkcml2ZXJzL2JsdWV0b290
aC9oY2lfcWNhLmM6MTgzMDozNzogZXJyb3I6IOKAmHFjYV9zb2NfZGF0YV93Y24zOTkw4oCZIGRl
ZmluZWQgYnV0IG5vdCB1c2VkIFstV2Vycm9yPXVudXNlZC1jb25zdC12YXJpYWJsZT1dIgpbNC80
XSBCbHVldG9vdGg6IGJ0bXRrdWFydDogbWFyayBPRiByZWxhdGVkIGRhdGEgYXMgbWF5YmUgdW51
c2VkCgpXQVJOSU5HOiBJMyAtIGlnbm9yZS1ib2R5LWxpbmVzOiBnaXRsaW50IHdpbGwgYmUgc3dp
dGNoaW5nIGZyb20gdXNpbmcgUHl0aG9uIHJlZ2V4ICdtYXRjaCcgKG1hdGNoIGJlZ2lubmluZykg
dG8gJ3NlYXJjaCcgKG1hdGNoIGFueXdoZXJlKSBzZW1hbnRpY3MuIFBsZWFzZSByZXZpZXcgeW91
ciBpZ25vcmUtYm9keS1saW5lcy5yZWdleCBvcHRpb24gYWNjb3JkaW5nbHkuIFRvIHJlbW92ZSB0
aGlzIHdhcm5pbmcsIHNldCBnZW5lcmFsLnJlZ2V4LXN0eWxlLXNlYXJjaD1UcnVlLiBNb3JlIGRl
dGFpbHM6IGh0dHBzOi8vam9yaXNyb292ZXJzLmdpdGh1Yi5pby9naXRsaW50L2NvbmZpZ3VyYXRp
b24vI3JlZ2V4LXN0eWxlLXNlYXJjaAo2OiBCMSBMaW5lIGV4Y2VlZHMgbWF4IGxlbmd0aCAoMTE0
PjgwKTogIiAgZHJpdmVycy9ibHVldG9vdGgvYnRtdGt1YXJ0LmM6OTcxOjM2OiBlcnJvcjog4oCY
bXQ3NjY4X2RhdGHigJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XZXJyb3I9dW51c2VkLWNvbnN0
LXZhcmlhYmxlPV0iCjc6IEIxIExpbmUgZXhjZWVkcyBtYXggbGVuZ3RoICgxMTQ+ODApOiAiICBk
cml2ZXJzL2JsdWV0b290aC9idG10a3VhcnQuYzo5NjY6MzY6IGVycm9yOiDigJhtdDc2NjNfZGF0
YeKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVdlcnJvcj11bnVzZWQtY29uc3QtdmFyaWFibGU9
XSIKODogQjEgTGluZSBleGNlZWRzIG1heCBsZW5ndGggKDExND44MCk6ICIgIGRyaXZlcnMvYmx1
ZXRvb3RoL2J0bXRrdWFydC5jOjk2MjozNjogZXJyb3I6IOKAmG10NzYyMl9kYXRh4oCZIGRlZmlu
ZWQgYnV0IG5vdCB1c2VkIFstV2Vycm9yPXVudXNlZC1jb25zdC12YXJpYWJsZT1dIgoKCi0tLQpS
ZWdhcmRzLApMaW51eCBCbHVldG9vdGgKCg==

--===============2126536082590533776==--

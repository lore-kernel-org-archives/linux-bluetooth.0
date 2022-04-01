Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A7FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Apr 2022 12:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbiDAMsE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Apr 2022 08:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345961AbiDAMrz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Apr 2022 08:47:55 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32C31D66F6
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Apr 2022 05:46:02 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id p25so1950112qkj.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Apr 2022 05:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=mYwQSsjTfbFSlGURzr8yHZbOoFKEF955qB0HOkTVr7Q=;
        b=czoLHSdLxyAGxAoxWBOvKemQAqYnhuQElN6gRqYDlTsTu4iM28P+dz3zoQJIKL8zB4
         aossIS+EQiik8fV7lb76TnYq9h7/JMQj8gn08Agj4kZSK8GZeylk1+MQWfyQrxQsgKn/
         qqZWtB4NH7gw0Er+KSjIwiEy7+D+B13Jy9zEnOsDpXJotOx27zELpNPyxKdAwSNomkTH
         nu+ZJvyFagqqreS3nuiVghhN+bGEdTGdA2mOAAu7mOavrOmjKO+1slHfgu8FhjiV471/
         /cWMX8HCGRcjZSeBqzzcABStekUHSlzSquzCywTR1sCg5+Xm3xiuQgh6+esiC3mOVHY6
         7Txg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=mYwQSsjTfbFSlGURzr8yHZbOoFKEF955qB0HOkTVr7Q=;
        b=jaJ86A4rnNVN4NbAi5zyc19H6TE2kLAzW86mxhUtpbfAQ5dEh4DNuXT1gKsuryFcF4
         bJkQq0yiYlMLarnmlML9iI9kcHz4DanysWwGW0SYFBkN6xlxYb4zmKynGTnf+iOQzsde
         sjGiQjZhk9fwFn2b6Tra1EsRUtMk9rqbwdaRvm1SPAThamBVdaOV7wZvTzDhMl3KSE0g
         XN0ISjmrOwUVFVyTmByEg3WDo2SsdFKmAj3sACW9/UWL9opCAiEZds5JOtXXwQyF25+u
         5kygfKLwUgiKPmuHrcQW+cnEuja9QKsQBm21+oZ4fSqcqffGA4TtW0d+DPCcgp+go0PC
         BKuw==
X-Gm-Message-State: AOAM53048rJAdw2mbvyiKQDDVPb+G1rhxPoVKip7EwxyXh4HVVg4xgD+
        ak+SdlkqxgnWsY4r0dtKxOyPhQDVWg4=
X-Google-Smtp-Source: ABdhPJzZt1Yi5Atl0CxLg7BiACjOLBIsDTzec/w+rkAGcImrLtGu1eDG/Aj8U0Kel3AZz1sPlhO8vA==
X-Received: by 2002:a05:620a:4592:b0:67d:8ed9:8c37 with SMTP id bp18-20020a05620a459200b0067d8ed98c37mr6491221qkb.150.1648817161608;
        Fri, 01 Apr 2022 05:46:01 -0700 (PDT)
Received: from [172.17.0.2] ([20.65.77.20])
        by smtp.gmail.com with ESMTPSA id u17-20020ac858d1000000b002e1cdbb50besm1693781qta.78.2022.04.01.05.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 05:46:01 -0700 (PDT)
Message-ID: <6246f409.1c69fb81.23f9d.947c@mx.google.com>
Date:   Fri, 01 Apr 2022 05:46:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7763340413434902986=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, i.kamaletdinov@omp.ru
Subject: RE: Fix bugs found by SVACE static analisys tool
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220401111408.3961844-2-i.kamaletdinov@omp.ru>
References: <20220401111408.3961844-2-i.kamaletdinov@omp.ru>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7763340413434902986==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NjI4MTY5CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgOS44NCBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICA2LjY2IHNlY29uZHMKUHJlcCAtIFNldHVwIEVMTCAgICAgICAgICAgICAgUEFTUyAg
ICAgIDQzLjMxIHNlY29uZHMKQnVpbGQgLSBQcmVwICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDAuNjkgc2Vjb25kcwpCdWlsZCAtIENvbmZpZ3VyZSAgICAgICAgICAgICBQQVNTICAgICAgOC44
MSBzZWNvbmRzCkJ1aWxkIC0gTWFrZSAgICAgICAgICAgICAgICAgIEZBSUwgICAgICA3OS40NCBz
ZWNvbmRzCk1ha2UgQ2hlY2sgICAgICAgICAgICAgICAgICAgIEZBSUwgICAgICAxLjE3IHNlY29u
ZHMKTWFrZSBDaGVjayB3L1ZhbGdyaW5kICAgICAgICAgRkFJTCAgICAgIDY1LjgwIHNlY29uZHMK
TWFrZSBEaXN0Y2hlY2sgICAgICAgICAgICAgICAgUEFTUyAgICAgIDIzMS4zNiBzZWNvbmRzCkJ1
aWxkIHcvZXh0IEVMTCAtIENvbmZpZ3VyZSAgIFBBU1MgICAgICA4Ljc4IHNlY29uZHMKQnVpbGQg
dy9leHQgRUxMIC0gTWFrZSAgICAgICAgRkFJTCAgICAgIDc5LjgyIHNlY29uZHMKSW5jcmVtZW50
YWwgQnVpbGQgd2l0aCBwYXRjaGVzRkFJTCAgICAgIDQzNzYuNTAgc2Vjb25kcwoKRGV0YWlscwoj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQnVpbGQgLSBNYWtlIC0gRkFJTApE
ZXNjOiBCdWlsZCB0aGUgQmx1ZVogc291cmNlIHRyZWUKT3V0cHV0Ogp0b29scy9ibHVlbW9vbi5j
OiBJbiBmdW5jdGlvbiDigJhyZXF1ZXN0X2Zpcm13YXJl4oCZOgp0b29scy9ibHVlbW9vbi5jOjQ5
NToxNzogZXJyb3I6IGNvbXBhcmlzb24gb2YgaW50ZWdlciBleHByZXNzaW9ucyBvZiBkaWZmZXJl
bnQgc2lnbmVkbmVzczog4oCYX19vZmZfdOKAmSB7YWthIOKAmGxvbmcgaW504oCZfSBhbmQg4oCY
bG9uZyB1bnNpZ25lZCBpbnTigJkgWy1XZXJyb3I9c2lnbi1jb21wYXJlXQogIDQ5NSB8ICBpZiAo
c3Quc3Rfc2l6ZSA+IChTSVpFX01BWCAtIDQpKSB7CiAgICAgIHwgICAgICAgICAgICAgICAgIF4K
dG9vbHMvYmx1ZW1vb24uYzogSW4gZnVuY3Rpb24g4oCYYW5hbHl6ZV9maXJtd2FyZeKAmToKdG9v
bHMvYmx1ZW1vb24uYzo4ODQ6MTc6IGVycm9yOiBjb21wYXJpc29uIG9mIGludGVnZXIgZXhwcmVz
c2lvbnMgb2YgZGlmZmVyZW50IHNpZ25lZG5lc3M6IOKAmF9fb2ZmX3TigJkge2FrYSDigJhsb25n
IGludOKAmX0gYW5kIOKAmGxvbmcgdW5zaWduZWQgaW504oCZIFstV2Vycm9yPXNpZ24tY29tcGFy
ZV0KICA4ODQgfCAgaWYgKHN0LnN0X3NpemUgPiAoU0laRV9NQVggLSAzKSkgewogICAgICB8ICAg
ICAgICAgICAgICAgICBeCmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3Jz
Cm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6NzI3NzogdG9vbHMvYmx1ZW1vb24ub10gRXJyb3IgMQpt
YWtlOiAqKiogW01ha2VmaWxlOjQzMTA6IGFsbF0gRXJyb3IgMgoKCiMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIwpUZXN0OiBNYWtlIENoZWNrIC0gRkFJTApEZXNjOiBSdW4gJ21ha2UgY2hl
Y2snCk91dHB1dDoKdG9vbHMvYmx1ZW1vb24uYzogSW4gZnVuY3Rpb24g4oCYcmVxdWVzdF9maXJt
d2FyZeKAmToKdG9vbHMvYmx1ZW1vb24uYzo0OTU6MTc6IGVycm9yOiBjb21wYXJpc29uIG9mIGlu
dGVnZXIgZXhwcmVzc2lvbnMgb2YgZGlmZmVyZW50IHNpZ25lZG5lc3M6IOKAmF9fb2ZmX3TigJkg
e2FrYSDigJhsb25nIGludOKAmX0gYW5kIOKAmGxvbmcgdW5zaWduZWQgaW504oCZIFstV2Vycm9y
PXNpZ24tY29tcGFyZV0KICA0OTUgfCAgaWYgKHN0LnN0X3NpemUgPiAoU0laRV9NQVggLSA0KSkg
ewogICAgICB8ICAgICAgICAgICAgICAgICBeCnRvb2xzL2JsdWVtb29uLmM6IEluIGZ1bmN0aW9u
IOKAmGFuYWx5emVfZmlybXdhcmXigJk6CnRvb2xzL2JsdWVtb29uLmM6ODg0OjE3OiBlcnJvcjog
Y29tcGFyaXNvbiBvZiBpbnRlZ2VyIGV4cHJlc3Npb25zIG9mIGRpZmZlcmVudCBzaWduZWRuZXNz
OiDigJhfX29mZl904oCZIHtha2Eg4oCYbG9uZyBpbnTigJl9IGFuZCDigJhsb25nIHVuc2lnbmVk
IGludOKAmSBbLVdlcnJvcj1zaWduLWNvbXBhcmVdCiAgODg0IHwgIGlmIChzdC5zdF9zaXplID4g
KFNJWkVfTUFYIC0gMykpIHsKICAgICAgfCAgICAgICAgICAgICAgICAgXgpjYzE6IGFsbCB3YXJu
aW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiogW01ha2VmaWxlOjcyNzc6
IHRvb2xzL2JsdWVtb29uLm9dIEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmlsZToxMTI4MzogY2hl
Y2tdIEVycm9yIDIKCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogTWFrZSBD
aGVjayB3L1ZhbGdyaW5kIC0gRkFJTApEZXNjOiBSdW4gJ21ha2UgY2hlY2snIHdpdGggVmFsZ3Jp
bmQKT3V0cHV0Ogp0b29scy9ibHVlbW9vbi5jOiBJbiBmdW5jdGlvbiDigJhyZXF1ZXN0X2Zpcm13
YXJl4oCZOgp0b29scy9ibHVlbW9vbi5jOjQ5NToxNzogZXJyb3I6IGNvbXBhcmlzb24gb2YgaW50
ZWdlciBleHByZXNzaW9ucyBvZiBkaWZmZXJlbnQgc2lnbmVkbmVzczog4oCYX19vZmZfdOKAmSB7
YWthIOKAmGxvbmcgaW504oCZfSBhbmQg4oCYbG9uZyB1bnNpZ25lZCBpbnTigJkgWy1XZXJyb3I9
c2lnbi1jb21wYXJlXQogIDQ5NSB8ICBpZiAoc3Quc3Rfc2l6ZSA+IChTSVpFX01BWCAtIDQpKSB7
CiAgICAgIHwgICAgICAgICAgICAgICAgIF4KdG9vbHMvYmx1ZW1vb24uYzogSW4gZnVuY3Rpb24g
4oCYYW5hbHl6ZV9maXJtd2FyZeKAmToKdG9vbHMvYmx1ZW1vb24uYzo4ODQ6MTc6IGVycm9yOiBj
b21wYXJpc29uIG9mIGludGVnZXIgZXhwcmVzc2lvbnMgb2YgZGlmZmVyZW50IHNpZ25lZG5lc3M6
IOKAmF9fb2ZmX3TigJkge2FrYSDigJhsb25nIGludOKAmX0gYW5kIOKAmGxvbmcgdW5zaWduZWQg
aW504oCZIFstV2Vycm9yPXNpZ24tY29tcGFyZV0KICA4ODQgfCAgaWYgKHN0LnN0X3NpemUgPiAo
U0laRV9NQVggLSAzKSkgewogICAgICB8ICAgICAgICAgICAgICAgICBeCmNjMTogYWxsIHdhcm5p
bmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6NzI3Nzog
dG9vbHMvYmx1ZW1vb24ub10gRXJyb3IgMQptYWtlOiAqKiogW01ha2VmaWxlOjQzMTA6IGFsbF0g
RXJyb3IgMgoKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBCdWlsZCB3L2V4
dCBFTEwgLSBNYWtlIC0gRkFJTApEZXNjOiBCdWlsZCBCbHVlWiBzb3VyY2Ugd2l0aCAnLS1lbmFi
bGUtZXh0ZXJuYWwtZWxsJyBjb25maWd1cmF0aW9uCk91dHB1dDoKdG9vbHMvYmx1ZW1vb24uYzog
SW4gZnVuY3Rpb24g4oCYcmVxdWVzdF9maXJtd2FyZeKAmToKdG9vbHMvYmx1ZW1vb24uYzo0OTU6
MTc6IGVycm9yOiBjb21wYXJpc29uIG9mIGludGVnZXIgZXhwcmVzc2lvbnMgb2YgZGlmZmVyZW50
IHNpZ25lZG5lc3M6IOKAmF9fb2ZmX3TigJkge2FrYSDigJhsb25nIGludOKAmX0gYW5kIOKAmGxv
bmcgdW5zaWduZWQgaW504oCZIFstV2Vycm9yPXNpZ24tY29tcGFyZV0KICA0OTUgfCAgaWYgKHN0
LnN0X3NpemUgPiAoU0laRV9NQVggLSA0KSkgewogICAgICB8ICAgICAgICAgICAgICAgICBeCnRv
b2xzL2JsdWVtb29uLmM6IEluIGZ1bmN0aW9uIOKAmGFuYWx5emVfZmlybXdhcmXigJk6CnRvb2xz
L2JsdWVtb29uLmM6ODg0OjE3OiBlcnJvcjogY29tcGFyaXNvbiBvZiBpbnRlZ2VyIGV4cHJlc3Np
b25zIG9mIGRpZmZlcmVudCBzaWduZWRuZXNzOiDigJhfX29mZl904oCZIHtha2Eg4oCYbG9uZyBp
bnTigJl9IGFuZCDigJhsb25nIHVuc2lnbmVkIGludOKAmSBbLVdlcnJvcj1zaWduLWNvbXBhcmVd
CiAgODg0IHwgIGlmIChzdC5zdF9zaXplID4gKFNJWkVfTUFYIC0gMykpIHsKICAgICAgfCAgICAg
ICAgICAgICAgICAgXgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwpt
YWtlWzFdOiAqKiogW01ha2VmaWxlOjcyNzc6IHRvb2xzL2JsdWVtb29uLm9dIEVycm9yIDEKbWFr
ZTogKioqIFtNYWtlZmlsZTo0MzEwOiBhbGxdIEVycm9yIDIKCgojIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMKVGVzdDogSW5jcmVtZW50YWwgQnVpbGQgd2l0aCBwYXRjaGVzIC0gRkFJTApE
ZXNjOiBJbmNyZW1lbnRhbCBidWlsZCBwZXIgcGF0Y2ggaW4gdGhlIHNlcmllcwpPdXRwdXQ6CnRv
b2xzL2JsdWVtb29uLmM6IEluIGZ1bmN0aW9uIOKAmHJlcXVlc3RfZmlybXdhcmXigJk6CnRvb2xz
L2JsdWVtb29uLmM6NDk1OjE3OiBlcnJvcjogY29tcGFyaXNvbiBvZiBpbnRlZ2VyIGV4cHJlc3Np
b25zIG9mIGRpZmZlcmVudCBzaWduZWRuZXNzOiDigJhfX29mZl904oCZIHtha2Eg4oCYbG9uZyBp
bnTigJl9IGFuZCDigJhsb25nIHVuc2lnbmVkIGludOKAmSBbLVdlcnJvcj1zaWduLWNvbXBhcmVd
CiAgNDk1IHwgIGlmIChzdC5zdF9zaXplID4gKFNJWkVfTUFYIC0gNCkpIHsKICAgICAgfCAgICAg
ICAgICAgICAgICAgXgp0b29scy9ibHVlbW9vbi5jOiBJbiBmdW5jdGlvbiDigJhhbmFseXplX2Zp
cm13YXJl4oCZOgp0b29scy9ibHVlbW9vbi5jOjg4NDoxNzogZXJyb3I6IGNvbXBhcmlzb24gb2Yg
aW50ZWdlciBleHByZXNzaW9ucyBvZiBkaWZmZXJlbnQgc2lnbmVkbmVzczog4oCYX19vZmZfdOKA
mSB7YWthIOKAmGxvbmcgaW504oCZfSBhbmQg4oCYbG9uZyB1bnNpZ25lZCBpbnTigJkgWy1XZXJy
b3I9c2lnbi1jb21wYXJlXQogIDg4NCB8ICBpZiAoc3Quc3Rfc2l6ZSA+IChTSVpFX01BWCAtIDMp
KSB7CiAgICAgIHwgICAgICAgICAgICAgICAgIF4KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJl
YXRlZCBhcyBlcnJvcnMKbWFrZVsxXTogKioqIFtNYWtlZmlsZTo3Mjc3OiB0b29scy9ibHVlbW9v
bi5vXSBFcnJvciAxCm1ha2U6ICoqKiBbTWFrZWZpbGU6NDMxMDogYWxsXSBFcnJvciAyCgoKCgot
LS0KUmVnYXJkcywKTGludXggQmx1ZXRvb3RoCgo=

--===============7763340413434902986==--

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75E7C48BDF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jun 2021 08:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94B93601FF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jun 2021 08:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhFRIip (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jun 2021 04:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhFRIip (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jun 2021 04:38:45 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36954C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Jun 2021 01:36:36 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id t9so6951734qtw.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Jun 2021 01:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=J2WHx5SlLk7cgxlq8pxgmPLJ0hsKGXBiFMhCK7zyWv0=;
        b=XsB7DtlfEIoigNKyPNNkL0lmtG1DXeh3FhkRjYeUtDqa55SrQ1p9IVkWbtHmMPoTsx
         WCY6jnxQQiR1vJAgGs+RxtQaevPqXzXrMNzY7nriTU+bXtlYdA9qvBiQ2BVpfqx4eEUS
         9h5oByllrodaqMwjur9O69nXvn/UOlNGVgS6L0WMzRdxmABWss/kQgCpda6MOGBV/vUT
         TYUxnvH6Sgata/cm8afzfXwk/GVU2SZhR1Zfi8WYvI2JaRu3zioD9Hgf9OV2kAao0S6d
         S7RoM+R64WY8HRsh1WJuYAt3KGsfvfUyO6lrej92aOj57xPsuJ11uGfUoZBmt9sBGFXD
         8AIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=J2WHx5SlLk7cgxlq8pxgmPLJ0hsKGXBiFMhCK7zyWv0=;
        b=ggSFBSMk6pCTbkmUblwzlz2paIIXS0rAzyV5hzIy6fg2hSKQ1sUqI7RxvSxLk77OWH
         2BHZlcLPvPhi0hCEba9MLaJ/1ROzr71Qejk41wBQc+TsxBuUaegEw5RTfrxDjXrt0uZB
         U8I8/KTzwAdAAELqjEV2pM38VK5YHRMLkY8zgoJjbUuAA82FoHq+JU8yeoXy7CW04O5s
         SsZhqprNOjMl+C7CtO0wbEsrT8ahan2/qRMQOmfu/+GPv0csLi0ABg9Gifv7dTUrbzkL
         ru+GnNJNrBPDCbVCnYaPeB8MozPwtZPRurm0wPFfGzFB8CM/Jmz4u6vjdTmFHtWMU8KU
         H/ZQ==
X-Gm-Message-State: AOAM533qB4aaRRz3D5BOAap4hfK9FzikBI5Vz3fbwEWXiaJawWg9o6rG
        M3nCqk22UHMCmUXHAQmd3+KyPgJCqsTRIQ==
X-Google-Smtp-Source: ABdhPJwcLmasdQ1Bidn/IhOllPK1/S5QTQzPaqngCUVIjzs4joq9rQ0/kRi7u0UBAG2pxMegZi1tew==
X-Received: by 2002:ac8:4f15:: with SMTP id b21mr9322929qte.222.1624005395111;
        Fri, 18 Jun 2021 01:36:35 -0700 (PDT)
Received: from [172.17.0.2] ([52.225.249.48])
        by smtp.gmail.com with ESMTPSA id q184sm2739498qkd.35.2021.06.18.01.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 01:36:34 -0700 (PDT)
Message-ID: <60cc5b12.1c69fb81.5cb52.297a@mx.google.com>
Date:   Fri, 18 Jun 2021 01:36:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2002411796658292592=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, josephsih@chromium.org
Subject: RE: [v1,1/3] monitor: add new Intel extended telemetry events
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210618155610.v1.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
References: <20210618155610.v1.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2002411796658292592==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NTAzMDQ5CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMS4zOSBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjM3IHNlY29uZHMKUHJlcCAtIFNldHVwIEVMTCAgICAgICAgICAgICAgUEFTUyAg
ICAgIDQ2LjM2IHNlY29uZHMKQnVpbGQgLSBQcmVwICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDAuMTAgc2Vjb25kcwpCdWlsZCAtIENvbmZpZ3VyZSAgICAgICAgICAgICBQQVNTICAgICAgOC4x
MyBzZWNvbmRzCkJ1aWxkIC0gTWFrZSAgICAgICAgICAgICAgICAgIEZBSUwgICAgICAyNS43MyBz
ZWNvbmRzCk1ha2UgQ2hlY2sgICAgICAgICAgICAgICAgICAgIEZBSUwgICAgICAwLjY1IHNlY29u
ZHMKTWFrZSBEaXN0Y2hlY2sgICAgICAgICAgICAgICAgUEFTUyAgICAgIDIzNC44NiBzZWNvbmRz
CkJ1aWxkIHcvZXh0IEVMTCAtIENvbmZpZ3VyZSAgIFBBU1MgICAgICA3Ljk0IHNlY29uZHMKQnVp
bGQgdy9leHQgRUxMIC0gTWFrZSAgICAgICAgRkFJTCAgICAgIDI0LjkwIHNlY29uZHMKCkRldGFp
bHMKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNrUGF0Y2ggLSBQQVNT
CkRlc2M6IFJ1biBjaGVja3BhdGNoLnBsIHNjcmlwdCB3aXRoIHJ1bGUgaW4gLmNoZWNrcGF0Y2gu
Y29uZgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEdpdExpbnQgLSBQQVNT
CkRlc2M6IFJ1biBnaXRsaW50IHdpdGggcnVsZSBpbiAuZ2l0bGludAoKIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjClRlc3Q6IFByZXAgLSBTZXR1cCBFTEwgLSBQQVNTCkRlc2M6IENsb25l
LCBidWlsZCwgYW5kIGluc3RhbGwgRUxMCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMK
VGVzdDogQnVpbGQgLSBQcmVwIC0gUEFTUwpEZXNjOiBQcmVwYXJlIGVudmlyb25tZW50IGZvciBi
dWlsZAoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEJ1aWxkIC0gQ29uZmln
dXJlIC0gUEFTUwpEZXNjOiBDb25maWd1cmUgdGhlIEJsdWVaIHNvdXJjZSB0cmVlCgojIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQnVpbGQgLSBNYWtlIC0gRkFJTApEZXNjOiBC
dWlsZCB0aGUgQmx1ZVogc291cmNlIHRyZWUKT3V0cHV0Ogptb25pdG9yL2ludGVsLmM6MTM4Njo4
OiBlcnJvcjogdHlwZSBxdWFsaWZpZXJzIGlnbm9yZWQgb24gZnVuY3Rpb24gcmV0dXJuIHR5cGUg
Wy1XZXJyb3I9aWdub3JlZC1xdWFsaWZpZXJzXQogMTM4NiB8IHN0YXRpYyBjb25zdCB1aW50OF90
IHByb2Nlc3NfZXh0X3N1YmV2ZW50KGNvbnN0IHVpbnQ4X3QgKmRhdGEpCiAgICAgIHwgICAgICAg
IF5+fn5+Cm1vbml0b3IvaW50ZWwuYzogSW4gZnVuY3Rpb24g4oCYaW50ZWxfdmVuZG9yX2V4dF9l
dnTigJk6Cm1vbml0b3IvaW50ZWwuYzoxNDI2OjE3OiBlcnJvcjogaW5pdGlhbGl6YXRpb24gZGlz
Y2FyZHMg4oCYY29uc3TigJkgcXVhbGlmaWVyIGZyb20gcG9pbnRlciB0YXJnZXQgdHlwZSBbLVdl
cnJvcj1kaXNjYXJkZWQtcXVhbGlmaWVyc10KIDE0MjYgfCAgdWludDhfdCAqdGx2ID0gKGNvbnN0
IHVpbnQ4X3QgKikgZGF0YTsKICAgICAgfCAgICAgICAgICAgICAgICAgXgpjYzE6IGFsbCB3YXJu
aW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiogW01ha2VmaWxlOjY5Mzk6
IG1vbml0b3IvaW50ZWwub10gRXJyb3IgMQptYWtlOiAqKiogW01ha2VmaWxlOjQxMzQ6IGFsbF0g
RXJyb3IgMgoKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBNYWtlIENoZWNr
IC0gRkFJTApEZXNjOiBSdW4gJ21ha2UgY2hlY2snCk91dHB1dDoKbW9uaXRvci9pbnRlbC5jOjEz
ODY6ODogZXJyb3I6IHR5cGUgcXVhbGlmaWVycyBpZ25vcmVkIG9uIGZ1bmN0aW9uIHJldHVybiB0
eXBlIFstV2Vycm9yPWlnbm9yZWQtcXVhbGlmaWVyc10KIDEzODYgfCBzdGF0aWMgY29uc3QgdWlu
dDhfdCBwcm9jZXNzX2V4dF9zdWJldmVudChjb25zdCB1aW50OF90ICpkYXRhKQogICAgICB8ICAg
ICAgICBefn5+fgptb25pdG9yL2ludGVsLmM6IEluIGZ1bmN0aW9uIOKAmGludGVsX3ZlbmRvcl9l
eHRfZXZ04oCZOgptb25pdG9yL2ludGVsLmM6MTQyNjoxNzogZXJyb3I6IGluaXRpYWxpemF0aW9u
IGRpc2NhcmRzIOKAmGNvbnN04oCZIHF1YWxpZmllciBmcm9tIHBvaW50ZXIgdGFyZ2V0IHR5cGUg
Wy1XZXJyb3I9ZGlzY2FyZGVkLXF1YWxpZmllcnNdCiAxNDI2IHwgIHVpbnQ4X3QgKnRsdiA9IChj
b25zdCB1aW50OF90ICopIGRhdGE7CiAgICAgIHwgICAgICAgICAgICAgICAgIF4KY2MxOiBhbGwg
d2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsxXTogKioqIFtNYWtlZmlsZTo2
OTM5OiBtb25pdG9yL2ludGVsLm9dIEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmlsZToxMDQwNjog
Y2hlY2tdIEVycm9yIDIKCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogTWFr
ZSBEaXN0Y2hlY2sgLSBQQVNTCkRlc2M6IFJ1biBkaXN0Y2hlY2sgdG8gY2hlY2sgdGhlIGRpc3Ry
aWJ1dGlvbgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEJ1aWxkIHcvZXh0
IEVMTCAtIENvbmZpZ3VyZSAtIFBBU1MKRGVzYzogQ29uZmlndXJlIEJsdWVaIHNvdXJjZSB3aXRo
ICctLWVuYWJsZS1leHRlcm5hbC1lbGwnIGNvbmZpZ3VyYXRpb24KCiMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIwpUZXN0OiBCdWlsZCB3L2V4dCBFTEwgLSBNYWtlIC0gRkFJTApEZXNjOiBC
dWlsZCBCbHVlWiBzb3VyY2Ugd2l0aCAnLS1lbmFibGUtZXh0ZXJuYWwtZWxsJyBjb25maWd1cmF0
aW9uCk91dHB1dDoKbW9uaXRvci9pbnRlbC5jOjEzODY6ODogZXJyb3I6IHR5cGUgcXVhbGlmaWVy
cyBpZ25vcmVkIG9uIGZ1bmN0aW9uIHJldHVybiB0eXBlIFstV2Vycm9yPWlnbm9yZWQtcXVhbGlm
aWVyc10KIDEzODYgfCBzdGF0aWMgY29uc3QgdWludDhfdCBwcm9jZXNzX2V4dF9zdWJldmVudChj
b25zdCB1aW50OF90ICpkYXRhKQogICAgICB8ICAgICAgICBefn5+fgptb25pdG9yL2ludGVsLmM6
IEluIGZ1bmN0aW9uIOKAmGludGVsX3ZlbmRvcl9leHRfZXZ04oCZOgptb25pdG9yL2ludGVsLmM6
MTQyNjoxNzogZXJyb3I6IGluaXRpYWxpemF0aW9uIGRpc2NhcmRzIOKAmGNvbnN04oCZIHF1YWxp
ZmllciBmcm9tIHBvaW50ZXIgdGFyZ2V0IHR5cGUgWy1XZXJyb3I9ZGlzY2FyZGVkLXF1YWxpZmll
cnNdCiAxNDI2IHwgIHVpbnQ4X3QgKnRsdiA9IChjb25zdCB1aW50OF90ICopIGRhdGE7CiAgICAg
IHwgICAgICAgICAgICAgICAgIF4KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBl
cnJvcnMKbWFrZVsxXTogKioqIFtNYWtlZmlsZTo2OTM5OiBtb25pdG9yL2ludGVsLm9dIEVycm9y
IDEKbWFrZTogKioqIFtNYWtlZmlsZTo0MTM0OiBhbGxdIEVycm9yIDIKCgoKCi0tLQpSZWdhcmRz
LApMaW51eCBCbHVldG9vdGgKCg==

--===============2002411796658292592==--

Return-Path: <SRS0=EW2K=B4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A85C433E3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 22:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3A2F207BB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 22:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQNYBu1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgHRWxF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Aug 2020 18:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgHRWxE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Aug 2020 18:53:04 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE43BC061389
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 15:53:03 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id x12so16477574qtp.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 15:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=w0Pl0CMcn8lEqI4RTOD0WCr2ZYgpItdGmyjIIKw3hds=;
        b=dQNYBu1z0oBEJIzACOLNOP0DMlz1QIuQ3PjBGJeMlIxIdCzMezB5K7PK97M9yJtlK/
         RHS15O3zNhreTfCcKbZt/VwiyC6j/N14cBJZWLHexg9soUZC6BzTt16sx2ciMIAeVdgW
         B7eDHlNg8RSNUTDmNkZlHpIa77uG8P+sKDylDxqp49C0RGrVGSd9xhepwLYi+JUOnUnX
         tDDUNk2l1GyF9SIX3WJOjDoERUgR1MIXcguoS9SSH7mZc3a6CznXtJ6yLvc1TwiGWaii
         thbeztC0ZpVaigQVXCqeGstEZJRv+ayA3ASbKrFGimuFWI2vovO7TzakjmGa23sWY5vm
         Y0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=w0Pl0CMcn8lEqI4RTOD0WCr2ZYgpItdGmyjIIKw3hds=;
        b=G/nZPZMOWbnxs0ZyYRp6eE77qR3zxSQwOIZPu0vmOxoJWSL0QgoFWU2vLBREV5tHPr
         u6zCOqKz21ol0sxVZIbLQ6gy4bqcNLtzg9xQWibb0rU9VK6JsM2WAK+kSTAksKvKie9h
         kmCon9xMtkE84fX76i6wGcJybo+e1FPEeNPQCbyGmUGssLHl6J4Csw9BfzSq2n9t0YaU
         +Kxh+jRu4OGt0cHXcuu7hcDeyq5jEoEEp1z+M5iGJZPmd+V/sJ5txHZU8KQRkCI4n1TF
         4yXxXsWp2MCEsyQ5zsn6llSXOv5bTR/B9wOq9ISNiKAFTXsbD4mKGozzWorIW56HcDzF
         p0FA==
X-Gm-Message-State: AOAM531iMbD7huohiRsa1qhB0dZbq7idugtTfaxDzw4bmr21BIMf5J6e
        Hn+5bZn0ko8WE23jxt885OPB2qfQTeKpaA==
X-Google-Smtp-Source: ABdhPJzhXtyYVHEftwdFYqAUNQWf20+Y4FGGDZGh2IdEHCrKjizhi2v2+Mjrk+JQjyUkxhZ209JqhA==
X-Received: by 2002:ac8:7650:: with SMTP id i16mr19827711qtr.215.1597791182794;
        Tue, 18 Aug 2020 15:53:02 -0700 (PDT)
Received: from [172.17.0.2] ([52.251.53.181])
        by smtp.gmail.com with ESMTPSA id 3sm22960673qkm.117.2020.08.18.15.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 15:53:02 -0700 (PDT)
Message-ID: <5f3c5bce.1c69fb81.89999.eda0@mx.google.com>
Date:   Tue, 18 Aug 2020 15:53:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0553159514088848311=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mcchou@chromium.org
Subject: RE: [BlueZ,v1,1/7] adv_monitor: Introduce org.bluez.AdvertisementMonitorManager1 interface
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200818152612.BlueZ.v1.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
References: <20200818152612.BlueZ.v1.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0553159514088848311==
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
ZmF1bHQgKHNlZSBgVScpCnNyYy9hZHZfbW9uaXRvci5jOjk4OjE2OiBlcnJvcjog4oCYQlRfQURf
TUFYX0RBVEFfTEVO4oCZIHVuZGVjbGFyZWQgaGVyZSAobm90IGluIGEgZnVuY3Rpb24pCiAgIDk4
IHwgIHVpbnQ4X3QgdmFsdWVbQlRfQURfTUFYX0RBVEFfTEVOXTsKICAgICAgfCAgICAgICAgICAg
ICAgICBefn5+fn5+fn5+fn5+fn5+fn4Kc3JjL2Fkdl9tb25pdG9yLmM6IEluIGZ1bmN0aW9uIOKA
mG1vbml0b3JfbWF0Y2jigJk6CnNyYy9hZHZfbW9uaXRvci5jOjI4NDozNTogZXJyb3I6IHBhc3Np
bmcgYXJndW1lbnQgMSBvZiDigJhnX2RidXNfcHJveHlfZ2V0X3BhdGjigJkgZGlzY2FyZHMg4oCY
Y29uc3TigJkgcXVhbGlmaWVyIGZyb20gcG9pbnRlciB0YXJnZXQgdHlwZSBbLVdlcnJvcj1kaXNj
YXJkZWQtcXVhbGlmaWVyc10KICAyODQgfCAgaWYgKHN0cmNtcChnX2RidXNfcHJveHlfZ2V0X3Bh
dGgocHJveHkpLCBtb25pdG9yLT5wYXRoKSAhPSAwKQogICAgICB8ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBefn5+fgpJbiBmaWxlIGluY2x1ZGVkIGZyb20gc3JjL2Fkdl9tb25p
dG9yLmM6MzE6Ci4vZ2RidXMvZ2RidXMuaDozMzY6MTM6IG5vdGU6IGV4cGVjdGVkIOKAmEdEQnVz
UHJveHkgKuKAmSB7YWthIOKAmHN0cnVjdCBHREJ1c1Byb3h5ICrigJl9IGJ1dCBhcmd1bWVudCBp
cyBvZiB0eXBlIOKAmGNvbnN0IEdEQnVzUHJveHkgKuKAmSB7YWthIOKAmGNvbnN0IHN0cnVjdCBH
REJ1c1Byb3h5ICrigJl9CiAgMzM2IHwgY29uc3QgY2hhciAqZ19kYnVzX3Byb3h5X2dldF9wYXRo
KEdEQnVzUHJveHkgKnByb3h5KTsKICAgICAgfCAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+
fn5+fn4Kc3JjL2Fkdl9tb25pdG9yLmM6IEluIGZ1bmN0aW9uIOKAmHBhcnNlX3BhdHRlcm5z4oCZ
OgpzcmMvYWR2X21vbml0b3IuYzo0OTM6MzY6IGVycm9yOiBzdWdnZXN0IHBhcmVudGhlc2VzIGFy
b3VuZCDigJgmJuKAmSB3aXRoaW4g4oCYfHzigJkgWy1XZXJyb3I9cGFyZW50aGVzZXNdCiAgNDkz
IHwgICBpZiAoYWRfdHlwZSA+IEJUX0FEXzNEX0lORk9fREFUQSAmJgpzcmMvYWR2X21vbml0b3Iu
Yzo0MzM6MTE6IGVycm9yOiB1bnVzZWQgdmFyaWFibGUg4oCYbnVtX3BhdHRlcm5z4oCZIFstV2Vy
cm9yPXVudXNlZC12YXJpYWJsZV0KICA0MzMgfCAgdWludDE2X3QgbnVtX3BhdHRlcm5zID0gMDsK
ICAgICAgfCAgICAgICAgICAgXn5+fn5+fn5+fn5+CnNyYy9hZHZfbW9uaXRvci5jOiBJbiBmdW5j
dGlvbiDigJhnZXRfc3VwcG9ydGVkX21vbml0b3JfdHlwZXPigJk6CnNyYy9hZHZfbW9uaXRvci5j
Ojc2MTozNDogZXJyb3I6IHVudXNlZCB2YXJpYWJsZSDigJhtYW5hZ2Vy4oCZIFstV2Vycm9yPXVu
dXNlZC12YXJpYWJsZV0KICA3NjEgfCAgc3RydWN0IGJ0ZF9hZHZfbW9uaXRvcl9tYW5hZ2VyICpt
YW5hZ2VyID0gZGF0YTsKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBe
fn5+fn5+CmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMV06
ICoqKiBbTWFrZWZpbGU6OTI3Mjogc3JjL2JsdWV0b290aGQtYWR2X21vbml0b3Iub10gRXJyb3Ig
MQptYWtlOiAqKiogW01ha2VmaWxlOjQwMTQ6IGFsbF0gRXJyb3IgMgoKCgotLS0KUmVnYXJkcywK
TGludXggQmx1ZXRvb3RoCg==

--===============0553159514088848311==--

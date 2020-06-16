Return-Path: <SRS0=6MVD=75=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBE8C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 10:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 591D420663
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 10:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lg1Sx5i4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgFPKK3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Jun 2020 06:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgFPKK3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Jun 2020 06:10:29 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DFCC08C5C2
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 03:10:29 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id i4so1342886pjd.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 03:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=a1gxGGiq4jI2E4WDXIgJtmvwXLaof0rN8NYJV/TX+wY=;
        b=Lg1Sx5i4axmMsC/Rq/IM+HCuJlA66n6oVyjPh+p9brtU0mfp4VhO4GGiIYTmdrm3CX
         ZuQgYylHxgT4daHUPc9pWZVsw5yWd+pXzK3FmQoOdcaOvdT6gMlWugV0yQPUdXNHZjpC
         nhhXQpbYihVJhcATXiXWWIU38jUXStz1zvhBLwNQLO21jWNdUJwLqldVTrwr9xYl+09W
         BvAjGFr4C/Y/O8eW0N6dbnPzGNoYCwERaEPMZCE51bz3woUoRb/XxxVdiE12aN+Fpqcv
         2JWfnMXvbMEOcRZHjglzIqV4yPwRgbMHg3Gwbnj4xMAt8PfP2HZxNpVEe3M0F/xazDaZ
         d88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=a1gxGGiq4jI2E4WDXIgJtmvwXLaof0rN8NYJV/TX+wY=;
        b=ofEHv31P6SdK1Nb42UmORKjgCPHCORUi2bfFYQT2+o+tNHXFe33Ma+ulaPm6J12EiN
         nYF15CuPgxYoNDbMdbmWSS2uH63fyTTj84ZL+1n3QfVbQ51c8XruT1YbRBQKZeWi/DlV
         Rw0ZC3gNhO9Cb3NLcrtKPC6pg1K7s1JdYwnQkmR7+K3RBz2c/3nYIyDJybeg0YX1tz26
         NK/nzXfP2V+bLLAk/nuNknbMdhTqUpTx+i4lwcVm4IyzdbnYZ8y2da6nqcVz3Vmna5v8
         4fVBdUttEFW/a4EsZd7Q0UB8GWlOETRyWySPssCxvJphp9fyo5Qo2sS6GjxNVg0Axw6o
         A68A==
X-Gm-Message-State: AOAM530tAjOLZiSb6psqQw9vrvFYpH0TiaAobF5WTB9DJnQCiR0zhJP5
        2w/ORqVr/+FqxCJrsGQyMW5jmLF3Xfw=
X-Google-Smtp-Source: ABdhPJyDkLzYCSh4jZWiJIykYp6tgFxnNXQf23jDggXJnQk16eh/13oFSF+GRzch2bPvAnW86rQ64Q==
X-Received: by 2002:a17:90a:e98e:: with SMTP id v14mr2201717pjy.70.1592302227536;
        Tue, 16 Jun 2020 03:10:27 -0700 (PDT)
Received: from [172.17.0.2] ([40.65.127.65])
        by smtp.gmail.com with ESMTPSA id 63sm16763433pfd.65.2020.06.16.03.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 03:10:27 -0700 (PDT)
Message-ID: <5ee89a93.1c69fb81.8555f.55f6@mx.google.com>
Date:   Tue, 16 Jun 2020 03:10:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3364156020200840730=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, michal.lowas-rzechonek@silvair.com
Subject: RE: [RFC,BlueZ] mesh: Allow calls to Attach/Leave before replying to JoinComplete
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200616094009.21753-1-michal.lowas-rzechonek@silvair.com>
References: <20200616094009.21753-1-michal.lowas-rzechonek@silvair.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3364156020200840730==
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
ZmF1bHQgKHNlZSBgVScpCm1lc2gvbWVzaC5jOiBJbiBmdW5jdGlvbiDigJhwcm9jZXNzX3BlbmRp
bmdfY2FsbOKAmToKbWVzaC9tZXNoLmM6NDgwOjE3OiBlcnJvcjogdG9vIGZldyBhcmd1bWVudHMg
dG8gZnVuY3Rpb24g4oCYbF9xdWV1ZV9yZW1vdmVfaWbigJkKICA0ODAgfCAgcGVuZGluZ19jYWxs
ID0gbF9xdWV1ZV9yZW1vdmVfaWYocGVuZGluZ19jYWxscywgbWF0Y2hfY2FsbF9ub2RlKTsKICAg
ICAgfCAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn4KSW4gZmlsZSBpbmNsdWRlZCBm
cm9tIC91c3IvaW5jbHVkZS9lbGwvZWxsLmg6MjcsCiAgICAgICAgICAgICAgICAgZnJvbSBtZXNo
L21lc2guYzoyNToKL3Vzci9pbmNsdWRlL2VsbC9xdWV1ZS5oOjYzOjc6IG5vdGU6IGRlY2xhcmVk
IGhlcmUKICAgNjMgfCB2b2lkICpsX3F1ZXVlX3JlbW92ZV9pZihzdHJ1Y3QgbF9xdWV1ZSAqcXVl
dWUsCiAgICAgIHwgICAgICAgXn5+fn5+fn5+fn5+fn5+fn4KbWFrZVsxXTogKioqIFtNYWtlZmls
ZTo2NzkxOiBtZXNoL21lc2gub10gRXJyb3IgMQptYWtlOiAqKiogW01ha2VmaWxlOjQwMTA6IGFs
bF0gRXJyb3IgMgoKCgotLS0KUmVnYXJkcywKTGludXggQmx1ZXRvb3RoCg==

--===============3364156020200840730==--

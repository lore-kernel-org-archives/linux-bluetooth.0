Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8002BC54EED
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Jan 2023 10:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbjA3Kzi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Jan 2023 05:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235861AbjA3Kzg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Jan 2023 05:55:36 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FF117CC0
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 02:55:36 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id nn18-20020a17090b38d200b0022bfb584987so10703155pjb.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 02:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cHGWzOCStbmROKGOpzyS/Tkh1EXQSVXLbdMC/nE/Evs=;
        b=cm9wy/6KWho/ugLjtDcyLHz/4rOXc4ZDC7KBpxbhLt43ELRBZXLqMDqmLFidIyFbwR
         u3SIUGFa3RH+cwZOAnRUbtr1++aJqNjunYrotaWQL3XtsdPw6lkx4o8TgVXJRJGG3Q+V
         dey+SCBto9RpYuV6s8O0i9u8KYjWOV0+nhazU71L9DsxaTKpDZUm7sBZ6DyC0UH4M8w0
         RV4dhml+d42APP8DW8HF+2J5NwvwMrHI6JhxXw92cH+zj4REsjvBveQO5b/lo1NCqbfo
         Ozk2nM4b1OD6iduYP0Zw7zxqsgX4DVGrhF4PcPMa7jPWmHzRCU7hgU69F2GFrFdN7oan
         R9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cHGWzOCStbmROKGOpzyS/Tkh1EXQSVXLbdMC/nE/Evs=;
        b=jG+4Tc/vttSMh9y/p6XJC78LoacWqsXUUMmTUA7VMfPVUEIOWcgBf8oUSFQqC13tgR
         AYQhX6xmzOmbArJdprc/GltVW3q2yVKCEHEqSpwCn2wviASpOnbts48zi9cshj50Hf7f
         dU6BxJ0QSTDbz21sGvYsrxANvmfhwv20B7ZBIeSgYRAGF4rpY+CtIRP1HyWyZ0kkivcB
         VyHT8eebE762rp2cPXUPRvYDPGePX2xazxOLG9mfdqElcOFvT20d0yH/c5O3uTHk6Zwg
         Yq0B7y63aD9mBOJj83NbFE9FagQ+xrQcEEn5jDlijQRuJqJtbi+Udf4MUCtEYYA3uCpb
         MT8w==
X-Gm-Message-State: AO0yUKWmSxdq7ngxNe9WpBeYFIxCITRDHmfwdX+GY7xy37nTzmlo66TU
        j1WuEvjST8S2AQfx3Mv48tWvcGQGjUQ=
X-Google-Smtp-Source: AK7set/9pqU+afc+MvOki3vocTmCLT9C6elGjmtcIA1GOrQyBpVAzDpAXZD3BNAfjz710ydCPYvt8Q==
X-Received: by 2002:a17:90b:4ac5:b0:22c:a544:e543 with SMTP id mh5-20020a17090b4ac500b0022ca544e543mr3132264pjb.3.1675076135512;
        Mon, 30 Jan 2023 02:55:35 -0800 (PST)
Received: from [172.17.0.2] ([13.64.11.209])
        by smtp.gmail.com with ESMTPSA id bt8-20020a17090af00800b00212e5fe09d7sm6923134pjb.10.2023.01.30.02.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 02:55:35 -0800 (PST)
Message-ID: <63d7a227.170a0220.92470.aa7b@mx.google.com>
Date:   Mon, 30 Jan 2023 02:55:35 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8433309666496349925=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, marcin.kraglak@telink-semi.com
Subject: RE: monitor/att: Fix Set Member Lock decoding
In-Reply-To: <20230130091336.19098-1-marcin.kraglak@telink-semi.com>
References: <20230130091336.19098-1-marcin.kraglak@telink-semi.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8433309666496349925==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=716824

---Test result---

Test Summary:
CheckPatch                    PASS      0.75 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      35.55 seconds
BluezMake                     PASS      1167.50 seconds
MakeCheck                     PASS      13.44 seconds
MakeDistcheck                 PASS      191.67 seconds
CheckValgrind                 PASS      314.94 seconds
CheckSmatch                   WARNING   434.30 seconds
bluezmakeextell               PASS      127.17 seconds
IncrementalBuild              PASS      970.60 seconds
ScanBuild                     PASS      1386.96 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/att.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============8433309666496349925==--

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359F4C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 00:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239672AbiKRA3X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Nov 2022 19:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240656AbiKRA3Q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Nov 2022 19:29:16 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6B76E550
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 16:29:15 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id jr19so2243272qtb.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 16:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lDChgHv5V422Egw6I8NjBLjnul8NJY0GZ4xAZfwO83U=;
        b=MGbCCgh6ZxrlxhJk/i5/5Le5FLwK6ofYErKV3I1Wno6PAAqmDML/aA/YYWzDnyQw9U
         P/P5CWmksR2OdUvnrVTpBYoglk6D/PpH+45hjsSWTdRp3V4sgjL03sVNVw88VCUU+gr8
         djcilVYOWPdoctaT3skrzPe7zJH5gdRpO7FE08YPNiDD1FRxH5kB8c7hvbhA3gbruFif
         sOClvbMIHMmrKbojO3R7MI2kpyiv5h+gfyirranNBVtJP+XkEZ47hCv/H3Zn1LVtSgB1
         OCKvfzEbu0pTx+mxi7rzy+GEsKgnVyron760+HV6qs7yoF+XmuY2wPMqJVcjYS4eC3ot
         MuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lDChgHv5V422Egw6I8NjBLjnul8NJY0GZ4xAZfwO83U=;
        b=nWGf9SQLlKsmrlHt+CLR4Uj/O7yNiposBtDEpvQFS7N7u1sUilzYe0Br4f4gakiKz4
         HZWgCaXfofB0K+iSnjAQZDVrK74p7/FNpgT/L2CtE4X/6oOJGFaVl55iR2+OK9nUqRwi
         KKgcbxyo1GH0p5OutL5aYRnrKEz1c//WllBoy2m7MtULEQ6qk66nLL9GO7Hu5c71XWSq
         0AyNJ+Y9rWUW6d7sGHnO1HDaZbyY6C1ENgyEBrgZVvuVSvWQDOY7EPxrhfd+0lau/2zC
         0bdpy+wiwofwo2MAWlfUi5lelt9zdpLVDSIFZoRMXpex2dUL7NU08ansTgxrFWZrEcXZ
         oEfQ==
X-Gm-Message-State: ANoB5pk6wVt8yPsz54U0gMiLYA3AbpAAFP5jtF/iID+2ltlSnEIX4zrx
        gbtMrFYyPcakwEwzxjlAC1LsNpkBliiT5Q==
X-Google-Smtp-Source: AA0mqf7Rcr+5YwkXEOuNc2bNTIYsNiD7FOvVY+2c/O/sYKbUaayT5Z87+pyYa7WQMHFKfO2DhtHK2Q==
X-Received: by 2002:ac8:5a83:0:b0:3a5:9672:a26e with SMTP id c3-20020ac85a83000000b003a59672a26emr4607972qtc.587.1668731354433;
        Thu, 17 Nov 2022 16:29:14 -0800 (PST)
Received: from [172.17.0.2] ([20.14.180.145])
        by smtp.gmail.com with ESMTPSA id bq30-20020a05620a469e00b006ef1a8f1b81sm1514711qkb.5.2022.11.17.16.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 16:29:14 -0800 (PST)
Message-ID: <6376d1da.050a0220.3f788.87b0@mx.google.com>
Date:   Thu, 17 Nov 2022 16:29:14 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4900220025436607038=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,v3] doc: test patch - DO NOT MERGE
In-Reply-To: <20221116052513.57081-1-hj.tedd.an@gmail.com>
References: <20221116052513.57081-1-hj.tedd.an@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4900220025436607038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=695796

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      26.69 seconds
BluezMake                     PASS      753.37 seconds
MakeCheck                     PASS      11.17 seconds
MakeDistcheck                 PASS      146.66 seconds
CheckValgrind                 PASS      238.54 seconds
bluezmakeextell               PASS      93.52 seconds
IncrementalBuild              PASS      610.12 seconds
ScanBuild                     PASS      963.67 seconds



---
Regards,
Linux Bluetooth


--===============4900220025436607038==--

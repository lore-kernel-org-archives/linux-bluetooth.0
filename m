Return-Path: <SRS0=wtMD=CT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B172C433E2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 23:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 057C32080A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 23:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOfPIQw0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725294AbgIJX2F (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Sep 2020 19:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgIJX2D (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Sep 2020 19:28:03 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B661C061573
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2020 16:28:01 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id z2so6291437qtv.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2020 16:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=pR9XyGv7DcrE5nJAweJ//E5dVpLXEl2DyKqrzYmUXr0=;
        b=LOfPIQw0cMvO9xTe8b1l/AXJ0ECI8guXCCK3RS/eO8tqYYkQhR9OoC63l1Po8fj2Hf
         9DAx1fkirv9uKVV3pUEoowtmxv4JE82y4Rk+ZfAt2HtYJXBqnwX4iC0FRvcayelzb53a
         7j5r/f4ZFdtWWvFOW7To2XQJD3wEEYlLAjSrjSHciHDtfAGX/5SG0lSWU1+cP8uzbJxY
         rNYuS0mz2ZaTCvmC6R7Oy+s1uUgl2gI5kaYozLKzmXU+ZMaeIT1Sr1hd/PdCOmQs5jYV
         SUqqUZUVOMDQdwcm62RMWXgOVilKLlbk23bEUqcwjndQpxGLUAeFA3gpcvvGOSAibz40
         pfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=pR9XyGv7DcrE5nJAweJ//E5dVpLXEl2DyKqrzYmUXr0=;
        b=pfJtGc0R+89WjYw2tYbao+6qy262dk0EyzLfaW8HuoVxmvG/gmtGCh/GvuygwSkeuu
         p6bQBLCrCjT7TSf6sVp/2z3ZdLbVzFl6X97KQn7u3g1Vt+8dWtaszear5wfx1CK0N068
         StV7oUJSzhFxHjDd5HbL8BB8LwOsRQWUybn7U5xhz1mgQtsA8zjz3ZcF8LfifbBX/62a
         jAze/IrRHwJlbWZT8x8395Q7X6mUxzh7Q242Shqbi61KoH78nsNBN0BAd88VVLItIemW
         sbzzApOHfDxPjSkZVgVA+WoycCj9pm433YkmQyOolIhdb3L2JC+mzRkl7EWuVuqPbWLy
         /zRQ==
X-Gm-Message-State: AOAM531Ps7NC5/rgrzRG66xtU4DflTDst3meuf1fY4tSSno/d5Mbo2iL
        13EdrVKNAVE6l0Z0geusGRMI6xbaKhruww==
X-Google-Smtp-Source: ABdhPJw2RoCk5bM4oFEug24Lue6k1WLA6QqV5I4hWhIHSdL+OENHQV8Sb1Cv3bJbBf8i6xA+kyO5Gw==
X-Received: by 2002:ac8:4f4b:: with SMTP id i11mr10176247qtw.379.1599780479991;
        Thu, 10 Sep 2020 16:27:59 -0700 (PDT)
Received: from [172.17.0.2] ([52.247.3.217])
        by smtp.gmail.com with ESMTPSA id w44sm363431qth.9.2020.09.10.16.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 16:27:59 -0700 (PDT)
Message-ID: <5f5ab67f.1c69fb81.a94e4.274c@mx.google.com>
Date:   Thu, 10 Sep 2020 16:27:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8045557263980472809=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mcchou@chromium.org
Subject: RE: [BlueZ,v4,2/8] adv_monitor: Introduce org.bluez.AdvertisementMonitorManager1 interface
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200910161528.BlueZ.v4.2.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
References: <20200910161528.BlueZ.v4.2.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8045557263980472809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkpatch Failed

Outputs:
WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#94: FILE: src/adv_monitor.c:1:
+/*

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#247: FILE: src/adv_monitor.h:1:
+/*

- total: 0 errors, 2 warnings, 235 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============8045557263980472809==--

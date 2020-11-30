Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A40C64E90
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 22:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45D2220705
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 22:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tX4MixU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbgK3Wfe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Nov 2020 17:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730753AbgK3Wfd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Nov 2020 17:35:33 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB1FC0613CF
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 14:34:53 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id b144so12504232qkc.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 14:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=zd3JtJgA8CxKtxrkxH4JvjXXQSZXjnIrXgDE4Kv6b2Y=;
        b=tX4MixU/Mj8/yZNoAgLceESS9CVjKI/bdnZ/6kZ2xoQgzi8KlCdft3BBtVbom1n1Qo
         HinLq9Vp775MnvlIcJS/52+AugRkRJ6HvHBJCS870Aa7nlknk+4jNgidOc7OBLUVTF1z
         FNNRoIJJM+0iHNR1Uqlzw8xXwFpKfRmP3KAMC1yOmolZ88NbEQBrgpW0JRK3T4o0YKsF
         9PRUcFAQqFzGYEozNhaSr3cIblCapEoj6IRXHpUIqbTHpUo5zkXp8eXXj+7QVdGWqyIf
         QqwfpUCyRuZUhtYmzp2ODbA9mmbkJztUAWxDJCvbsKnWB1NsJiRNhIIGf4ojfP7q5XVu
         AKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=zd3JtJgA8CxKtxrkxH4JvjXXQSZXjnIrXgDE4Kv6b2Y=;
        b=tBbhTe3wg0RgoJCxwnUR+k+YZaMx8QLHYeQj7EjxFljoJO0QTmCTdjV79AMJ3ZA61H
         ZDsAeLpvmxU9bSEOR5nKv6YEPBYgl4t5z1vLgSfY5IOHeeaFK3cVZB8RfmFfVkNSBSdD
         7KBFu0sk7E3Qg+pnqlhRFg6YmAum7qBUQsfCWRAiAXWJY+EOXBcdL/1jCDjE5OkMg/ay
         pgM+cEgYIE/JNJP63MiSudfpqVyH9NjwackR0WeQEtePHrhvJoDJ6oQwGv3TnaZHb7ME
         tV21z3dhf5ALJA/w2GvKa5J7ulwmHZ03XOrIski3xgtv+9/1+i2Pi+Euvp1+i63R3JtN
         ZGFA==
X-Gm-Message-State: AOAM532uVWJk3dWI77/VZ1C7EA3MobjGXVnV1EW83XlJOhY6vlpMgGpM
        c4i29yvqH8ZHAtysHC799Sv0g13dsYX+IA==
X-Google-Smtp-Source: ABdhPJyz9YTPtvEBbBuyAHuNj3ssCU7VoTKsWWLNllqcsRSQR9QUPhekn7fzOqZ60zpO0cDAJiSxoQ==
X-Received: by 2002:a05:620a:1435:: with SMTP id k21mr11710758qkj.375.1606775692576;
        Mon, 30 Nov 2020 14:34:52 -0800 (PST)
Received: from [172.17.0.2] ([20.186.96.76])
        by smtp.gmail.com with ESMTPSA id d16sm17305119qkc.58.2020.11.30.14.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 14:34:52 -0800 (PST)
Message-ID: <5fc5738c.1c69fb81.8e7df.5ba8@mx.google.com>
Date:   Mon, 30 Nov 2020 14:34:52 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0118614685827081986=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [BlueZ,v5,1/7] battery: Add the internal Battery API
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201130215602.386545-1-sonnysasaka@chromium.org>
References: <20201130215602.386545-1-sonnysasaka@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0118614685827081986==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=393559

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
battery: Add the internal Battery API
ERROR:INITIALISED_STATIC: do not initialise statics to NULL
#71: FILE: src/battery.c:38:
+static struct queue *batteries = NULL;

- total: 1 errors, 0 warnings, 215 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] battery: Add the internal Battery API" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

test: Add test app for Battery Provider API
ERROR:EXECUTE_PERMISSIONS: do not set execute permissions for source files
#12: FILE: test/example-battery-provider

- total: 1 errors, 0 warnings, 232 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] test: Add test app for Battery Provider API" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============0118614685827081986==--

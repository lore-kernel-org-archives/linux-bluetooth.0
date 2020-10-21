Return-Path: <SRS0=Xy/k=D4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B22C4363A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Oct 2020 22:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3F29241A4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Oct 2020 22:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0NBxwuV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409819AbgJUWeT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Oct 2020 18:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387512AbgJUWeT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Oct 2020 18:34:19 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE18BC0613CE
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2020 15:34:18 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id j62so3629626qtd.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2020 15:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=I/qpHK7Nmc3Z0ruuCNNcK9HZxnOr1K9TX4L/nj7nsn8=;
        b=j0NBxwuVhtKZDK3wVpFnhoHGTU2tY/KpwC1Ue/ytxe7iGmCKPueCTUAf1aS/cEAj0m
         nmkXQxXMgRXlhm9lXEOVW/QRmz/JmajxBFlpgy+c21PC0a2konmdoGCx9JW031oN0Ei/
         qBzLlGU+sAi/qYuAEekv0rbTIyPFRMF/aauKIbNqsF6iD3qAYcig/2Ni4m53pdrnt74b
         rmeYc1gXWC5BvYICujhbiigc2N+QPuEJ12jCUxon+b5V7Yw+Ou+JxF0Yga7RRE+9at9J
         +jJi0xGFJPYgYG5e1lWuWT5YFiFoILCC7Q7gG0d5tsy/V9PW14nVKdSsIYS7bnqohZXy
         wMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=I/qpHK7Nmc3Z0ruuCNNcK9HZxnOr1K9TX4L/nj7nsn8=;
        b=qEeU/Y2+NYxP9wkJg+NbTebDJt7NcB76Rk2P/OpTRkrgJ+MrjDbdD5YtufsrpmvSt8
         +v7TV3Hk1kFuuyLbLzMFHK0fgvChPlOFX1goHpt/TIen3msKo7Le147JUSMKdHr/B3R/
         zaYrEi7XKGIPBHjMW7toY8O6rBSjYR1J7AH4tJYVFebi1BEgYmRiPR7fe3BFe2dRglCG
         3PdKhwsxUI9Xd/4W97PHEAYEW3KmOIfs7MkVUWZtaJUvS38kLyGA3pWDET1FF6mqwsIF
         xIqihs99ncXAhBnkXuI8NGWdm9yU3j3p+BINKg+5F3+j6ew9M4mNQmBV98swrg9sTxwp
         b+vQ==
X-Gm-Message-State: AOAM531RZTdYKhYZcI+8ZwxJ8DBxaT1SbtRARZhB1Kk1PV08rttZ5otz
        PZE9hHXJDOwAFU4sOYxSShREwLXoQfmA7g==
X-Google-Smtp-Source: ABdhPJwLo+5L4wgvW1Jgv9sElBeIzx/yVPURAZoqR2K5jqwqvGNdcLV5MGzdgBsZ8QoiDlzVR5Wc8g==
X-Received: by 2002:ac8:1ae3:: with SMTP id h32mr5002035qtk.325.1603319657776;
        Wed, 21 Oct 2020 15:34:17 -0700 (PDT)
Received: from [172.17.0.2] ([20.36.180.174])
        by smtp.gmail.com with ESMTPSA id 67sm2343679qkd.14.2020.10.21.15.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 15:34:17 -0700 (PDT)
Message-ID: <5f90b769.1c69fb81.a62f8.f43d@mx.google.com>
Date:   Wed, 21 Oct 2020 15:34:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8245763326845435321=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, marijns95@gmail.com
Subject: RE: [BlueZ] audio: avrcp: Split supported events between target and controller
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201021221931.931878-1-marijns95@gmail.com>
References: <20201021221931.931878-1-marijns95@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8245763326845435321==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=368467

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
audio: avrcp: Split supported events between target and controller
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#42: 
[1]: https://android.googlesource.com/platform/system/bt/+/android-11.0.0_r4/bta/av/bta_av_main.cc#761

WARNING:LONG_LINE_COMMENT: line over 80 characters
#55: FILE: profiles/audio/avrcp.c:274:
+	/* Events the Remote Target expects based on peer Remote Controller version */

WARNING:LONG_LINE_COMMENT: line over 80 characters
#57: FILE: profiles/audio/avrcp.c:276:
+	/* Events the Remote Controller expects based on peer Remote Target version */

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#155: FILE: profiles/audio/avrcp.c:4210:
+^I// ^I^I^I(1 << AVRCP_EVENT_STATUS_CHANGED) |$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#156: FILE: profiles/audio/avrcp.c:4211:
+^I// ^I^I^I(1 << AVRCP_EVENT_TRACK_CHANGED) |$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#157: FILE: profiles/audio/avrcp.c:4212:
+^I// ^I^I^I(1 << AVRCP_EVENT_TRACK_REACHED_START) |$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#158: FILE: profiles/audio/avrcp.c:4213:
+^I// ^I^I^I(1 << AVRCP_EVENT_TRACK_REACHED_END) |$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#159: FILE: profiles/audio/avrcp.c:4214:
+^I// ^I^I^I(1 << AVRCP_EVENT_SETTINGS_CHANGED);$

WARNING:LONG_LINE_COMMENT: line over 80 characters
#166: FILE: profiles/audio/avrcp.c:4221:
+				// (1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED) |

WARNING:LINE_SPACING: Missing a blank line after declarations
#193: FILE: profiles/audio/transport.c:994:
+		struct media_transport *transport = l->data;
+		if (transport->device != dev)

- total: 0 errors, 10 warnings, 144 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - FAIL
Output:
audio: avrcp: Split supported events between target and controller
38: B1 Line exceeds max length (102>80): "[1]: https://android.googlesource.com/platform/system/bt/+/android-11.0.0_r4/bta/av/bta_av_main.cc#761"


##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============8245763326845435321==--

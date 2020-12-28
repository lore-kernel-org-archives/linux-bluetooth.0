Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBDEC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 12:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4833022A84
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 12:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbgL1MAc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Dec 2020 07:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgL1MAb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Dec 2020 07:00:31 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CF5C061794
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Dec 2020 03:59:51 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id t9so9297089ilf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Dec 2020 03:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=aI4Oo0GRfhN+5nvr9ZZ6FLBVuKULk074CAo/FVWfe9k=;
        b=Zr6qP3zw8Zo3WbN2MP91q398js6q8OayDau+YSzi4KJFeKNgSbloYoosjM3+o8g0kx
         ndjYywCgGBKmqgI6UrNLoP29deh1junjxjKXOeMXP/+UAONADTwA9sWFUZjxQ+0NqQN1
         DSl/H4pn9fe1f2p6P/U6DGmisRR/zmx1XlfzAxzJzmUhO73LHLMPBHYY0KMCSQ5It9z9
         82+8lwf4h2CG0WmTqRCO4XQqt9018HqDhfqbT2vHh2IInGLUFRpfaxeQy5iCM9fw5xok
         NkdR/1yveBdxGOyq6oDQ3PS5dRxBnRQmJYNgzpXzlqjIk8jLHH75xXv6cZUFpHsCxbML
         1sEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=aI4Oo0GRfhN+5nvr9ZZ6FLBVuKULk074CAo/FVWfe9k=;
        b=r2FgQFe8rT50uXH2GjDWveKVdmAgaoOMkQTegCVaIUpM1WX66lJRnMuSW/RfduTiQM
         cJB1YMex25Uy1wOBC23qFljqdkB5bxWD10NYn+z13pbe3o514+y2OFFiyKVC8SR1739L
         FeNtZqA0ShGrFGQQWuoEwJazqBAuSxB8l7+SoUnjjytna3RhiMHIUd4MJXBHIltIlwBk
         M9tsufV5Zo/1W0N3lqQeuL7Rn5JgC5+fOMhbg7sOMQ9b9PueBY7e04NMNJhmSDnHsuG7
         LCgu57fKKHdkh2VRwd3ls4GghR9hrr+Kaq9BvXcIwy6NbrX4l+cC8EfXh8219PbwPsnB
         5CMw==
X-Gm-Message-State: AOAM533wCtuGxjzsSOMI+N5WwKZy6QGcJ66ZVst+AcdNTkZlN4ZX3w7s
        5TV/goiB/sWjYLlmeScu6OzP8paVsnomUw==
X-Google-Smtp-Source: ABdhPJxaHsMgvd2MMcWfO/fw7lAfGKs3Eg5fSjLYsqxxSuSDYaz6NEh4ygVTkEhEgGyZUmaF0wVw1w==
X-Received: by 2002:a92:48d2:: with SMTP id j79mr42880486ilg.201.1609156790798;
        Mon, 28 Dec 2020 03:59:50 -0800 (PST)
Received: from [172.17.0.2] ([20.186.67.129])
        by smtp.gmail.com with ESMTPSA id p11sm27007062ilb.13.2020.12.28.03.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 03:59:50 -0800 (PST)
Message-ID: <5fe9c8b6.1c69fb81.895e5.6d1b@mx.google.com>
Date:   Mon, 28 Dec 2020 03:59:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5463017104195830935=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [Bluez,v3,1/4] shared/mgmt: Add supports of parsing mgmt tlv list
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201228193351.Bluez.v3.1.Ie32770d0eed2e7739ce9d17d920766fb6aee8583@changeid>
References: <20201228193351.Bluez.v3.1.Ie32770d0eed2e7739ce9d17d920766fb6aee8583@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5463017104195830935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=406753

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
btmgmt: Add command set-sysconfig
WARNING:NAKED_SSCANF: unchecked sscanf return value
#42: FILE: tools/btmgmt.c:1817:
+		if (!sscanf(input + i * 2, "%2hhx", &value[i]))
+			return false;

- total: 0 errors, 1 warnings, 121 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] btmgmt: Add command set-sysconfig" has style problems, please review.

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


--===============5463017104195830935==--

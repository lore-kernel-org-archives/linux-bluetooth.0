Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4A6C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Jan 2021 04:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 041DB225AC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Jan 2021 04:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbhAEETn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Jan 2021 23:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbhAEETm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Jan 2021 23:19:42 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0411BC061795
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Jan 2021 20:19:02 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id 4so14171530qvh.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Jan 2021 20:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=7JIe3UpZG9EleXZT23D873xwuUe++sL3ByYcAgBwAPw=;
        b=NEiaAX7abZdfQrYQtmyxiPLHqQ9f6n2QwpDXuzjDUHBX+u/CUh//WcGvtwKY0Lr9Xv
         JlBzBJq24gWfXH7fRDCfiulmOJd5lYt9XggopSCHILiNrexRGILlYgoTCCbMvL10wHl2
         gxuJE/NDCeroQQQx14AiQ8oq63McCK5ilWxZs4LqS2lOa7U3py2H196V1LMx8NhRkaHl
         Dzhvw9o9FqWfNRdnuUoQmV/LutBUlyLS0msEGxzE07sgl9alDzEhlYWpCL5U5mu0/bcZ
         EU6GnIv9OId0YZrv/NxjM2I8qx+gY4UKAxtsK083Ke0qLCEJl5PHUmYos61o1DufqDw7
         HXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=7JIe3UpZG9EleXZT23D873xwuUe++sL3ByYcAgBwAPw=;
        b=HJTN5pYdrwxj7PAZiQ/y6TQ6RILd5wWzxjCl57f0cdwGbg3h9jkzyuL0vxOnzjdrIr
         Hg5CZFaxF//edzjV4zudpjynfWX0xtPzZJoKFhY9LUDQHaQ0SVSjrAxGYpZXGNAjZ4CT
         JsFTYpdSgiNvYYwheT2OzXG7ZppEVlaazL9Yda7BMmJTAr9m8/38Gcinug0yVU8+7UzD
         5QfbPN9H8vEavqc34e11U6/0sbZZV/G33GTdXBeSF5JaF/QEoSdFZkB+ofrnsV6Qx4YI
         /yRfV9bR8DSy+cA4buKC8yatOV4V4o1ow/jy0G9vVdaGEM684EW2EAy74MB4HTCXrh2B
         m7Tg==
X-Gm-Message-State: AOAM533K+n+pxR0aiOawfMnAQFafQnGSGsCz6+cLvJUdddAJPFaTK2Mc
        Sz/S2BAoMDHS4eNraphFOQDUIJwKENJlQg==
X-Google-Smtp-Source: ABdhPJyE4uBnYx4c9JbiVQY3Q84czDzw15yskNymNVOARfwFrtzkp66puBvz0euIE16NFzZHLpZguQ==
X-Received: by 2002:a0c:f1ce:: with SMTP id u14mr78844124qvl.24.1609820341221;
        Mon, 04 Jan 2021 20:19:01 -0800 (PST)
Received: from [172.17.0.2] ([52.247.122.192])
        by smtp.gmail.com with ESMTPSA id u7sm38920024qke.116.2021.01.04.20.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 20:19:00 -0800 (PST)
Message-ID: <5ff3e8b4.1c69fb81.827b.74bf@mx.google.com>
Date:   Mon, 04 Jan 2021 20:19:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7548089152337245701=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [Bluez,v4,1/4] shared/mgmt: Add supports of parsing mgmt tlv list
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210105111219.Bluez.v4.1.Ie32770d0eed2e7739ce9d17d920766fb6aee8583@changeid>
References: <20210105111219.Bluez.v4.1.Ie32770d0eed2e7739ce9d17d920766fb6aee8583@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7548089152337245701==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=409009

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


--===============7548089152337245701==--

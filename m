Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDFEC25B08
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Aug 2022 05:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239598AbiHWFLz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Aug 2022 01:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiHWFLx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Aug 2022 01:11:53 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6ED4B0FC
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 22:11:52 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id t140so5952855oie.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 22:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=he6cqOmTlmIRKaGlvSwDHxSK70yIhGDlhaEW9TKHlQQ=;
        b=qYBeMamysv2Bkblwm2ub2udu8nMWccwBRmz9MkYETryE/SY2zz0pn+ugrWKJnef0ok
         Meqwx/DYc1jfJCvD2+2UOrVTt1CvK5pV6Ll4JjPg+8l9GEYbDAhi7IY4cJWkXewb0H7X
         hXgWEzi5oPJL3WeNE5kciVv93ZcK4AXtZzhZD8qPDvAkACc1Sof+y3VlFhj0a33pla4r
         dHOTfFt5sDA55YUq7tkwMAxfngC2YP/NTNnFTOuv/494USKENdmlt1ranJkRtpgOMYps
         sGb20HqW+A4IMGNtaGDlmAKkbvbW3M91FdmZwwbTvrvt+Gz+tHHVUWr3bJdH6T1MlFWD
         +q6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=he6cqOmTlmIRKaGlvSwDHxSK70yIhGDlhaEW9TKHlQQ=;
        b=BNEgNnXvY9HogzfEzoDf5cHIWYauyPYJ3DaPtzjTl2/acb0M7LlltXijLsHE0WZKHE
         QWdE6Keqcj4cmxwp6Tj2jJHD0nYtmZLcTmVghyijlj5GQZoLGpjRGb1+LHJIAx4xWIl9
         acpTixHe8VWN61Cdkgjr9MiEQM6T7EP2YvqDLVRvpSpAmhrw4g6NAsZIcZPIA/3Xz5I1
         Ru2zd/UCnld2waEWbfpPhsRdI9Ww4ZzCgtADEJ5CsOxMejYUZFgHTDd7BrGPDcLf8tRQ
         nk0VEPXKLiWzPVfK9CktIBrApPOQWfCkrvvzcFkvzdaHix0sKlGhDoOo5g7veF/trDMO
         iR+Q==
X-Gm-Message-State: ACgBeo3E4Wci9NJ6lVtqMjazecdu3vp01Fl3oPmucXasNCO5zQQnHxwR
        nBmeogTMswyCyPL46p2cOk0V9UT8JUM=
X-Google-Smtp-Source: AA6agR6H98NYt9tvlgD+aLbk2FPZm8BheOpwYr3WmGz9nWUXiFQsgbZgdb9r2TFmkrdCp1Hw7XX/Yw==
X-Received: by 2002:a05:6808:1489:b0:344:7ff8:54e8 with SMTP id e9-20020a056808148900b003447ff854e8mr648962oiw.195.1661231511243;
        Mon, 22 Aug 2022 22:11:51 -0700 (PDT)
Received: from [172.17.0.2] ([23.98.185.235])
        by smtp.gmail.com with ESMTPSA id r143-20020a4a3795000000b0044a8f5f87a9sm2876293oor.16.2022.08.22.22.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 22:11:50 -0700 (PDT)
Message-ID: <63046196.4a0a0220.af162.a8df@mx.google.com>
Date:   Mon, 22 Aug 2022 22:11:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4883379393674206936=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez,v2] adapter: Reset pending settings when receiving MGMT error
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220823121541.Bluez.v2.1.I541cbea9d6295f531c796bf3bda96b22db76bc19@changeid>
References: <20220823121541.Bluez.v2.1.I541cbea9d6295f531c796bf3bda96b22db76bc19@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4883379393674206936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=670000

---Test result---

Test Summary:
CheckPatch                    PASS      1.18 seconds
GitLint                       PASS      0.77 seconds
Prep - Setup ELL              PASS      32.67 seconds
Build - Prep                  PASS      0.81 seconds
Build - Configure             PASS      10.42 seconds
Build - Make                  PASS      954.05 seconds
Make Check                    PASS      13.19 seconds
Make Check w/Valgrind         PASS      350.63 seconds
Make Distcheck                PASS      290.38 seconds
Build w/ext ELL - Configure   PASS      10.67 seconds
Build w/ext ELL - Make        PASS      99.71 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      607.25 seconds



---
Regards,
Linux Bluetooth


--===============4883379393674206936==--

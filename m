Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB498C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Apr 2022 19:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349530AbiDKTSk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Apr 2022 15:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235610AbiDKTSi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Apr 2022 15:18:38 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A79236B7D
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Apr 2022 12:16:23 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id t12so2343234pll.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Apr 2022 12:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=aqPebkqfmJxhumkpjK5kd2ZdUuBokr3wa5daJVIbJ0A=;
        b=XAyCdzLHvlpPmxZw2mD+Bm9pxxVGIJ/qU7Dwgovs2SB/3A18StZUGU9ekQQDLFpe5Y
         V3oJ6X7JhTk8t/CB5L8IafS8LmdIHdtn3ct98ecGMFMh4uTekYf/1oFtwNUYofIHBhmj
         xRBLIsIrDIudahjEUt1eqPGFFF9BKQl6ItoFO4cFUM9gv5ioMXKUmpSj3IZnM9nL8UII
         rxToMkyiDsUS2fDI0gD39+EakEjoc8M7G84t05Wjh7TFWyJTPNIBa6DfhGNNqkKVl+10
         5aK7h8dG6uGOPQNrYQrt9HZ/Cj7DzP5wK26mDFASAN6jeYabKcg+iE5lGS/vzjkdqdEn
         W/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=aqPebkqfmJxhumkpjK5kd2ZdUuBokr3wa5daJVIbJ0A=;
        b=hq2hGU/tKg5bggLsw2zJ/tzTLO3zguQQWIQsFBZ7y18wSGlelz0Dcup1MlOSzprc6n
         6F9ZoUdg+GEluONQHKAeGOtJEhbkbZoe2zgY2Ixvi0V1C+jS5N0rLi3iJR7KRj6KQPBn
         TkcTkIlbRlesdj5emSf2b2Ln/trkD/Mq71Mdbw3S0Sa69SuWla2jcJLjBmAqSpk95rH2
         M1ELQ0W8zG5zPIUSAXN9crweO4KGZ49oCs5m+hlTi5rxThoNG9TTqgsnux9sjarIDih5
         WuuMleWhfRbpclA0k+msFVhR98pb3AHOENsEq+zjP5z21j0vF8SozQZUPlgbFYA44uzc
         ZOqA==
X-Gm-Message-State: AOAM532XcuVO5czmNYrcDjBe3wJpxjzuW9TBCRBDbY2OggyAZcUy0bM6
        4jWGRBdZojtM0oMaOx7ioolbX/Pxdf/AWw==
X-Google-Smtp-Source: ABdhPJwAuC0TwViWK/0BX2oRWvSHJlTFjqNNurviS9XsvvqhfB4BEKqJLoTKOa9nswjcb2m+u9j5Mw==
X-Received: by 2002:a17:902:cec4:b0:158:5584:7c46 with SMTP id d4-20020a170902cec400b0015855847c46mr8398879plg.80.1649704582763;
        Mon, 11 Apr 2022 12:16:22 -0700 (PDT)
Received: from [172.17.0.2] ([13.91.224.68])
        by smtp.gmail.com with ESMTPSA id g15-20020a056a0023cf00b004e17e11cb17sm37964593pfc.111.2022.04.11.12.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 12:16:22 -0700 (PDT)
Message-ID: <62547e86.1c69fb81.fac87.1e51@mx.google.com>
Date:   Mon, 11 Apr 2022 12:16:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1295946229488578287=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ismael@iodev.co.uk
Subject: RE: Bluetooth: btusb: Add 0x0bda:0x8771 Realtek 8761BUV (UGREEN CM390)
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220411174747.13704-1-ismael@iodev.co.uk>
References: <20220411174747.13704-1-ismael@iodev.co.uk>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1295946229488578287==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=631181

---Test result---

Test Summary:
CheckPatch                    FAIL      0.86 seconds
GitLint                       PASS      0.45 seconds
SubjectPrefix                 PASS      0.31 seconds
BuildKernel                   PASS      38.29 seconds
BuildKernel32                 PASS      34.51 seconds
Incremental Build with patchesPASS      49.79 seconds
TestRunner: Setup             PASS      589.49 seconds
TestRunner: l2cap-tester      PASS      18.06 seconds
TestRunner: bnep-tester       PASS      7.24 seconds
TestRunner: mgmt-tester       PASS      126.14 seconds
TestRunner: rfcomm-tester     PASS      9.79 seconds
TestRunner: sco-tester        PASS      9.48 seconds
TestRunner: smp-tester        PASS      9.40 seconds
TestRunner: userchan-tester   PASS      7.72 seconds

Details
##############################
Test: CheckPatch - FAIL - 0.86 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
Bluetooth: btusb: Add 0x0bda:0x8771 Realtek 8761BUV (UGREEN CM390)\WARNING:COMMIT_MESSAGE: Missing commit description - Add an appropriate one

total: 0 errors, 1 warnings, 10 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12809480.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============1295946229488578287==--

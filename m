Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F40C7EE2E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 May 2023 10:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjE2Kjm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 May 2023 06:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjE2Kjk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 May 2023 06:39:40 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA43EC4
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 May 2023 03:39:36 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64f47448aeaso2302972b3a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 May 2023 03:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685356776; x=1687948776;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PtUUJ9oO/UNrB/atUkIExbK5ez94q5uITCzVP0Kbfio=;
        b=qYoleBZMd+pK3ZC/ka9/1o8Zr6dPkjBLzOpRyTMge2B/pll3JkT5JiY38h/QNRcc8t
         ewz50vt4oakRDsv5hwKL43X0fejJn5lcJpWdCQiJ84AYq3XL3oKv/C62vNtwRCS/9VNh
         IXjY/lE+NQxH1rq/JMP2+PTfI/DxEAkbNRljaj3Ooj81Jiplvus3x6htMw2jM3qEvlBj
         rG5G+kgUE/hLX04Da+FG4fytoF4Rr+wa+DVRayVazvS+3iyY6yxEMpUZNp7yipn6kANC
         H/oGAL2Wo/HkQhtFyLin0Pv1qExSLS3B/tq+uyLDQ2/RVL/a83xVurt1YQ52N85IDz4V
         1VvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685356776; x=1687948776;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PtUUJ9oO/UNrB/atUkIExbK5ez94q5uITCzVP0Kbfio=;
        b=KCq6Wd8pOM4vlyYnZVw8kaS+kKP1tATNvGx74+Yn+HuYvLeiNTtme3zXFxZpJvo8F9
         UyAaC0F1QPXmMWXqPVQhAmMXp3Dx1BjxW0Hoct3wo4G44qZ3n8en9Th9Hz/Xkn/XziKw
         ch1hQWmW80itsnaGAMFSTsAD4ObO1mPbnCc4eqkawezFSec1+5CLzBxF4mw0VWJQROqg
         7ltUsQhByz3CDuE3dIq6jsAAOqch9HUSm4Xl2C4Q7DV2iVPKSIrkqifumL6dFX9sHLkJ
         KkSQOQTvNqU8+9cg8yL/UOhLZhW9GqkQTCk89z/lZUMBNyYfWdIj7yCU8zbpq0CZnBpc
         JGIA==
X-Gm-Message-State: AC+VfDyootJjoSFOxKy2tt90rCwqVkDXtOZsyQON0sZnPFV/tOntRRAt
        POFtxKx6KBGO7zs5yQ0lz9JB48U9qQM=
X-Google-Smtp-Source: ACHHUZ5cie6sMuT5yIsFRP29qBtvI0+Kd3oE5KAA/yvnpRazJpfWnM+Hct8LAvSaGDE3HRYT4NRInQ==
X-Received: by 2002:a17:903:2442:b0:1a9:bdf8:f551 with SMTP id l2-20020a170903244200b001a9bdf8f551mr10335486pls.69.1685356775842;
        Mon, 29 May 2023 03:39:35 -0700 (PDT)
Received: from [172.17.0.2] ([13.73.36.242])
        by smtp.gmail.com with ESMTPSA id k8-20020a170902760800b001acad86ebc5sm7929151pll.33.2023.05.29.03.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 03:39:35 -0700 (PDT)
Message-ID: <647480e7.170a0220.f1373.f64d@mx.google.com>
Date:   Mon, 29 May 2023 03:39:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7680000125183377053=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: unit: Introduce test-bass
In-Reply-To: <20230529084650.72126-2-iulia.tanasescu@nxp.com>
References: <20230529084650.72126-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7680000125183377053==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=751789

---Test result---

Test Summary:
CheckPatch                    PASS      1.06 seconds
GitLint                       FAIL      0.81 seconds
BuildEll                      PASS      30.00 seconds
BluezMake                     PASS      1050.56 seconds
MakeCheck                     PASS      12.23 seconds
MakeDistcheck                 PASS      173.29 seconds
CheckValgrind                 PASS      277.57 seconds
CheckSmatch                   PASS      391.37 seconds
bluezmakeextell               PASS      116.06 seconds
IncrementalBuild              PASS      1826.44 seconds
ScanBuild                     PASS      1214.80 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,1/2] shared/bass: Add Write Without Response property to the CP characteristic

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (85>80): "[BlueZ,1/2] shared/bass: Add Write Without Response property to the CP characteristic"
[BlueZ,2/2] unit: Introduce test-bass

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
6: B2 Line has trailing whitespace: "Test Summary "


---
Regards,
Linux Bluetooth


--===============7680000125183377053==--

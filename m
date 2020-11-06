Return-Path: <SRS0=OtJ6=EM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400ACC2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Nov 2020 23:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE32020704
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Nov 2020 23:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnMlfYBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgKFXqz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Nov 2020 18:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgKFXqy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Nov 2020 18:46:54 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BA6C0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2020 15:46:54 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id h12so2045970qtc.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2020 15:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=syZoAeGhk0pU7pTwSy00/VHQhG7TIb+pdjtDO8/w7JE=;
        b=SnMlfYBWCnq8cnA8iD/JNTXmRQlioiG1ccWrOdBploM6Wp8dBiCl4cfUIH9NvaScQ5
         dpGgBDIoMh7xPjioh0PZ8cUO2D5YvQbmhWXc4QE5uMwAmTsMyQEOZCkibTl4mw1G7lWh
         UMhWVBOqpzuKintVpDMnHNXX5d4YPH7aeiC1JZcM1JBdxkEVE0hlO5XKGXdQq6yx+Iu1
         yADrixw39gksUGEIcoeFzqveZnano2zUqqEZJwxYHTJRjWlTcq4D8VvX08zdl4rEUlMX
         PgqvaQqRBenXMzh/zJz2DyqSAZcDTlqESFPQhFw6ORn9WlDOC19C6VDwCP3Gjv8Ok9ZD
         SWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=syZoAeGhk0pU7pTwSy00/VHQhG7TIb+pdjtDO8/w7JE=;
        b=DUi32f8HVj/F/n/612VTZmd15R2P3W9tpgtgBGHLL4jb/iePd+k6b/8/qCSCntZJ7a
         deQZ6RFWHLtcqB8eGkW/u21GMTg2a6JU06Y24vSdJmyYaiIOYNVIgbm/Prz29QnQldZt
         Lfejn7fQrIqEGnFIZ6hRS2dZoh5YecUXkLouK03VTITnTUAWnmRA54UbOZD3Qy4b46Vv
         tklVvqcCcwfpdJPhfDA+u24M6G0RJs+RIVBkI5/skswm/gnJ7Svqp5OnUZ+5t1T45R+G
         lNovnVaEAfWtAPp0XctL2c/gXifRzG5X9DltP2SwpK9K7v1i7IapyUYYotZVGcE1xZfR
         hfoQ==
X-Gm-Message-State: AOAM530qLIni3C8UyljZeP9bk+bRZHDGKgZ2v2q0Ppwf/bj1CKN7poGD
        liPJP+HQNaN9FWObqi2qf1U4WsK7fXg=
X-Google-Smtp-Source: ABdhPJwNiMbIi5PR1GaDTvOuZm21np/oKyB3mhILsM+IbyH9tE6d/6j8OCVFNCyXI35+LqBnymu/TA==
X-Received: by 2002:ac8:5988:: with SMTP id e8mr3219462qte.223.1604706412802;
        Fri, 06 Nov 2020 15:46:52 -0800 (PST)
Received: from [172.17.0.2] ([40.65.201.217])
        by smtp.gmail.com with ESMTPSA id k17sm1566451qki.5.2020.11.06.15.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 15:46:52 -0800 (PST)
Message-ID: <5fa5e06c.1c69fb81.fb7eb.aec3@mx.google.com>
Date:   Fri, 06 Nov 2020 15:46:52 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3487856444662349315=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, danielwinkler@google.com
Subject: RE: Bluetooth: Resume advertising after LE connection
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201106151937.1.I8362b4cedb0f34b7a88b8dbd3a62155085e02ea7@changeid>
References: <20201106151937.1.I8362b4cedb0f34b7a88b8dbd3a62155085e02ea7@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3487856444662349315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=379417

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============3487856444662349315==--

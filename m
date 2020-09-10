Return-Path: <SRS0=wtMD=CT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D376BC433E2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 04:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77F49207DE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 04:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8ENxH9E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgIJEsT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Sep 2020 00:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgIJEsC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Sep 2020 00:48:02 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA63C061757
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2020 21:48:00 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id y11so3876590qtn.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2020 21:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=wAuESQ5dCEhkjNiNxWhtQHwcrrqfz0y6AMYdbWMZAJc=;
        b=c8ENxH9EYhzsyv/nSGXofPgfAuTNlnmd+iz1ubdh0qfyWmOWIcUNT4EiUCGYCY9JE5
         O4S6QqZrSPv+fQ3ZZ32ixG6xpwhgu/iGBTv/APIAxXeD5oTKM9RL9TmgIxoI8P3lEQPI
         +Ngbk2psVEtSNnN2o6ty+vEuZaJETOcdtJjI6D+Xtcy5OSU152BLKTU+QehdDLgMoixB
         TNGkPVZhrZkA/JzbcFgfgjUzrLbD33nlP37GZ6HGGS1pBHoFFV7+F702ZrXwAHcZ3mAT
         1mXLAn6G7Uidcp/zQmbjylVYz0yx6kKEdlQ8bNIIOpAwTM08TnZ6Upv3BE82vyS9Xdnd
         UW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=wAuESQ5dCEhkjNiNxWhtQHwcrrqfz0y6AMYdbWMZAJc=;
        b=PTCIqIlWX0Z7XPeQGVrDzwHllPjpHUh6XjuQW5/FWl1ueKe5nq/kvQGUOD7k1/Jgjv
         k6zNX7cftZcQORga4rl1Hadhl410FJ8UHzx5XgsERCeU4WsG+/x+ZPOV5Cenlb6L3T7M
         DY6DYhWs/wRKjtxbGePyl854e1qVAVAmqDZNgKDse3K0V5mN1S/caGlwpjf9t6gZFP3d
         z/lUwxPe7RgNcfmS83sgtM0lUnIqoYUiZzIDS9KpU9fG9qzG2mUX6U3/luygPnM2Xo5l
         P+G0FyTOXU0S1v0EPMapngldZ3Tv9+lULFcU6TxkfLxi1o/y3j1AHae2wtmo0pqnoJ9G
         VI8w==
X-Gm-Message-State: AOAM533AUaE40mx1+v4yua2L26ubdVV1wezYFN72m4i3vsPgaqZbapu3
        Il5lDbnjGpDF5Vzvse3NLeB2yHW/CIb6lg==
X-Google-Smtp-Source: ABdhPJxMvgT1qYaFFqxftvXfledSU8CCMOdRX3EOzRzQ+vAsh0Ebu6zV/fopfFRXrUMh69pXuiOQcg==
X-Received: by 2002:ac8:4d1a:: with SMTP id w26mr6446247qtv.220.1599713279443;
        Wed, 09 Sep 2020 21:47:59 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.25.207])
        by smtp.gmail.com with ESMTPSA id i66sm5140602qkc.63.2020.09.09.21.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 21:47:59 -0700 (PDT)
Message-ID: <5f59afff.1c69fb81.a663e.8e17@mx.google.com>
Date:   Wed, 09 Sep 2020 21:47:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5369202452627928207=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mcchou@chromium.org
Subject: RE: [BlueZ,v2,2/7] PRE-UPSTREAM: adv_monitor: Implement Get functions of Adv monitor manager properties
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200909213423.BlueZ.v2.2.I9960e45d36be3edb5f17de025e7eb8257d3cddef@changeid>
References: <20200909213423.BlueZ.v2.2.I9960e45d36be3edb5f17de025e7eb8257d3cddef@changeid>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5369202452627928207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkgitlint Failed

Outputs:
1: T1 Title exceeds max length (84>72): "PRE-UPSTREAM: adv_monitor: Implement Get functions of Adv monitor manager properties"



---
Regards,
Linux Bluetooth

--===============5369202452627928207==--

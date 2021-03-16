Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB56AC433E6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 14:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7397D65083
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 14:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbhCPOmK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 10:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhCPOll (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 10:41:41 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C1EC06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 07:41:40 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 16so8965323pfn.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 07:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=bskGChDU8ghRX6HxlS7szboa5iqQBzJyQCjoU5iTLAM=;
        b=mKI6ipz7b02w//gB/vf/so2HqDhIr3kHm/3diYHJ1fi/MpuNOtw7oywizQkSEnGBdW
         yzek8MW2PkuRd5GJmlgHOOgxt2lx1hRHZ0i3tGHPzoM8fkXZMjIjSWztraBs+4cLV7dh
         pVWm7fX8gFrYGrWp0VBL3VF44zymFFdzKqtMKF4vWW/j1x+iGijrHZ5dWWxstkbcGI1G
         h17gRJy4VXfzd4pF538d6uj4z5KfYax+ZihSSW1Kr/SxOVwNHrCMvX/Cfs2EdraIToQc
         FZvwwdYCrZKoyP2gKRCdPDtYNxyfcy0Vt4IEBpDWPYGEOypOhndqiwBgLZqhvrdC9VeJ
         am+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=bskGChDU8ghRX6HxlS7szboa5iqQBzJyQCjoU5iTLAM=;
        b=B1zIb0QJfmEgCeZn8btIqZOu7l8I56A/AIPUVtLRE+W4E40fR120mp8nG+1LWAYUNi
         GDwm3tG7p6eEriBppM7zEblqBQjdYjyNa24PM6WLjxb6KWpnHGQENvzAyrGJ5Hme3LZy
         aLPJyrIlj0tKjQqrEIzWjK0cGsyOKEdHqA1AchMkIVD4vbsdLBXPCeVkKsXdUg8DpGiM
         OhvI3fyrwHtSAwEBDa60gjR+5fxozw+1H3hIDNqUuhO3PIbNkVVkowXEl/FQelHxMhqY
         evfFOAeIq0DASU9aW0PpupKMK02jmBlbuZMyTkAlbJmrble/oW1rgZu7u1pW7CyKbCPi
         8rdw==
X-Gm-Message-State: AOAM532po7U4+eaQwr0m7LKTMdhkXL2hNE7/bKoUosO70FjWVPuE5ZOq
        gP7lUDijewma1OvRfGWBmZjWypv8Edo=
X-Google-Smtp-Source: ABdhPJxmoo8plB+9W8Bn5lU2gYneOZ33n2tLoJRIbQ9j9/NkWm55RsrAjs0hhu8IuUFuHVXAtWLygw==
X-Received: by 2002:a63:778e:: with SMTP id s136mr4261771pgc.433.1615905700009;
        Tue, 16 Mar 2021 07:41:40 -0700 (PDT)
Received: from localhost.localdomain (76-14-108-251.rk.wavecable.com. [76.14.108.251])
        by smtp.gmail.com with ESMTPSA id u2sm3209289pjy.14.2021.03.16.07.41.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Mar 2021 07:41:39 -0700 (PDT)
From:   cdwhite13@gmail.com
To:     linux-bluetooth@vger.kernel.org
Cc:     chris.white@dolby.com, kpare@dolby.com
Subject: [PATCH BlueZ 0/1] emulator: Add Create BIG command in emulator
Date:   Tue, 16 Mar 2021 07:41:35 -0700
Message-Id: <20210316144136.410-1-cdwhite13@gmail.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
Reply-To: chris.white@dolby.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Chris White <chris.white@dolby.com>

This patch adds support to the emulator for the Create BIG HCI command
needed for using the emulator for LE Audio broadcast development. See
https://github.com/bluez/bluez-sig/issues/3.

kpare (1):
  emulator: Add Create BIG command in emulator

 emulator/btdev.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

-- 
2.21.0 (Apple Git-122.2)


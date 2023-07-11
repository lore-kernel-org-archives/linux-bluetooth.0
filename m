Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665FAEB64DC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Jul 2023 13:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjGKNlW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Jul 2023 09:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjGKNlW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Jul 2023 09:41:22 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0121310DD
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jul 2023 06:41:20 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-765a4ff26cdso525231085a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jul 2023 06:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689082880; x=1691674880;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RdKFCwAxpz57GYDns9Ccs7rXCdIjVDNOgihXHYKis0g=;
        b=BcbTCVOH5YAV53/bcIRnWqU7nLhyDhdCJVOP4VHCmDICzPUdlHk6kDBqfPvYBcYKDd
         Zc4qKvhQSdlhd+NxnzENkubFGUgjFMi/XA6m1AbMZB+uwJ3v+ka5C2PT8IL7YOJi0J2I
         ZFODEolimyK++7kwwxWGnPyijo953/t4do6YSNZKgLCpa2xFTmmTa73V+abxpn9punHb
         qfazRM9DaLh3gh1pA5tqshJTj9Qmko2x1/lF9N2ShL/gsNc8SArs8pgaig3sIu2rs+WF
         1sEyesa+gAjhvdMveI/2+EZOZFDtR3q7JWbizgqxr/NxUIPDMLsw3evFBX5Pei45VGwK
         52/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689082880; x=1691674880;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RdKFCwAxpz57GYDns9Ccs7rXCdIjVDNOgihXHYKis0g=;
        b=SOoj4zdzsSqpoHj8zTPdIwEYBW7zjmY0i/DShQaZF5dLZ4I4Yfj2fKgcLkix6CEmHQ
         2vgMRqLermDjJMa4J2KvhpdQdv1VoyKzh1prsZRslBWKnYSTvLfVy22i/hlcKcKvA9OU
         KWifLbee2fYYPMOVLcMulX3OoGPxoNsGVUDQO6AKnN0cuxL/2TOyODDhLIHmdL3EgP8i
         MDUzxziyPTx4lvW3Jl9AFR/PvsDoljZqeM2oDYILCgMfP6UhWKvd/mLvICAUx7aY6GES
         vkoOG+DrxsczAaA8APOLrd2qoX4NM+1jYRR4B9uGjL7p8Duvbr5DSJ2VZO3BhudEhapp
         EyxQ==
X-Gm-Message-State: ABy/qLbGGJu/zzlzrHNtFX3k1Hbtcw8DzYObCiMGjxC0d6lpKwtCWqu9
        7zUrHITl3CMav64AXRe+l7Rmio1lC24=
X-Google-Smtp-Source: APBJJlENih8qoJHwIgpa67xlifMgx5/UKbWlQuCi4vvDEAHlvSQnk0yeQtHngVWvKgSDLa+wjIzlYw==
X-Received: by 2002:a05:620a:25c8:b0:767:3d1a:3a06 with SMTP id y8-20020a05620a25c800b007673d1a3a06mr15376463qko.17.1689082879864;
        Tue, 11 Jul 2023 06:41:19 -0700 (PDT)
Received: from [172.17.0.2] ([20.39.61.53])
        by smtp.gmail.com with ESMTPSA id g11-20020a05620a108b00b00767c76b2c38sm988533qkk.83.2023.07.11.06.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 06:41:19 -0700 (PDT)
Message-ID: <64ad5bff.050a0220.fd102.2b4b@mx.google.com>
Date:   Tue, 11 Jul 2023 06:41:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8554566284910995039=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, code@siddh.me
Subject: RE: Bluetooth: hci_conn: return ERR_PTR instead of NULL when there is no link
In-Reply-To: <20230711131353.40500-1-code@siddh.me>
References: <20230711131353.40500-1-code@siddh.me>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8554566284910995039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_conn.c:2254
error: net/bluetooth/hci_conn.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8554566284910995039==--

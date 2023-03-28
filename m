Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22134C76196
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Mar 2023 05:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjC1F1X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Mar 2023 01:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjC1F1V (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Mar 2023 01:27:21 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A37A3
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Mar 2023 22:27:19 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id cn12so44867359edb.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Mar 2023 22:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1679981238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDzNquyv5SldN3Klew58SF4E5FMQYLZxi2vqCIrjsM0=;
        b=HbfFLGAUg4E56W0nlxr2iVt+0DuBcbamaHsxM/xZNy7SmICOcdg0oAa39JDaK7ZEgR
         8HPC7spwLXX7TBpg7waQxxw0u5l8BBumSU0qGUuf5UeOoJMhQz3MSBqcPy9bWDV+r81F
         5sWx2RINNDGs3aapyuAbBHGAOmxuq9AapPPmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679981238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDzNquyv5SldN3Klew58SF4E5FMQYLZxi2vqCIrjsM0=;
        b=vw4JU8ehHTYOQSqVnW6etStArPUriPnT+/M3gj+MkfKKnpKNk9tHSHtlpsRll+wmxr
         eZvltd3P/8z4qyUuhX6vtIKBSccia9y4uJxhjw8JulIxelq9q87xJ6sHPXcvBJt9BCOV
         jUjNGxDsFcln9qVEc22m5zyOCWjluvmtOE0+wxk4uogwLR4sN471FnvWO3z6qIdxEIZ6
         /LZDmCm/LftumnI8D9TCN+k7i3/wIoUbkDlSh6c2AHtenHMKu7qDP9Vui/t4sECpkZTp
         zEVSKLoqIUzr9Ss9Tw3Hc522OmjHiWRiZOqkEKhtGv16Q7dACxZx3+3gg0/LoUpxrdbl
         P5uQ==
X-Gm-Message-State: AAQBX9eD5zST92qsN6xG4voq0Bj14LtUvBMr/qgGXb2P18GwJCaMhfcF
        dfCEHSHZTFVdDQDcEsncPYaCBG5+48QqJfJ7Et0=
X-Google-Smtp-Source: AKy350YBx3VNPMFmYSelS8rh+s1KKMFUG7it6FGrNtwqZTP6E5Ssld82alJHYPAvyldsrSsm6zF4FA==
X-Received: by 2002:aa7:cd84:0:b0:4fd:2b04:6e8b with SMTP id x4-20020aa7cd84000000b004fd2b046e8bmr14883268edv.29.1679981237746;
        Mon, 27 Mar 2023 22:27:17 -0700 (PDT)
Received: from smi-ubuntu.sueba ([2a01:390:0:101:1167:5b7f:c0f0:e6ec])
        by smtp.gmail.com with ESMTPSA id b44-20020a509f2f000000b004c09527d62dsm15427109edf.30.2023.03.27.22.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 22:27:17 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 0/2] l2test: Enable hex input for PSM
Date:   Tue, 28 Mar 2023 07:26:17 +0200
Message-Id: <20230328052619.1357253-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CABBYNZLyQkvU1uzV8WF9n54FC43OvFzNne6XJcAUj2yCB8dVbw@mail.gmail.com>
References: <CABBYNZLyQkvU1uzV8WF9n54FC43OvFzNne6XJcAUj2yCB8dVbw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks for review. I'm sending updated patches.

Simon Mikuda (2):
  l2test: Enable hex input for PSM
  l2test: Fix setting mode for BR/EDR l2cap socket

 lib/l2cap.h    |  2 ++
 tools/l2test.c | 24 ++++++++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

-- 
2.34.1


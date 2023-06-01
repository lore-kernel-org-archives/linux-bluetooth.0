Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C9EC77B7A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Jun 2023 03:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjFADFV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 May 2023 23:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjFADEF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 May 2023 23:04:05 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140FA10D4
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 May 2023 20:03:27 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3f6affdb6ddso3003801cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 May 2023 20:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685588606; x=1688180606;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m+HPGohiWM3MX5o5eg2+eVyHGyWHvkSQR5kZIuCOOaA=;
        b=oIIoLsYxS24yNbBX6yHibUa1o9aLOIpFHtqfjvFaOFosLSudCAGaIqLYkzi8s7FeXX
         PfgULyC12C020dDHLp1ruuL/ntVcm30Qjfy4mRtbgN4/d/Dg17dhHw8QlbMQHpcNxpP8
         1MvwtF6cdm0DP2/Ry/KnqIF+U0NgX3BEfyLe+dRwMqx/8oL1GfrWmzyLzdrWdmVo2Kr7
         MuPBcYkH8MSa0lIljBLYZ2rTUWq4HQ6pdHi6IUVdDaaMVjzr348C4z0pZBoJtfSYsQsr
         uZVOgJm85wNAxXMl7jtncAAmKSoe/Trx5kLFwzq9NgK/kklxy+pX6tQtd725757LJFo7
         8rKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685588606; x=1688180606;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m+HPGohiWM3MX5o5eg2+eVyHGyWHvkSQR5kZIuCOOaA=;
        b=deQwSpsG8ghXZp0TToL+hTvCI8Mbz8N/6bv8sVbifsOYdB/5r0rUYlTVyDQtjMNjN0
         AAdjks44/4q0nHcxnbPpddA6cXvPi5iYDogNxR0sI7HNW6Ue85XQNcc+nsur/X7H+6Fu
         953QndQZTxbfInD6MrOk4GsKq8yJpi1KcF6cqST9vl4OmNXBRnRCrI/cDk87uUtgqM21
         dA5njQ8teVpNLuIWcfoHcSNVd/dLjFfnDlqGAzA0Mo8JumBHV+Rc/FIc/hJlKh1FcbQi
         DbDZP16BzAwj6Z7/CZd15bZ9PQqFxJ9M9JDBZy8XTGc/fwWwZERL3pzXv8ArNDQ/b6+Y
         5aew==
X-Gm-Message-State: AC+VfDwYwUlNiGaoUdr8LKToA9YIJVotg5xHTEzDilSAzRFbLKA2r8nz
        gUX2ksAtETeEnip6L0qAyCdn3f6VNi4=
X-Google-Smtp-Source: ACHHUZ7iejDO0Ilw1ETyHcf2cdgeYJ5ChgvthvDxqf0Q1ILA+K/PBSD+miiEZuuqxiT3n9aP6lZ/bg==
X-Received: by 2002:ad4:5fc9:0:b0:5ef:8c79:fe92 with SMTP id jq9-20020ad45fc9000000b005ef8c79fe92mr11364876qvb.3.1685588606017;
        Wed, 31 May 2023 20:03:26 -0700 (PDT)
Received: from [172.17.0.2] ([52.226.126.232])
        by smtp.gmail.com with ESMTPSA id fc19-20020ad44f33000000b006262de12a8csm3183663qvb.65.2023.05.31.20.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 20:03:25 -0700 (PDT)
Message-ID: <64780a7d.d40a0220.ea23f.cabd@mx.google.com>
Date:   Wed, 31 May 2023 20:03:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6543141363251374183=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yinghsu@chromium.org
Subject: RE: [v6] Bluetooth: Fix l2cap_disconnect_req deadlock
In-Reply-To: <20230601023835.1117866-1-yinghsu@chromium.org>
References: <20230601023835.1117866-1-yinghsu@chromium.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6543141363251374183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/l2cap_core.c:4634
error: net/bluetooth/l2cap_core.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6543141363251374183==--

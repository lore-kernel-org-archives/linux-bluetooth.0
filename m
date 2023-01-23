Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4550EC25B50
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Jan 2023 22:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbjAWWzN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Jan 2023 17:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjAWWzM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Jan 2023 17:55:12 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A55911147
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jan 2023 14:55:11 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id j9so11705979qtv.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jan 2023 14:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Vz4Kce7oxw/Mqk0j1gzIIrbFNpD3kKiZhDEk8Pye5NM=;
        b=cYLirras/VQ5V/Ilz9wa+Mn/gZLc+2y5uNYFR/A1gjsM8igx9simcDrqSeHDAdpHuh
         Lt8/GR5EEa6KxUVrvZKz5fHDNaKIPNNUtRKDG42Eyl431UJVTYYdx2h7ZEsLLAvEazyZ
         PwQ2ECOqpIMOijqVfDJgCt/Q+r03YXUf9l7znYkP0YwBuxBl6zQ17ZhHEoRFEYxVAOGd
         UPcK+FXa5dxKTb+7g3ma/C9S5x+BSSszu2mtxIJidIlDOq0oQ9t/ZsBt0SVYfmB8Pdjq
         v02z27wkw52Hf/fY4CnRznfaARhl2luJyRH+EDsow/DW3dObzNMfyUoQPlPBpF24hZj/
         Zoqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vz4Kce7oxw/Mqk0j1gzIIrbFNpD3kKiZhDEk8Pye5NM=;
        b=cVCzbFL2MjNAYmhQIldklOPxEW4BuJ7M2fZYCifC8bv//2+GJmj6Srnu2Zy6mdczY7
         jM80q9ilpUBMdGCCmSsWGWYvSDyqON90TsHgM9+OQQbVLQu81KRfPQ1H3mn8968akQfo
         +8wFva/KOpJaFgFvUA+dgH/2yXsQu304vc3FGMpDljBGug/4tNrvfHUQc31a5vUG1CS8
         FWZ9pHdOztB1hcjv6RwdzC01F8KDqA5zMVuycUtzgHdQQuhTBpPZ9Xr2BAiaQuZLPb70
         3eigJtEvNCELmMdQQO4BhgNEdx5l5UzLp9ISbz5xmgbzVg2Skb4dKKyy0YaEBtsdHJDh
         m0vQ==
X-Gm-Message-State: AFqh2kryfR5i/pOWNlyzzLyDcep46nAvzwUIyKhr2NDdpz11bQD8Gjzv
        jLz4nzcUE7qNNml3Jo6zCpkcwbpIp2DGtA==
X-Google-Smtp-Source: AMrXdXvyJKQn0rWIy1ahGeiK9nByzplvaPt35ILG08zgZmr36mdylSn+tlGl+av9l3V5S1rVRDvBlA==
X-Received: by 2002:a05:622a:1e1b:b0:3b4:a6af:a2f2 with SMTP id br27-20020a05622a1e1b00b003b4a6afa2f2mr36317202qtb.34.1674514510412;
        Mon, 23 Jan 2023 14:55:10 -0800 (PST)
Received: from [172.17.0.2] ([52.226.82.113])
        by smtp.gmail.com with ESMTPSA id d136-20020ae9ef8e000000b0070905e2674dsm315157qkg.76.2023.01.23.14.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 14:55:09 -0800 (PST)
Message-ID: <63cf104d.e90a0220.b219e.1269@mx.google.com>
Date:   Mon, 23 Jan 2023 14:55:09 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7197361267902060890=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] shared/bap: Fix not detaching streams when PAC is removed
In-Reply-To: <20230123213212.3187747-1-luiz.dentz@gmail.com>
References: <20230123213212.3187747-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7197361267902060890==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=714905

---Test result---

Test Summary:
CheckPatch                    PASS      1.04 seconds
GitLint                       PASS      0.69 seconds
BuildEll                      PASS      30.05 seconds
BluezMake                     PASS      950.84 seconds
MakeCheck                     PASS      12.74 seconds
MakeDistcheck                 PASS      165.14 seconds
CheckValgrind                 PASS      272.77 seconds
CheckSmatch                   PASS      367.49 seconds
bluezmakeextell               PASS      112.71 seconds
IncrementalBuild              PASS      1569.53 seconds
ScanBuild                     PASS      1132.55 seconds



---
Regards,
Linux Bluetooth


--===============7197361267902060890==--

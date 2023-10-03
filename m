Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2ACE8FDBE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Oct 2023 22:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjJCWeY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Oct 2023 18:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjJCWeX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Oct 2023 18:34:23 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C984AF
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 15:34:20 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bf55a81eeaso11552405ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Oct 2023 15:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696372460; x=1696977260; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N2ewrZ10SRCqecrOwA6CYdTUnIw7YhqMnkOaLdc9g6g=;
        b=mvy0nrPc1xqB2VRf05Ye2xawR7kKQHatyvEcio+u3o4CYZd2dIoldCKj4hcopNN121
         zVRefyrAh4WhUkRYGrS4Hi8/NygVVQ13Hp9/DlWRzAsZckPt/FntrfCTILPh4/d198HP
         4sxzti/gBnxrQy4aPPsCLFtKGUr0vncwAfEYfTRMGEozItoRoGUIqhuaZC/o70gZ8SVa
         HBAxotn3JDdLFyngnOikJLY9fNjlJYv6u9WxtAFzNQXDywK1BXjID2n+oDLxmQhdrULP
         vA8NM09X3+M9XzSKtFejJKnTkJQ1k6o2J+SeQWzFB9hm4th2pyfHMyXrPhsSAVW6ixb9
         dZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696372460; x=1696977260;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N2ewrZ10SRCqecrOwA6CYdTUnIw7YhqMnkOaLdc9g6g=;
        b=JqDg71c2c240dtyugtaxzejusKmHYIYuvKf2vx+yUl595jm7uoKqr0j2CeQEj6FAKs
         Ve03/KxpIGMrzJLsWgI6rwOTOSUILN+HuGG3KDNNZDm88me6f7P7/nzHKxmfZ+Xk86ql
         +pvjEd17nzrROlKrql3TvM/K027rr7dduwmXf06z2rGm0aF/S7q+Fsx65RKoVzwnTGh6
         CoKUGXoQ+2RksGhww3tlHXJND3rqCb6JX5SXkNLaODnpCwlJoCHyV32Te4VYH6MwCy2a
         QEnXgYbk9JZdSq6wmPjKfOT9K6GS9Znn6sC9heEN1dXp4TZLQI92YW47wS4NQZFssakr
         jczw==
X-Gm-Message-State: AOJu0Yw3CcTK7ILR6bXrrmEDFOyKySIfeZnoCouVKr3nWTRoOrQotSkE
        s7UPZHDZfQf0MYoBcrgHOOeZ0WjD0l4=
X-Google-Smtp-Source: AGHT+IHFd8C2Vaef36G5oZcW3/o5BCD/qSPcIKmXiHrfoC3X0pIunqrWg0ECFp/5SQ8X6fTjDh6iYA==
X-Received: by 2002:a17:902:82ca:b0:1c3:83e2:d0c6 with SMTP id u10-20020a17090282ca00b001c383e2d0c6mr885892plz.52.1696372459677;
        Tue, 03 Oct 2023 15:34:19 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.76.145])
        by smtp.gmail.com with ESMTPSA id l19-20020a170902f69300b001c465bedaccsm2149321plg.83.2023.10.03.15.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 15:34:18 -0700 (PDT)
Message-ID: <651c96ea.170a0220.e70b2.6969@mx.google.com>
Date:   Tue, 03 Oct 2023 15:34:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1953544381701475068=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] client/mgmt: Fix registering pairing callbacks
In-Reply-To: <20231003211442.3348427-1-luiz.dentz@gmail.com>
References: <20231003211442.3348427-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1953544381701475068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=789713

---Test result---

Test Summary:
CheckPatch                    PASS      0.38 seconds
GitLint                       PASS      0.26 seconds
BuildEll                      PASS      27.84 seconds
BluezMake                     PASS      783.27 seconds
MakeCheck                     PASS      12.19 seconds
MakeDistcheck                 PASS      160.83 seconds
CheckValgrind                 PASS      255.32 seconds
CheckSmatch                   PASS      348.54 seconds
bluezmakeextell               PASS      106.02 seconds
IncrementalBuild              PASS      659.30 seconds
ScanBuild                     PASS      1041.71 seconds



---
Regards,
Linux Bluetooth


--===============1953544381701475068==--

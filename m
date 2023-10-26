Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC84EC25B67
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Oct 2023 16:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjJZQhl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Oct 2023 12:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjJZQhk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Oct 2023 12:37:40 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3687E1A2
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Oct 2023 09:37:39 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6ce2b6b3cb6so695502a34.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Oct 2023 09:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698338258; x=1698943058; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tGrjrElQV7Dk5QEzKRkvZ+dutrLbRxvlPxaMkip3zGs=;
        b=TNNKe6VcWyg+5+iytHSbrBV5F5AOewmPjFIY1JHiPLpOk5DQbtw7igZ3oNvd2jRje7
         JRs9Y767gM/pkywGJ30PYCyzGYi9tNKzEYyXPTykIY3IYFUKJsxhrnRybECT903EuR90
         cmtMJFoNMDh5/mfQnzdZf2U81tK4GqanWTHXOCTVO9Gu08WaVtziYC/OjgbyOYXYH70h
         +j4YGeqc433Cw11UhjhOt7Jh/0AFrfmiiWKBP68UVLJpsvBVOJVYv11c9B0ko3vQjnyS
         3uy6oAiU2WrLAiVc0iDfHF94ySXUPkq98NppXRr4zzXHe8LTnHONl0UFITgylx40sAJH
         LI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698338258; x=1698943058;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tGrjrElQV7Dk5QEzKRkvZ+dutrLbRxvlPxaMkip3zGs=;
        b=J3VohFQo9B6USWzh4azgNEKsRNHdFqyG6jaLFR8cBkDr5t/rRo6TMW3sNF2rKx4F8R
         Wa6IVRozz2z2wfxU+ZSfaZKc25EBijQHKPpQXspq6zIwWYJ8B0b7UAtFXGkpcmYhLoNl
         0arpm/lE9wI1kfeRI6ZZizd+EMsSd5+e0PtK8ihm5IpESgek2sVhNfumJpso+X/sYFmY
         m/CXDbtxBD82r7oTpiL08D5wDqJothwseB9hT99Klic4CX8UqBSMffBk8oUkyiZPGd2H
         0DC5k1N/d4FJHiaktnSSm3+bRB3BZ4rsmsWv/vUfZcCUaq7PPuFrAhsKeuySecA1Ihvy
         EDMg==
X-Gm-Message-State: AOJu0YyfZc9Lq6xyMwrx/Ba8pJeRFgrC2pQ/GP+CDURqzpm6ykgjuhbw
        PUdJbX2X0MLBGVJqCKDZicN725fc4yQ=
X-Google-Smtp-Source: AGHT+IE24AEqio6EP2K5M+HWtDr3XOZqOJwqRla1BcoNcb9MC7gmXRmfTqgkWfxmyWjQhbBem1RJ0w==
X-Received: by 2002:a05:6870:d889:b0:1d5:8d8b:dcc with SMTP id oe9-20020a056870d88900b001d58d8b0dccmr115537oac.18.1698338258313;
        Thu, 26 Oct 2023 09:37:38 -0700 (PDT)
Received: from [172.17.0.2] ([13.66.73.144])
        by smtp.gmail.com with ESMTPSA id v36-20020a056870956400b001e12f685592sm3098678oal.13.2023.10.26.09.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 09:37:37 -0700 (PDT)
Message-ID: <653a95d1.050a0220.90d49.3955@mx.google.com>
Date:   Thu, 26 Oct 2023 09:37:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5786874189328748707=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, juerg.haefliger@canonical.com
Subject: RE: bluez: btmgmt --index broken
In-Reply-To: <20231026182426.032a776d@gollum>
References: <20231026182426.032a776d@gollum>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5786874189328748707==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: src/shared/shell.c:1128
error: src/shared/shell.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5786874189328748707==--

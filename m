Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9E2C83F11
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Aug 2023 00:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbjH2A5F (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Aug 2023 20:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbjH2A4o (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Aug 2023 20:56:44 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCA8132
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Aug 2023 17:56:41 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-64b98479a66so22636606d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Aug 2023 17:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693270601; x=1693875401;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p62ART7/nUANkM0mxvG0haBZP9bY7eV00HRd5mM8lBs=;
        b=rhjCSiEXMy0G7WWCcF/mKl+y7hNbDQxc19DD4RHK5ycCJPcHJZE3OJRg0vKjC281Is
         avKb75ZYblM1NJLfYufczgX+RAK6dqvxsivUoeHWqMhtbVxHSWx+ihpUVBN8AL4egsZx
         5zUAg6BgIxnx50O+WIyoY6xn1cbdL29qIrcBB/Sz3sywrKFrWRl0+y8HpqvZezlrqj0Q
         SKm+7PFXMqJYvCe6vG9c6xKXilJTMJeRXWPmKy4cyRT5oQAvQ3T7TBaJ1bIa12VHSNOE
         OCipiBCrNXgnx6gPvf/ehB0VWeqwOQDh1zZZuToSU3cBcakbPrORMOTp0k4JsFxETTZM
         7dQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693270601; x=1693875401;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p62ART7/nUANkM0mxvG0haBZP9bY7eV00HRd5mM8lBs=;
        b=gzGJZzBVe3sFRZbhfkN/ZLklZzt4NcKC8bKOhPet1f6IE42zw0YYpneRdF95UmDj9z
         qIEJrZZnBbi5r8tKs4ePh36LBZe9+OB0uiyaTLwnwIy5UgqMsIPpQrpxkG9cNhrZ1c9/
         Qotf3vvI+igQLLUNeujhaq6eZzdrwU9uABs3ibUc8u2c/STSYVBp1zbFt8jVHTTd6wCc
         kmUzSKUXVAE+rBqi9sV9PyVG874PhNyGtVBsgt9uRbf2d0uCyFCB0GgqlJcpzcrWW/g2
         4YBDKXkL8jd9IvUM9wbwOJCaZbqdc20V0iLDX9t30UoCh5Didb1IKi7Cbjrdr3b329SL
         +gDA==
X-Gm-Message-State: AOJu0YytgLOehoJdcCum7vXEVwHdOSW4MMn2PVwr6SxfhdFN7i3/ACIX
        E6vKe6pIw0Y3VpndHl9u6x6PE1jrtac=
X-Google-Smtp-Source: AGHT+IFKlMD4GzpumOFsWQrpMWacSre7cjoRXtZYPS8/B1Gzlbn5OuQ8/95VGsltdWghTBDFbc8FHw==
X-Received: by 2002:a0c:e24c:0:b0:651:6a97:333f with SMTP id x12-20020a0ce24c000000b006516a97333fmr2644412qvl.19.1693270600752;
        Mon, 28 Aug 2023 17:56:40 -0700 (PDT)
Received: from [172.17.0.2] ([20.185.155.208])
        by smtp.gmail.com with ESMTPSA id x18-20020a0ce0d2000000b0064f59ca89basm2975145qvk.45.2023.08.28.17.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 17:56:40 -0700 (PDT)
Message-ID: <64ed4248.0c0a0220.e72a7.a9ca@mx.google.com>
Date:   Mon, 28 Aug 2023 17:56:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3417206456313442168=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] media-api: Make QoS a single property
In-Reply-To: <20230828233239.634106-1-luiz.dentz@gmail.com>
References: <20230828233239.634106-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3417206456313442168==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=780071

---Test result---

Test Summary:
CheckPatch                    PASS      0.51 seconds
GitLint                       PASS      0.37 seconds
BuildEll                      PASS      27.31 seconds
BluezMake                     PASS      871.72 seconds
MakeCheck                     PASS      11.96 seconds
MakeDistcheck                 PASS      156.71 seconds
CheckValgrind                 PASS      257.43 seconds
CheckSmatch                   PASS      344.99 seconds
bluezmakeextell               PASS      104.42 seconds
IncrementalBuild              PASS      706.54 seconds
ScanBuild                     PASS      1062.82 seconds



---
Regards,
Linux Bluetooth


--===============3417206456313442168==--

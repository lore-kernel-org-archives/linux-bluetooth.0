Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6313E95A61
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Oct 2023 10:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343733AbjJGKM2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 7 Oct 2023 06:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbjJGKM1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 7 Oct 2023 06:12:27 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E9692
        for <linux-bluetooth@vger.kernel.org>; Sat,  7 Oct 2023 03:12:26 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6c7bbfb7a73so1972354a34.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 07 Oct 2023 03:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696673546; x=1697278346; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K5iM9N2DAv9GqnRngNRoNpQ/h3/1GnSmZJ17Mp+sf2w=;
        b=mHK8AFguIkz+p/QOZd0CydnaBqBUoKFJI7nZqVnVjIbfLxaB5bNenGT86tyMliAC/n
         xuzv3pPHSsdYuB0oGKH7zJMM1o6Ms7w4GRNx7TzW0t6RuhASEH+hCQhI+hqmD8KiD0sj
         4sIVtBAikrsle4yez9CPruHmlyEs/6OmikfX3iWuXCL47nPQMxTeknULZeSum/uy3wLm
         1sq20BR0rkkk83ZJRiacRyfOX8ZM2lKx/iD80FMtkQcTO7xt3i2fluYniQQdych5X+qj
         A9At/wUfmE99+jnfCnQkRCDl5/m/xyvQ6iRTB3EEUHlbLRIcxHNbUjVijswfZLU+pUbg
         YepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696673546; x=1697278346;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K5iM9N2DAv9GqnRngNRoNpQ/h3/1GnSmZJ17Mp+sf2w=;
        b=lL9zBD6wSrH5Et62O4O9Ruqpfkss47f3kAchP54DJ3WWY67eJlg4/vZ/70sj6GCLFz
         u6qYjBZz5cMi7HdJxxISKTTBphQ23MXLdgR+RFU9u414oihe0Mb0/jRRG8vByE358zEq
         EJPXsn0CT6y5Z7L1uWgNNKf0xwGaZ8W7zEVIg8Y68KA0/g1OOxnuwtiDOrornDMxBd0o
         vaKl+BLZRboIxl6gw+jOymzqaDBTjX8NbSwWqHchiz0bzdNinw4FQliveCCMkscRU6t0
         kAnsO5C8a40sjnoFmBbGryA40SPKlLPNF3zDpkzrZq4XESbLqp50uNsY49lgpjccgVW4
         pM9g==
X-Gm-Message-State: AOJu0YxitYlInf9VSDkViGTr3Aq4czN3s1UZqiUbQppR1u8zVLa/f7qL
        JnLfxs3klBcSG2pYBLLYpVXiGvVeRLs=
X-Google-Smtp-Source: AGHT+IF7LducNA8yudGCO80wLGqeEa6wbRSnkOgAlIqg/ir7EWe8tOO7Hx3diWEWSFWFAFDGZ78bag==
X-Received: by 2002:a05:6830:1d6c:b0:6b9:9f84:dc8b with SMTP id l12-20020a0568301d6c00b006b99f84dc8bmr10300941oti.19.1696673545644;
        Sat, 07 Oct 2023 03:12:25 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.173.123])
        by smtp.gmail.com with ESMTPSA id w19-20020a9d6753000000b006c480563197sm868626otm.26.2023.10.07.03.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 03:12:25 -0700 (PDT)
Message-ID: <65212f09.9d0a0220.33713.590c@mx.google.com>
Date:   Sat, 07 Oct 2023 03:12:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8294532496178716783=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, william.xuanziyang@huawei.com
Subject: RE: Bluetooth: Fix UAF for hci_chan
In-Reply-To: <20231007093521.2404844-1-william.xuanziyang@huawei.com>
References: <20231007093521.2404844-1-william.xuanziyang@huawei.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8294532496178716783==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: include/net/bluetooth/hci_core.h:350
error: include/net/bluetooth/hci_core.h: patch does not apply
error: patch failed: net/bluetooth/hci_core.c:2786
error: net/bluetooth/hci_core.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8294532496178716783==--

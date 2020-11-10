Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993E5C388F7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 08:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3188720780
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 08:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZL17sMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgKJIqo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Nov 2020 03:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgKJIqo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Nov 2020 03:46:44 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD21C0613CF
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 00:46:44 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id n129so13016199iod.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 00:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Csd+m5HsJcGMllXNC7thQcEsc+NBW1HHs8rOS2FXWfI=;
        b=oZL17sMAvUCgvJ8kU/WxmKOfauvgHs+Fg7k/quJhrOML05WZQc5nbR1Kz8PxyUq9SN
         SXOLyLthVEsza29vsmYwVJDlrYZWXN+Di/0TcSaej0HNr5JQsUb7WSiwA/VKOlJgpX9M
         Fx2KcPYmqz7/rnfBI/cv2pbkAEAR/tXWS77aMGk0T93/QXBLi0tX6gMREJy9HMKLgG8j
         o2Jd/nYdvV/f8yED3BfoaXT0tqq0lo7RqXTtwuKc0PXUtIgpAGojRMk7MOUL/+wX/oEK
         88XwUp543Yzgu3kJlEnp+98102Go3EoK1JlZlv6sD9PT5TUmLos0yWkKIgi4NoQmMAC7
         Lz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Csd+m5HsJcGMllXNC7thQcEsc+NBW1HHs8rOS2FXWfI=;
        b=UQWa4pqFdwangawN9ycdCXhNbTatc0tI77Iy/2i1LJfmn4tbatt5aVVXbLqQBVHL0f
         R2V7xR41Fxs60RoU5GfyqIO5tcQy7ad47ymqsnBiY7VeebzNplcSS2jnqMFBpDWVjhPy
         fXjwJDFDX75HrGnk0h1MswHU7W0mG66x7dCECVM1iAPnV1buJL8G6NpOmGawZDieYh4t
         8YESm2V8dvng7lMNtG2mKL0XPxmKlil+WMFtNndD6KxcRJkxoXk4FDaOR0f7ex+JA276
         ExVTi0LgswA3HErEfz1bSnZ0MX6jRzk2+vVoqCz86IW3vot4Xjr7aF869thCF/uDIA7k
         MpQg==
X-Gm-Message-State: AOAM533/Zo0QZ1R/01KPC/0odmr4ngid+2cQX/4KfW/Nq4SLPC8SQb7r
        4bORkeUDh8kEiMpDD6J0A/Ie6Wbll2U=
X-Google-Smtp-Source: ABdhPJw6h6ZtdoinhcOxo5XLDvQazYZbiRHzMizjx85P4IljPzgJyrJWuEAoB/hiQLMuwX8lSKcsAA==
X-Received: by 2002:a05:6602:2d49:: with SMTP id d9mr12937140iow.39.1604998003656;
        Tue, 10 Nov 2020 00:46:43 -0800 (PST)
Received: from [172.17.0.2] ([40.70.247.128])
        by smtp.gmail.com with ESMTPSA id e4sm8306112ils.75.2020.11.10.00.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 00:46:43 -0800 (PST)
Message-ID: <5faa5373.1c69fb81.c638b.fab4@mx.google.com>
Date:   Tue, 10 Nov 2020 00:46:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6526232405211076200=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, julian@pidancet.net
Subject: RE: [v2] Bluetooth: btusb: Add support for 1358:c123 Realtek 8822CE device
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201109164722.23501-1-julian@pidancet.net>
References: <20201109164722.23501-1-julian@pidancet.net>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6526232405211076200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=380475

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
Bluetooth: btusb: Add support for 1358:c123 Realtek 8822CE device
WARNING: 'equiped' may be misspelled - perhaps 'equipped'?
#8: 
are equiped with a RTL8822CE chip using the 1358:c123 USB identifiers.

total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] Bluetooth: btusb: Add support for 1358:c123 Realtek 8822CE" has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============6526232405211076200==--

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A65C43334
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jun 2022 18:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344861AbiFMSoZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347827AbiFMSoH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jun 2022 14:44:07 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AE8DE331
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 08:18:13 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id e24so5949495pjt.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 08:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=0f2HQ5QyzTAw5GHRuNhK7+HuO9hgcAvoxf3F82iNyjI=;
        b=RVN2yFoNX9gMS1eXqOXXLqC8CNsA+Fw601cxeZ9lgFTL194v5/nIi4lysCQlNRCqxK
         03AGsI+Y4dG/D86JRp4FzserRY5LBue9H7jmHfbKhnjBBnzVRsqRKlxM3rkziXCApvT2
         e7Nv71nyyJxQASqIp1rQA2BojvGWoNka43Mu5ROHIT9QbEqR9UddMzYhcjmbV4A3NoAn
         Pi6Fka6p8933LjM2em20ahyyeYd2/WsOHsRzcyxynMv7/5qVArvJdE9XW/qGkztUSJfv
         Le0ybxwQewNUlkisNKbq85BiizUe47vKEZwj3nH3Irlg5MJs+QjyCpgGRBFma6RdEWEk
         lp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=0f2HQ5QyzTAw5GHRuNhK7+HuO9hgcAvoxf3F82iNyjI=;
        b=d5owYGo4bhOuHxr2QcAEmIFDsQVDZFBVDZ9MZOx5TeI6dAZiQbVjqfToveSHGGyooc
         z1OxTfkAGc6g/DtUiIg9wXUrcdNytNlKe6ZEsYZU+umNMNbOitq4UF4vs8ZKb/NBN4nk
         XFjpZavFGlFuuAZ7s3dKrNBOHJQ125Y9DlqZEUu3zy4RHaYT+hIs9lmzP/uV+lSgrx3/
         b55L5t0j0EzHCwOotdeUjXfUEKmqNXj4iQxfPBq7i9xtiETVjDP1oPefnGJ7Aq7y9gR2
         cW6pdu++Gtp+IioljQ0QE4ZzWAtE3qu5k/EsLyF5Y8xh4Wduutsku+gFDRmobS9EdVPp
         T++A==
X-Gm-Message-State: AOAM530mDcI3qyyb47VRQjXI5ZD+8ZDG9v6KQJ2nE3oS44IHRFj4TvRS
        7D7yKMZEpVq1HU8cPQ00OlvPz/XCXT4=
X-Google-Smtp-Source: ABdhPJy6kNI7fA8Nu3H8+JF1mwGM1g7W6PEWD1dgTLM0rdRgMHSyAFRfLeDnwJZyWhvZ/MDYafek/w==
X-Received: by 2002:a17:902:cec8:b0:163:e4c1:b302 with SMTP id d8-20020a170902cec800b00163e4c1b302mr59514663plg.123.1655133493077;
        Mon, 13 Jun 2022 08:18:13 -0700 (PDT)
Received: from [172.17.0.2] ([20.118.134.211])
        by smtp.gmail.com with ESMTPSA id mn20-20020a17090b189400b001d954837197sm7755327pjb.22.2022.06.13.08.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 08:18:12 -0700 (PDT)
Message-ID: <62a75534.1c69fb81.c0ce6.929a@mx.google.com>
Date:   Mon, 13 Jun 2022 08:18:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7304942822088907345=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wangyouwan@uniontech.com
Subject: RE: obexd: Fix callback->func =! NULL in the xfer_complete() func
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220613113713.13681-1-wangyouwan@uniontech.com>
References: <20220613113713.13681-1-wangyouwan@uniontech.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7304942822088907345==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=649838

---Test result---

Test Summary:
CheckPatch                    PASS      0.78 seconds
GitLint                       PASS      0.51 seconds
Prep - Setup ELL              PASS      41.52 seconds
Build - Prep                  PASS      0.47 seconds
Build - Configure             PASS      8.00 seconds
Build - Make                  PASS      1212.26 seconds
Make Check                    PASS      11.20 seconds
Make Check w/Valgrind         PASS      438.49 seconds
Make Distcheck                PASS      228.62 seconds
Build w/ext ELL - Configure   PASS      8.06 seconds
Build w/ext ELL - Make        PASS      1178.65 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============7304942822088907345==--

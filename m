Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64A9C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Nov 2021 21:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 989566109F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Nov 2021 21:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbhKEVhZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Nov 2021 17:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbhKEVhZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Nov 2021 17:37:25 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287CDC061570
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Nov 2021 14:34:45 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id p138so3498426qke.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Nov 2021 14:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Gmh0RyObGf1UlmsBz6DV7HAg6JxCZYf0JYFe8xG76e0=;
        b=KyI3NM+aKKuIlNGwAETc41pHQm+Ix3Bb8816piTrGznEtib8LvwqmlkyqLYkV6R8it
         wXJKHWtj4suAt4HnMKVnEG89nBi7YzbjQEUgKPztM1QbxdngZWs4R0UlQp6Y2xRXp0OE
         5Hq6ukovQTqjINXAI67Tme6LKbVirSKjQlkF0wmVKxPCpqyT/g8Fmrt6Was0UhLPB907
         sGTxV9fCOMfzFqp2rjON/1Zzj4oWPxvnLRxAcNlM6cADZlLuHaAHn3lSh7iGWiCD3dA/
         sdHGnfs1XTVBQKAkpnXb3TsIQ4Bpwbk1kue+u1t1xjPrb+8PcSbsj+VEbFUc0bEbOX8z
         415A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Gmh0RyObGf1UlmsBz6DV7HAg6JxCZYf0JYFe8xG76e0=;
        b=cRljsktKp22lKc0DgZ2lvVXPDtWWPLt7MMJKZ+lG/LKAmTq+w6ikJgMSgl3bnjjGbJ
         4+ul8zVQW1NOvI2bL+B2iKZaQwRwxeMSaq4uOVu99jIFjE9yea11W5VrDBK4Q/Lbse5o
         tDciP/2ZeBGWqx132IT8/zzx0lWe5GG5dsoX2Iogf5mP4ixBimKeobt4N7IjW4eTc3oE
         ykamUUB1LUqKAqhgOUraOITbNILAhcFCrbLEHJAaAsOqCCBDie5C6UOmbFSrD/UdcVts
         BYQfELOiPEmD53ceZUo6msnO1KTCfAsPKkdxOiUpBRmqPdiGFommR9BRU1Sivl+Re+Gw
         mnaw==
X-Gm-Message-State: AOAM533ovRJLxXiCHwtY1NCGvnCen3zyyQW9BRa5xjoxHHKihTy9qwec
        zXE2WW7OJRtMLKGEkPC7IZUOh6ABmoYOog==
X-Google-Smtp-Source: ABdhPJxe7rb4DaVaU2bVWoV/L7hTy8/k5bd8SlVYf1DRVuLF9SXovM6EAWF2Rr0Bb7aea8pB1VEHaw==
X-Received: by 2002:a37:54d:: with SMTP id 74mr19225515qkf.209.1636148084204;
        Fri, 05 Nov 2021 14:34:44 -0700 (PDT)
Received: from [172.17.0.2] ([20.65.58.14])
        by smtp.gmail.com with ESMTPSA id h20sm6636327qtk.93.2021.11.05.14.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 14:34:43 -0700 (PDT)
Message-ID: <6185a373.1c69fb81.8801.67d8@mx.google.com>
Date:   Fri, 05 Nov 2021 14:34:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6299567121672836172=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/6] btdev: Add support for LE Set Privacy mode
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211105211245.424024-1-luiz.dentz@gmail.com>
References: <20211105211245.424024-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6299567121672836172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=576261

---Test result---

Test Summary:
CheckPatch                    PASS      9.31 seconds
GitLint                       PASS      6.26 seconds
Prep - Setup ELL              PASS      48.36 seconds
Build - Prep                  PASS      0.55 seconds
Build - Configure             PASS      9.27 seconds
Build - Make                  PASS      210.26 seconds
Make Check                    PASS      9.43 seconds
Make Distcheck                PASS      251.47 seconds
Build w/ext ELL - Configure   PASS      9.52 seconds
Build w/ext ELL - Make        PASS      200.26 seconds



---
Regards,
Linux Bluetooth


--===============6299567121672836172==--

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80978C636CC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Jan 2023 07:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjAaHXc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Jan 2023 02:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjAaHXb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Jan 2023 02:23:31 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6C230280
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 23:23:31 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id w3so3913855qts.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 23:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=x9Z0aXKs5bikdUy5BizN3q1MR3JeGuOW/n1GJwXhBnI=;
        b=kqvAHarPj0lhONcArhr7ezYXSRtf0+AfxQNKp5IHOItx3taPCKpiTNN2rauaLrgtvL
         XpK+dOUEGPTctwby47Taj8oYz/f+5ScyWjDRMkHb4qryUZ48yLzUXOPIR0qwS/oo+65a
         nb+736gPR8UBVV2bHgcFWzo2W2lsOQvDMGSrOOCShPparycvsvBwEzeXUZbSYXhXGwFY
         fEGF5RygLmC5RXC/2s7oAaJG0xl1XrrlGx/rk6SgfpRLj9hAwK6xdncj7MRbG2UaPwKX
         QHmjIEQGvSwFwaAx7EyQ6KTwYh6GiXRuoHGSvZt778g/h44uusztA/2nw+iDQsrbzzF6
         8b7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x9Z0aXKs5bikdUy5BizN3q1MR3JeGuOW/n1GJwXhBnI=;
        b=IEKd+A6dL8YSwHm3QqqspohGY3O4y531AZF1TOPgop41ezedLi5RqUF5k2A6yu5Hvi
         DBqmaDD55+XuM5K2sCiQnU76DlBVmml8jlKdt7hjjwgZoBGDfTT3p7uo7y+Lu7xHy3cv
         0UKrBCYFOHgaNWa9fJYI20vwE2cTsnWT9BzTSB8sWqVdr3EAsT9PloTxFj/ddwL9vas0
         glhBAW2Hds9dSgisAW2H5XmK+1EdIMdjCFxkKnoZ7PCb7GDJdsdFHAJK8YLP4MBJIS90
         366rccG8Y2faLwwmXzIVDhE7POR4IBR3zckn7FHI78fVRWBRTPpn6o86YEY4uoNh8WEw
         n6YA==
X-Gm-Message-State: AFqh2krIWPMumZ1lXJGXkNlHmoKiA4sWa08+kXA97kdTyw6OZhYTIN3I
        1VWzbpZu/qOwWXMYKqTx1O+I4aHL/BU=
X-Google-Smtp-Source: AMrXdXvkaesacM8bkdMFENqQQbn4f0DhUtBCXY8/5IE8e3/8nFdS/VoSFbtHjONDfkCh5TSxZXUcIw==
X-Received: by 2002:a05:622a:2593:b0:3b6:694f:d710 with SMTP id cj19-20020a05622a259300b003b6694fd710mr69441699qtb.50.1675149809958;
        Mon, 30 Jan 2023 23:23:29 -0800 (PST)
Received: from [172.17.0.2] ([172.177.134.82])
        by smtp.gmail.com with ESMTPSA id x19-20020a05620a14b300b00706aeebe71csm2429706qkj.108.2023.01.30.23.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 23:23:29 -0800 (PST)
Message-ID: <63d8c1f1.050a0220.b063b.8f82@mx.google.com>
Date:   Mon, 30 Jan 2023 23:23:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3926386700503652086=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sam@gentoo.org
Subject: RE: shared: define MAX_INPUT for musl
In-Reply-To: <20230131055258.3311810-1-sam@gentoo.org>
References: <20230131055258.3311810-1-sam@gentoo.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3926386700503652086==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=717213

---Test result---

Test Summary:
CheckPatch                    PASS      1.28 seconds
GitLint                       PASS      0.40 seconds
BuildEll                      PASS      32.60 seconds
BluezMake                     PASS      930.49 seconds
MakeCheck                     PASS      12.57 seconds
MakeDistcheck                 PASS      172.91 seconds
CheckValgrind                 PASS      287.70 seconds
CheckSmatch                   PASS      375.44 seconds
bluezmakeextell               PASS      111.96 seconds
IncrementalBuild              PASS      749.42 seconds
ScanBuild                     PASS      1142.01 seconds



---
Regards,
Linux Bluetooth


--===============3926386700503652086==--

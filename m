Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DA1C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Jan 2021 20:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C84872310D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Jan 2021 20:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbhASUcB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Jan 2021 15:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391600AbhASU22 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Jan 2021 15:28:28 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8724EC061575
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Jan 2021 12:27:46 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id n142so23274587qkn.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Jan 2021 12:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=STL8mDGeFFuDBPzExabuDmMm2uZ1HXrxm+J5p459Fx0=;
        b=EBQtNcqApDxpiM9aMllyStszw9DdiiZfVgbRmVr1v8j0gVG2frKHM4UoGckH7HHKq/
         WetDxUsCdic7hwTgCCnmamko0W7MH523Km3QxWlaVhxTSocLdFaaDuHjrTsdaQXWydD8
         ovxhPM0c2L3GdbheDEb6Rm29jaYRDfzFYTlzlSyAwH9GtvphG4sHdvZ7G/DERnpt/ZO3
         ddO2XBNFAF7y0KExwjQx945uwGEJnLao/WtfiwOUZVF202yanNML28HC8mhs1J6ufxA9
         8YzgF8h8cr0NYw4Z+oszB1wX6DZaByrB3s5Kgfz/51B/sASFOqHbPGHligpQK4aoC22j
         ejhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=STL8mDGeFFuDBPzExabuDmMm2uZ1HXrxm+J5p459Fx0=;
        b=QyXUcMDFUbwEMeYhTWCIsr/iTzNhIAJzzcSTmJtJHum2z5OXIrXCnHX5C2cSxH18AR
         MC4p0dltzns0/kbIG5zOs244+OZ9qZINI+U2wwhm2ktgkYLAiw6lBBlFkU3pCtLb9R9Z
         kBMvgE7IWDWKtiESeYd74RAL2LM1OXZ4e9bVj+NYYjCvmfTqaaCb3LqELhu3jNC8rOPb
         +bt8g+8nEyAqAB4mx/GjBPoZzcazL52Cy0CeLwC8X7Adi5IY2QgVzeb1WR/eWzSgGzZD
         YBNle4o44cTpwk76Dc5gOZxUVXzatdZnmawwuMHGONz5TyZm/7VUNz1ck14LSKIQKXhq
         BTnQ==
X-Gm-Message-State: AOAM532TjhycAkA8wuxRo1wq4oVx1eLcuGW0IPm65wphggIFZoe70NHa
        zra1dbHZ14B5RvedP4ugEgy7xz1AGf24zg==
X-Google-Smtp-Source: ABdhPJxKKpKw7EFW4YUyJUSNvUJYXltE0xq8IfFu8b1ZjbjrBxJ9YVex52l/NIBc4V7xyJtCCezznw==
X-Received: by 2002:a05:620a:13b8:: with SMTP id m24mr5936535qki.205.1611088065733;
        Tue, 19 Jan 2021 12:27:45 -0800 (PST)
Received: from [172.17.0.2] ([20.49.44.245])
        by smtp.gmail.com with ESMTPSA id w9sm687659qka.76.2021.01.19.12.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 12:27:45 -0800 (PST)
Message-ID: <600740c1.1c69fb81.b7d5d.524e@mx.google.com>
Date:   Tue, 19 Jan 2021 12:27:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0825861796887939211=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] gatt: Fix crash when a device is removed
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210119193512.821918-1-luiz.dentz@gmail.com>
References: <20210119193512.821918-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0825861796887939211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=417643

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============0825861796887939211==--

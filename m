Return-Path: <SRS0=Rzh7=7E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FC0C433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 23:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 409692073B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 23:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEkS2czo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731238AbgEVXg4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 May 2020 19:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgEVXg4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 May 2020 19:36:56 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1FAC061A0E
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2020 16:36:56 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id v4so9721621qte.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2020 16:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=SoLYAHKyl51HrBpIGS/LBCeJ1Z7Vf3V7KeXBnJ37GZY=;
        b=LEkS2czo0EfJIIY399S2t2GB6UI8C0AA0DVmkvh809dKjcj5o1ZrMQUsPo+96U5k66
         BtDHDBss82DHa4H2pWfTVD7KqMC95Z3R8XTvy0vGHKuXxBUY0fgC9lUP/jIb5+YlROgi
         lDu6hduj+X7Gd9RHkKk9JRyAinor8bW//qrlRLeUIV8Vc/yCGTAbYGABJYv6mQFCXo4p
         AAAwJbTTr5no+uRcBRFu0r7SMUK4iMXIg5VIZda7KzavBCqAaPMPnbOGNHNgh2ILqPBx
         7Cp1TEThRw+VOqPKzHn6icw/5lVxqD8Zx4LFXbwqdZwj2iIHTu4ybyW1jqHB0LCBY3Ay
         kD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=SoLYAHKyl51HrBpIGS/LBCeJ1Z7Vf3V7KeXBnJ37GZY=;
        b=da1bA7kqlIDxboV/RiCNbs7KCC76oYbbFuu5JDYu3+HN0cZePF9+8sZgYkG/DamnTF
         TaXlbh1gYVapZlOsTqcYyjOVHNRZVsmzOT2dJYF4/r0SUvdExnuu3hjTA5eQ83SQTM1G
         7Q4p8MvlahlJK5bq701cAzn9r5cPchTqEyINIIh5/Q8XIut2BfLWl9KOuC7QKsxfrzsY
         mjQSjAue2FHAk2m2V2XLOuQ2wOPcBvNd3w5JPLfp2wVjyTTarCyEBB3CrwqMQPO98Y6b
         pCW6OIoI6/LhzgpbFklcZnxP8UGvXny/9cmwO8GI3AcQ79tVYf1VteQq7HX3TnmeWZAs
         G73w==
X-Gm-Message-State: AOAM533BtG96tqCl/DoY5GlEp1BXPBBj9UfSHbhVbffk96V7UCAdYPM3
        RCX+ad1N961k2fKIgXdJS1xO39jzb1M=
X-Google-Smtp-Source: ABdhPJx7xD+ykKcTXJBhwqwtRcE06dMdoUY2edtAW9wlBKzYFua2uNfQBSS3cPqYXUh7CF5EEZ3asg==
X-Received: by 2002:ac8:1a54:: with SMTP id q20mr18579417qtk.274.1590190614951;
        Fri, 22 May 2020 16:36:54 -0700 (PDT)
Received: from [172.17.0.2] ([52.252.100.111])
        by smtp.gmail.com with ESMTPSA id w67sm8688113qkb.102.2020.05.22.16.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 16:36:54 -0700 (PDT)
Message-ID: <5ec86216.1c69fb81.8d4eb.281d@mx.google.com>
Date:   Fri, 22 May 2020 16:36:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7235835977625295856=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ,2/3] mesh: Fix leaked mesh_net allocation
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200522205756.230907-3-brian.gix@intel.com>
References: <20200522205756.230907-3-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7235835977625295856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkgitlint Failed

Outputs:
3: B6 Body message is missing



---
Regards,
Linux Bluetooth

--===============7235835977625295856==--

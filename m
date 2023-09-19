Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E80CD5BA7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Sep 2023 12:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjISMY4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Sep 2023 08:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjISMYn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Sep 2023 08:24:43 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0D6F2
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Sep 2023 05:24:38 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-770ef0da4c2so363844585a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Sep 2023 05:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695126277; x=1695731077; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mxIagnpMQQbOIJiqQIZjrOe0l2w83kBvvAm3N41wihI=;
        b=KM4eflxNTXUIUMtYcJpWbFhjQZmoSixI8xaF1rFIbyLpDFbIVuUHRP/4p+75LQGJHh
         /GHF76KMZxCULTXrd9EzMTA3WFq4i3NbM42zbtkkeCpEbKUbqS89Uop1r28LxYvcqDuE
         Q7P725fDJl95bWsymUE/O+ors/XPB6/xAFNmcgXOrskXUg9ijhEkONx5nNtykPIEIiGr
         ZbZitpEw64ycasyPfsfJVmpxn2Q0qFx/PXqkjlJ6lqIKiIHCw6QVtnTG4H8JzRGxyLwZ
         bE/mBZoxnV8520rpqFOewCwWK7mUsgfYByWeN9entvVcfGrmHQKTKnJUpj2pg61A+8gM
         e21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695126277; x=1695731077;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mxIagnpMQQbOIJiqQIZjrOe0l2w83kBvvAm3N41wihI=;
        b=DOnhJRqKFJHWyiqYzLgQbubzvCDQwI4oAklLLYReucgPXuCivWbERJo84eyTKhTCLn
         YMH17MrP32pHJaGtgVEQH7wBHNdK0LRhgJJYP/Tn8m6z9sXgnEf8LVCj+V5gsYhx4XIs
         6TfOk+yD/6ehu4siYvlb4qRPSnJ25jtjKLr+hmf1v8+T0oYabsU3J63F9dApSWWWJ1Fh
         4/8DHpaUeMZX/TLNBz3srd3X84r1F7+2GdylCGNYipcl9EYpPKzipM5dmsPH3ymdWkuu
         E8o60rKZ+jdAfurnUHaPvx7YRv+5iUzTHSBg9K8jC1QAmKfRHukvXorWc9UiTsLE9Lw0
         nQeg==
X-Gm-Message-State: AOJu0YyNoAuMNviOte+R9uvOrM/vkHxCYGZtp7nlrF0RFdxAm8yVvKUb
        +x3VIxqDuxeqnmLgcsQj04HXmOXddFI=
X-Google-Smtp-Source: AGHT+IEIL/ZbAvtb/A9udTVPk06VVrIaX8ZIDJxysCuq2ECqgIH2BiaqFMsMv8pcj8yle9lBvBi0xA==
X-Received: by 2002:a05:620a:47a5:b0:767:154b:2f91 with SMTP id dt37-20020a05620a47a500b00767154b2f91mr11764288qkb.24.1695126277159;
        Tue, 19 Sep 2023 05:24:37 -0700 (PDT)
Received: from [172.17.0.2] ([52.179.102.214])
        by smtp.gmail.com with ESMTPSA id u8-20020ae9c008000000b0076cc4610d0asm3914208qkk.85.2023.09.19.05.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 05:24:36 -0700 (PDT)
Message-ID: <65099304.e90a0220.79bf2.e1b4@mx.google.com>
Date:   Tue, 19 Sep 2023 05:24:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7784944997072709081=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, vibhavp@gmail.com
Subject: RE: [BlueZ] : adapter: Add Version and Manufacturer props to org.bluez.Adapter1.
In-Reply-To: <89ceb9e5d67485c19d0f139ac0825cf008491ebb.camel@gmail.com>
References: <89ceb9e5d67485c19d0f139ac0825cf008491ebb.camel@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7784944997072709081==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch fragment without header at line 9: @@ -3540,6 +3541,29 @@ static gboolean
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7784944997072709081==--

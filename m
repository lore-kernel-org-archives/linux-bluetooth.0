Return-Path: <SRS0=YOMr=7K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A2EC433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 10:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 565B4207D3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 10:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJh2+Ofi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387867AbgE1KhA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 May 2020 06:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387846AbgE1KhA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 May 2020 06:37:00 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98CDC05BD1E
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 03:36:58 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id a23so21788342qto.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 03:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=jyCYc4nZMOYTwzrCqYyfRueoxJc1INghjgHl4ae1n9E=;
        b=VJh2+OfiOUWXHhJ6cryzmeYbAIifqCKWM9WqR0N8md20tsl9KgJ8VjApSkzKcqYAMC
         btl6qHA7oOA2/ZVnyT/q4cjyRZHJbCuWjUtQaDnnCz1Dux/8npA7U7LZwmrvyQWXTR+C
         iNrtxCdIBOUwfiIpeTtmcfJcRNpNRHbVQRTm0FlPJ0GkEwgdsXlYg9tDzuni1327VqNo
         5lA7p5iWzHOiMkgemrmqkxFSaS+3bltQ2jPY/ABXJ0h2IrDyDunNzB1te3HpNLTZz+N/
         uOpVj93BDkFX131lwO6qdDFCZjuuhEeq4naOWh7hQTJfY5nN29PgUUz3UKtWO/1O1h78
         piXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=jyCYc4nZMOYTwzrCqYyfRueoxJc1INghjgHl4ae1n9E=;
        b=WefWds3eXI4u+Fu90pwmitoXSPZXgiZSCxLqeVdcc5paoK+TG0w0PVxhao0d6it/C+
         8OUZhtggwNuZmnU8avBiWDauLjEEeefZ8TNPq3r+GcB7buV1x1pKnxU8zIcdLXfkKODc
         WkJnDTdi4wFGtoESBLGBpYBGI2HPnaO6j9POgL9nYVnYMA+xVZC4PRlU7AjFiiGMLdwn
         DN21skxhptMpelmI60AOWpuLzA913W0XjRI4Ax6ezGwuIBfMtXh0v38rkEWFnF1YsLhL
         VHnlBTPjpXQJDs6mFfx7LAoU5f6kJ+imrPPY6tPSyyf111A5RfAynch3swgMnYU1sRHD
         F3bg==
X-Gm-Message-State: AOAM531K0hXMl/olENs7MTLsdUQ6zmpLeUDH7UyVONNaDYOoQshM0+e9
        2/VksnVvmvC2xXq/npPEvmf342OQoO0=
X-Google-Smtp-Source: ABdhPJxTy5IiD+uCH4QLhSxl9a/ECIQ8a5vk9N6xZsxRH2P0oOSOhq50D6aDd5k9IlQV4kM6CUUS6w==
X-Received: by 2002:aed:21af:: with SMTP id l44mr2405024qtc.124.1590662218044;
        Thu, 28 May 2020 03:36:58 -0700 (PDT)
Received: from [172.17.0.2] ([52.188.113.25])
        by smtp.gmail.com with ESMTPSA id w10sm5366330qtc.15.2020.05.28.03.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 03:36:57 -0700 (PDT)
Message-ID: <5ecf9449.1c69fb81.37d70.ec80@mx.google.com>
Date:   Thu, 28 May 2020 03:36:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1053965527625791712=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, michal.narajowski@codecoup.pl
Subject: RE: [BlueZ] monitor: Fix for incorrect len in L2CAP Enhanced Connection Req
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200528101408.98400-1-michal.narajowski@codecoup.pl>
References: <20200528101408.98400-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1053965527625791712==
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

--===============1053965527625791712==--

Return-Path: <SRS0=EfKn=BJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_HELO_IP_MISMATCH,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBABDC433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jul 2020 05:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92F4A2084D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jul 2020 05:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keZRLbt6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgG3Fmz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jul 2020 01:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbgG3Fmy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jul 2020 01:42:54 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEDBC061794
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2020 22:42:53 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a14so23668810wra.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2020 22:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LBeaeuqxaxtoO45G9AbSfGvRf/xh3V9TYQgiS7rKYcE=;
        b=keZRLbt6VbOZ+cZZmB4mr9wkxV/jmXV2gzCpXtRcoqmeVJX63A4ABe4c4RTUUgJ+Fk
         fe4lB1YNkR7utnYmMMUwmNq9OhwQEQL55WfnpRoTixM2bxA3bzKjUPNF8yv1LoQkphtv
         slTZyvcTAaX8WJzokfaqSV4yCf9hP77ivIYphBDxJ9clPJMJS85a2BcLycu0mudSPVCW
         xcC+r1V/mw1HUEkCbG34VWHmVxKBaSs79+tER5pAsegXCIgO/KP8TEqkyG1XZwgB9zeo
         h35/ezO6HEBGzFaGXagFcZzCMnH+RGBYtwlN66zofO5ORLmjvpshpKW/EnwdpEASytca
         ld0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LBeaeuqxaxtoO45G9AbSfGvRf/xh3V9TYQgiS7rKYcE=;
        b=BEFhZq6OhdpzXa3FClAMvCC4PiwEww/wn3UOfJt33RTWmEhQb4MjkEnDPye1A3mEuK
         xhAYNDfxOaBcs14v9TMiCWysWpzlE94qV1CuXaSl+/BLqIqbZGwfyVRYkWACRE4T8blF
         A+mLKYQIKprCG0NYZVLvzKQIeJOPw2Q4zQBtKXAFujQnL+VAc6iWiOKKAh4usxk7uWEw
         oSWREWSUz2GoF8wYuZiATmQwQNRBgJS4Xbr42mUX/zt0PO9y7zwSYR+gCBfDDxkPcqDl
         IIaTnckd1Uy+9odCGxRWJzT2rj0QGI9uy3fDKXiq9OylL8wNmVlZHKAk75B+pTjyJbF6
         9uaQ==
X-Gm-Message-State: AOAM533m/a3JJVPggr79K0+OO6X1tFSC7+XPPfro3CVPn//pIA7+0rFS
        4rnEeQDo52pGR85/GuRhIt8=
X-Google-Smtp-Source: ABdhPJwrJttMz9TjwYhlt5uervKTZeoihmVmNBILdpeRgvrprdpDDxejbSJ0lA9r8k++IWReR222cw==
X-Received: by 2002:a5d:6692:: with SMTP id l18mr32388720wru.211.1596087772327;
        Wed, 29 Jul 2020 22:42:52 -0700 (PDT)
Received: from 168.52.45.77 (201.ip-51-68-45.eu. [51.68.45.201])
        by smtp.gmail.com with ESMTPSA id c14sm8061106wrw.85.2020.07.29.22.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 22:42:51 -0700 (PDT)
Subject: Re: [PATCH v4] Bluetooth: btusb: Fix and detect most of the Chinese
 Bluetooth controllers
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
References: <0bba3f22-a232-3c07-1b05-73e6d38dab8a@gmail.com>
 <BB91A6AF-35AD-4BFF-BD1A-49292C064A43@holtmann.org>
From:   Ismael Ferreras Morezuelas <swyterzone@gmail.com>
Message-ID: <7ece308a-4890-bb70-bc20-41e89508c12e@gmail.com>
Date:   Thu, 30 Jul 2020 07:42:47 +0200
User-Agent: nano 6.4
MIME-Version: 1.0
In-Reply-To: <BB91A6AF-35AD-4BFF-BD1A-49292C064A43@holtmann.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 28/07/2020 9:10, Marcel Holtmann wrote:
> Hi Ismael,
>
> patch has been applied to bluetooth-next tree.
> 
> Regards
> 
> Marcel
> 

Thanks, Marcel! And sorry for the missing quotes in the 'Fixes' line.
Seems like the scripts still don't check for those. I'll keep it in mind.

It's been a cool experience, that's for sure.

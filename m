Return-Path: <SRS0=Rzh7=7E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5427CC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 23:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26C1020738
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 23:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maDYHiYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387435AbgEVXhH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 May 2020 19:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387436AbgEVXhH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 May 2020 19:37:07 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D3AC061A0E
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2020 16:37:07 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id n22so9648768qtv.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2020 16:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=JIVkHeadwVHc1IcWrS823JddPMa0eDzE/cmFkzTqXLI=;
        b=maDYHiYP6Y/crE/EG6mXbcVbZpLQiB60CACbbZpcoHT/2IbLwvTcoPgdQ7XaxdlEFK
         MI7UE8nDumxKmTAVeJ3vNaKCw3IS5C4cvH3R/MI9iSw+494RFdq3Vp2WTWUYhXOZRl8X
         EwGfKVyxJB47oYBdtmr+UEXzyxLvyot8Zo4qD8S67RnAeeSIMyyKHB6P+0pbQO9s99rQ
         lrEwqxbFWAWFr2i3XYzgx+Mo4OxAXZ7PNpyTQU90GdvTln+vbWrF/0WrRv4HBFTYbVAU
         ln5iFyRiSw0wCiz8E/4qnuG9Hj0IknuJmKqg9brU/YR6bzRvmw/fA3KHBXLhHbqCaEu1
         RPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=JIVkHeadwVHc1IcWrS823JddPMa0eDzE/cmFkzTqXLI=;
        b=WdhpLbKcNM7uImhQNxAfu1v+EXEjBJsD5bHw9cLQn5jt3wmft3wsdxpMSdtsNg1+5v
         KXKWlnnep613dSJi7BkgrcQb+v3v+fWMqBXHrMK3+plDjhI42FdOtZ0N7FWUsU3Tni8Y
         T1EF0p1lkKHzpSAj1Scep9HKGbLlD0p1nidAnTRCXfKW1nB9pL9ed1CTkOvstTtz68Od
         6vJfZdHdDzTLxskyr3qE1sqPinbJewT6lArGj/ufoLbM5Wetm/EaJIKnj41cUCDTiJAl
         78sAwHYabrPkxw3JjfgZzH+CdnIQXafFOc8lIyLxYcgnlXtrj3eOPifuQTF0kr05kzAy
         qu2Q==
X-Gm-Message-State: AOAM532Yz4MJuXcl6xm75mQxmWCqf+G4dr0ZbXv0A6uDmdVYf1lZDPnH
        f5kAboKGC72DrED4PcdXNqsTLsvp4O0=
X-Google-Smtp-Source: ABdhPJwthcKolAPEem7SVi0xfmolm7TcU+6dz7qyhoQls0ivzBpdDX8RNg8NA4P8+dY0R9iTMA+PPQ==
X-Received: by 2002:ac8:3733:: with SMTP id o48mr18528737qtb.149.1590190625327;
        Fri, 22 May 2020 16:37:05 -0700 (PDT)
Received: from [172.17.0.2] ([52.254.17.127])
        by smtp.gmail.com with ESMTPSA id g11sm8338603qkk.106.2020.05.22.16.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 16:37:05 -0700 (PDT)
Message-ID: <5ec86221.1c69fb81.9f5f2.04aa@mx.google.com>
Date:   Fri, 22 May 2020 16:37:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0058788604514928163=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ,v2,3/4] mesh: Fix leaked message reference
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200522211309.233824-4-brian.gix@intel.com>
References: <20200522211309.233824-4-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0058788604514928163==
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

--===============0058788604514928163==--

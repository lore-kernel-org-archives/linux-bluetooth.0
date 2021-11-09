Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9E0C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 22:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9299961073
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 22:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhKIW75 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Nov 2021 17:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236847AbhKIW7v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Nov 2021 17:59:51 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593D1C09A7A6
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Nov 2021 14:46:32 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id az37so781147uab.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Nov 2021 14:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=8k2yjqam7W3V/Bv0R/FkAdRGvK3HnXJ0fj7tlPbANNw=;
        b=ZViqxlKWDN9vxB9K1TeOmPMd6/XxEW0zlowH5VlGPTtJRCIkTiQ9VWrjCFGtX/duXQ
         sKfsCRpDkqjJsQDZA+G6Q2F5btMrKFfW47al6CnkPCLhFMTvfWO6icLl9/kdv0nqblIq
         Oxzvvd3ssan7bU96pq6k37f+xcecqfxmSTVkomCDKBucg+hibao58z0IPzhwVm7JOdZa
         6ZHwXDNFEOJ95RjCKwYxzLdtyI9i/uHhaiN2DMMbyO8cZSj6AG+4IZ8ro5nIDiX09qzg
         PjEgY+4sb6l5YtZf4AruQuzPIKMz7CZfMO/23PV66ZrOfqQOVjT1G+y8vs2AwP+8d3E7
         TIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=8k2yjqam7W3V/Bv0R/FkAdRGvK3HnXJ0fj7tlPbANNw=;
        b=jqzx5N0juTVMI9BARXsHwMkkd2GIhP1/4IQQcV08QRWvPWXo1MAKFgS+AhMAkUYokA
         SGMKTkM4EiBCGOPiIhgrU2JGGrZIiC7aQ4ytxdbkWAJ4O+eLA3Say5hb8hL/m/JnX4VV
         oFpP0tMXrVIyZf2n5BBddtTRrRGMHBckeBRQaciuNP2bpZSueml2VMGdayF29JGoLq7T
         c4s2eR/eaY6gF8e/UuHdd2cLh9d2+wKRXnNtAr/YOKXErKvQ6SnsAxhw6J2ipGW/7P/e
         /V89V1VBIIblxzDJUQsWXfu1RmDivpC9Dhzcm5t69gV1ccDaO8f60lNZM5wUrnj7RaXE
         mmPQ==
X-Gm-Message-State: AOAM531XCqUrUNjKGDtDSNloL7ByTB6h/d1iJPOESlX9FuHqNaNMjYbO
        1WwFyySb+Y1kDgqtf9LEnPdZuV1yCUof5ze3WtGwNQGs
X-Google-Smtp-Source: ABdhPJyU3jKpD5z8NiaC1hoZQFyIrhlynZUPs4SghoPhK5J2fTbs9BBOMzNAl0Nu/DMGyKrcO3tUqwHM9UsLLQjqgd4=
X-Received: by 2002:ab0:5b99:: with SMTP id y25mr15178581uae.47.1636497991364;
 Tue, 09 Nov 2021 14:46:31 -0800 (PST)
MIME-Version: 1.0
References: <20211109215322.1124566-1-luiz.dentz@gmail.com> <618af832.1c69fb81.e5dd0.6ba1@mx.google.com>
In-Reply-To: <618af832.1c69fb81.e5dd0.6ba1@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 9 Nov 2021 14:46:20 -0800
Message-ID: <CABBYNZJ-cpSGgW_TsgcqkXDLT-yZajSf0N0QYO5behvKCt=pxQ@mail.gmail.com>
Subject: Re: [BlueZ] media: Fix memory leak
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, Nov 9, 2021 at 2:37 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=577661
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.30 seconds
> GitLint                       PASS      0.87 seconds
> Prep - Setup ELL              PASS      49.54 seconds
> Build - Prep                  PASS      0.46 seconds
> Build - Configure             PASS      9.05 seconds
> Build - Make                  PASS      204.90 seconds
> Make Check                    PASS      9.80 seconds
> Make Distcheck                PASS      244.96 seconds
> Build w/ext ELL - Configure   PASS      9.09 seconds
> Build w/ext ELL - Make        PASS      194.61 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth

Pushed.

-- 
Luiz Augusto von Dentz

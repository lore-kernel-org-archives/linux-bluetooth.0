Return-Path: <SRS0=53yU=DR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83098C433E7
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Oct 2020 07:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD9C82078B
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Oct 2020 07:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=grimler.se header.i=@grimler.se header.b="r3P3D2/w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbgJJHsW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 10 Oct 2020 03:48:22 -0400
Received: from h04mx15.reliablemail.org ([185.76.67.208]:51730 "EHLO
        h04mx15.reliablemail.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgJJHsO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 10 Oct 2020 03:48:14 -0400
X-Halon-Out: f09f32c2-0acc-11eb-b756-6d217f6c6b7a
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=grimler.se;
         s=default; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
        In-Reply-To:Date:To:From:Subject:Message-ID:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=AUeK/6t2ldxlT6trvuS+e/Ccx85xA/c8oChyN8i5zLo=; b=r3P3D2/wGENcRliQr88K1p9qDz
        TImmaYbzuz+7s/WYQPzsElW5IZQpt7QdNBueojPDV8BgHPyqsI0Oa6lCXvkOpM36FLQmysk3gNm2l
        yFHc9NblpSE62ZC5+0JDbbRxmtN3K0W6G1L6DQLFJu0OQhUecizHoIJZvHzLaEDrNJKCsitXKPe9Y
        hNe28cnqQGVCGG+hJYX7GrcjqNupjyVtt1LYPqZIQdERmlEhqGFfALGmuKU4UU5mNLjB11SNtKf1e
        i4evMtYPKFrz3Nw7TxQan28NrxPYM0mvuCGCRFcZKb0jDAPJOjbBTw1yUUNvw3sJsdvthghB6b70Q
        0jCytxRA==;
Message-ID: <81a98880c72ad06b48bc2f25a673e3346fd339d7.camel@grimler.se>
Subject: Re: [BlueZ,v3] tools: fix forgotten index->mgmt_index renaming in
 btmgmt.c
From:   Henrik Grimler <henrik@grimler.se>
To:     linux-bluetooth@vger.kernel.org
Date:   Sat, 10 Oct 2020 09:48:07 +0200
In-Reply-To: <5f7c9d77.1c69fb81.532c0.5527@mx.google.com>
References: <20201006155034.126914-1-henrik@grimler.se>
         <5f7c9d77.1c69fb81.532c0.5527@mx.google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpsrv07.misshosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - grimler.se
X-Get-Message-Sender-Via: cpsrv07.misshosting.com: authenticated_id: henrik@grimler.se
X-Authenticated-Sender: cpsrv07.misshosting.com: henrik@grimler.se
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi, 

The lint check seem to fail due to long lines in the old code. In the
new code the same lines are shorter than 75 chars. 

Is there anything I can do to make the check pass? 

Best regards,
Henrik Grimler

On Tue, 2020-10-06 at 09:38 -0700, bluez.test.bot@gmail.com wrote:
> This is automated email and please do not reply to this email!
> 
> Dear submitter,
> 
> Thank you for submitting the patches to the linux bluetooth mailing
> list.
> This is a CI test results with your patch series:
> PW
> Link:https://patchwork.kernel.org/project/bluetooth/list/?series=360353
> 
> ---Test result---
> 
> ##############################
> Test: CheckPatch - FAIL
> Output:
> tools: fix forgotten index->mgmt_index renaming in btmgmt.c
> WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description
> (prefer a maximum 75 chars per line)
> #12: 
>                                 config_info_rsp, UINT_TO_PTR(index),
> NULL)) {
> 
> - total: 0 errors, 1 warnings, 11 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-
> inplace.
> 
> Your patch has style problems, please review.
> 
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO
> CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED
> SPLIT_STRING SSCANF_TO_KSTRTO
> 
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> 
> 
> ##############################
> Test: CheckGitLint - PASS
> 
> ##############################
> Test: CheckBuild - PASS
> 
> ##############################
> Test: MakeCheck - PASS
> 
> 
> 
> ---
> Regards,
> Linux Bluetooth
> 



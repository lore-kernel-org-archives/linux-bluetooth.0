Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061F1C4743C
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Jun 2021 00:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4CE6613E9
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Jun 2021 00:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhFEAzo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Jun 2021 20:55:44 -0400
Received: from mail-yb1-f180.google.com ([209.85.219.180]:43738 "EHLO
        mail-yb1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhFEAzn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Jun 2021 20:55:43 -0400
Received: by mail-yb1-f180.google.com with SMTP id b9so16099188ybg.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Jun 2021 17:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=+q/sRlpn+CkJZ66w7vLNF58TPGfeni2Pv46W+1q0Zuo=;
        b=QXvuC/ySGNUNIXKq5S8VqpJUZlGSH/DvaN2IyzEE6E+EeZoUZgYfHN37mUSJjL4Ozu
         VXK5MPe5hsaLhwRbm5M18CjwZhi+fh8VIKShZbsyyhwdqi34KosSgubFh/DuDg8axAZe
         teF0k8810XbeNdczVcR2NyB7nPIziLQgd0OhVdBeoK8XGooJp+RPHGGPMx1XrQJsRc3m
         54IEtXOFrnWHTOu+7oA+riB9RL6R6waNI8aAQ++bK7byOhEKgouA31U9whXXC0fWM5UG
         zWiSpRu9b0buVOiES8nVtsdMQAJGhQSyk2eKMq7REav+WyxCmifzGDkQah971NNyo4qf
         8kJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=+q/sRlpn+CkJZ66w7vLNF58TPGfeni2Pv46W+1q0Zuo=;
        b=SUXhbHFff6kCq6UQxR0stMZWMwOec2WC9NrrI1l4Y5Gu89XwB0tTANOcHkXIrBJTEg
         RAKc7FoahEG8bfbb7OP2p1lope3Pf/hoeT+7Nty6oVzLbh88mH/h1SJRNKDm/SLIGQaS
         HHIX/19V6sPQRVOqSiZkPrGQqNIkCPvISaStX2DWLQesLtZpTU/QbwJ3ZL2TPW/IqjAC
         qveAnrzfYxZqY08YzAJ2QxBMwC4i3Upaohw86Me1C47TMa30JNFzJx49D55sbrVcLgba
         W3ym7p+ly9U10iwMlAT9ynwWxERkXUwpLDIesRRUynkikgn0ORaj62sSnSAkpDTMph8A
         P41A==
X-Gm-Message-State: AOAM533MA/6QHyQeWBxYYyA3yOXLU9+gahvaLixehuMeeZvD5vW/Cxzi
        LLs6Bs5GxB26/fld+bfLzlXjWCiwT0w1MemGlriZwftg
X-Google-Smtp-Source: ABdhPJzy247kLhzZrmA1loh2tDz4IV7OEMo22iLYCnE8hkgOpSpZzMmuoMOwuNyGj8VDBNlMvB5thlx6nXMMqRYU5j8=
X-Received: by 2002:a25:6612:: with SMTP id a18mr8800056ybc.347.1622854362032;
 Fri, 04 Jun 2021 17:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210605000200.1938853-1-luiz.dentz@gmail.com> <60bac7ff.1c69fb81.cfc9d.3cee@mx.google.com>
In-Reply-To: <60bac7ff.1c69fb81.cfc9d.3cee@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 4 Jun 2021 17:52:31 -0700
Message-ID: <CABBYNZ+nDr-0-tFoCtEpXNJtBd1gpFkFrEXHZu1xamh7kMTUMg@mail.gmail.com>
Subject: Re: [V2] shared/mgmt: Fix not processing request queue
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Fri, Jun 4, 2021 at 5:40 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=494447
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.49 seconds
> GitLint                       PASS      0.13 seconds
> Prep - Setup ELL              PASS      45.76 seconds
> Build - Prep                  PASS      0.10 seconds
> Build - Configure             PASS      7.90 seconds
> Build - Make                  PASS      193.49 seconds
> Make Check                    PASS      9.03 seconds
> Make Distcheck                PASS      229.13 seconds
> Build w/ext ELL - Configure   PASS      8.06 seconds
> Build w/ext ELL - Make        PASS      185.19 seconds
>
> Details
> ##############################
> Test: CheckPatch - PASS
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
>
> ##############################
> Test: GitLint - PASS
> Desc: Run gitlint with rule in .gitlint
>
> ##############################
> Test: Prep - Setup ELL - PASS
> Desc: Clone, build, and install ELL
>
> ##############################
> Test: Build - Prep - PASS
> Desc: Prepare environment for build
>
> ##############################
> Test: Build - Configure - PASS
> Desc: Configure the BlueZ source tree
>
> ##############################
> Test: Build - Make - PASS
> Desc: Build the BlueZ source tree
>
> ##############################
> Test: Make Check - PASS
> Desc: Run 'make check'
>
> ##############################
> Test: Make Distcheck - PASS
> Desc: Run distcheck to check the distribution
>
> ##############################
> Test: Build w/ext ELL - Configure - PASS
> Desc: Configure BlueZ source with '--enable-external-ell' configuration
>
> ##############################
> Test: Build w/ext ELL - Make - PASS
> Desc: Build BlueZ source with '--enable-external-ell' configuration
>
>
>
> ---
> Regards,
> Linux Bluetooth

Pushed.

-- 
Luiz Augusto von Dentz

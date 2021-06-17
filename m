Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4408C2B9F4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Jun 2021 20:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 663CF610A1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Jun 2021 20:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbhFQUwp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Jun 2021 16:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbhFQUwp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Jun 2021 16:52:45 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F23C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Jun 2021 13:50:37 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id g142so5551937qke.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Jun 2021 13:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K2e3bFQa+oawqSym7M7CIXxMV9WUDMKPC9LZ+dDg5Dc=;
        b=Mcyq+ux9lbZkZhAPV1QcWgICg4qKmQbyxmN/hiz5s/lVT76Zryw0ReNCmzLC5z0NKY
         lFaW2DfMjY8oN+bvo0jwf9L0RKJG7BmHPa/IYbzKJcPdCToacYo6KG5nB0IPR8JcpvAZ
         eYfm1RFqSCGvrBWm7Bvly61x8/08rVrz5bsB6K8c+g1A/9sNn37zl0ifeBTsn7vGGuQc
         eouZlqBJnw1ZK2tdnu6gQxeUkrFG8p87rHQnKQVOFS+m2v+Q1+1saWHA0P5IkFckRgAx
         Xw/zS+O4X9aHVJ3uPMqIO4BPrtwHftNvTVnlKyi9LSkC6ASHjxUUxAwvf2275UhoCWzL
         e19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K2e3bFQa+oawqSym7M7CIXxMV9WUDMKPC9LZ+dDg5Dc=;
        b=afUXRpSt8/HyTVHrkrEi5eIsr6ft9qgXiSPTdAnlEQ73Eryqxu+X2spUyjsQTFEPx+
         ThpgTfqlhLnmT8SIdtc3yFm3UIhGqwLiMe161cLynmtLm6IHeGzo0uknEx+An2cQSg45
         VbYQw3LSS6oy6SVCCgBJpu9Z0eIqF1xaVXp3WVaAKg0bSgyn3WMcTWkQnzBGF6uw1I6f
         61ORMNpo4TlTVz4tvN2AbErqaWNXOTtm1dlo5UI9C84c7ReedYXhJOQXXZEGsSoecQug
         9Uefz0mX9cFzLwVZwro03ALX6nNSd4H+z2dlFtqfFVuKIUSgidWwyzKj9sI9M20XacxA
         CSHA==
X-Gm-Message-State: AOAM532uMuG+GA6FW9exCDuxLE97aQhVqvqTXqMouAraIVYsccFx4Z1g
        S1OI05g+9T56ZvNOcX7mIbZP8Ty7YfFvBvwA6OC8icABP3k=
X-Google-Smtp-Source: ABdhPJzIW/nTJKwDOyYZu3rojZP5bkU519CFGgaX6HuSNFILBt/KwLau7+SGWisWqp2iO7ZkEmEgXytrunrX4yOxwCc=
X-Received: by 2002:a25:c60a:: with SMTP id k10mr8209507ybf.264.1623963035164;
 Thu, 17 Jun 2021 13:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210617085321.Bluez.1.Ibf5dbfc72abf7d12ffbf18219832e19d965ba024@changeid>
 <60caa492.1c69fb81.29ed.5e49@mx.google.com>
In-Reply-To: <60caa492.1c69fb81.29ed.5e49@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 17 Jun 2021 13:50:24 -0700
Message-ID: <CABBYNZKS0brNmEh=STncEDJr72yC47KS6nfi=-PFStej__CUaw@mail.gmail.com>
Subject: Re: [Bluez] avdtp: Fix parsing capabilities
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Archie Pusaka <apusaka@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Wed, Jun 16, 2021 at 7:45 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=501973
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.63 seconds
> GitLint                       PASS      0.10 seconds
> Prep - Setup ELL              PASS      39.84 seconds
> Build - Prep                  PASS      0.10 seconds
> Build - Configure             PASS      6.94 seconds
> Build - Make                  PASS      171.48 seconds
> Make Check                    PASS      8.72 seconds
> Make Distcheck                PASS      201.76 seconds
> Build w/ext ELL - Configure   PASS      6.95 seconds
> Build w/ext ELL - Make        PASS      161.26 seconds
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

Applied, thanks.

-- 
Luiz Augusto von Dentz

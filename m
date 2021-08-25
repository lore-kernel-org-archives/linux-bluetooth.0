Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788EAC432BE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Aug 2021 22:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59B0C61076
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Aug 2021 22:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhHYWOR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Aug 2021 18:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhHYWON (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Aug 2021 18:14:13 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6C0C061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Aug 2021 15:13:27 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id h29so625180vsr.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Aug 2021 15:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=OK/+jqAl453hx35MLn00NPeLf4ZPRP3aTgWBDICzl0g=;
        b=G8GfS+cMAA0MY//7COFS4cYrAvfmtHZleaZRYSdmuSP2fXIhrCs7OxTEc2jKi23YJ/
         Qc18SeDYwbvlNvXAH2eemCeAvZXjwzVWGDKVR8/Uye9RFOguCDdpHy9OTLEmI3D6D4JD
         bFq2MBUoIXb3g2UK756IA5bLHKXBeK+nJSuQS+itN4HKb7a2m1x1hj8bKfUNEqYAkShh
         J19kMEn1fhIqbMsKYPqc732u3hDB1zHi9wuHmU4yzhGdliy9BRW5nSOGqKM4qfcTAJAs
         3niYmZOH0I1hxcRA6F55lsgiL8cgwGI8hoGC5OCd1VD1WAUaUA5ue4VXfg4w7sOhcgML
         ZcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=OK/+jqAl453hx35MLn00NPeLf4ZPRP3aTgWBDICzl0g=;
        b=CUVQMnGbwSj9gwJtuYgDxaA+OdCjjfG293KEV6xR0QgLILeEw6gQNrt3E9Qb9bwulm
         oJg0hXy6sLf3cexXTxDXAPduvQe319eGL0P83Cy2WQxy/OrkqZLqaSRkk2apFLyu8lgf
         72pdBYjsd35d5vGRf598NHDZred2h2b+lXH2MpiKcdM1j9XgJOPzNqPeRE7PbGavyYaK
         iN1kRHWFFizv/q7dMRh4qbj4lAngjN5e8yhtuThl2ciY0BUE/eqhw+uGLGzUQ+S/mZ9v
         lbVaCtjqtSbtmRen83UjjP8lMUV43MuzvG41Pd2ycy9oa21DA2U0YvE94uAYg4lzyose
         5WNQ==
X-Gm-Message-State: AOAM532AaGWjP8dc2Stk8nQT0D6rLUo5TAu10Dg+rfkL8A6tzim8K4H3
        UCHKs/kAofFHJobBjt1JAovpMKKNWTdb7/6m8zVTB/Hh
X-Google-Smtp-Source: ABdhPJwkL1O7TK8jGIZqZ/0rZ1ZXD8OCVGLkPYsDT2f+cOUJqQz0bKNmTxnShZIFPa7rRFHvJZyiJdlmtg9xrRvOy60=
X-Received: by 2002:a67:1d07:: with SMTP id d7mr669892vsd.25.1629929606223;
 Wed, 25 Aug 2021 15:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210824225202.826941-1-luiz.dentz@gmail.com> <61258229.1c69fb81.8af0c.f2e0@mx.google.com>
In-Reply-To: <61258229.1c69fb81.8af0c.f2e0@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 25 Aug 2021 15:13:15 -0700
Message-ID: <CABBYNZKyWxSWuGV4VcsuhbpPFnrcNi1WCHLrYniHf=9McBQ3PQ@mail.gmail.com>
Subject: Re: [BlueZ] device: Remove GATT Attribute when device is removed
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, Aug 24, 2021 at 4:35 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=536773
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.26 seconds
> GitLint                       PASS      0.10 seconds
> Prep - Setup ELL              PASS      39.79 seconds
> Build - Prep                  PASS      0.10 seconds
> Build - Configure             PASS      6.95 seconds
> Build - Make                  PASS      173.06 seconds
> Make Check                    PASS      8.48 seconds
> Make Distcheck                PASS      204.33 seconds
> Build w/ext ELL - Configure   PASS      7.06 seconds
> Build w/ext ELL - Make        PASS      163.01 seconds
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

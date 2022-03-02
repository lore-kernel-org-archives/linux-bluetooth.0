Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3437CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Mar 2022 23:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiCBX4G (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Mar 2022 18:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiCBX4C (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Mar 2022 18:56:02 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433AF1680A6
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Mar 2022 15:55:17 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id l25-20020a9d7a99000000b005af173a2875so3134352otn.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Mar 2022 15:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=c3/Uh5oMDF5135HoHCo87pTQpDIemur6Q6HFvcHOy1U=;
        b=lhwqje9+bAJPqc/Sq4CTO2qX+Nm6Uzl6/ZPq3WVN3Scjmn3H8wTFjq2FvMpjSARzqf
         6tgQQbv7rScQ22oBCmskiNONp2ULUaMjRXCdT4Fs0E0ltjflpYuY5gjytmV8k9YAltc5
         GjUI30kGWdqGxz798T/uviowTPFzAiu8kdHfyov30dM9yHXjipIynxOluSXLo00oALBS
         NzFq8ATN92NeZGDO3oLbRzjGPa03JrowycTJlM7QR5DRfRyEIh5SnmZ0jqzF62PGtuDZ
         6YdHYxqWu6qNNQxEnXqggi3HG2U2KxSGreSKjZmXBtiEWgg62rvXMv40cshE29P3uP7Y
         ebgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=c3/Uh5oMDF5135HoHCo87pTQpDIemur6Q6HFvcHOy1U=;
        b=vEWs3UgAlxXiuxYDNSeLyd2nh1H3UGO8DIjCRSkjwYmtSy6vhbS5rXrW/CBr2nqpF8
         WKBkliHTOC4EIaRB2VLuzTXmupz82bOv6HvsaqIvrtpC7rMD5wllz6lBHrDu0thDIs7+
         zcmMwb4cMSAW5WuWsY3KzBMB+tBdO6xGBj7USvp0ZCGZ9yZ9qTFEGKgZklGGJZhQKVUE
         b3n5YvuTQp2LGhaFkQL9sG4rL9e+XCzrd6aWE/A226sYfdO22q2Uf8RJWiKaGregUiIg
         cN15dDEen64Tu8UvpKR7Hs8umVuneTHGDr1HJ09sNEBPe4u1LBuXzorzHCewRY0f9b9D
         eK0w==
X-Gm-Message-State: AOAM532iZp6iOCJrRf9vkION0KvLjggjDTUFtGTKSC7c5br20UQSQdGV
        9Uu/Fube3yQlWPXMGl18cbsRO9dsbj1W+mXmvKGMePiV
X-Google-Smtp-Source: ABdhPJxYTBFVRtFYbEJWjG90jP4uKZ2h3R7gz7cL845JcUx4fTE8kYmrJ7s0ejLvZq4S9SLxxRHI06qkIcblv6XrfLQ=
X-Received: by 2002:a81:f0c:0:b0:2d6:83ab:7605 with SMTP id
 12-20020a810f0c000000b002d683ab7605mr32487006ywp.150.1646263370144; Wed, 02
 Mar 2022 15:22:50 -0800 (PST)
MIME-Version: 1.0
References: <20220301233053.109920-1-luiz.dentz@gmail.com> <621ebcd4.1c69fb81.e52ea.fd21@mx.google.com>
In-Reply-To: <621ebcd4.1c69fb81.e52ea.fd21@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 2 Mar 2022 15:22:39 -0800
Message-ID: <CABBYNZ+9ba9_4xQDgjBbCpcaVWcKO_KWx_JNrLGH_iBWoWWjeA@mail.gmail.com>
Subject: Re: [BlueZ] test-runner: Fix parsing of command line
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, Mar 1, 2022 at 4:39 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=619350
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.54 seconds
> GitLint                       PASS      1.02 seconds
> Prep - Setup ELL              PASS      48.50 seconds
> Build - Prep                  PASS      0.79 seconds
> Build - Configure             PASS      9.42 seconds
> Build - Make                  PASS      1383.88 seconds
> Make Check                    PASS      12.20 seconds
> Make Check w/Valgrind         PASS      499.39 seconds
> Make Distcheck                PASS      262.03 seconds
> Build w/ext ELL - Configure   PASS      10.36 seconds
> Build w/ext ELL - Make        PASS      1368.58 seconds
> Incremental Build with patchesPASS      0.00 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth
>
Pushed.

-- 
Luiz Augusto von Dentz

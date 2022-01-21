Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3904DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Jan 2022 22:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbiAUWNe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Jan 2022 17:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiAUWNd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Jan 2022 17:13:33 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0833CC06173B
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jan 2022 14:13:33 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id g14so31385588ybs.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jan 2022 14:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=RzbzprbmERQ/ecYcSqkbG19eL3YdIDh05Yq0DWzJAaE=;
        b=h4xrNMgywp3RxDrjmS1K9O665Om4jXqKToGPb3u1Ai2IwzkCIpjKm4E85R85IIRV/h
         kepvQZ5cWQC7auWOmueHclWdoafWZbO6zyCgrVDgLW3dnmHI/HbYKN3JFWIZRbrlD5eM
         L0hj5JL/zkj/Mp7uDGdetM2pbg4IyRk2ceqHFaP1MITbkCf2E3v6XS5RhlDFk8+VjlO/
         MG7p5wk9Tw0uDo520ASbR4gnlHmLWgL2qdIdgoBmgLpxGzfblRjfnIe+jN+SVIyS63ed
         N4WQGov2HVm/1Mti4DOd4zFGQEDgEjScxs0inOuXSTjBkjGMtj7z90E5akYroDPWuCmp
         ppDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=RzbzprbmERQ/ecYcSqkbG19eL3YdIDh05Yq0DWzJAaE=;
        b=39FGY+/3z+nFaB7gOtYxP3s/e3E0SbudIH3s96grwlQJhQs5TbiXbGXz4HXr7ylMeh
         Bag34X8p+6afmQlKeFQ91X5wUWxMSO3JaKBVgWxoRNcO1axUFxe1XSvsbUfCR/TSbr66
         SujXXCO2NHjYy95g1Ne3ay6A4tFMsf8vSstxWNH2zn83XclPOl3dkfe6eYDBwe/2U0tR
         eOIFdlDSQtJmh77eTrOu8CQUEJY8INsK/k7dXhwZwHkxb8fZZWTLzNN2Fb5F1xUOTCA2
         TMeGVMWPqtb84ls2M4lU3Sra5imDyULjENrJZVRvV4h6vExc5SDTxWbMvib+BxeeepGk
         jRFA==
X-Gm-Message-State: AOAM531SZ30Mq/lCuaJgAJg0zWJmg4UcRpY89bcU3NLZxSOI3UwdsuY9
        LOdQkJzQBD88Qj2nYyD9g5GJE3jDGIkZn87KQ10A13hqr20=
X-Google-Smtp-Source: ABdhPJyXsw5Qhv5fXcttKjvv2nOUtv6K9Xvong9T3381NBGnx/oX6XM4Cl3RsWL84OZdeKGioH1xfZ2iMPg5B5E8P1g=
X-Received: by 2002:a25:b683:: with SMTP id s3mr8974419ybj.293.1642803212120;
 Fri, 21 Jan 2022 14:13:32 -0800 (PST)
MIME-Version: 1.0
References: <20220119002257.1428841-1-luiz.dentz@gmail.com> <61e773fc.1c69fb81.7f03d.d578@mx.google.com>
In-Reply-To: <61e773fc.1c69fb81.7f03d.d578@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 21 Jan 2022 14:13:21 -0800
Message-ID: <CABBYNZ+CqY3dJjc2PVTqcCjYEqpBT72rBa_UND_bzY=dkq0Erg@mail.gmail.com>
Subject: Re: [BlueZ] hog-lib: Make use of UHID_CREATE2
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, Jan 18, 2022 at 6:14 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=606425
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.69 seconds
> GitLint                       PASS      0.36 seconds
> Prep - Setup ELL              PASS      42.37 seconds
> Build - Prep                  PASS      0.42 seconds
> Build - Configure             PASS      8.16 seconds
> Build - Make                  PASS      1409.22 seconds
> Make Check                    PASS      10.96 seconds
> Make Check w/Valgrind         PASS      440.84 seconds
> Make Distcheck                PASS      228.14 seconds
> Build w/ext ELL - Configure   PASS      8.25 seconds
> Build w/ext ELL - Make        PASS      1397.65 seconds
> Incremental Build with patchesPASS      0.00 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth

Pushed.

-- 
Luiz Augusto von Dentz

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862E4C43334
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Jun 2022 08:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbiF0IZo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Jun 2022 04:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbiF0IZn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Jun 2022 04:25:43 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71395624C
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jun 2022 01:25:42 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ge10so17480441ejb.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jun 2022 01:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=X1ZYkcNonUi8xla4l6VyX6ObjubtgJP9qSKvTS81tEE=;
        b=qcv/o90ghpVt01BbEpMD//elgBIgDHmgKUPCZku7voePNkcvYFyJCBIyYBvkSPWsUj
         /W6mNFBweq3/vDo2C7FeUxTH1lgqLLWe2rxnCpSvFPN1uYZ2bH3FXWpiUCq0iw+Bwlkj
         cJgVHGz6CgC8v4GwraQP74jdPigICksmChnjjoKkcotBtxOjdhcaTTeRDTfLLpZyhYua
         QGz5oe8i7N/D2wvGCd6BHQWIVQ5WJwOtS5V5lzp5PDgnnVYLQYcyIuaEKfF1VSGEY7EW
         Hw/oo+roDh4rwRdhaYdU3p0ojATQzW7EI8hpdgz9aSjAbcKfJeGO8xVG5UIOHLd1eXas
         5hXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=X1ZYkcNonUi8xla4l6VyX6ObjubtgJP9qSKvTS81tEE=;
        b=DTh/kQxAdujDa+LcAn5sQS4oSjzYXVkKMuXs5KD13RG1SbNrVj5A4ihFC7GZ+bvlCu
         d1MXNW9zGA0oqCzhxdtAGFRHOKrn4iRM7DcFZokpWZdMVLd9dU6bRmfzyV4RT8d887ZX
         rSRjMjmQC+4rDLNEVNZBik/15wR4VGFSBuC+5SfEXP4+weXmKajYKyD4SBtxt/154lhN
         fiMA0ZcR4N3BBABUNtXMe1KN3eHDnyLXtCIo4MkFE4E8IxdgU/bI63vzHt7ZT+FHs+MM
         sQ1j3Ba9AIcr4SvL0gCf1rGfGOF4OwEuvkVO2HNxIyQSgWROE7h/kdJ8rd1Iq5d+T4bu
         vD2w==
X-Gm-Message-State: AJIora82UMycrOzF8KjkHiWC6EENi+MLr9eKNAKZHPm9K5qp3MHkDKfk
        QU76n/QZVzdTP1FglTavq5JtPD7PZ7xpCdJig1iYnUXmTB8=
X-Google-Smtp-Source: AGRyM1sc6D2LofDp8Q0cwop/sZdvGhath9iK/LBlZLUhmwbp3Uu6MsQGLTb46M7EL9sZ4M7H5Ovg4pm1MAW8saZFv70=
X-Received: by 2002:a17:907:7e9d:b0:726:9a17:6a0e with SMTP id
 qb29-20020a1709077e9d00b007269a176a0emr6046819ejc.257.1656318340958; Mon, 27
 Jun 2022 01:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220624082541.51687-1-szymon.janc@codecoup.pl> <62b583e4.1c69fb81.57c65.133d@mx.google.com>
In-Reply-To: <62b583e4.1c69fb81.57c65.133d@mx.google.com>
From:   Szymon Janc <szymon.janc@codecoup.pl>
Date:   Mon, 27 Jun 2022 10:25:30 +0200
Message-ID: <CAAEJBhKeyY6Y0CAqunH1TXW-f04Of8+mHs-4r=195TE2q=-Rug@mail.gmail.com>
Subject: Re: monitor: Fix crash when using RTT backend
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Fri, 24 Jun 2022 at 11:29, <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=653494
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.09 seconds
> GitLint                       PASS      0.73 seconds
> Prep - Setup ELL              PASS      43.22 seconds
> Build - Prep                  PASS      0.55 seconds
> Build - Configure             PASS      8.74 seconds
> Build - Make                  PASS      1280.85 seconds
> Make Check                    PASS      11.53 seconds
> Make Check w/Valgrind         PASS      433.72 seconds
> Make Distcheck                PASS      225.36 seconds
> Build w/ext ELL - Configure   PASS      8.31 seconds
> Build w/ext ELL - Make        PASS      1228.49 seconds
> Incremental Build with patchesPASS      0.00 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth
>

Applied.

-- 
pozdrawiam
Szymon K. Janc

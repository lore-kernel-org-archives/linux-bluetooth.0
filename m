Return-Path: <SRS0=pby4=AY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4469EC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 06:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B58920791
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 06:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3F9LSHw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbgGMGVK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728463AbgGMGVK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jul 2020 02:21:10 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C11C061794
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2020 23:21:10 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id i18so10199584ilk.10
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2020 23:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h4CintOxCJTb1rZhZ+UdVT8MIuTrjLv1VUQEptjjqko=;
        b=K3F9LSHwPzlZ9x9z0kFRnWC0uAp006SVtLvwdNYlndkuhxrL9+S7E7K1UxuMpxIHaQ
         X8ez5yqWm2swVms3Ouf2X6HffxNS3LE+q1Il3rGd4qltLZbLmHUj5wOkJD88RVvU4V3D
         HH5osWpCOiEfE1WToL7ezBubrdQCkTZPnK/QnGPP1DcuCFi1TlWrTQ/f0NswEvWAcF2W
         /QvnbHRwCRz4FatGSJk6nB0f3sJl7wyrf+pW4/j0V1/qz/t8+XY+VNf0Fp13F3k/C9eR
         PlbIseQekz48JOLLLcHYR/mtowmBpIxuRzgtmCVWSfpXF311hURcMU8J7rYYVMum/bm/
         IoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h4CintOxCJTb1rZhZ+UdVT8MIuTrjLv1VUQEptjjqko=;
        b=hpQWt4dvbRC2WrYgNJxWpicI+tXbxqoGsjrnYSUsM7xKMdcGSVhQJB9eY62NfcLNEf
         TWSMm6YtURD/kpwXUhDlwVsldb1oAcr/jld1PmNmAWz4l02PRcBDBpzFUViF2BgKMUzd
         qUmxXvFSZPilwyGPTsk4qa/s6t6MKJ+k+5EwXTnykGsflaFOU7TmXK5DPIcd98LOhCwL
         Kzui/rlB5Axt67yqirIxR2D0OzxDyoc17vQsIV/cesavNBI5cDaZGn3DWFv/DeXX3Xvv
         IUeuQMXdVy7MzVHQTHKf9iULgAKAgQQ3MXgkAEUeDKKZfGhFFnrVUd8nJsB5CsG5jfLv
         U7HA==
X-Gm-Message-State: AOAM530+nWxelqD3+H7sW7EH1ajPyadZH1/3pqmQL9JDr1ReYfEKmE+S
        lV1k3uqLvw43vAnNC3x2TCuunEKvev8NE4sXL9Q=
X-Google-Smtp-Source: ABdhPJxvfKx+pQ0cdNgeKbHvP48JPiumYI+f0z5MDjSmNqS9Pb2Tqx0idn1T6BFRfgbVZuiDTe+GK0yKJa4SMqygPoo=
X-Received: by 2002:a92:aa92:: with SMTP id p18mr63077577ill.199.1594621269557;
 Sun, 12 Jul 2020 23:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200701100432.28038-1-sathish.narasimman@intel.com>
 <20200701100432.28038-9-sathish.narasimman@intel.com> <10FB84C9-79E7-48F9-88A5-B10FB67CB585@holtmann.org>
In-Reply-To: <10FB84C9-79E7-48F9-88A5-B10FB67CB585@holtmann.org>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Mon, 13 Jul 2020 11:50:58 +0530
Message-ID: <CAOVXEJ++6NLoZ+T3mpcR4JnHdm7t-O5CciNZpOFu9QOp12-0cw@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] Bluetooth: Add support to enable LL PRIVACY using set_privacy
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Sathish Narasimman <sathish.narasimman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel

On Thu, Jul 2, 2020 at 6:51 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Sathish,
>
> > Enable LL Privacy using mgmt set_privacy command. The privacy
> > value 0x03 is used here to enable LL Privacy.
> > Still to use LL Privacy controller support is must.
>
> that is not what I meant. And it is also misleading since Set Privacy is enabling RPA usage and not RPA resolution. So what I meant was using the Set Experimental Features mgmt command to enable usage of RPA resolution in the controller.

Updated v4 of the patches
Please review them

>
> Regards
>
> Marcel
>

Regards
Sathish N

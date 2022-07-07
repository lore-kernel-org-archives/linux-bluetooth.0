Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2F4C43334
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Jul 2022 20:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236597AbiGGU1G (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Jul 2022 16:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbiGGU1D (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Jul 2022 16:27:03 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CC72A940
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Jul 2022 13:27:02 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z25so15473166lfr.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Jul 2022 13:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EIXz3j3gvSzpEfFLZOiBRHBJHtYNJ4jD1XNeoWqpLec=;
        b=XrWpYY2CSy0XPgliWbUa7RxYVHjAjDOOWQswo06yDBzF8i0ovoYJk1tDjpgGlFPnHD
         7rBBObr2nIPsgBcwDvFDpIqj9p9BJhk7I3FUhyDtqoiKKhu/d64peohrOkJGIRSUOcS9
         Uw3n+eS1DHWzfnkE/tL18KNFsTYPe7jDooSo57AaTpL44DWz8G/wYrHc/US7uEq7ukqO
         7ZZJNWNk+YVtBkvLZ1FBSNtyTy7XmctIU04b2JIXrJ6dUUn4H504xcnHB7vUmvGSsBbn
         xCJtK4DCQRz5/gNqf7nDJ4rVJRItYzTaj7z3hyZjVxluXZkSRxwCqW+eb54fnWRixaow
         fOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EIXz3j3gvSzpEfFLZOiBRHBJHtYNJ4jD1XNeoWqpLec=;
        b=iZ1E+opiA1lnGqZzknJZ1wph27y3ZQRF612ytX4hZxDlPMNhjesw2b3mUHJ5STlWze
         sIWr5IHDgcPf5hD++8sHzSzKsWey553ANIIcujxxI3wn36sxNBRbsPypdj6lAVE3MKH2
         8rKpmxqT90LM9Sfi7u586D4KGb4YpCdRgZyZ3OU0vKydq+5ZwVbP8/DeOVJXbS+qwUut
         G5h+G7MLJw2mBYCVYVq0rIcGvuviR3ujxKtsUrlGg/s/qOpB3i3HEG/xbmqJUUUyQ/Hp
         muNWuqyIyPSgQHYenb+Smle6i3cY2Vi19zs1vJC0ttV3QoUGu8OwakUX4aAc9Qu3BPPI
         Xd2A==
X-Gm-Message-State: AJIora9zC3gtQr5A4wKhueIBPUVR5zwe7aHC3Z5gOM5zpcbIrGfW+UnN
        /+RMuNPF3JbzyLX7qsB/G+8OGbndOe2J6jFOcFo=
X-Google-Smtp-Source: AGRyM1tltY1wZyyFRqSJ/NHMqzMG0xgr/g01YN1S6H5heCk9N4SzB7Jq5fkVKljpSrEQGTTV2tNrNlkjz5+YBVbenQo=
X-Received: by 2002:a05:6512:108d:b0:481:6f3:e641 with SMTP id
 j13-20020a056512108d00b0048106f3e641mr29629467lfg.251.1657225621055; Thu, 07
 Jul 2022 13:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <SJ0PR13MB575532A88E75738299CB1636FEB49@SJ0PR13MB5755.namprd13.prod.outlook.com>
 <0b943515-915b-8bdd-2e60-a6f38e0db17a@eknoes.de>
In-Reply-To: <0b943515-915b-8bdd-2e60-a6f38e0db17a@eknoes.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 7 Jul 2022 13:26:49 -0700
Message-ID: <CABBYNZKVQKT2GD7hCei+1r08d5PoFjD8U76G=nLrGw4wQFCGuw@mail.gmail.com>
Subject: Re: Linux v5.4.199: Bluetooth: hci_event: Ignore multiple conn
 complete events
To:     =?UTF-8?Q?S=C3=B6nke_Huster?= <soenke.huster@eknoes.de>
Cc:     John Klug <John.Klug@multitech.com>,
        Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi John,

On Tue, Jun 28, 2022 at 11:35 PM S=C3=B6nke Huster <soenke.huster@eknoes.de=
> wrote:
>
> Hi John,
>
> On 25.06.22 00:46, John Klug wrote:
> > This patch updated for the 5.4.199 kernel on Friday, 24 June 2022 by
> > John Klug <john.klug@multitech.com>
>
> Thanks for backporting! I do not know how the process is for backporting =
patches to stable releases - do you need my Tested-by or Reviewed-by or sim=
ilar? I'll test it in the afternoon.
>
> Furthermore, I think it must go to stable, and there seem to be some guid=
ance how that works over here:
> https://www.kernel.org/doc/html/v4.17/process/stable-kernel-rules.html#op=
tion-3

This probably should be sent to stable tree directly, at least our CI
won't be able to test it as it expects to be applied to
bluetooth-next.

--=20
Luiz Augusto von Dentz

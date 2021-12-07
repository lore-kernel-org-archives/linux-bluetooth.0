Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDBBC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Dec 2021 21:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241698AbhLGVTI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Dec 2021 16:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241725AbhLGVTH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Dec 2021 16:19:07 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31703C061746
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Dec 2021 13:15:37 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id 30so942629uag.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Dec 2021 13:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Sv2/mHSddS9BAHHlYFBIc0U30hSp4hUin4/t6qC+/Ik=;
        b=E+r4eCIBiwC7ZHjsLc0ELgfs1Cck72NFEiL9pI5+KL1Rlj04dUXIdTsaqnHm8TP8IG
         ZkW7gUHD6Y8w9QSHohxY0MgTOjEMUKqvHelsWTWO4hudoDPzKpuqRqFlUwaegMtceT0E
         nLXcwvCsETSdXqUktI+Uh85QjKRqwa+RzSSWiFM8IgSVdHYwzYOG7Rff4lZKI3rD44UX
         Aqd/mzW47jTO8Q9RxFbHrdhQR5F8u8VDMFgZfq9THNxc2g8tdvWp4sn+OSw7L/8ri0W7
         3AE4KRhfvBdKK7QpvkdmF0KfXCKY7KPzMld6dRLF9bu9RlxN8H1HSkhGye4XGKev1qkW
         lFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Sv2/mHSddS9BAHHlYFBIc0U30hSp4hUin4/t6qC+/Ik=;
        b=h9M4Df82VLGb/1A6MLjGVPodbefzblUMw17ZLCQP88pXBcVzSzWCVoLcsXP0LfXXIl
         NI+VL9r8QTY0H+tjwnQN7mkfQoLckJ0IiRTRs2dr97VGPovk1wXuDlXd+fvXTKhxb7Lp
         Jm/gAuzn5q0UMAlCfV6YkmZir/jUyEASAWozqzGtNoxOg9fJdQ18RGjGr6HIZCLFcxdM
         nrJQ+3ZAJcJLkMHVQe+KyAITyZHKJtYOk6Dw5J01YduaSpOw7t7I4unw7PLVcUlnCorZ
         5wws7rcujIOsgQTuY+JGvtwDdiMt9ISAC2tQtWzgyASkzu/Rw0+aoP7OeHrpXoML7K2W
         tzqA==
X-Gm-Message-State: AOAM5312lfAqVLAeDulF1p14d80BhYhzj+bbtQMExVJ3wmDMjKz5QxB8
        N0PYCiYahrRlOdU3aCQMHHmLWotrxQLT4yjW0TK3aXkdTFQ=
X-Google-Smtp-Source: ABdhPJy4rIzuVP4cd3qknm7NtNYZU9jVti7+Nn9vLrsJpC6rAxATAzpiRZHIXKGBDD5CcZNlUCKOtcpt/k6k9vj/gEI=
X-Received: by 2002:ab0:4465:: with SMTP id m92mr2260192uam.47.1638911736234;
 Tue, 07 Dec 2021 13:15:36 -0800 (PST)
MIME-Version: 1.0
References: <CAC3L_ehiFCotnFo7G==70s09FQqbwJdt-SkrcLb6aj-XaS6-Cg@mail.gmail.com>
 <CAC3L_eiWPvM+ycvPfRXLbu9buwuqMNC-kCuGt6ABR3WTZJ95jQ@mail.gmail.com>
In-Reply-To: <CAC3L_eiWPvM+ycvPfRXLbu9buwuqMNC-kCuGt6ABR3WTZJ95jQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 7 Dec 2021 13:15:25 -0800
Message-ID: <CABBYNZKpuOKFYydC4bSBqQivjgwQN0bsR1i8OGaGLfK71v0ddw@mail.gmail.com>
Subject: Re: CVE-2021-43400 patch potentially introduces timeout on Chrc WriteValue
To:     =?UTF-8?Q?Ulisses_Ara=C3=BAjo_Costa?= 
        <ulissesaraujocosta@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ulisses,

On Mon, Dec 6, 2021 at 10:36 PM Ulisses Ara=C3=BAjo Costa
<ulissesaraujocosta@gmail.com> wrote:
>
> Hello,
>
> I am maintaining a custom embedded Linux (v5.4) with BlueZ 5.50 and a
> GATT application that runs on top of BlueZ DBus. We are interested in
> applying the patch for CVE-2021-43400. Based on the original patch* I
> have created another one for BlueZ 5.50, this produces a reproducible
> timeout every time I write into a GATT characteristic (sometimes the
> first write is successful, but all of the subsequent ones fail with
> -110 error).
>
> I tried 5.62 (where the patch is included already) and the same
> behaviour happened.
> I tried 5.61 without the patch and no problem with the WriteValue,
> when I applied the original patch* it also showed the same timeout
> behaviour.
>
> So, my guess is that the original patch for CVE-2021-43400 is
> triggering this timeout on the WriteValue.
>
> If needed I can provide more information or get adicional results.
>
> * https://git.kernel.org/pub/scm/bluetooth/bluez.git/patch/?id=3D838c0dc7=
641e1c991c0f3027bf94bee4606012f8

Make sure you also have the following change:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=3D259407032af=
93cc861b3648780f7478921172572

> Thanks,
> Ulisses Costa.



--=20
Luiz Augusto von Dentz

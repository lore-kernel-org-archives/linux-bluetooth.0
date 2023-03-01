Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B4DC64ED6
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Mar 2023 15:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCAPji (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Mar 2023 10:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjCAPje (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Mar 2023 10:39:34 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F1E42BD2
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Mar 2023 07:39:30 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id bj30so5323486oib.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Mar 2023 07:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677685169;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hGJaw4Jonq4cRnOfGphlDgYNIau6Yy3m1xjZlq6ZlPc=;
        b=VSOW9/KESvIXE0QANL7NfROiQNcZUZTg97/cPaGO/GGoGJkhTO7P3ULAto3K5+vzG+
         St9wiysvZTi/eJ8DwaSk8TybFzhqehcv8jWx5gJ7lUW7k0cfGJxRbQyNuqZlVElVupGr
         j8fdNsTpxEdduw/fv7roD5hpxgho9swwhbkBcPFoAmc0XmXtjyGdU6OkZWKVM35dg51N
         Z6l17IDSv8B/MG24Q/T1eiDSo3qRVbxgXzILC6V6vZhdYyq899mzgxQ6X0gXgHOYeA6i
         xwN/PZ1zq54Otl5TJNOgSnpbPzonS3IDwiHmQPe0ILQH2ABv++2DDRdLvke3Tbd/zeUv
         yNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677685169;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hGJaw4Jonq4cRnOfGphlDgYNIau6Yy3m1xjZlq6ZlPc=;
        b=TKaFBW/zoh/EjjUub/VJt4zOlVu8jKNhysGVFfRnrn05Di5JxBr0yfDvTsHsB/lN1h
         itQYxPwjIQRp8riHrv5FncDcGeW1h6KyLOQySrwGr1eZGn04z1tNqEeCaf//DoiCCkP7
         MA4QYTGNmPf4Z04Of3o9O3N5FxgMFXwXKSYNz+YBQqB/Vr8XazF9YSAryMijI54sA+Zv
         +Iu3eNlkpeJv7MtlCOwSLBD9MTTd7EVnH+YGtgT6mTEESA8cBEYNlzD/bFoY3GSsb5zP
         a4NdW2KsYQkXsS+gDiwC8M2uhOOmhlnZYs2Yxu3YwnJ+60rUo+x0CHK7Ptz05em6+ahx
         aRZg==
X-Gm-Message-State: AO0yUKUmd2TzIbD0FMewFhF5gXNq1p6dU6n9fhcR4Qa95UqZms22LW77
        khrqM5N5+ybVWobpnSv0AQH7LCrfoZM=
X-Google-Smtp-Source: AK7set8vWLSNYOkX+hdjHOe8+8EbXV1FRhT53nPl1CLgEwLgE5thj8OtIzlNQYIVf+2mQbKCTqTN8Q==
X-Received: by 2002:a05:6808:3a85:b0:378:5f75:bf27 with SMTP id fb5-20020a0568083a8500b003785f75bf27mr3175805oib.50.1677685169245;
        Wed, 01 Mar 2023 07:39:29 -0800 (PST)
Received: from [172.17.0.2] ([65.52.35.4])
        by smtp.gmail.com with ESMTPSA id b5-20020aca3405000000b0037f879e46b9sm5872573oia.3.2023.03.01.07.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 07:39:28 -0800 (PST)
Message-ID: <63ff71b0.ca0a0220.edf70.b272@mx.google.com>
Date:   Wed, 01 Mar 2023 07:39:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0914322258335834317=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Add initial BASS support
In-Reply-To: <20230301153322.12555-2-iulia.tanasescu@nxp.com>
References: <20230301153322.12555-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0914322258335834317==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: src/shared/bap.c:108
error: src/shared/bap.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0914322258335834317==--

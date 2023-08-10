Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D62C001DE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Aug 2023 17:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbjHJRy4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Aug 2023 13:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbjHJRy4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Aug 2023 13:54:56 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495F210C3
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Aug 2023 10:54:55 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so18411321fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Aug 2023 10:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691690092; x=1692294892;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fC1IxObPN7cqkHgrFTkD5vZ9a0EpeBTON86KPAsS468=;
        b=aGWhy/jcZ2CSPM3k2KcAFzzJEo/FhpggTyIaDFdWyQtTXo2HoGX0Lu3+JmK//lZR2o
         6KduB9+VYymfaUd1h+mIs8y0AvVR0ZLwHZXLVI87d5nPUhMdeczEoBQVmwsobM4jJzxi
         clvMst9C/D30kEfEx6cmdLD7gtMnJYNy8p4G7/FnE9wR/VpIbogr8nUp9asKzXJDBVom
         HCQpqecrZCX954ULpcB0afaUBr/Fh9Xs5bL4rmsIgLbHzjgOLExMKetUaUM6xWWebdI8
         bH/P51v/bWcNndG+IUJp+ttdj41hoUPfvin9rjuECSvJBwL9Dg+4bDrZaai9LyU+FXqH
         trgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691690092; x=1692294892;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fC1IxObPN7cqkHgrFTkD5vZ9a0EpeBTON86KPAsS468=;
        b=SotKqptKh5evLp7fKb6ZHEfJTNT5LkOnITwiqCy84CQWx5aYwsXjL8rIBJ7lGaEECC
         wYUfbJMtjA8rKAIbztt7Bd6Z37sg3qlIGZY4bOc8wuzOgwA9bhnlavp/cxijGFSNeeQL
         3u9yKtZSXkTp9jxj6+rGGT9lMTYa3l5IuumNr52fKjN/rXtKwLMeyFh95DvBpFwCwhlb
         rIfXR7TjseYMB+JI3XsEsE+IIcxIVSVcDgTovW8s8mNpxOQ7JS8lo2SJFGhuLszNqLLC
         Qdpv+u01LdAlIQqxpyfnmds2qQrLNSJnkwtEYyDOj6Rjkvdsymr3PYe8fLZDXxasw9yg
         QN7Q==
X-Gm-Message-State: AOJu0Yy7AsiAyhxoWM8d3iaVqHzw8IT7TiwMPvllkyUOh0jkHNwLuOiz
        EE0adE41gyDkNl9PNtzzEKkw9925WbZxXbBZ6gsi8Sbx
X-Google-Smtp-Source: AGHT+IGKs6hO1xLJiKIGXdUWWmap35/lQW+pphUOTz4NkAYIGuWYWyr9yiO9VLj4QbmyTYV06wMfoAr1WaEspHY8+N8=
X-Received: by 2002:a2e:9dc6:0:b0:2b9:ebcb:9c80 with SMTP id
 x6-20020a2e9dc6000000b002b9ebcb9c80mr2658844ljj.39.1691690092297; Thu, 10 Aug
 2023 10:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230809235622.1664227-1-luiz.dentz@gmail.com> <64d43a91.0c0a0220.2d9ef.03cc@mx.google.com>
In-Reply-To: <64d43a91.0c0a0220.2d9ef.03cc@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 10 Aug 2023 10:54:40 -0700
Message-ID: <CABBYNZKEE8N=OEv9SQOp-7OC7GqV29yO5x=mpuUy5=S6tGQNFw@mail.gmail.com>
Subject: Re: Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Wed, Aug 9, 2023 at 6:17=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D774=
728
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.73 seconds
> GitLint                       PASS      0.34 seconds
> SubjectPrefix                 PASS      0.13 seconds
> BuildKernel                   PASS      34.17 seconds
> CheckAllWarning               PASS      36.99 seconds
> CheckSparse                   PASS      42.33 seconds
> CheckSmatch                   PASS      114.33 seconds
> BuildKernel32                 PASS      32.77 seconds
> TestRunnerSetup               PASS      497.41 seconds
> TestRunner_l2cap-tester       PASS      24.07 seconds
> TestRunner_iso-tester         PASS      48.08 seconds
> TestRunner_bnep-tester        PASS      10.83 seconds
> TestRunner_mgmt-tester        PASS      217.70 seconds
> TestRunner_rfcomm-tester      PASS      16.31 seconds
> TestRunner_sco-tester         PASS      19.30 seconds
> TestRunner_ioctl-tester       PASS      18.36 seconds
> TestRunner_mesh-tester        PASS      13.48 seconds
> TestRunner_smp-tester         PASS      14.60 seconds
> TestRunner_userchan-tester    PASS      11.31 seconds
> IncrementalBuild              PASS      30.92 seconds

Any comments on this one? Perhaps we should add a test for it as well
since I don't think it was reproducible with the existing tests.

--=20
Luiz Augusto von Dentz

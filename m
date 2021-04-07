Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73753C433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Apr 2021 00:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 445C1613C2
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Apr 2021 00:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245292AbhDGAOw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Apr 2021 20:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233917AbhDGAOw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Apr 2021 20:14:52 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CB9C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Apr 2021 17:14:42 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id y19-20020a0568301d93b02901b9f88a238eso16382518oti.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Apr 2021 17:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=12z29Le0OqIrYkd2T+EsN1vGKtzkWv+LB8f1AOUgSyI=;
        b=Wz1n8GFBPjbZNJBVPkvFvvmK/88NY94uPf6pjiQbzmiAoGzkxR6D8lzuMHoQPmWTzW
         a+Fcy9ZNBUvirbNXnfS25r8bWwLl5MROb6L9hvGusNHjl1yIsBfT3Hoav/KaJybSKI3F
         PhITCYqVvSlQq7Jdq+vTnfIdN8RB2S2zVSqSv9gYkmkUGMEvv8MbLc6fP/Ts8Ai4+/yz
         HGSuwOQl4zJPmVdgurktprTGyB7XUItr3MlX4zrG+Bz2Zs1+hm/REi58nLA0b0hxR7Tj
         170Kh4e1vA58gJ/WK2ASVone9L0B4d8WQ+1kQmmUtfQmcxlgckDC+kHLne1DBUJrcbTp
         VG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=12z29Le0OqIrYkd2T+EsN1vGKtzkWv+LB8f1AOUgSyI=;
        b=I2Wh9TM4QTHGltMV7b8QsHfODYlt11ei2063WsG3S44XcoTaYDwna2pAIoxUW+8QoK
         C/eD2WmA1NTF6utvZT3gvT/P5hyVaHzKnolpTItP4oaUc7P7K+3mUSENaASRRNyZg34x
         PdbbF3xhCVGAJSpof1BgAs75n85no27R3nKdtPqixb31fuIqfQIds6o8Zf6heUtyT+uF
         rv0b0IT5CcJVm3jfgJNkZnC5/cWBkxgGkAv2/kZJX8Z0XIU1svQ47D8xitDwMseJ53k+
         7orrL3G2U548sGEUxPt0Lfu+n+z0eee53/WQ9dlcIhEK+SIK2QB2xHGQbbIebTb37q88
         BcTw==
X-Gm-Message-State: AOAM532+Amyge97HT2jhQ9cTm+a/bHOeMH/Dbo3CgGY21UsKox0Ok41a
        it3oF5ZBcgNpFnctpIdDG2yCMV8gpDGxwTODlSB1J2kz1gI=
X-Google-Smtp-Source: ABdhPJxi/ElbJAZQ7jTVrYcNlOuuDEH89Hph4PtAaa5ud+iYMKf1LyyWFZLLTaNJ3QsTdWrUPihcOSxAf0FdDhps0vk=
X-Received: by 2002:a9d:7cd2:: with SMTP id r18mr597836otn.240.1617754481599;
 Tue, 06 Apr 2021 17:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210316144136.410-2-cdwhite13@gmail.com> <6050c8be.1c69fb81.680f3.60d3@mx.google.com>
 <CABBYNZK_97ebCpdDHMSDLubu6o_zJw1W0xndmU3zySMcxjJyDA@mail.gmail.com>
In-Reply-To: <CABBYNZK_97ebCpdDHMSDLubu6o_zJw1W0xndmU3zySMcxjJyDA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 6 Apr 2021 17:14:30 -0700
Message-ID: <CABBYNZ+0MAVhUkMy+zGJ5LkCkB7KpyML7dEh0UcEGaeLpm44-Q@mail.gmail.com>
Subject: Re: emulator: Add Create BIG command in emulator
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     cdwhite13@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Chris,

On Tue, Mar 16, 2021 at 6:18 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Chris,
>
> On Tue, Mar 16, 2021 at 3:46 PM <bluez.test.bot@gmail.com> wrote:
> >
> > This is automated email and please do not reply to this email!
> >
> > Dear submitter,
> >
> > Thank you for submitting the patches to the linux bluetooth mailing lis=
t.
> > This is a CI test results with your patch series:
> > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D4=
49125
> >
> > ---Test result---
> >
> > ##############################
> > Test: CheckPatch - PASS
> >
> > ##############################
> > Test: CheckGitLint - PASS
> >
> > ##############################
> > Test: CheckBuild - FAIL
> > Output:
> > emulator/btdev.c: In function =E2=80=98cmd_create_big_complete=E2=80=99=
:
> > emulator/btdev.c:4529:6: error: =E2=80=98struct bt_hci_evt_le_big_compl=
ete=E2=80=99 has no member named =E2=80=98big_id=E2=80=99
> >  4529 |   evt.big_id =3D cmd->big_id;
> >       |      ^
> > emulator/btdev.c:4529:19: error: =E2=80=98const struct bt_hci_cmd_le_cr=
eate_big=E2=80=99 has no member named =E2=80=98big_id=E2=80=99
> >  4529 |   evt.big_id =3D cmd->big_id;
> >       |                   ^~
> > make[1]: *** [Makefile:6794: emulator/btdev.o] Error 1
> > make: *** [Makefile:4023: all] Error 2
>
> There is some build errors, big_id has been renamed to handle at some
> point, you should always rebase on top to master before submitting
> upstream otherwise these errors could happen.

Ive fixed these myself, they are not applied.

>
> >
> > ##############################
> > Test: MakeCheck - SKIPPED
> > Output:
> > checkbuild not success
> >
> >
> >
> > ---
> > Regards,
> > Linux Bluetooth
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

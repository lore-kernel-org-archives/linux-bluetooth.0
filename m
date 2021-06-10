Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE48C48BD1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jun 2021 20:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21C26613E9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jun 2021 20:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhFJUye (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Jun 2021 16:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhFJUyd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Jun 2021 16:54:33 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A130C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jun 2021 13:52:23 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id b13so1227634ybk.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jun 2021 13:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+1sPzTurp4wqo2OLG72xu3f4JnLHRA4Rv7k/HLdpytc=;
        b=L2RbdwPdgSd/yQLh3knxxSlGUVcm6C4K3KrGmfuP+ppB4S2ZldV6hxAItZyFU94vwr
         9Yom5mCte05/PhmWKFeSQqIMo51QtADy2m1qgOq/3Gf+0Qjd49u0dB3RAhP+lcL4EEiI
         aOajF3XnM5Zo+FJ18z6ldrSA1GT8sc8agHXFq8q+22hKOvl84akyxI6xzXeKT6QnFJiJ
         /IE5UvVcllLty+qs4GMT4SKCe3aHnXE9kizg8WnW4F+/WWApLgXzNwkQRUrBnZ/7H6Dn
         TylM41CIGv83WdsE+dScHPgqACH/8BTtjw4tzR14Cll/Hi6nYakwoMSs13ImJu9NKeqA
         91Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+1sPzTurp4wqo2OLG72xu3f4JnLHRA4Rv7k/HLdpytc=;
        b=Hg/7auUNlEJ0JEL03YIJZUsr6MV844lAuADYTc58tWuJbDbIly6wGSuwxvpUU7dXtf
         AityvtN5daf5UFvZ8ZULznlq/8wpP/lvaEghaBzChcJNAlg6dGofIcfARQ7avK4jzh57
         cUzOG3N459eb9WG5VvPFUfVRCoZ3U1OFsSuB6hJn6LHR5xmQxLhZvop6Npiq+ENqxKdv
         fQBrIlfCoZaBelvH1zKxjomDmFJ4YgSEQ6QjNcQnjDAa62UNi79TKwz/DSRX+JqMIDa9
         8Ng9P3poSLzAT9I73p5x0rZdMelK5EyYp2vD1ALdkLDrebtPEWq3HO3rbOnG639cqf8o
         TNTw==
X-Gm-Message-State: AOAM53284zk/QTJNW1nCKPperMSq0ZV1qcA0Pw5gaGWjwGzibMhGCCx7
        Fr+SkhCJoU8hTWbmhy6EASsFvVeHIPOsnlpiT0uy1i12
X-Google-Smtp-Source: ABdhPJxFTHpdRgJr/KAYuAjtIWyPolTcnrNnEgRLy15LeuwwXOM06FMSbWhv4A5hMzAmNlDAaEDjrycp1KhguNpfQsc=
X-Received: by 2002:a25:a2c5:: with SMTP id c5mr961356ybn.432.1623358339524;
 Thu, 10 Jun 2021 13:52:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210609222035.297833-1-luiz.dentz@gmail.com> <20210609222035.297833-2-luiz.dentz@gmail.com>
 <3E85B755-5B79-4DD3-AD17-F8907B5E854F@holtmann.org>
In-Reply-To: <3E85B755-5B79-4DD3-AD17-F8907B5E854F@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 10 Jun 2021 13:52:08 -0700
Message-ID: <CABBYNZ+ZkZ7bOJSbTjSZzxS0V-2vVN9NtvZZgRAKbiK9m9PYoQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: HCI: Fix Set Extended (Scan Response) Data
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Thu, Jun 10, 2021 at 12:37 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > These command do have variable length and the length can go up to 251,
> > so this changes the struct to not use a fixed size and then when
> > creating the PDU only the actual length of the data send to the
> > controller.
> >
> > Fixes: a0fb3726ba551 ("Bluetooth: Use Set ext adv/scan rsp data if
> > controller supports")
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > include/net/bluetooth/hci.h      |  6 ++--
> > include/net/bluetooth/hci_core.h |  8 ++---
> > net/bluetooth/hci_request.c      | 51 ++++++++++++++++++--------------
> > 3 files changed, 37 insertions(+), 28 deletions(-)
>
> I assume you accidentally send this again.

Yep, it was stuck in my outbox for some reason.

>
> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz

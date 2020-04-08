Return-Path: <SRS0=PsJ4=5Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402D6C2D0F4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Apr 2020 03:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E9822075E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Apr 2020 03:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Heqe4Anh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgDHDmA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Apr 2020 23:42:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55601 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgDHDmA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Apr 2020 23:42:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id e26so3686591wmk.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2020 20:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DPd8oVV9nWQKthBDemCYwDjl2nHGDrPidU8Al5wfRuM=;
        b=Heqe4AnhZLQq2qhwbug3VW0E1cSi1V02apJhg4WQmm4bJiNhJbIVLhzvUuRP/u0Dua
         yZ1sBXTnAG+evJG1TCRpcoo7CyBNlrnXrtRaNW0+XH+SX4J7dE0oqk3FQaPK2unN6RQx
         kbcdvUTXGwo5X5ct4euqeO8iMIYAp8HZwHf8kBm2Ga3bauua58uCh/MwbfrAqZRXCqr9
         r7yGYYifJnYSZvxw5r/5kVwdj4gCa0dMPoL/cxZymR3wf1wTQk6UVG4ABJssFjHjXXg6
         c2gBqRUT4Xnx/ZtM29TJny425CfpNLFjabLEpACd5nNUPpY6HaYczoJJIBnHcQlcvDk9
         JoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DPd8oVV9nWQKthBDemCYwDjl2nHGDrPidU8Al5wfRuM=;
        b=QnVqFplhq9dEQYtWIJOUszgw7uos3O56ycWiKnZmpaTbSi7R80xoMj+/WQ5zt9k8lb
         SyxlHFuh27p5qNs7mlt/1LOMIzykOE+nHAeJqZiK0oaUUMV9U9XrH4KQzw5cojfhupCc
         n91uU765IJu/TpFVgnCE+K0UAqlTkSRjg7GF9PGGaQLMQ45VdTtuQ3lNcq1qF/fnXY74
         pDQK6cMg9Nag2YcVBlKnEUCF3f1GpdU7uqtLpuexTkGwYhP1Szrxga88pNCXTcL5Igev
         +43TCKb6DEyS4mYbZqvDy0wiY5NqPBoV6OmV26z3rreattpr8dF7Cf+or7wYaLF7Esjx
         UY6g==
X-Gm-Message-State: AGi0Pua+q+7jkIOf7capZDFsOz7XH7qS7/ukDdPwNFNmNWr9b1/dtQUS
        h4TPZTAbS76D3cckaZFNLudd+UReRVgizpgtVnEkIA==
X-Google-Smtp-Source: APiQypJ2uW8RVoV6V5j9n0kNqleKxKl5olRjEHn4rbQNRbMflUpW9R+oIfTVWZqaNpDAc+3dV4/YSt81bayWaYtO4Co=
X-Received: by 2002:a05:600c:114d:: with SMTP id z13mr2439785wmz.54.1586317316344;
 Tue, 07 Apr 2020 20:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200407085610.231013-1-apusaka@google.com> <CABBYNZ+3SUbZbO+BJ7BX3uj5dds=KzWpe316SghncrOE8ikLBw@mail.gmail.com>
In-Reply-To: <CABBYNZ+3SUbZbO+BJ7BX3uj5dds=KzWpe316SghncrOE8ikLBw@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Wed, 8 Apr 2020 11:41:45 +0800
Message-ID: <CAJQfnxHTiJ6ft5TF=8YC2KxWkBL3r57AoR8YTh96-T2uNt4mHg@mail.gmail.com>
Subject: Re: [Bluez PATCH v4 0/4] Check the signature of att packets
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Wed, 8 Apr 2020 at 04:07, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Archie,
>
> On Tue, Apr 7, 2020 at 1:56 AM Archie Pusaka <apusaka@google.com> wrote:
> >
> > From: Archie Pusaka <apusaka@chromium.org>
> >
> > According to bluetooth spec Ver 5.1, Vol 3, Part C (GAP), 10.4.2
> > A device receiving signed data shall authenticate it by performing
> > the Signing Algorithm. The signed data shall be authenticated by
> > performing the Signing Algorithm where m is the Data PDU to be
> > authenticated, k is the stored CSRK and the SignCounter is the
> > received counter value. If the MAC computed by the Signing
> > Algorithm does not match the received MAC, the verification fails
> > and the Host shall ignore the received Data PDU.
> >
> > Currently bluez ignore the signature of received signed att
> > packets, as the function bt_crypto_sign_att() only generates the
> > signature, and not actually make any check about the genuineness
> > of the signature itself.
> >
> > This patch also fix a wrong boolean condition which prevents
> > handle_signed() to be called.
> >
> > Tested to pass these BT certification test
> > SM/MAS/SIGN/BV-03-C
> > SM/MAS/SIGN/BI-01-C
> >
> > Changes in v4:
> > - Fix wrong variable assignment
> > - Fixing test-gatt.c
> >
> > Changes in v3:
> > - Add check for the case where pdu_len < ATT_SIGN_LEN
> > - Add unit test
> > - Separate into three patches
> >
> > Changes in v2:
> > - Move the signature verification part to crypto.c
> > - Attempt not to copy the whole pdu while verifying the signature
> >   by not separating the opcode from the rest of pdu too early, so
> >   we don't have to rejoin them later.
> >
> > Archie Pusaka (4):
> >   shared/crypto: Add bt_crypto_verify_att_sign
> >   unit/test-crypto: test for bt_crypto_verify_att_sign
> >   shared/att: Check the signature of att packets
> >   unit/test-gatt: Fix unknown request with signed bit
> >
> >  src/shared/att.c    | 25 +++++++++----------
> >  src/shared/crypto.c | 28 +++++++++++++++++++--
> >  src/shared/crypto.h |  2 ++
> >  unit/test-crypto.c  | 59 +++++++++++++++++++++++++++++++++++++++++++++
> >  unit/test-gatt.c    | 32 ++++++++++++++++++++----
> >  5 files changed, 126 insertions(+), 20 deletions(-)
> >
> > --
> > 2.26.0.292.g33ef6b2f38-goog
>
> Ive applied 1-3 and reworked a little bit the third patch so we
> actually attempt to find a handler before we attempt to check the
> signature.

Ack, thanks a bunch!

Regards,
Archie

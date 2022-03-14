Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E895CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Mar 2022 17:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbiCNRbo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Mar 2022 13:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiCNRbn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Mar 2022 13:31:43 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DDABF77
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 10:30:33 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id u61so32179196ybi.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 10:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=raQa8Nmjc/PTxEEFNJJMTi3ZiAgiKKbCJubIMbYM3wo=;
        b=SDmd7Kxbeg2w9b9LUrUiJvT/z5RLs7fbXbpdak3nOZ+skC5pUjZ9bVvl9khBD1BD7d
         l+Lv4sQObp1Zpv6tFyhZlJNGvkKreyiF2r24l4AncFcoSY9/2XHDoE+1TSzVgYPRusjO
         kJL5M5wK19lPExQGB3wKf48n9ZqN9DFNUyl6OPscB3N9NuovaUxksZPC8zJf69Tjmqze
         15/80svrD8qd+v/FT8AfR3kfBIcvhHQ3Jv4gTR0H2lmzT6m4qirz7YkBxpwofLqFZxvf
         hVdehSJa1GP8wzXtPa6uROXh8uDgZyNJPFJhLhhf0OUfekNPZMP1Kcq3ldzjjc6kL6eJ
         YreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=raQa8Nmjc/PTxEEFNJJMTi3ZiAgiKKbCJubIMbYM3wo=;
        b=eFp03y204itfNvddlUWgL1MAaUetBVjwUSZsw+e6wYyuqL6H84qS0whMfNUFIuC+Os
         rNYSeMTh6ATiLKWPt+S2Tcdlrr2DSGqmX706SUfyp6qO6ugjQb6GpjcWvdjReHurlZNp
         BFw1yUXU22U49yK+Jw3ouz2Fx97NPDb9JcKC8uiYkcBDVxlMYNU5khoYXl3gqsWF9q/H
         rrJjapG4otXKqxLK/5P+EYdkhYOiZUdZgy7Ra6fTpjJ4/+bZQf6jCywtvcRBAf8IMWkh
         5w6CnWlu2ndYzo5qjYRt+NVRlOpMHlectTtR9PKBS+oVdBa88nUUSFrSz+k7BD5w91oh
         JAOQ==
X-Gm-Message-State: AOAM532ykrZnh3mWpEt8A2dza0pSTWDD9vIQuLg6UXeUABOe6sDa/uDp
        CpKJAws7k/AsHAYP3Z+l1nkHLq9QK1lJeIVqhTO8IEu/vXI=
X-Google-Smtp-Source: ABdhPJxc9rCXd8pqA23X7yPpesboSnK7S/Ja5Yt7VDZ8SevSB/uSTrG5AifritZRsPLSpJ03PP2dy37gLcgGZKeCNFE=
X-Received: by 2002:a25:8546:0:b0:61e:1d34:ec71 with SMTP id
 f6-20020a258546000000b0061e1d34ec71mr17939185ybn.259.1647279032831; Mon, 14
 Mar 2022 10:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220125185305.2419774-1-luiz.dentz@gmail.com> <20220314135044.2040-1-mike@fireburn.co.uk>
In-Reply-To: <20220314135044.2040-1-mike@fireburn.co.uk>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 14 Mar 2022 10:30:22 -0700
Message-ID: <CABBYNZJfVnjuo9JPtapiHrfoXUoDYRQ0eMmh3n6-hx--jb=hSQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_event: Fix HCI_EV_VENDOR max_len
To:     Mike Lothian <mike@fireburn.co.uk>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Mike,

On Mon, Mar 14, 2022 at 6:50 AM Mike Lothian <mike@fireburn.co.uk> wrote:
>
> Hi
>
> I've only just noticed this patch solves my issue
>
> https://lore.kernel.org/netdev/20220125144639.2226-1-mike@fireburn.co.uk/
>
> Can it be added to stable too?
>
> My patch can then be ignored:
>
> https://patchwork.kernel.org/project/bluetooth/patch/20220312164550.1810665-1-mike@fireburn.co.uk/
>
> Thanks
>
> Mike

We fixed this a while back:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/net/bluetooth/hci_event.c?id=314d8cd2787418c5ac6b02035c344644f47b292b

-- 
Luiz Augusto von Dentz

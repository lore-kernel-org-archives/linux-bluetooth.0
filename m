Return-Path: <SRS0=+je2=2F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49549C43603
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Dec 2019 21:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0861F24673
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Dec 2019 21:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdQJcKbn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfLOVkH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 15 Dec 2019 16:40:07 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:38633 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfLOVkH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 15 Dec 2019 16:40:07 -0500
Received: by mail-ot1-f54.google.com with SMTP id h20so6420955otn.5
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Dec 2019 13:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vU0JtVZQ8mI/srTZhdPG0U6MBWJSIYfH7c3BBjSSd2I=;
        b=QdQJcKbnaomiwqX97hWMwboOVK7+b6j+BjsDRcT0idiJXVDi+W/lTj2CdPkr3g9Fni
         8ccnnqmkfIO9GxTALEGAn+zy9S1dHYyuceEvyln4waZIl+dosxvTfI/udmgN/ju1aVmb
         ZBxadTndxsoG5MxkwzQtphBekTY94Bq7ded+Mg4Q9UdOdb0CzwBlOKn8nla5n/14gIov
         6rYPFhsX3Qf46/8EaXorxdDwvIWZK5Vd3+0/2cOH1O8EKl/2VlfMLlFKvhTyslV0og7Y
         odKpMoOWxFVNm1SmIU/jJtnHLjPHD+HcYLnh8/5H3zKT0u5aLCmEL/10jqHLafQ0ODid
         sssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vU0JtVZQ8mI/srTZhdPG0U6MBWJSIYfH7c3BBjSSd2I=;
        b=T5v1vkMITB8zUBVfTH92621nQt2ivB4ie+lKyFwCQb4tDNvwwd7rIHgf6msXpqP8bx
         pp7Xbgbln8xQ83MDNb9UJScUMKtHU9zOuH6uhS0qz06hedAH25uNGmPHVPPEiwWqiumg
         fQLZ84MHDG0aLVcKFsaR5+kns0VqRJf2k9Y1r3VF/AxJScPuZThnYBGYBhUCoS0+Uojz
         djxin2rg684gmQXBpamgTX3U0l62NRIAvg+orL+ND/ltXQoebtrIYfq/jSLM1eQOek4z
         1vVE5/UZ0wt5fo/fLb5L78vQ2C2sup5xE2jByTj9cAF/86l1EMbNrsUzRJN2uSzBdhDW
         hleA==
X-Gm-Message-State: APjAAAWQDXRugH8mnqDLAcy30N/Djs9hIpvkAR9X732IXOq+TyBy+lue
        BcT+BsWeoYBeR4sdyNOsuWiJ7hNq3Qs38JUC2zc=
X-Google-Smtp-Source: APXvYqwk+avB2pc6SRkXmIQqm6hmDdXrzmnldfB3VniMizAcrfvhC0oAMkCa4iNObLOLIAcAeGwrkO+0fFmDAUjiS5M=
X-Received: by 2002:a9d:39a5:: with SMTP id y34mr26446568otb.146.1576446006108;
 Sun, 15 Dec 2019 13:40:06 -0800 (PST)
MIME-Version: 1.0
References: <20191212105447.Horde.-DyB7PgBfgAz5YM_p1UkbyO@mail.sapo.pt>
In-Reply-To: <20191212105447.Horde.-DyB7PgBfgAz5YM_p1UkbyO@mail.sapo.pt>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sun, 15 Dec 2019 23:39:54 +0200
Message-ID: <CABBYNZ+pDrwgPbXY+wJVGvTz=UEwxusJiTVWBe4Yme3Zx1MuFg@mail.gmail.com>
Subject: Re: Licence of libbluetooth?
To:     Nuno Ribeiro <recstar@sapo.pt>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alex,

On Thu, Dec 12, 2019 at 12:56 PM Nuno Ribeiro <recstar@sapo.pt> wrote:
>
> Hi all
> We have been searching for the licence that applies to libbluetooth
> but without success till now. Hence, we decided to try in this
> mailling list
>
> We are interested in developing software that deals with bluetooth
> interface using linux boxes and use the libbluetooth but we are not
> aware about the licence that our own software must follow because we
> can not find the libbluetooh and bluetooth.h header licence.
> Please, could you guide us to the address where the licence is stored?

That is GPL, we actually don't recommend using it directly since most
of the functionality is covered by D-Bus APIs you should need to link
to it.

-- 
Luiz Augusto von Dentz

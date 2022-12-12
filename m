Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD1CC4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Dec 2022 15:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiLLPgr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Dec 2022 10:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiLLPgp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Dec 2022 10:36:45 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F696460
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Dec 2022 07:36:44 -0800 (PST)
Received: (Authenticated sender: arthur@marmottus.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 9D6F724000B;
        Mon, 12 Dec 2022 15:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
        s=gm1; t=1670859403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=EG34TET7/h55ECfPUlV2gPgr7iQGT/vWNiKrYRt4UZE=;
        b=ZhjN8mUcpJN5UhagDd6HOIEQrjwdx6QDiL/D6WmiR5gCzViH8SpNMOgd93K9AbrSqXwoEc
        FOwgZ84BFwfKvqFB64kPEFT8KrlSfLNgDnyQtFJCN/mMP7vomBgWVJlxfLLqJtwGjMyf3y
        BLWzQwVpxktMEqNQpjPL5ExvtK4d7zdy1q+MRfIj9iui2h5FUz07V7f2njrUBnSm94bw01
        +uZAXj+fiGWAT+RE5r8uJXgNQeSfcAT+5cMGXtPh3hPkNUFn8y7xRkXhjJmu1rP8cCG289
        adLqVBtIN2g500jOo7XTQuZ+XZrZNQdq3ZdlN9Y3CCridLTfVLYma5kwODVvwQ==
From:   "Arthur Crepin-Leblond" <arthur@marmottus.net>
In-Reply-To: <988dc1f9add28a70ba18ce2f3042aac0bea04b5b.camel@hadess.net>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
Date:   Mon, 12 Dec 2022 16:36:42 +0100
Cc:     linux-bluetooth@vger.kernel.org
To:     "Bastien Nocera" <hadess@hadess.net>
MIME-Version: 1.0
Message-ID: <7dc4-63974a80-14d-24592140@246924754>
Subject: =?utf-8?q?Re=3A?= [PATCH BlueZ 0/1] Expose the disconnect reason over D-Bus
User-Agent: SOGoMail 5.5.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Monday, December 12, 2022 15:49 CET, Bastien Nocera <hadess@hadess.n=
et> wrote: 
 
> On Mon, 2022-12-12 at 14:32 +0100, Arthur Crepin-Leblond wrote:
> > Hello,
> > 
> > I am trying to expose the device disconnect reason over D-Bus and t=
he
> > most elegant way I found was to subscribe to the adapter notify
> > callback that gives the reason as an argument.
> 
> Any reason why this can't be a signal with the reason as an argument?=


I chose the easy path by copying the existing code for the device prope=
rties
that get updated like the "Connected" or "ServicesResolved". 
I am not too familiar with BlueZ signals other than PropertiesChanged, =

InterfacesRemoved/Added. What would you have in mind?

And apologies in advance, it's my first time submitting here, I do not =
have
an advanced knowledge of the BlueZ internals.


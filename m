Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6EEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Oct 2021 07:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCD2361502
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Oct 2021 07:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhJEHJN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Oct 2021 03:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhJEHJM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Oct 2021 03:09:12 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E16BC061745
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Oct 2021 00:07:22 -0700 (PDT)
Date:   Tue, 5 Oct 2021 09:07:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=t-8ch.de; s=mail;
        t=1633417638; bh=qwppw7E33g5MxWqSbrHtDJvsCtXBG2WV1wPRcv/axLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P41A6LkZ6ZwL7WOPRMGvMrWVOaycXZMEhmIiyydKZUTvPnldXL0hIkTfB0LoedpYt
         KQdGzUyGU5LR2FZfm6FDPcY7qEdoMnPRDR0nQJkSHQxpxEwCr3SHjyoInXegBQR3tG
         JW6qaXAB/+aQZr/qALI63jewN5JRYYIuhrP75DM8=
From:   thomas@t-8ch.de
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [BlueZ] Use accurate icons for headphones and headsets
Message-ID: <008c2b28-f830-46fe-bc51-9f1714695f37@t-8ch.de>
References: <20211003101834.45448-1-thomas@t-8ch.de>
 <61598804.1c69fb81.d279a.fe3f@mx.google.com>
 <CABBYNZ+-7QASvCoA9XJQ_Jmi8=e2-dZQSnL4Xft4Ci_WGb=nPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABBYNZ+-7QASvCoA9XJQ_Jmi8=e2-dZQSnL4Xft4Ci_WGb=nPA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On 2021-10-04T21:15-0700, Luiz Augusto von Dentz wrote:
> Shouldn't they be proposed to be added to the standard before we do
> these changes? I mean it is better to have an icon then not have
> anything or is there a fallback mechanism e.g. audio prefix fallback
> to audio-card?

The naming standard has not been updated since 2006, I'm not sure it is still
maintained.
Each theme can specify other themes it inherits from where missing icons
are looked up from. The themes I checked either contain these icons or they
inherit from some that do.
A standard fallback mechanism by name is not specified.

If you want I can try to submit the names to the standard but they seem already
be part of the de-facto standard.

Thomas

Return-Path: <SRS0=RD0i=XP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E81CC49ED7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Sep 2019 09:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1DC4207E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Sep 2019 09:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="DUFNCnoF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393342AbfITJLm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Sep 2019 05:11:42 -0400
Received: from mail.andi.de1.cc ([85.214.55.253]:56078 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393258AbfITJLm (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Sep 2019 05:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HELD1wBCSgloEXPlRNWMELq87zwane+TqAg9m+mb8VA=; b=DUFNCnoFznFomFaS/hxKJnsYUA
        wJqr4aabO8I4BAY7TJ5NZyJ2spYa926AEdPvYI7Oe+amfZUKJqI7bLqCLYMyDU9onPPNU28vM6wGq
        llcBfDyzDvyxIyb8NqYFyQ7UcvQvlhb347nG2va0qnW01YfqWNbwaB6HG68enjMCSf+E=;
Received: from p200300ccff0d4e001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0d:4e00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iBEx1-00087g-Fl; Fri, 20 Sep 2019 11:11:39 +0200
Date:   Fri, 20 Sep 2019 11:11:38 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Carey Sonsino <csonsino@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Jamie Mccrae <Jamie.Mccrae@lairdconnect.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/1] bluetooth: update default BLE connection params
Message-ID: <20190920111138.047dc5be@aktux>
In-Reply-To: <4BFC2A23-1D8A-4021-BB74-418A13676E65@holtmann.org>
References: <705dbccb-58a9-7adc-8430-c16b395c27e5@gmail.com>
        <4BFC2A23-1D8A-4021-BB74-418A13676E65@holtmann.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Thu, 5 Sep 2019 17:34:03 +0200
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Carey,
> 
> > Update the default BLE connection parameters.
> > 
> > Commit c49a8682fc5d298d44e8d911f4fa14690ea9485e introduced a bounds
> > check on connection interval update requests, but the default min/max
> > values were left at 24-40 (30-50ms) which caused problems for devices
> > that want to negotiate connection intervals outside of those bounds.
> > 
> > Setting the default min/max connection interval to the full allowable
> > range in the bluetooth specification restores the default Linux behavior
> > of allowing remote devices to negotiate their desired connection
> > interval, while still permitting the system administrator to later
> > narrow the range.
> > 
> > The default supervision timeout must also be modified to accommodate
> > the max connection interval increase.  The new default value meets the
> > requirements of the bluetooth specification and the conditions in
> > the hci_check_conn_params function.
> > 
> > The downside to modifying the default supervision timeout is that
> > it will take longer (about 10 seconds) to detect a link loss condition.
> > 
> > Fixes c49a8682fc5d: (validate BLE connection interval updates)  
> 
> I decided to revert c49a8682fc5d and we need an overall better solution for handling connection parameters.
> 
is this revert also going towards stable/longterm? I do not see it in
stable-queue yet. 

Regards,
Andreas

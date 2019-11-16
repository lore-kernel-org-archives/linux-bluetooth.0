Return-Path: <SRS0=UnQ+=ZI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1A4C432C3
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 Nov 2019 12:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01517206D3
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 Nov 2019 12:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfKPMFe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 16 Nov 2019 07:05:34 -0500
Received: from hall.aurel32.net ([195.154.113.88]:52650 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbfKPMFe (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 16 Nov 2019 07:05:34 -0500
Received: from [2a01:e35:2fdd:a4e1:fe91:fc89:bc43:b814] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <aurelien@aurel32.net>)
        id 1iVwpW-000186-Io; Sat, 16 Nov 2019 13:05:30 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.92.3)
        (envelope-from <aurelien@aurel32.net>)
        id 1iVwpV-0001Lw-7N; Sat, 16 Nov 2019 13:05:29 +0100
Date:   Sat, 16 Nov 2019 13:05:29 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     "Stotland, Inga" <inga.stotland@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Fix io inititalization sequence
Message-ID: <20191116120529.GB30589@aurel32.net>
References: <20191114235210.3312-1-inga.stotland@intel.com>
 <fa582ab72a01b588db65fa840109c82bb4870596.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa582ab72a01b588db65fa840109c82bb4870596.camel@intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 2019-11-15 23:23, Gix, Brian wrote:
> Applied, Thanks
> 
> On Thu, 2019-11-14 at 15:52 -0800, Inga Stotland wrote:
> > This introduces a chain of callbacks to indicate whether mesh io
> > is initialized and mesh network is ready to use.
> > 
> > This fixes the reported situation when the receive callbacks
> > were setup before the HCI was fully initialized. In other words,
> > BT_HCI_CMD_LE_SET_SCAN_PARAMETERS was called before BT_HCI_CMD_RESET
> > and, as the result, the callback issueing BT_HCI_CMD_LE_SET_SCAN_ENABLE
> > command was not called.
> > ---
> >  mesh/main.c            | 42 ++++++++++++++++++++++++------------
> >  mesh/mesh-io-api.h     |  3 ++-
> >  mesh/mesh-io-generic.c | 48 +++++++++++++++++++++++++++++++-----------
> >  mesh/mesh-io.c         |  5 +++--
> >  mesh/mesh-io.h         |  6 +++++-
> >  mesh/mesh.c            | 33 ++++++++++++++++++++++++-----
> >  mesh/mesh.h            |  5 ++++-
> >  7 files changed, 107 insertions(+), 35 deletions(-)

I have just tried this patch, and I confirm it fixes the RX issue after
restarting the bluetooth-meshd daemon. Thanks!

Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net

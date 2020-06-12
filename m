Return-Path: <SRS0=RDM4=7Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826DEC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jun 2020 13:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68144206A4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jun 2020 13:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgFLNMG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:12:06 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:56488 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgFLNMF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Jun 2020 09:12:05 -0400
Received: from marcel-macbook.fritz.box (ip-109-41-64-170.web.vodafone.de [109.41.64.170])
        by mail.holtmann.org (Postfix) with ESMTPSA id 03240CED03;
        Fri, 12 Jun 2020 15:21:53 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v6] sco:Add support for BT_PKT_STATUS CMSG data
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200611195041.46839-1-alainm@chromium.org>
Date:   Fri, 12 Jun 2020 15:12:01 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <CE137166-3D51-40C1-819C-D6CC91639439@holtmann.org>
References: <20200611195041.46839-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> This change adds support for reporting the BT_PKT_STATUS to the socket
> CMSG data to allow the implementation of a packet loss correction on
> erronous data received on the SCO socket.
> 
> The patch was partially developed by Marcel Holtmann and validated by
> Hsin-yu Chao.
> 
> Signed-off-by: Alain Michaud <alainm@chromium.org>
> 
> ---
> 
> Changes in v6:
> - Fixing sparse errors.
> 
> Changes in v5:
> - reducing cmsg_mask to 8 bit
> - clarifying the public symbol usage versus internal CMSG flags.
> 
> Changes in v4:
> - Addressing feedback from Marcel
> 
> include/net/bluetooth/bluetooth.h | 10 ++++++++++
> include/net/bluetooth/sco.h       |  2 ++
> net/bluetooth/af_bluetooth.c      |  3 +++
> net/bluetooth/hci_core.c          |  1 +
> net/bluetooth/sco.c               | 32 +++++++++++++++++++++++++++++++
> 5 files changed, 48 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel


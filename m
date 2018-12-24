Return-Path: <SRS0=i2N+=PB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D80EC64E79
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Dec 2018 20:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4273E217D7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Dec 2018 20:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbeLXU5m convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Dec 2018 15:57:42 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:33030 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeLXU5m (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Dec 2018 15:57:42 -0500
Received: from [192.168.0.117] (188.146.78.210.nat.umts.dynamic.t-mobile.pl [188.146.78.210])
        by mail.holtmann.org (Postfix) with ESMTPSA id C2B0FCF2A7;
        Mon, 24 Dec 2018 22:05:21 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH BlueZ v5 02/30] mesh: Delete obsolete files
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181219042016.25538-3-brian.gix@intel.com>
Date:   Mon, 24 Dec 2018 21:57:40 +0100
Cc:     linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        inga.stotland@intel.com
Content-Transfer-Encoding: 8BIT
Message-Id: <A3FD3D5A-1A8C-4178-A090-ED4A381D6D77@holtmann.org>
References: <20181219042016.25538-1-brian.gix@intel.com>
 <20181219042016.25538-3-brian.gix@intel.com>
To:     Brian Gix <brian.gix@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

> ---
> .gitignore                   |    1 -
> mesh/btmesh.c                |  181 -------
> mesh/config/composition.json |   44 --
> mesh/display.c               |   64 ---
> mesh/display.h               |   28 -
> mesh/prov.c                  |  722 --------------------------
> mesh/provision.c             | 1162 ------------------------------------------
> 7 files changed, 2202 deletions(-)
> delete mode 100644 mesh/btmesh.c
> delete mode 100644 mesh/config/composition.json
> delete mode 100644 mesh/display.c
> delete mode 100644 mesh/display.h
> delete mode 100644 mesh/prov.c
> delete mode 100644 mesh/provision.c

is it too much to ask for a good commit message if you delete 2202 lines of code. And why the Makefile.mesh is not part of this is beyond me.

Regards

Marcel


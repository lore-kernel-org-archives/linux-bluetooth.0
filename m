Return-Path: <SRS0=RDM4=7Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBB8C433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jun 2020 13:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 050802081A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jun 2020 13:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgFLNrT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:47:19 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:60163 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgFLNrS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Jun 2020 09:47:18 -0400
Received: from marcel-macbook.fritz.box (ip-109-41-64-170.web.vodafone.de [109.41.64.170])
        by mail.holtmann.org (Postfix) with ESMTPSA id CB5B1CED03;
        Fri, 12 Jun 2020 15:57:06 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v3 0/3] Support reading and setting default system
 parameters
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200611020157.70230-1-alainm@chromium.org>
Date:   Fri, 12 Jun 2020 15:47:16 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <17B2F033-19B2-463A-A8D1-B561A5F16AD6@holtmann.org>
References: <20200611020157.70230-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> This series adds support for reading and setting default system
> parameters from userspace.  In particular, combined with the userspace
> changes, allows platforms to override default system parameters from a
> main.conf file.
> 
> The series has been reviewed and tested on chromeos.
> 
> 
> Changes in v3:
> - Fixed sparse errors
> -Fixing sparse errors
> 
> Changes in v2:
> - Renamed the mgmt.h per Marcel's comments.
> - Addressed Marcel's comments in the implementation.
> 
> Alain Michaud (3):
>  mgmt: read/set system parameter definitions
>  bluetooth:centralize default value initialization.
>  bluetooth: implement read/set default system parameters mgmt
> 
> include/net/bluetooth/hci_core.h |  18 +++
> include/net/bluetooth/mgmt.h     |  30 ++++
> net/bluetooth/Makefile           |   2 +-
> net/bluetooth/hci_conn.c         |  14 +-
> net/bluetooth/hci_core.c         |  14 +-
> net/bluetooth/hci_request.c      |  15 +-
> net/bluetooth/mgmt.c             |   6 +
> net/bluetooth/mgmt_config.c      | 253 +++++++++++++++++++++++++++++++
> net/bluetooth/mgmt_config.h      |  11 ++
> 9 files changed, 341 insertions(+), 22 deletions(-)
> create mode 100644 net/bluetooth/mgmt_config.c
> create mode 100644 net/bluetooth/mgmt_config.h

all 3 patch have been applied with modifications to bluetooth-next tree.

Regards

Marcel


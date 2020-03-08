Return-Path: <SRS0=rf5u=4Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB32FC18E5B
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Mar 2020 07:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A198220663
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Mar 2020 07:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgCHHxn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 8 Mar 2020 03:53:43 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:55701 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgCHHxm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 8 Mar 2020 03:53:42 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id ED7A2CED15;
        Sun,  8 Mar 2020 09:03:08 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH v4] bluetooth: Enable erroneous data reporting if wbs is
 supported
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200305161459.153606-1-alainm@chromium.org>
Date:   Sun, 8 Mar 2020 08:53:40 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <761DAC5E-74A6-429A-8CE6-AB105340DC75@holtmann.org>
References: <20200305161459.153606-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> This change introduces a wide band speech setting which allows higher
> level clients to query the local controller support for wide band speech
> as well as set the setting state when the radio is powered off.
> Internally, this setting controls if erroneous data reporting is enabled
> on the controller.
> 
> Signed-off-by: Alain Michaud <alainm@chromium.org>
> ---
> 
> drivers/bluetooth/btusb.c        |  2 +-
> include/net/bluetooth/hci.h      | 16 +++++++-
> include/net/bluetooth/hci_core.h |  1 +
> include/net/bluetooth/mgmt.h     |  4 +-
> net/bluetooth/hci_core.c         | 24 ++++++++++++
> net/bluetooth/hci_event.c        | 39 +++++++++++++++++++
> net/bluetooth/mgmt.c             | 66 +++++++++++++++++++++++++++++++-
> 7 files changed, 147 insertions(+), 5 deletions(-)

patch has been applied to bluetooth-next tree.

However I fixed a few minor style issues as well.

Regards

Marcel


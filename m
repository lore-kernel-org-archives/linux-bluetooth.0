Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763B5C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 17:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A0822072F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 17:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgFJR4N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:56:13 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:33969 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbgFJR4M (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 13:56:12 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 98A90CECE9;
        Wed, 10 Jun 2020 20:06:00 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [BlueZ PATCH v8] doc: Describe the new Advertisement Monitor
 support
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200518203627.BlueZ.v8.1.If9f6be992cbaeaa35423de29da6db28675b35fcc@changeid>
Date:   Wed, 10 Jun 2020 19:56:10 +0200
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Michael Sun <michaelfsun@google.com>,
        Yoni Shavit <yshavit@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Transfer-Encoding: 7bit
Message-Id: <48A64960-FE08-47BF-9301-418396A1E880@holtmann.org>
References: <20200518203627.BlueZ.v8.1.If9f6be992cbaeaa35423de29da6db28675b35fcc@changeid>
To:     Miao-chen Chou <mcchou@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Miao-chen,

> This describes the following commands and event.
> - Read Advertisement Monitor Features command
> - Add Advertisement Patterns Monitor command
> - Remove Advertisement Monitor command
> - Advertisement Monitor Added event
> - Advertisement Monitor Removed event
> Note that the content of a monitor can differ based on its type. For now we
> introduce only pattern-based monitor, so you may find that unlike the
> command of removing monitor(s), the Add command is tied to a specific type.
> ---
> 
> Changes in v8:
> - Fix bit index of advertisement monitor feature and remove a tailing line.
> 
> Changes in v7:
> - Update command/event opcodes after rebasing.
> 
> Changes in v6:
> - Refine the description of commands.
> - Add Monitor_Handle as the return parameter of Remove Advertisement
> Monitor command.
> 
> Changes in v5:
> - Add more fields in the return value of Read Advertisement Monitor
> Features command.
> - Refine the description of commands and events.
> 
> Changes in v4:
> - In Read Advertisement Monitor Features command, rename
> Adopted_Features to Enabled_Features.
> 
> Changes in v3:
> - Remove Advertisement Monitor can perform the removal of one monitor
> or all monitors.
> - Add Read Advertisement Monitor Features command.
> - Add Advertisement Monitor Added event and dvertisement Monitor Removed
> event.
> 
> Changes in v2:
> - Combine commands to remove one monitor and remove all monitors. The
> refined command takes multiple handles and an extra field to indicate
> whether to remove all monitors.
> 
> doc/mgmt-api.txt | 146 +++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 146 insertions(+)

I adjusted the command and event codes and then applied your patch.

Regards

Marcel


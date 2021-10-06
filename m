Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F1CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 08:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 331A9611C3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 08:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237837AbhJFIw1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Oct 2021 04:52:27 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:58097 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237832AbhJFIwZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Oct 2021 04:52:25 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1BFC6CED31;
        Wed,  6 Oct 2021 10:50:33 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 3/3] Bluetooth: Fix wake up suspend_wait_q prematurely
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211006010935.902645-3-luiz.dentz@gmail.com>
Date:   Wed, 6 Oct 2021 10:50:26 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <0D89D750-039B-4320-A51F-AA97831521AB@holtmann.org>
References: <20211006010935.902645-1-luiz.dentz@gmail.com>
 <20211006010935.902645-3-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> suspend_req_complete shall only attempt to wake up if there no tasks
> left otherwise the WAKE_COND will evaluate to false causing a premature
> timeout when in fact the tasks are still in progress.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/hci_request.c | 21 ++++++++++++++-------
> 1 file changed, 14 insertions(+), 7 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


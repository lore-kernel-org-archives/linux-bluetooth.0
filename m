Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CE9C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 13:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BBBD61039
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 13:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbhJYNJM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 09:09:12 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:57589 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbhJYNJL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 09:09:11 -0400
Received: from smtpclient.apple (p4ff9f2d2.dip0.t-ipconnect.de [79.249.242.210])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7330FCED17;
        Mon, 25 Oct 2021 15:06:48 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v2 0/2] Bluetooth: hci_h5: btrtl: Add support for
 RTL8822CS hci_ver 0x08
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211025084704.173755-1-adeep@lexina.in>
Date:   Mon, 25 Oct 2021 15:06:48 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <53EA5BEB-8D36-480E-9FB7-A3F49FFB3CFF@holtmann.org>
References: <20211025084704.173755-1-adeep@lexina.in>
To:     Vyacheslav Bocharov <adeep@lexina.in>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Vzacheslav,

> Add a variation of RTL8822CS with hci_ver = 0x08. This is fully similar to RTL8822CS with hci_ver = 0x0a
> The controller does not always start when the system starts up, so we do a forced reset via gpio during initialization.
> 
> Changes from v1:
> - remove Signed-off-by chbgdn <chbgdn@gmail.com> as not reachable
> 
> Vyacheslav Bocharov (2):
>  Bluetooth: btrtl: Add support for RTL8822C hci_ver 0x08
>  Bluetooth: hci_h5: Add power reset via gpio in h5_btrtl_open
> 
> drivers/bluetooth/btrtl.c  | 7 +++++++
> drivers/bluetooth/hci_h5.c | 5 +++++
> 2 files changed, 12 insertions(+)

the patches don’t apply cleanly against bluetooth-next tree.

Regards

Marcel


Return-Path: <SRS0=SE7D=N2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29E4C43441
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Nov 2018 10:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E7320868
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Nov 2018 10:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E7320868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387646AbeKOUZw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Nov 2018 15:25:52 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:42264 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbeKOUZv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Nov 2018 15:25:51 -0500
Received: from marcel-macbook.fritz.box (p4FEFC1D6.dip0.t-ipconnect.de [79.239.193.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id EC6C7CEF98;
        Thu, 15 Nov 2018 11:26:08 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH BlueZ] gatt: Ignore SIGPIPE
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHotPr-jS457EKX=7dvcwA6eB12zr7d2dZG5Prjh6+fMdAT=+Q@mail.gmail.com>
Date:   Thu, 15 Nov 2018 11:18:37 +0100
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <9007400A-D10D-4906-AB75-6D6395AF98FD@holtmann.org>
References: <20181115083817.20986-1-gbenhaim@augury.com>
 <CABBYNZJ_TEM18yfO6O4HFdyo7sm-cE8iL4Y8_DEa1e6xZ7a=Bg@mail.gmail.com>
 <CAHotPr-jS457EKX=7dvcwA6eB12zr7d2dZG5Prjh6+fMdAT=+Q@mail.gmail.com>
To:     Gal Ben Haim <gbenhaim@augury.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Gal,

> io_send can use poll and check for POLLOUT and POLLRDHUP before
> writing to the pipe

that should be done anyway since code that writes to a pipe descriptor (or socket for that matter) without checking that it is still valid is broken code.

Regards

Marcel


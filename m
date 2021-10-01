Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79C4C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Oct 2021 05:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3C4E61A55
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Oct 2021 05:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351721AbhJAFp1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Oct 2021 01:45:27 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:40699 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241958AbhJAFp0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Oct 2021 01:45:26 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 89502CED25;
        Fri,  1 Oct 2021 07:43:40 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [RFC PATCH] Bluetooth: hci_sock: Set flag to all sockets
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211001035931.50485-1-hj.tedd.an@gmail.com>
Date:   Fri, 1 Oct 2021 07:43:40 +0200
Cc:     linux-bluetooth@vger.kernel.org,
        Tedd Ho-Jeong An <tedd.an@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <E6D38153-42EC-4AE2-9292-9EFE7F61318B@holtmann.org>
References: <20211001035931.50485-1-hj.tedd.an@gmail.com>
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

> The mgmt_limited_event() send the event to the socket that matches the
> flag type, but also it skips to the given socket object in the
> parameter.
> 
> For Local Out of Band Data Updated Event and Experimental Feature
> Changed Event, it sets flags only for the socket which the change was
> triggered, the event cannot be sent to the client via any sockets
> because the flag is not set for other sockets and it doens't send to the
> socket which the change was triggered.
> 
> This patch adds the function that sets the flag for all available
> management sockets, so the mgmt_limited_event() still can send the event
> to the management sockets other than the one through which the change
> was triggered.

actually that is on purpose. Only the socket that used a specific mgmt commands gets to see the new events. So if you have a second listening socket that just cares about the events, it has to at least issue the “read” command to tell mgmt that it does understand it. There is no point in sending out signals to all mgmt sockets if you haven’t read an initial status first. The updates would make no sense to you.

Regards

Marcel


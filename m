Return-Path: <SRS0=rf5u=4Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A64CC10DCE
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Mar 2020 09:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B0520828
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Mar 2020 09:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgCHJOp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 8 Mar 2020 05:14:45 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:50250 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgCHJOp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 8 Mar 2020 05:14:45 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id AD60FCED17;
        Sun,  8 Mar 2020 10:24:11 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH 2/2] Bluetooth: Add BTPROTO_ISO socket type
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200117000137.29166-2-luiz.dentz@gmail.com>
Date:   Sun, 8 Mar 2020 10:14:43 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <72004581-0F75-442B-85B2-B1EF87538AC8@holtmann.org>
References: <20200117000137.29166-1-luiz.dentz@gmail.com>
 <20200117000137.29166-2-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This introduces a new socket type BTPROTO_ISO which is used to transfer
> ISO packets between userspace and kernel similarly to how BTPROTO_SCO
> works.

circling back to this now. What is the advantage of using a separate socket instead of the SCO socket type with a proper configured set of socket options.

I mean at some we can just rename BTPROTO_SCO into BTPROTO_AUDIO since all the Synchronous and Isochronous naming in the spec is not really helpful. Even if in theory it can be used for other data, it has been in 20+ years only used for audio data.

And actually it doesn’t need to be a socket at all. If we figure out a better interface for SCO/eSCO and ISO data when transported over HCI, I am ok with that as well.

The fact that we open a SCO socket to establish the underlying transport, but then the data goes somewhere else is also weird to some degree. So I wonder if the audio control part might be better done over mgmt and if we get audio data to transport, we just hand back an fd via mgmt event.

This is me just thinking out loud. If the separate ISO socket is in the end the best approach, we can also do it like that, but we should really evaluate the possible direction before we set this API in stone.

Regards

Marcel


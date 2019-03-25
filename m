Return-Path: <SRS0=CZwu=R4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E340C43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Mar 2019 11:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF332063F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Mar 2019 11:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbfCYLLT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:11:19 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:39543 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729727AbfCYLLT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Mar 2019 07:11:19 -0400
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id F3BE7240002
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2019 11:11:16 +0000 (UTC)
Message-ID: <66544e21401986edd519e4f6939e405eea5c7397.camel@hadess.net>
Subject: Re: [PATCH v2 1/2] autopair: Add more common PIN codes for audio
 devices
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-bluetooth@vger.kernel.org
Date:   Mon, 25 Mar 2019 12:10:52 +0100
In-Reply-To: <1511796502.11411.33.camel@hadess.net>
References: <20171127152651.18997-1-hadess@hadess.net>
         <1511796502.11411.33.camel@hadess.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, 2017-11-27 at 16:28 +0100, Bastien Nocera wrote:
> On Mon, 2017-11-27 at 16:26 +0100, Bastien Nocera wrote:
> > PIN codes "1111", and "1234" are fairly common PIN codes used for
> > audio
> > devices such as speakers and headsets. This replaces similar quirks
> > already present in gnome-bluetooth's PIN database.
> 
> V2 of this patch, I've tested it again, and it seems to work in my
> tests. I've also added another special case for gaming input devices
> and remote controls in a second patch.

The 2 patches in this patchset still apply, and are still relevant.
Could those be reviewed and merged, please?

Cheers


Return-Path: <SRS0=xgU7=QE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53743C282C8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jan 2019 12:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2702F2148E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jan 2019 12:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfA1MW5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:22:57 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:40128 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfA1MW5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Jan 2019 07:22:57 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id 005EDCF2B6;
        Mon, 28 Jan 2019 13:30:43 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH BlueZ 0/2] Added config conversion tool
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190127115646.5814-1-zimmermach@gmail.com>
Date:   Mon, 28 Jan 2019 13:22:55 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <D0326ED7-4865-4922-AC04-475FB0A9F213@holtmann.org>
References: <20190127115646.5814-1-zimmermach@gmail.com>
To:     Christian Zimmermann <zimmermach@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Christian,

> Added a config conversion tool for Bluez4 config, instead of doing the conversion in adapter.c
> 
> Christian Zimmermann (2):
>  Renamed Bluez4 config read functions
>  Added config converter for Bluez4 config conversion

so what is the intention here. I was going to just remove any 4.x support and more to BlueZ 6.0 soon. Actually BlueZ 5.x has been release over 6 years ago. I have pretty much zero interest in carrying / maintaining anything for BlueZ 4.x support.

Regards

Marcel


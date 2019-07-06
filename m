Return-Path: <SRS0=OJUr=VD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3392C0650E
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Jul 2019 19:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76DD72075C
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Jul 2019 19:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfGFTo4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 6 Jul 2019 15:44:56 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:58452 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfGFTo4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 6 Jul 2019 15:44:56 -0400
Received: from [192.168.1.175] (apn-37-247-209-172.dynamic.gprs.plus.pl [37.247.209.172])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5AD3ACF165;
        Sat,  6 Jul 2019 21:53:26 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v3 0/3] bluetooth: 6lowpan: multiple peers and addresses
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190706155448.13382-1-josua.mayer@jm0.eu>
Date:   Sat, 6 Jul 2019 21:44:48 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <5A501DEB-B2CA-4C3B-AF5E-F2E5816AA5D0@holtmann.org>
References: <20190706155448.13382-1-josua.mayer@jm0.eu>
To:     Josua Mayer <josua.mayer@jm0.eu>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Josua,

> This patch set deals with an issue I reported earlier this year, where
> 1) packets addressed to a non-link-local address
> 2) any packets when at least 2 peers are connected
> were not delivered if they matched a direct peer i.e. no routing.
> 
> The full explanation of the issue including steps to reproduce are:
> https://www.spinics.net/lists/linux-bluetooth/msg78486.html
> 
> Changes since v2:
> - rebased on bluetooth-next
> 
> Changes since v1:
> - changed comment style to c++
> 
> Josua Mayer (3):
> bluetooth: 6lowpan: search for destination address in all peers
> bluetooth: 6lowpan: check neighbour table for SLAAC
> bluetooth: 6lowpan: always check destination address
> 
> net/bluetooth/6lowpan.c | 41 +++++++++++++++++++++++++----------------
> 1 file changed, 25 insertions(+), 16 deletions(-)

all 3 patches have been applied to bluetooth-next tree.

Regards

Marcel


Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18CDC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 11:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A56C5604D7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 11:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbhG2Lls convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 07:41:48 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:42394 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhG2Lls (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 07:41:48 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id 43710CED14;
        Thu, 29 Jul 2021 13:41:44 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH] Bluetooth: btusb: Enable MSFT extension for TyphoonPeak,
 GarfieldPeak, and WCN6855 controllers
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210727140425.1.I1ac63dde4853d7b38a018b20b3d6d3d539378df3@changeid>
Date:   Thu, 29 Jul 2021 13:41:43 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <71AEBFF9-4FAA-4C86-A297-561174C1D3F9@holtmann.org>
References: <20210727140425.1.I1ac63dde4853d7b38a018b20b3d6d3d539378df3@changeid>
To:     Michael Sun <michaelfsun@google.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Michael,

> The Intel TyphoonPeak, GarfieldPeak and Qualcomm WCN6855 Bluetooth
> controllers support the Microsoft vendor extension, enable them by
> setting VsMsftOpCode accordingly.

please send two patches, one that enables Intel hardware and another one for Qualcomm chips. I am not a big fan of intermixing vendor specific parts in the same patch if not absolutely needed.

Regards

Marcel


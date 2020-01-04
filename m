Return-Path: <SRS0=BHgP=2Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C025C32767
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Jan 2020 09:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE33222C4
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Jan 2020 09:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgADJoy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 4 Jan 2020 04:44:54 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:43695 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgADJoy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 4 Jan 2020 04:44:54 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 21420CED12;
        Sat,  4 Jan 2020 10:54:08 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: OCF_READ_LOCAL_CODECS is permitted only for root user
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191228171212.56anj4d4kvjeqhms@pali>
Date:   Sat, 4 Jan 2020 10:44:52 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <45BB2908-4E16-4C74-9DB4-8BAD93B42A21@holtmann.org>
References: <20191228171212.56anj4d4kvjeqhms@pali>
To:     =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

> I wrote a simple script "sco_features.pl" which show all supported
> codecs by local HCI bluetooth adapter. Script is available at:
> 
> https://github.com/pali/hsphfpd-prototype/blob/prototype/sco_features.pl
> 
> And I found out that OCF_READ_LOCAL_CODECS HCI command cannot be send by
> non-root user. Kernel returns "Operation not permitted" error.
> 
> What is reason that kernel blocks OCF_READ_LOCAL_CODECS command for
> non-root users? Without it (audio) application does not know which
> codecs local bluetooth adapter supports.
> 
> E.g. OCF_READ_LOCAL_EXT_FEATURES or OCF_READ_VOICE_SETTING commands can
> be send also by non-root user and kernel does not block them.

actually the direct access to HCI commands is being removed. So we have no plans to add new commands into the list since that it what the kernel is suppose to handle. If we wanted to expose this, then it has to be via mgmt.

Regards

Marcel


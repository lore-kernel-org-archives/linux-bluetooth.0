Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38107C4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Aug 2021 16:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21C9060F4B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Aug 2021 16:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237754AbhHPQAv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Aug 2021 12:00:51 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:40535 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237825AbhHPQAb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Aug 2021 12:00:31 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id 97EA3CECC8;
        Mon, 16 Aug 2021 17:59:58 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [Bluez PATCH 01/62] lib: Inclusive language in HCI commands and
 events
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZJVNiz0E2_knPUoXOV1VVhkjBY2Wcq-So_+2=ES5a2cDA@mail.gmail.com>
Date:   Mon, 16 Aug 2021 17:59:58 +0200
Cc:     Archie Pusaka <apusaka@google.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <15027B55-B5EA-47E3-994C-A21662A37F06@holtmann.org>
References: <20210813121848.3686029-1-apusaka@google.com>
 <20210813201256.Bluez.1.I3be2e373e96293524fa38328ebac177eddc71938@changeid>
 <FB2904D7-96FA-4A26-83A3-2F1729DC2D73@holtmann.org>
 <CABBYNZJVNiz0E2_knPUoXOV1VVhkjBY2Wcq-So_+2=ES5a2cDA@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>>> "central" and "peripheral" are preferred, as reflected in the BT
>>> core spec 5.3.
>>> 
>>> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
>>> ---
>>> 
>>> lib/hci.h          | 14 +++++++-------
>> 
>> until we deprecate libbluetooth and no longer give an option to install it, you can not do this. It is part of libbluetooth and this would break API.
> 
> Couldn't we perhaps bump the major version so we could move on with
> these changes, or would you like to deprecate the libbluetooth before
> we move to e.g. BlueZ 6.0? Since we have done these changes on the
> kernel size I wonder also if it shouldn't reflect into userspace
> though, we could perhaps keep the old definition alongside with the
> new though so we don't break userspace tools/apps which may still be
> using the old definitions.

I think we need to get rid of libbluetooth really fast. In addition we also should remove the Android code. Both seems to be not really needed anymore.

Regards

Marcel


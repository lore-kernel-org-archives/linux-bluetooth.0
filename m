Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26B9C432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 09:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A9FD61051
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 09:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343686AbhIBJgA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Sep 2021 05:36:00 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:56658 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343703AbhIBJf7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Sep 2021 05:35:59 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id E8B78CECDD;
        Thu,  2 Sep 2021 11:34:59 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [Bluez PATCH v2 01/13] lib: Inclusive language changes
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAJQfnxEHbXzfm_2+zvZyKwwGOdyLYSKbXiMuZd3qo6RK9a494w@mail.gmail.com>
Date:   Thu, 2 Sep 2021 11:34:59 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Transfer-Encoding: 7bit
Message-Id: <33EE4DB9-DAA9-4D63-AFC0-7B4FEF789B4F@holtmann.org>
References: <20210902040711.665952-1-apusaka@google.com>
 <20210902120509.Bluez.v2.1.I3be2e373e96293524fa38328ebac177eddc71938@changeid>
 <3D29644F-F6C1-463C-83E6-23CB3FD00057@holtmann.org>
 <CAJQfnxEHbXzfm_2+zvZyKwwGOdyLYSKbXiMuZd3qo6RK9a494w@mail.gmail.com>
To:     Archie Pusaka <apusaka@google.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

> Could you give me pointers on this libbluetooth API?
> I can't seem to figure out which ones of these replacements belong to
> libbluetooth.

take a clean git tree and do this.

	./bootstrap
	./configure --enable-library
	make
	make install DESTDIR=$PWD/x
	find x
	rm -rf x

It should give you API from the include directory.

x/usr/include/bluetooth
x/usr/include/bluetooth/cmtp.h
x/usr/include/bluetooth/hidp.h
x/usr/include/bluetooth/bluetooth.h
x/usr/include/bluetooth/bnep.h
x/usr/include/bluetooth/rfcomm.h
x/usr/include/bluetooth/l2cap.h
x/usr/include/bluetooth/hci.h
x/usr/include/bluetooth/sco.h
x/usr/include/bluetooth/sdp.h
x/usr/include/bluetooth/hci_lib.h
x/usr/include/bluetooth/sdp_lib.h

So any change here is fundamentally an API breakage.

Regards

Marcel


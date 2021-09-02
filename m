Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FA5C432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 07:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A46A561008
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 07:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242445AbhIBHOc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Sep 2021 03:14:32 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:55573 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbhIBHOc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Sep 2021 03:14:32 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 952FCCECD7;
        Thu,  2 Sep 2021 09:13:32 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [Bluez PATCH v2 01/13] lib: Inclusive language changes
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210902120509.Bluez.v2.1.I3be2e373e96293524fa38328ebac177eddc71938@changeid>
Date:   Thu, 2 Sep 2021 09:13:31 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <3D29644F-F6C1-463C-83E6-23CB3FD00057@holtmann.org>
References: <20210902040711.665952-1-apusaka@google.com>
 <20210902120509.Bluez.v2.1.I3be2e373e96293524fa38328ebac177eddc71938@changeid>
To:     Archie Pusaka <apusaka@google.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

> BT core spec 5.3 promotes the usage of inclusive languages.
> This CL replaces some terms with the more appropriate counterparts,
> such as "central", "peripheral", and "accept list".
> ---
> 
> Changes in v2:
> * Merging several patches from the same directory into one
> 
> android/bluetooth.c    |  4 ++--
> btio/btio.c            | 20 ++++++++--------
> lib/hci.c              | 52 +++++++++++++++++++++---------------------
> lib/hci.h              | 44 +++++++++++++++++------------------
> lib/hci_lib.h          |  8 +++----
> lib/l2cap.h            |  2 +-
> lib/mgmt.h             |  2 +-
> lib/rfcomm.h           |  2 +-
> monitor/control.c      |  4 ++--
> profiles/health/mcap.c |  2 +-
> src/adapter.c          |  4 ++--
> src/sdpd-server.c      |  2 +-
> tools/hcitool.c        |  8 +++----
> tools/l2test.c         |  4 ++--
> tools/oobtest.c        |  4 ++--
> tools/parser/hci.c     | 14 ++++++------
> tools/rctest.c         |  4 ++--
> tools/rfcomm.c         |  2 +-
> 18 files changed, 91 insertions(+), 91 deletions(-)

so I am not sure if my comments were unclear last time, but touching libbluetooth is no go until we have deprecated it. So as long as it can be still installed by distributions (and it is), you can not break API.

Regards

Marcel


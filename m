Return-Path: <SRS0=2tab=5J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B866C4332B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 10:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0BB20775
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 10:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgCXKHO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:07:14 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:55831 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgCXKHN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Mar 2020 06:07:13 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id B4D73CED08;
        Tue, 24 Mar 2020 11:16:43 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: avoid cross-transport key derivation
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAB+bgRbibcup6cAwk9mUXD388zN2kYP4wJHJRq_acD_U_YdBdw@mail.gmail.com>
Date:   Tue, 24 Mar 2020 11:07:11 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <54261B51-7F77-45F0-9C63-1307423D1FE3@holtmann.org>
References: <CAB+bgRanN9W4oH00rATmgarRnk4NXPXOdT2K+ZYDLMM1pYmtuQ@mail.gmail.com>
 <7FCF5282-5F2B-42C5-BC85-D3D5B828519A@holtmann.org>
 <CAB+bgRbibcup6cAwk9mUXD388zN2kYP4wJHJRq_acD_U_YdBdw@mail.gmail.com>
To:     Ordit Gross <ordit.gross@orcam.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ordit,

> thanks Marcel,
> btmon file attached. (both as btmon format and txt)
> actually it looks like the BR/EDR connection is initiated by my side,
> not the mobile.
> #11 LE Connection Complete
> #85 done pairing
> #138 Create Connection (br/edr)
> #263 Disconnection Request (br/edr)
> 
> ** is it possible that bluetoothd might invoke this br/edr connection?
> - I was able to reproduce this when running btgatt-server with
> bluetoothd running. meaning after pairing I saw creation of br/edr
> connection.
> - running btgatt-server without bluetoothd in background, br/edr
> connection was not observed after pairing.
> (in both cases I used btmgmt to verify controller settings are the same )
> 
> ** in order to reproduce the br/edr connection after pairing, I must
> remove credentials from both mobile side and my side.
>    removing credentials from mobile side only, I can see pairing but
> no br/edr connection is created.
> thanks again!

so bluetoothd is doing a service discovery via BR/EDR and then terminated the L2CAP link used for SDP. However then the remote device / phone terminates the BR/EDR link. They LE link seems not be terminated.

Nothing looks bad here. It is a bit of extra traffic, but bluetoothd actually has to learn about the BR/EDR services somehow.

Regards

Marcel


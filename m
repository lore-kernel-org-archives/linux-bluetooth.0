Return-Path: <SRS0=bh0L=UG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA926C28CC3
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jun 2019 08:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9223E208C0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jun 2019 08:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfFGIB6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jun 2019 04:01:58 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:43251 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbfFGIB6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jun 2019 04:01:58 -0400
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 4EC2260013
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Jun 2019 08:01:56 +0000 (UTC)
Message-ID: <101ef9a8e17e89a2a8f43ec081b929b596711b90.camel@hadess.net>
Subject: Re: [RFC] tools: Fix build after y2038 changes in glibc
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-bluetooth@vger.kernel.org
Date:   Fri, 07 Jun 2019 10:01:55 +0200
In-Reply-To: <20190607075133.11255-1-hadess@hadess.net>
References: <20190607075133.11255-1-hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, 2019-06-07 at 09:51 +0200, Bastien Nocera wrote:
> The 32-bit SIOCGSTAMP has been deprecated. Use the deprecated name
> to fix the build.

Without this patch (or a port to the new 64-bit timestamps) you'd get
this error on newer glibcs:
BUILDSTDERR: tools/rctest.c: In function 'recv_mode':
BUILDSTDERR: tools/rctest.c:507:19: error: 'SIOCGSTAMP' undeclared (first use in this function); did you mean 'SIOCGARP'?
BUILDSTDERR:   507 |     if (ioctl(sk, SIOCGSTAMP, &tv) < 0) {
BUILDSTDERR:       |                   ^~~~~~~~~~
BUILDSTDERR:       |                   SIOCGARP
BUILDSTDERR: tools/rctest.c:507:19: note: each undeclared identifier is reported only once for each function it appears in
BUILDSTDERR: make[1]: *** [Makefile:6224: tools/rctest.o] Error 1
BUILDSTDERR: make[1]: *** Waiting for unfinished jobs....
BUILDSTDERR: tools/l2test.c: In function 'recv_mode':
BUILDSTDERR: tools/l2test.c:909:19: error: 'SIOCGSTAMP' undeclared (first use in this function); did you mean 'SIOCGARP'?
BUILDSTDERR:   909 |     if (ioctl(sk, SIOCGSTAMP, &tv) < 0) {
BUILDSTDERR:       |                   ^~~~~~~~~~
BUILDSTDERR:       |                   SIOCGARP
BUILDSTDERR: tools/l2test.c:909:19: note: each undeclared identifier is reported only once for each function it appears in

Given that those are tests that there's another 19 years to port, and
that I don't know how to test, I went for the quickest fix.


Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BEEC4708F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Jun 2021 11:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE2FF613AB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Jun 2021 11:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbhFALHg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Jun 2021 07:07:36 -0400
Received: from mailbackend.panix.com ([166.84.1.89]:40814 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbhFALHg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Jun 2021 07:07:36 -0400
Received: from xps-7390 (ip70-164-222-119.oc.oc.cox.net [70.164.222.119])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 4FvTq5486bzG2b;
        Tue,  1 Jun 2021 07:05:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1622545554; bh=eHU03dM91q+gOK98DDkJsOA+it+7xBPhwvhRdUeXMz0=;
        h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
        b=KltytmlNp+P8y0lOuizYcjnPWwoewewc/UYm6CZsVr2N3i8p81BUlMZF+mahb1WIm
         96i9uzdQmAU/BHUyC+7xCB5lLOWJCFO34TnD/1JZFdm7I57YP6OvrR4e2INrczZo93
         BumwvcPWFQZd9/YaHexbQmyzpmJaKfSDSP1Kkl9g=
Date:   Tue, 1 Jun 2021 04:05:52 -0700 (PDT)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
cc:     Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        "An, Tedd" <tedd.an@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Commit 9b16bfbf41 ("Bluetooth: btintel: Move operational checks
 after version check") causing BT FW loading problems
In-Reply-To: <388538-11df-ce26-8737-9c611e69498a@panix.com>
Message-ID: <bad98c2f-3983-b768-b7cd-b13dcc69977@panix.com>
References: <42d9c52a-bcc9-13e6-9b1d-d9a94ff2889f@panix.com> <CABBYNZKqK6wEyrAL9y7+mPSWKr5CG=NnSEJK67Tt9ogimYA-zw@mail.gmail.com> <388538-11df-ce26-8737-9c611e69498a@panix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


On Sun, 30 May 2021, Luiz Augusto von Dentz wrote:

> > In case of the former you will probably need the following commit:

> > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=183dce5a7fd3040ced6a220b0aa536c926f10cd9

That seems to have fixed it- thanks!

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Orange County CA

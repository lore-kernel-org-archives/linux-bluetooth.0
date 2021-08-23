Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6972C4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Aug 2021 20:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C61261357
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Aug 2021 20:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbhHWUdc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Aug 2021 16:33:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:57242 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232237AbhHWUdb (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Aug 2021 16:33:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10085"; a="217207074"
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="217207074"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 13:32:48 -0700
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="535503407"
Received: from trangn-mobl.amr.corp.intel.com ([10.209.102.243])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 13:32:47 -0700
Message-ID: <76f1ddc63531da892643527116aeec434d809091.camel@linux.intel.com>
Subject: Re: how to cleanly shutdown an application using HCI_CHANNEL_USER
From:   Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To:     "Peter A. Bigot" <pab@pabigot.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>
Date:   Mon, 23 Aug 2021 13:32:47 -0700
In-Reply-To: <A6782BCD-0C05-40AD-B567-7A1E163184E0@holtmann.org>
References: <e17b2044-62cb-cbf7-64b8-c647aa7f6ee7@pabigot.com>
         <A6782BCD-0C05-40AD-B567-7A1E163184E0@holtmann.org>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Peter

On Thu, 2021-08-19 at 17:01 +0200, Marcel Holtmann wrote:
> Hi Peter,
> 
> > I'm using an AF_BLUETOOTH socket bound with HCI_CHANNEL_USER from a
> > user-mode application with cap_net_admin=ep.  As expected this
> > requires the device be down, and brings the device up automatically.
> > 
> > When I close that socket and exit the application, the device appears
> > to remain up forever.  Which prevents me from re-starting the
> > application.
> > 
> > I tried to issue HCIDEVDOWN before closing, but that produces EBADFD
> > because ioctls cannot be performed with HCI_CHANNEL_RAW.
> > 
> > I can bring the interface down from within the application if, after
> > closing the socket, I wait a second or so, then create a new bound
> > HCI_CHANNEL_RAW socket and issue HCIDEVDOWN on it.
> > 
> > Is there some other way to cleanly shut down an application that used
> > HCI_CHANNEL_USER so that the device is returned to down state on exit?
> > Or is this supposed to happen automatically (I see code that suggests
> > it should)?
> > 
> > Kernel version is 5.11.0-7620-generic (System76), and I'm using go
> > 1.16, if that's relevant.
> 
> I think you found a regression. Calling close() on the HCI User Channel should bring the device
> back down. This used to work correctly, can you please bisect which kernel patch broke this.
> 
> Back in the days I added tools/userchan-tester, but it seems I never included enough test cases to
> catch this regression.
> 
> Regards
> 
> Marcel
> 

Was bluetoothd running when you test?
If then, try to run without running the bluetooth daemon and check to see if you have a same
problem.

If you have to use the daemon, change the "AutoEnable" flag in the /etc/bluetooth/main.conf to false
and restart the bluetooth daemon. This will prevent the HCI interface from powering on after cloing
socket.

Regards,
Tedd




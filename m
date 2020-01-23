Return-Path: <SRS0=lRrI=3M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A79C33CB6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jan 2020 17:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACAC6214AF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jan 2020 17:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgAWRow convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jan 2020 12:44:52 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:36905 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgAWRov (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Jan 2020 12:44:51 -0500
Received: from marcel-macpro.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 71D21CED02;
        Thu, 23 Jan 2020 18:54:09 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [Bluez PATCH] doc: Add definition for Set Kernel Debug Level
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CALWDO_V=Q0725MhnA3hMnvL+hDbGVCa-RCT4d4NCysMo0Fvh7g@mail.gmail.com>
Date:   Thu, 23 Jan 2020 18:44:49 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <F6319DB4-FE70-45C8-A61D-D965CB659C9E@holtmann.org>
References: <20200120202708.111383-1-alainm@chromium.org>
 <6E55772A-01D5-4616-B3DB-CC22B935C855@holtmann.org>
 <CALWDO_WyZUvkOgXVSd12q7Trg_=LqSb9KQsXH9_C_k8_kD0ddQ@mail.gmail.com>
 <D0C01568-E48B-46ED-A2CC-D19FB2895756@gmail.com>
 <CALWDO_Wf3c5Vgt1a_p+pt_SpdkGJnLvneiZZ_1spRVuOr+9n0g@mail.gmail.com>
 <CALWDO_VC2z8ZxCQM0EBWvkEWJRQKaVy0butAeRc+uUqhpGcyMw@mail.gmail.com>
 <DFE9B731-5CB8-4FDA-8E89-1D5A51EAFB67@holtmann.org>
 <CALWDO_V=Q0725MhnA3hMnvL+hDbGVCa-RCT4d4NCysMo0Fvh7g@mail.gmail.com>
To:     Alain Michaud <alainmichaud@google.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

>>> Thanks for your patience.  After further research dynamic_debug is not
>>> available on retail chromium os user systems for a variety of reasons,
>>> some of which you can find in this trail:
>>> https://bugs.chromium.org/p/chromium/issues/detail?id=188825.
>>> 
>>> Given we need to be able to diagnose things in the field, this is not
>>> a good option for this.
>>> 
>>> I hope this helps explain or justify the need for this interface.
>> 
>> the reasoning from Kees is 6 years old. Are his issues still valid?
>> 
>> So I have been looking into pushing bt_{info,warn,err} into the btmon traces. That is why we have bt_dev_* etc. error macro and have changed a lot of code to use them. This will hopefully allow us to have errors and warnings directly in the btmon traces. For bluetoothd errors and warnings this already works btw.
>> 
>> I don’t believe that I want to duplicate the dynamic_debug functionality and push even more info into dmesg ring buffer that then needs to be collected and aligned with btmon traces. The big advantage is if you get a btmon trace and that has the actual message right in it at the right place with the right timestamp.
>> 
>> If we push bt_{info,warn,err} into btmon, it might be simpler to do the same for BT_DBG, but it will of course require extra work since our BT_DBG statements are meant to be compiled out if dynamic_debug is disabled.
> 
> The rational is all still relevant today.  To give you some additional
> background, here's how a version of this is currently used:
> 
> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1697851
> 
> Note that I don't expect us to upstream this as is, in particular,
> it'd expect we'd also want to forward to pr_debug to support
> dynamic_debug for systems where it makes sense to use.

if we do something like this, then I want to do it a lot more integrated. So far I came up with this:

1) We want to be able to start btmon -d and btmon-logger -d and then debugging gets enabled in the kernel and bluetoothd and all of them will be included in the btmon trace files. So a customer can just create a log files that includes kernel messages, bluetoothd messages and also HCI traces and if enabled (and supported by the specific hardware) LMP traces.

2) When enabled in the kernel, then bluetoothd should follow the debug level. I think it makes no sense if we end up having to restart bluetoothd. Especially since bluetoothd also has internally “dynamic_debug” like statements that can be switched at runtime (and per statement actually).

3) We need an option to disable this and compile it out. Switching on dynamic_debug and extra debug statements for our own “dynamic_debug” causes an overhead that we can not really accept. We might even go this far as making it mutually exclusive.

4) Wherever possible we want debug statements that can be related to the given hciX interface index.

5) There needs to be an option to limit the scope of the debug messages since otherwise you get lost in the noise.

6) I don’t want to touch every BT_DBG statement or debug statement in bluetoothd. Developers should be able to just add a debug and the rest will be taken care of for them.

This needs a bit more time to be planed out, but I am roughly thinking something like this:

Read Debugging Categories Command
=================================

	Command Code:		TBD
	Controller Index:	<controller id>
	Command Parameters:
	Return Parameters:	Num_Supported_Categories (2 Octets)
				Num_Enabled_Categories (2 Octets)
				Supported_Category1 (2 Octets)
				..
				Enabled_Category1 (2 Octets)
				..

Set Debugging Categories Command
================================

	Command Code:		TBD
	Controller Index:	<controller id>
	Command Parameters:	Category_Count (2 Octets)
				Category1 (2 Octets)
				..

Debugging Categories Changed Event
==================================

	Event Code:		TBD
	Controller Index:	<controller id>
	Event Parameters:	Category_Count (2 Octets)
				Category1 (2 Octets)
				..


With this bluetoothd can check the enabled categories and just enable them when it starts, but it can also monitor the change in enabled categories and change the debug statements accordingly.

This would be independent of btmon and btmon-logger, but these two commands could also use the monitor socket to enable additional categories via a socket option. Or maybe this is better done just one way. I need to think about this a bit more.

Anyhow this is just the API that I would look into doing. The heavy lifting has to be done in the kernel and bluetoothd to use it correctly. That is actually a bit more complicated.

Regards

Marcel


Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FA0C47082
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 14:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5923F6138C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 14:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhFCOSO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Jun 2021 10:18:14 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48202 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhFCOSN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Jun 2021 10:18:13 -0400
Received: from smtpclient.apple (p4fefc9d6.dip0.t-ipconnect.de [79.239.201.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id 504C4CED1F;
        Thu,  3 Jun 2021 16:24:25 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: Please backport BTUSB_INTEL_NEWGEN to stable 5.10.x
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <DM8PR11MB55737E1DC9F97B750713C1EDF53C9@DM8PR11MB5573.namprd11.prod.outlook.com>
Date:   Thu, 3 Jun 2021 16:16:27 +0200
Cc:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <029F6035-91C8-475C-A7C9-C8DB2698255C@holtmann.org>
References: <cdab6dbada26fe31d21bb133ef087574c85c1411.camel@infinera.com>
 <c975e61b3866cc7615e6b995977a9d59f22384e8.camel@infinera.com>
 <DM8PR11MB55737E1DC9F97B750713C1EDF53C9@DM8PR11MB5573.namprd11.prod.outlook.com>
To:     "K, Kiran" <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

> I need to check the process to submit patch to stable version of kernel.
> 
> Luiz/Marcel,
> 
> Any input here ?

in general if it is more than just adding USB_DEVICE entry, then no, we don’t back port.

Regards

Marcel


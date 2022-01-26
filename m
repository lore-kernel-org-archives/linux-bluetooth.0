Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98235C28CF5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jan 2022 13:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239923AbiAZNcE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jan 2022 08:32:04 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:49826 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiAZNcB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jan 2022 08:32:01 -0500
Received: from smtpclient.apple (p4ff9fc34.dip0.t-ipconnect.de [79.249.252.52])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1880ECED06;
        Wed, 26 Jan 2022 14:32:00 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH 1/4] build: Always define confdir and statedir
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <78f77f0268ce1b4818c0a0749d3371b825fa1c92.camel@hadess.net>
Date:   Wed, 26 Jan 2022 14:31:59 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <390473B8-2187-4C84-B319-9D4A8FB6ED0A@holtmann.org>
References: <20220126113638.1706785-1-hadess@hadess.net>
 <78f77f0268ce1b4818c0a0749d3371b825fa1c92.camel@hadess.net>
To:     Bastien Nocera <hadess@hadess.net>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

> Some patches from 2017 to use systemd lockdown. They've been used for 5
> years by Fedora and RHEL.
> 
>> As we will need those paths to lock down on them.
>> ---
>>  Makefile.am | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/Makefile.am b/Makefile.am
>> index e391d7ae8..2ba25e687 100644
>> --- a/Makefile.am
>> +++ b/Makefile.am
>> @@ -28,14 +28,14 @@ AM_CFLAGS = $(MISC_CFLAGS) $(WARNING_CFLAGS)
>> $(UDEV_CFLAGS) $(LIBEBOOK_CFLAGS) \
>>                                 $(LIBEDATASERVER_CFLAGS)
>> $(ell_cflags)
>>  AM_LDFLAGS = $(MISC_LDFLAGS)
>>  
>> +confdir = $(sysconfdir)/bluetooth
>> +statedir = $(localstatedir)/lib/bluetooth
>> +
>>  if DATAFILES
>>  dbusdir = $(DBUS_CONFDIR)/dbus-1/system.d
>>  dbus_DATA = src/bluetooth.conf
>>  
>> -confdir = $(sysconfdir)/bluetooth
>>  conf_DATA =
>> -
>> -statedir = $(localstatedir)/lib/bluetooth
>>  state_DATA =
>>  endif
>>  

seems I missed that one. Can you please be more specific what this change does.

Regards

Marcel


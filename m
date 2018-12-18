Return-Path: <SRS0=Q26+=O3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EB8C43387
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 13:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9431421871
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 13:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbeLRNri convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:47:38 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:51963 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeLRNri (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Dec 2018 08:47:38 -0500
Received: from marcel-macpro.fritz.box (p4FF9F1DE.dip0.t-ipconnect.de [79.249.241.222])
        by mail.holtmann.org (Postfix) with ESMTPSA id 4D69ECF35C;
        Tue, 18 Dec 2018 14:55:16 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH BlueZ v3 00/30] Major rewrite for Multi-Node and DBus
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <110368016.VWXbCARz0c@ix>
Date:   Tue, 18 Dec 2018 14:47:36 +0100
Cc:     Brian Gix <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <73E0C5F2-1162-4857-976A-EDE376D55747@holtmann.org>
References: <20181215002624.9313-1-brian.gix@intel.com>
 <DEBB0CAA2616974FAE35E4B560B9A4375D8E01AF@ORSMSX101.amr.corp.intel.com>
 <17761993.WvVeqkb5i9@ix> <110368016.VWXbCARz0c@ix>
To:     Szymon Janc <szymon.janc@codecoup.pl>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

>>> This patch-set has been applied upstream.
>> 
>> There is something wrong with Makefile.mesh
>> 
>> Makefile.am: installing './depcomp'
>> parallel-tests: installing './test-driver'
>> Makefile.mesh:31: warning: variable 'mesh_btmesh_LDADD' is defined but no
>> program or
>> Makefile.mesh:31: library has 'mesh_btmesh' as canonical name (possible
>> typo) Makefile.am:306:   'Makefile.mesh' included from here
>> Makefile.mesh:32: warning: variable 'mesh_btmesh_DEPENDENCIES' is defined
>> but no program or
>> Makefile.mesh:32: library has 'mesh_btmesh' as canonical name (possible
>> typo) Makefile.am:306:   'Makefile.mesh' included from here
>> 
>> 
>> Enabling commented out code (why is it commented out btw?) in Makefile.mesh
>> stil results in:
>> 
>> Makefile.mesh:39: warning: mesh_btmesh_LDADD multiply defined in condition
>> MESH ...
>> Makefile.am:306:   'Makefile.mesh' included from here
>> Makefile.mesh:31: ... 'mesh_btmesh_LDADD' previously defined here
>> Makefile.am:306:   'Makefile.mesh' included from here
>> 
> 
> 
> This seems to fix warnign for me. Was ot on purpose that btmesh wasn't added 
> to noinst ?
> 
> 
> diff --git a/Makefile.mesh b/Makefile.mesh
> index 5344fbb21..1b8adea7e 100644
> --- a/Makefile.mesh
> +++ b/Makefile.mesh
> @@ -31,8 +31,8 @@ mesh_meshd_DEPENDENCIES = $(ell_dependencies)
> mesh_btmesh_LDADD = src/libshared-mainloop.la $(ell_ldadd) -lreadline -ljson-
> c
> mesh_btmesh_DEPENDENCIES = $(ell_dependencies)
> 
> -#
> -# noinst_PROGRAMS += mesh/btmesh
> +noinst_PROGRAMS += mesh/btmesh
> +
> #
> # mesh_btmesh_SOURCES = $(mesh_sources) \
> #                                              mesh/btmesh.c
> 


so this stuff is _not_ acceptable at all. Please stop treating bluez.git as your playground. It is your responsibility that such patches are not applied.

We have git and so everything can be reversed and history can be restored. Commenting anything out in a Makefile is never needed and a total no-go. Same applies to *.c files. I do not want staging or untested stuff in the main tree. I also do not want any dead files in the tree that are not build. Clone your tree on github or somewhere else if you want to experiment.

I am reverting the whole set of patches and doing a push —force. You need to start over.

Regards

Marcel


Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE11C433B4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 May 2021 19:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7532F61261
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 May 2021 19:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbhEQTbS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 May 2021 15:31:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25078 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233582AbhEQTbS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 May 2021 15:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621279800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=izTKXsFo2xZ0g0QbNeP3aW40bOHkfh7qiU/FQQuphvs=;
        b=ZTWTc0U7WKI//9T30bGQtCBDnAc9EJGoPVG2BeSTRlWeig0U+qwSholgNqswRttjVnvH7P
        xDXZMrVH/iWnXrxr4gJaIWJNhj+tWpepQghSZequIta+lTCfDZnwB3NcD11W06Ok5bXycm
        DctG+3y367DbESGaMayjSSywFP+G7n0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-Sjw_Fl2JPeSCAFb_yK-8VA-1; Mon, 17 May 2021 15:29:58 -0400
X-MC-Unique: Sjw_Fl2JPeSCAFb_yK-8VA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6321F1009460;
        Mon, 17 May 2021 19:29:57 +0000 (UTC)
Received: from x2.localnet (ovpn-114-255.rdu2.redhat.com [10.10.114.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D8DE5D9F2;
        Mon, 17 May 2021 19:29:57 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     linux-bluetooth@vger.kernel.org,
        Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Subject: Re: [Bluez PATCH ] Fix memory leaks in obex
Date:   Mon, 17 May 2021 13:17:32 -0400
Message-ID: <11751357.O9o76ZdvQC@x2>
Organization: Red Hat
In-Reply-To: <9af2be8769f9b8b1146424a72735084984fde825.camel@gmail.com>
References: <20210515094307.16fb1572@ivy-bridge> <9af2be8769f9b8b1146424a72735084984fde825.camel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Monday, May 17, 2021 1:10:58 PM EDT Tedd Ho-Jeong An wrote:
> On Sat, 2021-05-15 at 09:43 -0400, Steve Grubb wrote:
> > This patch fixes a couple memory leaks.
> > 
> > In filesystem, g_file_get_contents allocates fresh memory to buf.
> > It needs to be freed after conversion to a GString object.
> > 
> > Destination was missed on an error path as is mld.
> > 
> > ---
> > obexd/plugins/filesystem.c     | 2 +-
> > obexd/plugins/ftp.c            | 8 ++++++--
> > obexd/plugins/messages-dummy.c | 1 +
> > 3 files changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/obexd/plugins/filesystem.c b/obexd/plugins/filesystem.c
> > index 09bff8ad0..44e3cf3d2 100644
> > --- a/obexd/plugins/filesystem.c
> > +++ b/obexd/plugins/filesystem.c@@ -416,6 +416,7 @@ static void
> > *capability_open(const char *name, int oflag, mode_t mode,
>
> CI wasn't able to apply the patch and couldn't run the tests, and I think
> because of this line.

Hmm. Apologies. I'll regenerate the patch and send it again.

Cheers,
-Steve



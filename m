Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D92C433ED
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 May 2021 02:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50A7660FE9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 May 2021 02:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhEMCMK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 May 2021 22:12:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40317 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229630AbhEMCMJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 May 2021 22:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620871860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ICMQylqhCgMRtr83Y58Bbw7PMiU8fqMBGPQQmoz74mo=;
        b=RujhAk8OoTHELDLSEGcr+3BomzuyhNoOx7n3ZeIU8hMfm/fgOX7jBZF9u+lH+LoHPd9MId
        rCD2e2FLj1cyOzYx+DsCHO7IR4+DLBPo0fov2zdpbWuyAsDQE5c4J+cOxjLf4VULQmgxcF
        hIPHl8xw0+yLgG5nvpCnt6r1q6ThPRQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-hoFXd1VIMeSOiUD_8440Kg-1; Wed, 12 May 2021 22:10:58 -0400
X-MC-Unique: hoFXd1VIMeSOiUD_8440Kg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FB02FC95;
        Thu, 13 May 2021 02:10:57 +0000 (UTC)
Received: from x2.localnet (ovpn-112-55.rdu2.redhat.com [10.10.112.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A9995D6AC;
        Thu, 13 May 2021 02:10:57 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     linux-bluetooth@vger.kernel.org, Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 1/1] Fix various memory leaks
Date:   Wed, 12 May 2021 22:10:55 -0400
Message-ID: <11748148.O9o76ZdvQC@x2>
Organization: Red Hat
In-Reply-To: <6af830fc74d50c722ecb9855038a00bf6673d4e5.camel@hadess.net>
References: <20210512133932.4e2b4bd0@ivy-bridge> <6af830fc74d50c722ecb9855038a00bf6673d4e5.camel@hadess.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wednesday, May 12, 2021 6:35:54 PM EDT Bastien Nocera wrote:
> On Wed, 2021-05-12 at 13:39 -0400, Steve Grubb wrote:
> > diff --git a/obexd/plugins/filesystem.c b/obexd/plugins/filesystem.c
> > index 09bff8ad0..44e3cf3d2 100644
> > --- a/obexd/plugins/filesystem.c
> > +++ b/obexd/plugins/filesystem.c
> > @@ -415,7 +415,7 @@ static void *capability_open(const char *name,
> > int oflag, mode_t mode,
> >                         goto fail;
> >                 }
> >  
> > -               object->buffer = g_string_new(buf);
> > +               object->buffer = buf;
> >  
> >                 if (size)
> >                         *size = object->buffer->len;
> 
> Pretty certain this is wrong. 

Yeah, now that you mention it...that is a GString object. I guess we 
g_free(buf) right after the g_string_new(). Should I resend just that one 
patch or do I need to regenerate all 7 emails?

-Steve



Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079A7C433B4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 May 2021 17:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9DD060FE6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 May 2021 17:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237854AbhEQRMS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 May 2021 13:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235732AbhEQRMR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 May 2021 13:12:17 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722BAC061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 May 2021 10:11:00 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so5938296pjp.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 May 2021 10:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=czs6JRqNIf7QdQUc60mBgkL4AfLpnyGt/i/VHJNAXfU=;
        b=YT/VK6dI/gyxTNVpUVuyTW4WDc2fe2jdrab3LKg2ZyPMtf9c1p98WCH/hw6deOpImM
         WEDnMAUAlMR9KROAKP1VrYYndg/ZEzXl7VmtmzC4vkNF31jkJSBRgtmj+1Ju9w6jpiPt
         /jSzA4U4ztW7lA4KecIVUuOFSRXRVJ8TUJcYQgTn2vGZ9dBsIPk3A2AdCRPVD9Id3LUj
         SZ/TJN4Fh5nSXhoiqvjI4UYl910rptMIX6ZTFmnvqjkkg4LQ3SbzKM3UsYmOhGNLb0t/
         kRadzGYbsP8HQmhSjgiF+N3sBe+3O6Dk0+U1O/B7qeDLktYmSqd5IgTGvr/J348PU/KT
         G3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=czs6JRqNIf7QdQUc60mBgkL4AfLpnyGt/i/VHJNAXfU=;
        b=hrCovc6Eh3UZXA7OUlyWy6ocshwWF4APAGo7FZLwMNLuQ+hNcFomf9ZX7qg8ocLmyg
         JCVr1E64k4UO+giN39DfxcVdzo5xK2JkQEJDiMg1RTA7aojCtT7nneFyRBnLKa9+xciE
         wHfSUtB9Pqn8fDPTD5Gfla0UJhPDmU9Pv4x9A5fdwLDW6f6WQySujk2yfGbvJYEG/pkS
         nY9IlC2885wdlkgyxiOuJet1/VE5RznsM/H6XNDDm2dyqusxn0Rb73uhiSRWOQZqhrpI
         aBPVA4VdCjDQMlt9hh2c1DODr8kgrVB/09XItaaqVdMQ9C7Klx3A/jcVX1a+DhOxhdn5
         xI5g==
X-Gm-Message-State: AOAM531FPnm0rxFTv3Wu8QgAReB2oK5OT2NJUX1zG05D3eNgO2LpV/W4
        IUQe/K9tncTFmohwnHHE2NX68+feknBtgA==
X-Google-Smtp-Source: ABdhPJxPhoedntR7jItGxJAAsJdZ+xfpiEvGF/HJrxAq4WIO0yq4P9/MFoNXpTUn05SU9bAZrHu0TQ==
X-Received: by 2002:a17:90a:c42:: with SMTP id u2mr515958pje.10.1621271459997;
        Mon, 17 May 2021 10:10:59 -0700 (PDT)
Received: from han1-mobl3 ([2601:1c0:6a01:d830::f604])
        by smtp.gmail.com with ESMTPSA id u1sm10872957pgh.80.2021.05.17.10.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 10:10:59 -0700 (PDT)
Message-ID: <9af2be8769f9b8b1146424a72735084984fde825.camel@gmail.com>
Subject: Re: [Bluez PATCH ] Fix memory leaks in obex
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     Steve Grubb <sgrubb@redhat.com>, linux-bluetooth@vger.kernel.org
Date:   Mon, 17 May 2021 10:10:58 -0700
In-Reply-To: <20210515094307.16fb1572@ivy-bridge>
References: <20210515094307.16fb1572@ivy-bridge>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Steve,

On Sat, 2021-05-15 at 09:43 -0400, Steve Grubb wrote:
> This patch fixes a couple memory leaks.
> 
> In filesystem, g_file_get_contents allocates fresh memory to buf.
> It needs to be freed after conversion to a GString object.
> 
> Destination was missed on an error path as is mld.
> 
> ---
>  obexd/plugins/filesystem.c     | 2 +-
>  obexd/plugins/ftp.c            | 8 ++++++--
>  obexd/plugins/messages-dummy.c | 1 +
>  3 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/obexd/plugins/filesystem.c b/obexd/plugins/filesystem.c
> index 09bff8ad0..44e3cf3d2 100644
> --- a/obexd/plugins/filesystem.c
> +++ b/obexd/plugins/filesystem.c@@ -416,6 +416,7 @@ static void *capability_open(const char *name, int oflag, mode_t mode,

CI wasn't able to apply the patch and couldn't run the tests, and I think because of this line.


>  		}
>  
>  		object->buffer = g_string_new(buf);
> +		g_free(buf);
>  
>  		if (size)
>  			*size = object->buffer->len;
> diff --git a/obexd/plugins/ftp.c b/obexd/plugins/ftp.c
> index 259bfcae2..4b04bab06 100644
> --- a/obexd/plugins/ftp.c
> +++ b/obexd/plugins/ftp.c
> @@ -386,8 +386,10 @@ static int ftp_copy(struct ftp_session *ftp, const char *name,
>  	ret = verify_path(destdir);
>  	g_free(destdir);
>  
> -	if (ret < 0)
> +	if (ret < 0) {
> +		g_free(destination);
>  		return ret;
> +	}
>  
>  	source = g_build_filename(ftp->folder, name, NULL);
>  
> @@ -424,8 +426,10 @@ static int ftp_move(struct ftp_session *ftp, const char *name,
>  	ret = verify_path(destdir);
>  	g_free(destdir);
>  
> -	if (ret < 0)
> +	if (ret < 0) {
> +		g_free(destination);
>  		return ret;
> +	}
>  
>  	source = g_build_filename(ftp->folder, name, NULL);
>  
> diff --git a/obexd/plugins/messages-dummy.c b/obexd/plugins/messages-dummy.c
> index 34199fa05..e37b52df6 100644
> --- a/obexd/plugins/messages-dummy.c
> +++ b/obexd/plugins/messages-dummy.c
> @@ -488,6 +488,7 @@ int messages_get_messages_listing(void *session, const char *name,
>  			int err = -errno;
>  			DBG("fopen(): %d, %s", -err, strerror(-err));
>  			g_free(path);
> +			g_free(mld);
>  			return -EBADR;
>  		}
>  	}


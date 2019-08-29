Return-Path: <SRS0=q5Cw=WZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA347C3A59F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Aug 2019 09:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79DE02339E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Aug 2019 09:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="jULKQIJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfH2J74 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Aug 2019 05:59:56 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42922 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfH2J7z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Aug 2019 05:59:55 -0400
Received: by mail-lf1-f68.google.com with SMTP id u13so2012667lfm.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2019 02:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1lC+hH9Gwx+bNHkwBGuwqMYJcIp0XDfnrsTRuI7bdjo=;
        b=jULKQIJjcaORvjGcebXlcKU8ghD3G8S3WiXzUvKbuW8ktGUfL/SItKHqss0QH2Fi27
         lZ/fWYomnY4NW2U/D6Inc2+3rPU8+4YrOennXq6E6g4iTZ0Ebx7F0qUGpZLoLliYvprL
         o9nQgky7vSkh92XHMbOrMmFgocUjbyV2ksmM13JFraVeJrx81kkKI9KCIr69iuLJaIMW
         iZsA2p0Elofmv9d9OriKn4TF976WHI8FHsJzYj/6ovBvPCqNnnzI3wnU35wyv+NZwTFH
         5Z8GLMMmPBAYCLqFskU1t9w34Ft8LXmv4Op9Jlvp9qU3qHg1fMtrA0TP9v1rUsVKyDOQ
         7nDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=1lC+hH9Gwx+bNHkwBGuwqMYJcIp0XDfnrsTRuI7bdjo=;
        b=EBCwRIVRFixXaiMKagm5jQLh7SLBdTFcPaDOI1BMqfm9JaK1T5vBxI3uc3i32cGXbg
         JLacZuOhYs59HbErXjD3frVfq1y0bYq4DwawpjvmjEc+Ctg480X1NJ6c0bFR0LBoUUo3
         oW3MrLS5CzSwmTit+/GmwjqCGTCX0pL9loPh7oKBbWW2OXpEHlfWaAvBtOGWghrwAUBz
         SN2QJKg9koIV5tbMbcvmfAHsBgW0KbWCW0b8D2KAiEXuoTiqQsfx/PeVCru8Z1G6rEl4
         7bXloZZORMyOr4Xw5lRrHnUduRXm70lNqEkiBAgPQa+GFaKZEj9DDqSVwx8X+hqUri/e
         9G1A==
X-Gm-Message-State: APjAAAVFw8tG9z2TIGPOrIvbBQeD6g/7Sje5+7fnhyIJ8RfFYcuTlaHR
        XT6wuFD3nz5uGuCJvNshrmKxpw==
X-Google-Smtp-Source: APXvYqwIQcewig2T6+eREfJFW8CrrEJ3QOso9IlAlKZqp1c0bJy1AmI5pzU2DLSCLr6gfq2wYwZhqA==
X-Received: by 2002:ac2:4901:: with SMTP id n1mr5778781lfi.0.1567072794078;
        Thu, 29 Aug 2019 02:59:54 -0700 (PDT)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id p9sm276337lji.107.2019.08.29.02.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 02:59:53 -0700 (PDT)
Date:   Thu, 29 Aug 2019 11:59:51 +0200
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Log D-Bus method call errors
Message-ID: <20190829095951.nzzqqhgvblhogf4e@mlowasrzechonek2133>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20190820075654.2195-1-michal.lowas-rzechonek@silvair.com>
 <685bc703108f5329b861f5c5f87301b44bddd8e0.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <685bc703108f5329b861f5c5f87301b44bddd8e0.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On 08/28, Gix, Brian wrote:
> On Tue, 2019-08-20 at 09:56 +0200, Michał Lowas-Rzechonek wrote:
> > If a system is misconfigured, mesh daemon might not have permissions to
> > call application methods.
> >
> > This patch causes mesh daemon to log such errors, instead of failing
> > silently.
>
> Some of these Replies for error checking are warranted, I think...
> Particularily when there is required information that needs to be sent
> to the Application during Provisioning, for instance.
>
> But sometimes we expect the application to be "away" for normal
> reasons (it is intended as a foreground app, for instance) where I am
> not sure we want to require the response... For instance the method
> calls in model.c that occur when a remote node has sent a message.

Yes, these calls were my primary concern here.

Note that D-Bus calls do *not* happen if the application is not attached
(node->owner is NULL).

> The Non-Reply version of send (towards the apps) was actually a design
> decision, since we don't want the *daemon* to exhast d-bus resources,
> depending on replies from Apps that are ignoring the messages we are
> sending.
>
> This could negatively impact the daemon's ability to
> interact with perhaps better behaved applications.  I think every
> reply required message persists for up to 30 seconds.

True.

Since most of the application-side methods do not return anything (and
rightly so, because "Any discrete OTA message might be lost"), the
application is free to do whatever is pleases with the payload,
including dropping it.

Still, I think that the none of the call handlers on the application
side should *ever* return errors/timeouts over D-Bus.

I'm arguing that such an application is misbehaving, so it probably
should be promptly detached. That would protect the daemon.

> I think our rule of thumb should be requiring a response when the
> daemon needs to know that the App has successfully handled critical
> information so for instance YES for:
>
> AddNodeComplete()
> JoinComplete()
> RequestProvData()

Agreed.

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND

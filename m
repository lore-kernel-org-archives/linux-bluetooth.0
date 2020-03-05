Return-Path: <SRS0=x0qO=4W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEE9C3F2CD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 14:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A680E21739
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 14:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dKfNSaaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgCEOg5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Mar 2020 09:36:57 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45840 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgCEOg4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Mar 2020 09:36:56 -0500
Received: by mail-lj1-f195.google.com with SMTP id e18so6327029ljn.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Mar 2020 06:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QBLIBZ6bMlE4H5bgueyYEzwbeCvV1i77C/PdlNsQOQs=;
        b=dKfNSaaYeHeVOJV6OMWJfFS05zqBJQW3CPPQf9N3g8Jan275xkkyzhXZQ8HMXpU+0r
         tblo2TupyMdco0CZr16E5ilsc3onViAQPMaXCa3Pl7N79GS3mrAld9LCsZ/eCdBMYWJJ
         JAdSNmAm51GQtlm52codaZozDks/9tpLtBvQxVe1P1BM5j0P9SKNZO0+Io2bxZe7Gwvu
         BVO731M8T1zwFDgc0kPzLEj6CZfYQk+1u1X3TKsu2XYJGs9IhMCUDJdcVtgYJdKgFq0y
         ipHIQvS6zZuhbhOUsE88T3coKnvDGH9kSegMsZfzKLF5kcTUIkrVUm+ICb1MEpBUHLiv
         +BFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QBLIBZ6bMlE4H5bgueyYEzwbeCvV1i77C/PdlNsQOQs=;
        b=j9JJOyXImYCaR6p1P7EqoQ3t9SgIZ5D/iaX27kSioMgojIJJdvIkgvDfi25m5dXuJ7
         2LtFitPM4dQnI9hLEeujdicw3ewbZnBrRSaOaJ/qdCjc6zydgqX1SG8cv2BrabNHZvgM
         zimwrGUNgrRGCmrddliA7UQDM0BjD51Om3jiot4c9xpkCpFWnUXcJqL4qJItvTkmyAkx
         xMzTIYqYE1uPBFNHQLZoa/oH6s52sKphmn6/k6D/FEmpvr4gAakuxZiCjGK0+6DLAcWX
         Ed8b5MPRvxcXx49bFM0BFrjnDTXEROG5Nhnz+qqvoH8jAdBWo4eulPSSfcpqT0+5lmtk
         +qvw==
X-Gm-Message-State: ANhLgQ1/L9SBAXdoW8uF+OQsfex39aCfFCzOdDj/4ge4hjtkvhxlfkFW
        kLQaz5FeMEPk9ai5vGKGOCQ8GQ46B9ZtfD9AW/I7wg==
X-Google-Smtp-Source: ADFU+vv73pwoTYrfRIJG8sAcxIMw+U8Hst7b2FYSMDCmL2Tfv/vdYmej4qd5BCnlEfJpnhd36mzshIp1I2BTeZbK3Ps=
X-Received: by 2002:a2e:9e03:: with SMTP id e3mr5536824ljk.186.1583419014295;
 Thu, 05 Mar 2020 06:36:54 -0800 (PST)
MIME-Version: 1.0
References: <20200304203152.111935-1-alainm@chromium.org> <634EDB16-907F-42B8-A717-826EE334B1D5@holtmann.org>
In-Reply-To: <634EDB16-907F-42B8-A717-826EE334B1D5@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Thu, 5 Mar 2020 09:36:42 -0500
Message-ID: <CALWDO_U9Ob3JNqWXu0M3oQJf=eBWanRC6J3jdRXY5k=D7wifxw@mail.gmail.com>
Subject: Re: [BlueZ PATCH v2] Adding definitions for Wide Band Speech configuration
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Ok, thanks Marcel, I'll send v4 of the other patch with your suggested changes.


On Thu, Mar 5, 2020 at 6:10 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Alain,
>
> > This change adds the corresponding user space definition for wide band
> > speech.
> >
> > ---
> >
> > lib/mgmt.h | 5 ++++-
> > 1 file changed, 4 insertions(+), 1 deletion(-)
>
> patch has been applied.
>
> However I did change WIDE_BAND to WIDEBAND as mentioned in the other review.
>
> Regards
>
> Marcel
>

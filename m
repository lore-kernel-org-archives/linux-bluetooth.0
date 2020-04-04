Return-Path: <SRS0=Oq99=5U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED06C2BA17
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Apr 2020 00:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05CE52074B
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Apr 2020 00:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CTYeesYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgDDAjs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Apr 2020 20:39:48 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37891 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgDDAjs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Apr 2020 20:39:48 -0400
Received: by mail-oi1-f194.google.com with SMTP id w2so7841812oic.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2020 17:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fwdppA0HowuUxClKJSgNKg+JHXHmd+YQUDGgvkgPrgc=;
        b=CTYeesYijL6YL0zbY2T3qZ9i9jeI+GL+zJV/w8dCXBJeLXh80ZNTvBGixknssfhX1T
         1rCCELoyTTit8BEXfL9towo6fN7qTznLFlsXaS3X17sDNz77Xy9qtI2NGU4R04t0aovx
         OuWqaIM5p76ajHQA97GKBo8dejcwB7YDY/FWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fwdppA0HowuUxClKJSgNKg+JHXHmd+YQUDGgvkgPrgc=;
        b=JkJXvmknKfWLiZXJIL8Ddo8qI5/BJL8NA928qxWYuyko04Er2y7+/8WQkfqrN6X5W0
         IwxiDSKz/heC1fVYPQFh6ebosrR2CziUCM7itZueVtKXudO51CI2oGLy9zMnuwxeiOyo
         i5am8qwENsXmGJ5DLQcZYw+frDoePLFkkh0val7JyACMBL8MoCisbcO2/Uvrg+i8BoV6
         7sn32No+YF0qyZikEsaax/dwwz0NBX3iHnenjLGl98NUVOF+/1js/9Vv+Rr7RSknZZW1
         8a49wpOHEhNUVcTQRnBIwMXW8ZUXFk6AMTHnW2c/SxgbCMMHsN69LKeNHUQIyDMXQ16S
         erow==
X-Gm-Message-State: AGi0PuaC/OZ0AjiiaztR5qWDoWmnBV2KXqRBp7W3v5YtdS356hbi1Hqt
        GPxLG2deXxbLlckYeVUxSaJpyUzx6DNvHAh5Rx5aeQ==
X-Google-Smtp-Source: APiQypK6wmBpZkXXMEXYONFsAJvr2BqqX5Cgz+k5e2G1JIYQoEjpB2AFV8zsmkWIpww0h+1ARvwfZ49JiRrnCJchBqs=
X-Received: by 2002:aca:1e0e:: with SMTP id m14mr5275665oic.136.1585960785750;
 Fri, 03 Apr 2020 17:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200403150236.74232-1-linux@roeck-us.net> <CALWDO_WK2Vcq+92isabfsn8+=0UPoexF4pxbnEcJJPGas62-yw@mail.gmail.com>
 <0f0ea237-5976-e56f-cd31-96b76bb03254@roeck-us.net> <CALWDO_VfZV0_uvsXyWAa-uOQ21228rUDsaChgkex88pyiP3U=A@mail.gmail.com>
In-Reply-To: <CALWDO_VfZV0_uvsXyWAa-uOQ21228rUDsaChgkex88pyiP3U=A@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Fri, 3 Apr 2020 17:39:34 -0700
Message-ID: <CAOxioNn-eRnMmLu7dk9bLi5KwRzh_yip4hiwMY6mRW6cYMaWeA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Simplify / fix return values from tk_request
To:     Alain Michaud <alainmichaud@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The patch looks good to me. Agreed with Guenter's assessment, I made a
mistake in the original patch by not being consistent with the
function contract.

On Fri, Apr 3, 2020 at 9:57 AM Alain Michaud <alainmichaud@google.com> wrote:
>
> On Fri, Apr 3, 2020 at 12:43 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On 4/3/20 8:13 AM, Alain Michaud wrote:
> > > Hi Guenter/Marcel,
> > >
> > >
> > > On Fri, Apr 3, 2020 at 11:03 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > >>
> > >> Some static checker run by 0day reports a variableScope warning.
> > >>
> > >> net/bluetooth/smp.c:870:6: warning:
> > >>         The scope of the variable 'err' can be reduced. [variableScope]
> > >>
> > >> There is no need for two separate variables holding return values.
> > >> Stick with the existing variable. While at it, don't pre-initialize
> > >> 'ret' because it is set in each code path.
> > >>
> > >> tk_request() is supposed to return a negative error code on errors,
> > >> not a bluetooth return code. The calling code converts the return
> > >> value to SMP_UNSPECIFIED if needed.
> > >>
> > >> Fixes: 92516cd97fd4 ("Bluetooth: Always request for user confirmation for Just Works")
> > >> Cc: Sonny Sasaka <sonnysasaka@chromium.org>
> > >> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > >> ---
> > >>  net/bluetooth/smp.c | 9 ++++-----
> > >>  1 file changed, 4 insertions(+), 5 deletions(-)
> > >>
> > >> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> > >> index d0b695ee49f6..30e8626dd553 100644
> > >> --- a/net/bluetooth/smp.c
> > >> +++ b/net/bluetooth/smp.c
> > >> @@ -854,8 +854,7 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
> > >>         struct l2cap_chan *chan = conn->smp;
> > >>         struct smp_chan *smp = chan->data;
> > >>         u32 passkey = 0;
> > >> -       int ret = 0;
> > >> -       int err;
> > >> +       int ret;
> > >>
> > >>         /* Initialize key for JUST WORKS */
> > >>         memset(smp->tk, 0, sizeof(smp->tk));
> > >> @@ -887,12 +886,12 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
> > >>         /* If Just Works, Continue with Zero TK and ask user-space for
> > >>          * confirmation */
> > >>         if (smp->method == JUST_WORKS) {
> > >> -               err = mgmt_user_confirm_request(hcon->hdev, &hcon->dst,
> > >> +               ret = mgmt_user_confirm_request(hcon->hdev, &hcon->dst,
> > >>                                                 hcon->type,
> > >>                                                 hcon->dst_type,
> > >>                                                 passkey, 1);
> > >> -               if (err)
> > >> -                       return SMP_UNSPECIFIED;
> > >> +               if (ret)
> > >> +                       return ret;
> > > I think there may be some miss match between expected types of error
> > > codes here.  The SMP error code type seems to be expected throughout
> > > this code base, so this change would propagate a potential negative
> > > value while the rest of the SMP protocol expects strictly positive
> > > error codes.
> > >
> >
> > Up to the patch introducing the SMP_UNSPECIFIED return value, tk_request()
> > returned negative error codes, and all callers convert it to SMP_UNSPECIFIED.
> >
> > If tk_request() is supposed to return SMP_UNSPECIFIED on error, it should
> > be returned consistently, and its callers don't have to convert it again.
> Agreed, the conventions aren't clear here.  I'll differ to Marcel to
> provide guidance in this case where as a long term solution might
> increase the scope of this patch beyond what would be reasonable.
> >
> > Guenter
> >
> > >>                 set_bit(SMP_FLAG_WAIT_USER, &smp->flags);
> > >>                 return 0;
> > >>         }
> > >> --
> > >> 2.17.1
> > >>
> > >
> > > Thanks,
> > > Alain
> > >
> >

Return-Path: <SRS0=BBV2=6L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB7FC4CECD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Apr 2020 18:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6179E214AF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Apr 2020 18:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588011293;
	bh=0LOW8UHxK43n+uKonJZnS7anP2ETCfbtmi1hwNBs6Ww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ndh8fZS8EpZzI49o6wsvSbPzxz5lEgMfNIKnotDBLK5T7Qvn08w10LzUS3eK0v/XJ
	 tfoiXN7VpausjPgKAldVqm31HMF5vjMNXQ9PSLxepTeeGlxfE82hqB8yh/b5fpMmVh
	 J2C39Si1tddPqx3/+TDqi4Gg8nsBfGsFjYWu1Jn8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgD0SOx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Apr 2020 14:14:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbgD0SOw (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Apr 2020 14:14:52 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1706D214AF;
        Mon, 27 Apr 2020 18:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588011292;
        bh=0LOW8UHxK43n+uKonJZnS7anP2ETCfbtmi1hwNBs6Ww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E7AqD8CusYLMuzL8gvT5Hv1Psgkf9KkEP+CuJVIISVRLrjlJALi+91GyI1dKpwbXf
         HqHsTvEDc+Er5QmGZoMBcTVBO6a8brLLKrrsE+n4F6RwWHLWT5dSD+Uq1Uofu7uZuE
         zbDQ/oAmMIx0rwGITSMX8KhyfHiaaGCUJKr/Sua4=
Received: by pali.im (Postfix)
        id 37EA28A8; Mon, 27 Apr 2020 20:14:50 +0200 (CEST)
Date:   Mon, 27 Apr 2020 20:14:50 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] device: Return error when ConnectProfile DBus method
 fails (second fix)
Message-ID: <20200427181450.6gpq6sy24wzr2cfc@pali>
References: <20200426210247.757-1-pali@kernel.org>
 <CABBYNZ+whHfHr27X8RgBpYv1980itzwTQmO03oR=DJDbgx78tQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZ+whHfHr27X8RgBpYv1980itzwTQmO03oR=DJDbgx78tQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Monday 27 April 2020 09:44:50 Luiz Augusto von Dentz wrote:
> Hi Pali,
> 
> On Sun, Apr 26, 2020 at 2:05 PM Pali Rohár <pali@kernel.org> wrote:
> >
> > This is fixup of commit 3aa815a31017e8793b030b04ef704ce85455b9aa. There is
> > another place which needs to distinguish between Connect and ConnectProfile
> > DBus method.
> > ---
> >  src/device.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/src/device.c b/src/device.c
> > index 229579378..7b0eb256e 100644
> > --- a/src/device.c
> > +++ b/src/device.c
> > @@ -1861,7 +1861,9 @@ static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bdaddr_type
> >         dev->pending = create_pending_list(dev, uuid);
> >         if (!dev->pending) {
> >                 if (dev->svc_refreshed) {
> > -                       if (find_service_with_state(dev->services,
> > +                       if (dbus_message_is_method_call(msg, DEVICE_INTERFACE,
> > +                                                       "Connect") &&
> > +                               find_service_with_state(dev->services,
> >                                                 BTD_SERVICE_STATE_CONNECTED))
> 
> Perhaps it would be better to have a helper function that checks this for us.

I do not know if it helps, but I think this is the last problem which I
observed with connect/disconnect profile method.

> >                                 return dbus_message_new_method_return(msg);
> >                         else
> > --
> > 2.20.1
> >
> 
> 
> -- 
> Luiz Augusto von Dentz

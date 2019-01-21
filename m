Return-Path: <SRS0=Rr1U=P5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B139CC2F421
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jan 2019 15:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A602087F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jan 2019 15:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548083393;
	bh=1bE1KOtbOjX/VG+2C7/7PrHjmRzd/RkYJMJD7IyZ3gg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M5iDRZI4ovAAMKKWoDQ8stWF4tNZWbTTXbAuyYDSqQxBwspPFzCi/SwIHKV1PuBPG
	 ZqLXs/oSyYzCY0EI2yj4cMM7Xo4bO0RbwlEkoYegc8KpXs3nxR2xlcGSD1UGHEMbUB
	 HCfEvmin1B5ErqgNbc61gZJbd+3kk0o0SA89Jrmc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbfAUPJx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:09:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:42200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729072AbfAUPJw (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Jan 2019 10:09:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9481720823;
        Mon, 21 Jan 2019 15:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548083392;
        bh=1bE1KOtbOjX/VG+2C7/7PrHjmRzd/RkYJMJD7IyZ3gg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mjk130B/sTLIVWMqibjbsQk5DUwBJeZZExJxAF7+RLObPbf1rmVsGKot5ZtK6XwrE
         CWS7lpuaICUY5eMD3qfymhoP0EBR3aRIBwxvW6KTGscFSUBpscGl6Y8TT5CvLJGIqo
         bZlir7t6x+veOBSp0ffmz0SuH/HiI14mvp+PVylw=
Date:   Mon, 21 Jan 2019 16:09:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Verify that l2cap_get_conf_opt provides large
 enough buffer
Message-ID: <20190121150949.GA4717@kroah.com>
References: <20190118124319.12187-1-marcel@holtmann.org>
 <20190118125342.GA31025@kroah.com>
 <93BDB9CB-55F3-415A-8EED-DD532C36BC8A@holtmann.org>
 <20190118150044.GA31656@kroah.com>
 <70BE945F-F92B-4353-A2F8-41158CFEC535@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70BE945F-F92B-4353-A2F8-41158CFEC535@holtmann.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Jan 21, 2019 at 03:51:11PM +0100, Marcel Holtmann wrote:
> Hi Greg,
> 
> >>>> The function l2cap_get_conf_opt will return L2CAP_CONF_OPT_SIZE + opt->len
> >>>> as length value. The opt->len however is in control over the remote user
> >>>> and can be used by an attacker to gain access beyond the bounds of the
> >>>> actual packet.
> >>>> 
> >>>> To prevent any potential leak of heap memory, it is enough to check that
> >>>> the resulting len calculation after calling l2cap_get_conf_opt is not
> >>>> below zero. A well formed packet will always return >= 0 here and will
> >>>> end with the length value being zero after the last option has been
> >>>> parsed. In case of malformed packets messing with the opt->len field the
> >>>> length value will become negative. If that is the case, then just abort
> >>>> and ignore the option.
> >>>> 
> >>>> In case an attacker uses a too short opt->len value, then garbage will
> >>>> be parsed, but that is protected by the unknown option handling and also
> >>>> the option parameter size checks.
> >>>> 
> >>>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> >>>> ---
> >>>> net/bluetooth/l2cap_core.c | 6 ++++++
> >>>> 1 file changed, 6 insertions(+)
> >>>> 
> >>>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> >>>> index 77799e7d5a34..ccdc5c67d22a 100644
> >>>> --- a/net/bluetooth/l2cap_core.c
> >>>> +++ b/net/bluetooth/l2cap_core.c
> >>>> @@ -3337,6 +3337,8 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
> >>>> 
> >>>> 	while (len >= L2CAP_CONF_OPT_SIZE) {
> >>>> 		len -= l2cap_get_conf_opt(&req, &type, &olen, &val);
> >>>> +		if (len < 0)
> >>>> +			break;
> >>> 
> >>> <snip>
> >>> 
> >>> Patch looks good to me, thanks for fixing this all up:
> >> 
> >> it would be still good if we can get this verified by the reporter.
> > 
> > The "reporter" seems to have disappeared once they reported this stuff,
> > so I would not count on them doing anything here, we asked numerous
> > times :(
> > 
> > If the patches look correct, I recommend just merging it and I can
> > backport it to the stable releases and the distros can pick it up from
> > there.
> 
> I think that I have Johan merge them into bluetooth-next first and let
> them sit a little so we can verify they do not break anything else.
> You can pick them up later into -stable if nobody complained and we
> didn’t break qualification.

Sounds good to me, thanks.

greg k-h

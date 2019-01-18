Return-Path: <SRS0=s7/i=P2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51C3C43444
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 15:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C0320896
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 15:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547823648;
	bh=a/+McF0cITMP6pxFXNLPV1FPG7/8cCqbAniN7ouA5+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D7ZpfuAV44Wm83jQEnyjjGrE+AKCMKd3pljKEi+GnUtIPrXkkOpxe2GP++8hpVAIz
	 n/7LQTBGTZ9PoJ0FExOXH7dyA9szAn/3iwERiRgOU5pewDHJchvetsShMqoxXcURpH
	 YWMrGpCUUaVnIUyQDDe0A/DuL2DxixJ4jv7v7OeE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfARPAs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:00:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:35406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727415AbfARPAr (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jan 2019 10:00:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66B792087E;
        Fri, 18 Jan 2019 15:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547823646;
        bh=a/+McF0cITMP6pxFXNLPV1FPG7/8cCqbAniN7ouA5+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gG9eSKJcLZhpmZwuxj6vhvSQtLx3q74k8xfEiB2iuw+4z4tQoVWVeKQ2nydVxawlC
         EgTz1kgLWfhkfeqjFwhDVcNls1Hhfi2PZ2dfm7h3ePmXU8VbH4yFW4U+p0o0It6/ei
         E3SbSE+9OXxGpMK2d+tU0CAy7iCWIRJCfE9FfV7g=
Date:   Fri, 18 Jan 2019 16:00:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Verify that l2cap_get_conf_opt provides large
 enough buffer
Message-ID: <20190118150044.GA31656@kroah.com>
References: <20190118124319.12187-1-marcel@holtmann.org>
 <20190118125342.GA31025@kroah.com>
 <93BDB9CB-55F3-415A-8EED-DD532C36BC8A@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93BDB9CB-55F3-415A-8EED-DD532C36BC8A@holtmann.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Jan 18, 2019 at 02:12:23PM +0100, Marcel Holtmann wrote:
> Hi Greg,
> 
> >> The function l2cap_get_conf_opt will return L2CAP_CONF_OPT_SIZE + opt->len
> >> as length value. The opt->len however is in control over the remote user
> >> and can be used by an attacker to gain access beyond the bounds of the
> >> actual packet.
> >> 
> >> To prevent any potential leak of heap memory, it is enough to check that
> >> the resulting len calculation after calling l2cap_get_conf_opt is not
> >> below zero. A well formed packet will always return >= 0 here and will
> >> end with the length value being zero after the last option has been
> >> parsed. In case of malformed packets messing with the opt->len field the
> >> length value will become negative. If that is the case, then just abort
> >> and ignore the option.
> >> 
> >> In case an attacker uses a too short opt->len value, then garbage will
> >> be parsed, but that is protected by the unknown option handling and also
> >> the option parameter size checks.
> >> 
> >> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> >> ---
> >> net/bluetooth/l2cap_core.c | 6 ++++++
> >> 1 file changed, 6 insertions(+)
> >> 
> >> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> >> index 77799e7d5a34..ccdc5c67d22a 100644
> >> --- a/net/bluetooth/l2cap_core.c
> >> +++ b/net/bluetooth/l2cap_core.c
> >> @@ -3337,6 +3337,8 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
> >> 
> >> 	while (len >= L2CAP_CONF_OPT_SIZE) {
> >> 		len -= l2cap_get_conf_opt(&req, &type, &olen, &val);
> >> +		if (len < 0)
> >> +			break;
> > 
> > <snip>
> > 
> > Patch looks good to me, thanks for fixing this all up:
> 
> it would be still good if we can get this verified by the reporter.

The "reporter" seems to have disappeared once they reported this stuff,
so I would not count on them doing anything here, we asked numerous
times :(

If the patches look correct, I recommend just merging it and I can
backport it to the stable releases and the distros can pick it up from
there.

thanks,

greg k-h

Return-Path: <SRS0=EsMn=TA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB97C43219
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Apr 2019 15:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F1821734
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Apr 2019 15:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="cOkggsWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfD3PIT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Apr 2019 11:08:19 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:14865 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfD3PIS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Apr 2019 11:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1556636896;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=rfOSW7kFy1K4hs8GGHboqP2vTbwLIlmzqd+wayFLZZQ=;
        b=cOkggsWsCaCBx06Zw037bpzmUUUzGUvNt9s1JapLRCSmAXf/CtACEbW56tJVEV5BOW
        PHjd0ECyJxssIAju2AQjZMJylh0A4pAWkcFQdCLseHUvdnBehWpf18bhi3xxeCHU/AGH
        WAK8rhLqiemGQvSwi2buXmgYD7pzymdCYoXde+tkD9xI4ADvczT/riIkIeN0DAztxzkT
        N/NoWSPXQLAzTWacS6N6TKC/ziCBwewpfu12gOrqzgYX76SUzZueBBp1TIH1hskEDAA6
        wNAMO+PUu7WbHFx2cYxHjaDyHCkE0JXxWX8RFLBUVwFTeCMLMZVD86H8u3ayvUHD5uEA
        SiCA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u266EZF6ORJL3vVgtqsm"
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 44.18 AUTH)
        with ESMTPSA id 50b061v3UF59XmP
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 30 Apr 2019 17:05:09 +0200 (CEST)
Date:   Tue, 30 Apr 2019 17:04:56 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: btbcm: Add default address for BCM2076B1
Message-ID: <20190430150456.GA50466@gerhold.net>
References: <20190305130901.56660-1-stephan@gerhold.net>
 <20190305130901.56660-2-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305130901.56660-2-stephan@gerhold.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel, Hi Johan,

On Tue, Mar 05, 2019 at 02:09:01PM +0100, Stephan Gerhold wrote:
> BCM2076B1 appears to use 20:76:A0:00:56:79 as default address.
> This address is used by at least 5 devices with the AMPAK AP6476
> module and is also suspicious because it starts with the chip name
> 2076 (followed by a different revision A0 for some reason).
> 
> Add it to the list of default addresses and leave it up to the
> user to configure a valid one.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  drivers/bluetooth/btbcm.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 

As far as I can tell, you have applied the first patch of this series,
but forgot about this one. :)

It does not apply as-is anymore since you applied the patch from
Ferry Toth first, but it still applies cleanly with with 
"git am --3way".

Is that fine for you or should I re-send it on top of latest
bluetooth-next?

Thanks,
Stephan

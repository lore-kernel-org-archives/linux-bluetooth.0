Return-Path: <SRS0=wWRn=YK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8A4FA3736
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Oct 2019 12:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3203214E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Oct 2019 12:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="1W6T+By6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406438AbfJQMnF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Oct 2019 08:43:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45741 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbfJQMnE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Oct 2019 08:43:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id r5so2158822wrm.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Oct 2019 05:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HGYfQMOQQ/Llw7JM+7jrZqk8jvWFbqivJs1N/X/ktYU=;
        b=1W6T+By6Fyb2jmC1zIN29lxvN1RfimvyqGZm/IyNd0V+jAhEnMuR3HyZpQgzrmOhLk
         PVRFTAfV/ZKXqr6U/08O1Ez3u3mVXh5UF45EOmJyN3i4IzE3ozHnHpbxebhjZ94shBvL
         gHXflbn54dpLGUVRAM6N1AIiKogkN2aPAmJCtXER0fMyKruwAyjCtnCp3Rdk4VX76zV8
         vxUCyNaqnutYi9qbxamM5qop4YUgQPt/9Tt21OPAYxz34RRWnzsq5SkxwtK6D7YJZOTA
         WmDUDbMaLCyxAVbKdVFhHQMpTO7XA2cyDMEkk1fNYHBI9fnGNSx8oQhGeCqkQaUCwJaf
         ML8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HGYfQMOQQ/Llw7JM+7jrZqk8jvWFbqivJs1N/X/ktYU=;
        b=BITJWMJ3hayeaufCpkAxyGkHldFE6rTaE/RaFcEGpY/Gem/5aTOT3ubz2V0wwHvQiD
         MriImPb18epHUcyTIwOTHOvj7rMCarOlJLmEMRPCoiwSlsAYWgr8BjH3DVvi6w3pyiAt
         pi4Jbf+yJ2w5rFS7bMEnPOajZctIql+d58URL2M2yNpcOms2Zr3x0sVWrrIfCtTKOdbw
         xGpMcMyeeQsv9OF7/sLe8H3vEVjdiAmkii1WcfILVtuU88ZxOFYbqJNeJECviOoRNz8o
         8bglA/WSA/nw0LBuK9+x90+o1vEP2NqFnUjom+9XTiulTdn7u44E/oujJ45694yjwBHY
         jQMA==
X-Gm-Message-State: APjAAAVbhM2a6jfGXyUKUoCuHsKk/bGyVzR3zAasXm/mI7KI2pQkAvjm
        VVpdyH7GjnwgRTJ+7ddAK4warQ==
X-Google-Smtp-Source: APXvYqxSTrTbdDOJVZ/NSpsLlPLKMh5bomXVvJWF0PlOY6wiEaCsHR6FF/GB5VdIRYS1B4NMgrdXsA==
X-Received: by 2002:a05:6000:1190:: with SMTP id g16mr2819078wrx.133.1571316182250;
        Thu, 17 Oct 2019 05:43:02 -0700 (PDT)
Received: from netronome.com ([2001:982:756:703:d63d:7eff:fe99:ac9d])
        by smtp.gmail.com with ESMTPSA id k8sm576756wrg.15.2019.10.17.05.43.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Oct 2019 05:43:01 -0700 (PDT)
Date:   Thu, 17 Oct 2019 14:43:01 +0200
From:   Simon Horman <simon.horman@netronome.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        linux-kernel@lists.codethink.co.uk,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RFC: Bluetooth: missed cpu_to_le16 conversion in
 hci_init4_req
Message-ID: <20191017124300.fktzd27yy2t7gcqx@netronome.com>
References: <20191016113943.19256-1-ben.dooks@codethink.co.uk>
 <20191016122022.kz4xzx4hzmtuoh5l@netronome.com>
 <BFA3CB11-5FD8-4BD8-9DDA-62707AB84626@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BFA3CB11-5FD8-4BD8-9DDA-62707AB84626@holtmann.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Oct 16, 2019 at 08:42:48PM +0200, Marcel Holtmann wrote:
> Hi Simon,
> 
> >> It looks like in hci_init4_req() the request is being
> >> initialised from cpu-endian data but the packet is specified
> >> to be little-endian. This causes an warning from sparse due
> >> to __le16 to u16 conversion.
> >> 
> >> Fix this by using cpu_to_le16() on the two fields in the packet.
> >> 
> >> net/bluetooth/hci_core.c:845:27: warning: incorrect type in assignment (different base types)
> >> net/bluetooth/hci_core.c:845:27:    expected restricted __le16 [usertype] tx_len
> >> net/bluetooth/hci_core.c:845:27:    got unsigned short [usertype] le_max_tx_len
> >> net/bluetooth/hci_core.c:846:28: warning: incorrect type in assignment (different base types)
> >> net/bluetooth/hci_core.c:846:28:    expected restricted __le16 [usertype] tx_time
> >> net/bluetooth/hci_core.c:846:28:    got unsigned short [usertype] le_max_tx_time
> >> 
> >> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> >> ---
> >> Cc: Marcel Holtmann <marcel@holtmann.org>
> >> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> >> Cc: "David S. Miller" <davem@davemloft.net>
> >> Cc: linux-bluetooth@vger.kernel.org
> >> Cc: netdev@vger.kernel.org
> >> Cc: linux-kernel@vger.kernel.org
> >> ---
> >> net/bluetooth/hci_core.c | 4 ++--
> >> 1 file changed, 2 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> >> index 04bc79359a17..b2559d4bed81 100644
> >> --- a/net/bluetooth/hci_core.c
> >> +++ b/net/bluetooth/hci_core.c
> >> @@ -842,8 +842,8 @@ static int hci_init4_req(struct hci_request *req, unsigned long opt)
> >> 	if (hdev->le_features[0] & HCI_LE_DATA_LEN_EXT) {
> >> 		struct hci_cp_le_write_def_data_len cp;
> >> 
> >> -		cp.tx_len = hdev->le_max_tx_len;
> >> -		cp.tx_time = hdev->le_max_tx_time;
> >> +		cp.tx_len = cpu_to_le16(hdev->le_max_tx_len);
> >> +		cp.tx_time = cpu_to_le16(hdev->le_max_tx_time);
> > 
> > I would suggest that the naming of the le_ fields of struct hci_dev
> > implies that the values stored in those fields should be little endian
> > (but those that are more than bone byte wide are not).
> 
> the le_ stands for Low Energy and not for Little Endian.

Thanks, in that case I have no objections.

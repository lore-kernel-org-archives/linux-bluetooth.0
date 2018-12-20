Return-Path: <SRS0=5zPD=O5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB2FC43387
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Dec 2018 16:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CAA7205C9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Dec 2018 16:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="mrcz9FNS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732459AbeLTQRO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:17:14 -0500
Received: from mail-lj1-f176.google.com ([209.85.208.176]:46188 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730483AbeLTQRO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Dec 2018 11:17:14 -0500
Received: by mail-lj1-f176.google.com with SMTP id v15-v6so2063345ljh.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Dec 2018 08:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=o2hliW0c5FepOfyHYediT+IQFKwo29FjvZfez1VJ0BU=;
        b=mrcz9FNSGkWzAaTScrbvKCb8zlO2orBmoI52rNizNwnqZau84eR/MCFjLdyeeiAgWR
         v7a/aUZLy38RLmfqqin7i/yjCxElE2oIRkBY9tyEnTLEEkiQh6/nwIT0irO+LB3xN3pu
         2SwMop0wXkzWE7q/b6NchYdrhdC9Mxzu8j3Nj8glzTaOx/YozJDV5y6tZzG3oJg5nlnX
         jT+frUBlCFPuDPBCPvaK9x2SVvyDkesu0kSOFg+nRfl3tRwwplfJggO7VAxFzH7VyjIP
         YVuatvfRRgWJQRF7/t3V3t4WBSSXeLdJlpXsvCjXEEXjXA5ZBGybuq7YU+KKizUQ71hT
         mr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition:content-transfer-encoding
         :user-agent;
        bh=o2hliW0c5FepOfyHYediT+IQFKwo29FjvZfez1VJ0BU=;
        b=qM7mQdKsy7PHS+HFdhiud6qq3PIjnfj6dSB9d+jxT3VcBpC4UvpW3+9bSGdTQLuBzd
         klh7KiyIZKk870Juq7WE/AaAXS6dNjRDzdc9yUf5Qx/2y1EBo7uwMIM8XWlrUAAlsCmE
         qJ7vVWz132MiwoW/ZlSlqhMJvnZNheCpQUc5CrV50/DmRc75aKMToX21vOESr8R78exT
         GKgdASSZgbGOlnHWTAxvqrKJFqsjQEMj/DzrCUMcrfWm6kqtPRD6y2fM5G4vpUjPXXZA
         JGn5yIpYFNMyD+cucQrLPGfTIKHOsRx1YIJc/iKU8Bt22zzmfm8UlmQfXq3KogEAX24j
         bvsA==
X-Gm-Message-State: AA+aEWYIcUOPwwVAgZFaXwoUTpy2vqFtF3QUsdCJ9JKf1VR7LMZRy4K7
        eaVj8tn36FS7FNeO+wGhiA6zl+0gUrc=
X-Google-Smtp-Source: AFSGD/U6Pi1FrIo6giUFof8+pUT+pbR6ckkZf59lrmhB3appqU3M9QrSv0pPq3IFMlAD6vCa5DAkag==
X-Received: by 2002:a2e:8045:: with SMTP id p5-v6mr15379043ljg.87.1545322631926;
        Thu, 20 Dec 2018 08:17:11 -0800 (PST)
Received: from kynes (apn-31-2-85-140.dynamic.gprs.plus.pl. [31.2.85.140])
        by smtp.gmail.com with ESMTPSA id p21sm4447393lfj.10.2018.12.20.08.17.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 08:17:10 -0800 (PST)
From:   "=?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek" 
        <michal.lowas-rzechonek@silvair.com>
X-Google-Original-From: =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek <khorne@kynes>
Date:   Thu, 20 Dec 2018 17:17:07 +0100
To:     linux-bluetooth@vger.kernel.org
Subject: Advertising report address types in mesh-io-generic
Message-ID: <20181220161707.lxrzzvknqa64pmyc@kynes>
Mail-Followup-To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I've noticed that mesh-io-generic.c filters advertising report events by
address type:

static void event_adv_report(struct mesh_io *io, const void *buf, uint8_t size)
{
    ...

	if (evt->addr_type != BDADDR_LE_PUBLIC &&
			evt->addr_type != BDADDR_LE_RANDOM)
		return;

Does anyone know why (Brian?)?

Bluetooth Mesh spec doesn't mention address types at all, so I assumed
that this layer shouldn't really care about MAC addresses and their
types.

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND

Return-Path: <SRS0=Lvhs=W2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D326DC3A59B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Aug 2019 18:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DB820674
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Aug 2019 18:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="sj8/KPYO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfH3SnG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Aug 2019 14:43:06 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:39886 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbfH3SnG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Aug 2019 14:43:06 -0400
Received: by mail-lj1-f181.google.com with SMTP id j16so1200959ljg.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Aug 2019 11:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=4CRPb51TZ0bhqQt1DR9LUgNdBVn0pApY0oAweaOb324=;
        b=sj8/KPYOpbnWr6UCfSo3IlVzaLAMtIxG1h2/j6DSdgHjFhCDtH7hcyRbL9JpsDTcIt
         f3la19iEU4v1ooIyQLYGSGY1Vvyig3/+Ba7wceZGdXMQ05vrusbyVx7x7WtgLcAgXaS9
         hHsOdgOeS96gK6suK2e4LKA/iwSGqfY7VOsplZypizNcb0sNbigHFRFE66WrBJ163pX9
         6O9bJ3aQRq1dmgfTD7oYfpmCVpStNFOFPIjx58WJ4cs8Hb4X+L5M4KzRcLgtmelkm8Mr
         I+N05U1cDElJ6YOZBVoRKLWxMYdVsioNCaiL63EOQqEc1fPZO/ne8MtMidnt9Z2tBkUR
         VrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition:content-transfer-encoding
         :user-agent;
        bh=4CRPb51TZ0bhqQt1DR9LUgNdBVn0pApY0oAweaOb324=;
        b=BF7M7LnCfz8699DoZOFHJmWHAH8abJ8m7JdIKr4fIdtksgYx2+kiR2rWrKVvDXRJ8i
         FccOX21YUC9/zhRQmbQ+l3KmB7KBKdnT8biAR3sFiYSUuwpjoUM20ydrr2xCFtzIbScw
         LO7704b2P5s4+KMGqH5AR3r1tNHt0SCiH9VAiaHT0pIUSTLd6rUWrv0QGQRToypKePmw
         JSX+OVL1lkJyxxe9IcTYhxuHBo55ZAagjJDin9PWAWhJX1X526i3H94xWjYxcKRqY2sf
         fGmT5CP45+NILBRTRLAXut3KDZnKP2jmnjBwxkXelUvp4BdwezpEh/UC00ciG7hZ491m
         8mcA==
X-Gm-Message-State: APjAAAVrsdMpLnH62oL568u/5mVISVg7qIOS61pAn8In6FpUId0ifWW3
        B+KsnrhtXdfGoMzWnG3Q9w33tgVR/JY=
X-Google-Smtp-Source: APXvYqwTgz46zh1FwzDPMcSP/GChOQwOf+ZExMlXMkSFkS0mTKYZjtEePE4L4BbX1ggzv+y2Rk1GBg==
X-Received: by 2002:a2e:1518:: with SMTP id s24mr8698651ljd.205.1567190583821;
        Fri, 30 Aug 2019 11:43:03 -0700 (PDT)
Received: from kynes (apn-95-41-66-58.dynamic.gprs.plus.pl. [95.41.66.58])
        by smtp.gmail.com with ESMTPSA id 134sm1025445lfk.70.2019.08.30.11.43.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Aug 2019 11:43:03 -0700 (PDT)
From:   "=?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek" 
        <michal.lowas-rzechonek@silvair.com>
X-Google-Original-From: =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek <khorne@kynes>
Date:   Fri, 30 Aug 2019 20:43:01 +0200
To:     linux-bluetooth@vger.kernel.org
Subject: mesh: org.bluez.mesh.Element.MessageReceived method does not provide
 destination address
Message-ID: <20190830184301.zd3zaqrw7mv6r252@kynes>
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

When trying to use subscriptions in meshd, I've noticed that
MessageReceived API does not provide the application with destination
address of the deceived message - instead, it only sends a boolean flag
saying if the message was part of a model subscription, or not.

I think this is problematic. There are use cases where a model is
interested in the destination address of a group subscription. For
example:

Imagine a dot-matrix, where each pixel is a mesh node.

Each of these pixels implements two models:
    on element 0, a GenericOnOffServer controlling the light output
    on element 1, a Blinkenlights Server model

Blinkenlights Server extends GenericOnOff Server and GenericOnOff
Client, and on top of that contains a translation table mapping group
address to either 'ON' or 'OFF'.

Now, when Blinkenlights Server receives a GenericOnOff Set message, it
looks up the destination address at the translation table, and sends a
*different* GenericOnOff Set to *its own* element 0, with target value
determined by the translation entry.

This allows users to configure each node in such a way, that sending a
*single* message to a group address causes all pixels to switch to a
preconfigured pattern *at the same time*.

Moreover, at the moment the application can't receive the label of a
virtual address the message is targeted to.


I'd like to discuss the API change, from the current:

	void MessageReceived(uint16 source, uint16 key_index,
					boolean subscription, array{byte} data)

to something like:

	void MessageReceived(uint16 source, uint16 destination,
                    uint16 key_index, array{byte} data)

	void VirtMessageReceived(uint16 source, array{byte}[16] label,
                    uint16 key_index, array{byte} data)

thoughts?
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND

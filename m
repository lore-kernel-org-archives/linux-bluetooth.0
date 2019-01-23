Return-Path: <SRS0=X26K=P7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA65C282C0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jan 2019 10:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3474221019
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jan 2019 10:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="Y2YCA+Gv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfAWKY5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:24:57 -0500
Received: from mail-lj1-f176.google.com ([209.85.208.176]:42525 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfAWKY5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Jan 2019 05:24:57 -0500
Received: by mail-lj1-f176.google.com with SMTP id l15-v6so1417235lja.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jan 2019 02:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=/4Ud9/YP+KOpe1j7y/Sk8cRJA3Q7CtrIrzIOtHn/8rU=;
        b=Y2YCA+GvX0s/fjDJo/oqd50dY45OvnB11NuYBfNnqsYcO/vGvp/f/XWrk6kpzhGOyH
         4t6NIq0WzKrxYemGgz5pHrKGl5c7ILnS+pXc8thnOWxbea0XOlQTpQK/JhhylH0rgF7o
         3Dvy54t0fLb0noNfYJZb5WJWuXA5k3bn/Dk8qSHVz10myaRaLB3O995PnQYyUOY/4kFE
         L8CPGwIJkbXJsfNeUVqsfCJpeOVZMTa2jiFyDfkzkSmgArD3QqqFITOFvza1mQ43RGiJ
         GdBRa432bdDriyVwE3ZObTLm3qEMwZhIXyefiUEfLxRMwALjZSHNsMHjhVOn1VqUXw36
         u4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition:content-transfer-encoding
         :user-agent;
        bh=/4Ud9/YP+KOpe1j7y/Sk8cRJA3Q7CtrIrzIOtHn/8rU=;
        b=iSAKpQ2Br5B41PGn5arjqzDoQIMyLuvZNoAQs/eewK2q186alN6Z1rHEY9FZbLHuMM
         u2UuROSClbM9df8tnnDyety2xiYHL4mzZ2gTDsWevqvzQPvSeXekB4cuNdxpXGvWmODd
         MYsVVMFSysejEk3NT9s5gEMU6potD2aOEyGlCEF4eyCN4uU6Y4lUIg8rTBNoilVC3eyY
         G/0JxiijM4UFvD6NAoMg+maYJ/TgvNQ8HU1O7o/4RAsJJp2gyA9Yd7j7riJ0ZkGyYCB+
         Meqst7BOzH9aEFU6ArAZ9kHHmNqHdNF+yACaRl2Vh9XxlmOGabd4oCP4fiLyg/rRgQeW
         d21g==
X-Gm-Message-State: AJcUukcJzk/Jye9Gi/09CjDBePFPkM6nQH4/EIB17b+YWPAi65i5nyAh
        FHEbSpr9mL216ZhM+1qMdwyDDkXS4xQ=
X-Google-Smtp-Source: ALg8bN4sZcvcPk8Qpcj6Ij5g2BpSMkDFJRUeG3qL/hvMloGFcGBu6GUiK9sG+X09wYHq1qi5Ys8Hsw==
X-Received: by 2002:a2e:561d:: with SMTP id k29-v6mr1494396ljb.91.1548239095174;
        Wed, 23 Jan 2019 02:24:55 -0800 (PST)
Received: from scytale ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id z7-v6sm429737lji.42.2019.01.23.02.24.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 02:24:54 -0800 (PST)
From:   "=?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek" 
        <michal.lowas-rzechonek@silvair.com>
X-Google-Original-From: =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek <khorne@scytale>
Date:   Wed, 23 Jan 2019 11:24:52 +0100
To:     linux-bluetooth@vger.kernel.org
Subject: Format of HCI LE Advertising Report Event
Message-ID: <20190123102452.o5xvunjcsx57pdwl@scytale>
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

I've been reading Bluetooth Core spec v5.0, looking for a way to
optimize sending LE Advertising Report events through HCI.

It turns out that spec allows concatenating a few reports into a single
HCI frame: 7.7.65.2 says that "The Controller may queue these
advertising reports and send information from multiple devices in one LE
Advertising Report event. So far, so good.

The question I have is about the exact format of this event. Wording and
tables in the spec suggest that fields from concatenated reports should
be interleaved in the HCI frame, that is for num_reports = 2, fields
should be ordered as follows:

event_type[0]
event_type[1]
address_type[0]
address_type[1]
address[0]
address[1]
length[0]
length[1]
data[0]
data[1]
rssi[0]
rssi[1]

I don't this format is "natural", if I were to choose I would rather
simply concatenate a few reports. This is exactly what BlueZ (and other
projects too, like Zephyr) expects in tools/parser/hci.c:

static inline void evt_le_advertising_report_dump(int level, struct frame *frm)
{
	uint8_t num_reports = p_get_u8(frm);

	while (num_reports--) {
		le_advertising_info *info = frm->ptr;

        /* .... */

		frm->ptr += LE_ADVERTISING_INFO_SIZE + info->length;
		frm->len -= LE_ADVERTISING_INFO_SIZE + info->length;

		frm->ptr += RSSI_SIZE;
		frm->len -= RSSI_SIZE;
	}
}

Who is right? Seems like most of implementations deviate from the
spec, but OTOH I haven't seen any HCI controllers sending num_reports
greater than 1...

cheers
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND

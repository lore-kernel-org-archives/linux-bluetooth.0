Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A574C00523
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 09:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB0E20705
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 09:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="ph7q4sgK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgAHJxU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 04:53:20 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41192 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgAHJxT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 04:53:19 -0500
Received: by mail-lj1-f195.google.com with SMTP id h23so2631626ljc.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jan 2020 01:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zzbFEiJ9y/McpMzwIwIERcTp9NMkNWUdv9x47+Y/Joo=;
        b=ph7q4sgKkwVsMW6Y3+9F0cjG1opJBpLgAhjOOQPqhO5gaedzBP97So8JxkHxiw3jrG
         6UhxYyUo5nB/0A2AcQ6gTrYy3SeG1TBlnmKI6RFLa1bcItgKOVuDUp9gFv5UTQlbchCY
         +lCMS4VDdV3SuU8EzaWtML+0IDMF4K6o2w1TrVTfqQrUcbqR2FNsgNStrrOVZ+SzXgod
         GYMwuzq2PEV8yXAgiJFU3nBCRNo4PY14RLBBwPBW2JYuPQ1VBPErTX8QZLEaD5fNAi91
         T2K9Ttukg4Yzs/SLGeoqkwiNHDDV/MEzj6YDy2Gpan5P0eHHlUwSPR3kCSPYCeW83YuZ
         Q8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=zzbFEiJ9y/McpMzwIwIERcTp9NMkNWUdv9x47+Y/Joo=;
        b=cKY2HquDxT9IFwcM9GA0dM/i44MuL9ntG9gqj4zDRn/I3U2vPSKhpw+N2NE7EdGmKl
         25Obiv6oSApltoeZXKzH4wDat2S0saCJkg7OMQgUhBgRDjzD/L4vXcoygiBYOIhZqAjQ
         5lZ6MYMjFRG6BSXvj4o9xn3o/qPYMPL1Bzlg8H02fVPlEZj23rVEu9uJOTui/6Yv9+2Y
         pSHdeP9TFOBBKkMM3e46GXxN9RuldWYiAtiPOXPWSbSmEUvuoO8quor9WrkCVZhhmFxi
         IOlyj/zV06tk2guvjov/4bzm/AJdo7YBmwLycMK5RdsoLXZYUGhEmq3wqX5PE0aKRr/I
         PSpQ==
X-Gm-Message-State: APjAAAW3eUcEogDfVsF49WiUmJJaUspiZ7X8DJ0ITn5o2Wbw5d+FYjlT
        Cg9cOotOhUAB9Gb3gvzQ/dQ77Q==
X-Google-Smtp-Source: APXvYqzctbl2tpj/mj6MAxYtFYbgEglNAIq7k6Zj3CLgsq5Y/QUN9SnV9xrZLnBnqzsCL3WCGn73nQ==
X-Received: by 2002:a2e:8755:: with SMTP id q21mr2462447ljj.156.1578477196383;
        Wed, 08 Jan 2020 01:53:16 -0800 (PST)
Received: from ix.localnet ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id u24sm961456ljo.77.2020.01.08.01.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 01:53:15 -0800 (PST)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Szymon Czapracki <szymon.czapracki@codecoup.pl>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 2/8] monitor: Decode LE Periodic Advertising Sync Transfer Received Event
Date:   Wed, 08 Jan 2020 10:53:14 +0100
Message-ID: <1770049.2qRCXdMzth@ix>
Organization: CODECOUP
In-Reply-To: <CABBYNZLwzscUwUwFgpUu4TjbY7XVCVOCXXccvFFtZiU7yLEjcQ@mail.gmail.com>
References: <20200107091833.14921-1-szymon.czapracki@codecoup.pl> <20200107091833.14921-2-szymon.czapracki@codecoup.pl> <CABBYNZLwzscUwUwFgpUu4TjbY7XVCVOCXXccvFFtZiU7yLEjcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wednesday, 8 January 2020 00:43:44 CET Luiz Augusto von Dentz wrote:
> Hi Szymon,
> 
> On Tue, Jan 7, 2020 at 1:20 AM Szymon Czapracki
> 
> <szymon.czapracki@codecoup.pl> wrote:
> > Change-Id: I5a7c2d36ca5aee61441c2aab6adeb16058ab062f
> > ---
> > 
> >  monitor/bt.h     | 14 ++++++++++++++
> >  monitor/packet.c | 27 +++++++++++++++++++++++++++
> >  2 files changed, 41 insertions(+)
> > 
> > diff --git a/monitor/bt.h b/monitor/bt.h
> > index ecf3782c9..e14c1771f 100644
> > --- a/monitor/bt.h
> > +++ b/monitor/bt.h
> > @@ -3140,6 +3140,20 @@ struct bt_hci_evt_le_chan_select_alg {
> > 
> >         uint8_t  algorithm;
> >  
> >  } __attribute__ ((packed));
> > 
> > +#define BT_HCI_EVT_LE_PER_ADV_SYNC_TRANS_REC           0x18
> > +struct bt_hci_evt_le_per_adv_sync_trans_rec {
> > +       uint8_t  status;
> > +       uint16_t handle;
> > +       uint16_t service_data;
> > +       uint16_t sync_handle;
> > +       uint8_t  sid;
> > +       uint8_t  addr_type;
> > +       uint8_t  addr[6];
> > +       uint8_t  phy;
> > +       uint16_t interval;
> > +       uint8_t  clock_accuracy;
> > +} __attribute__ ((packed));
> > +
> > 
> >  #define BT_HCI_ERR_SUCCESS                     0x00
> >  #define BT_HCI_ERR_UNKNOWN_COMMAND             0x01
> >  #define BT_HCI_ERR_UNKNOWN_CONN_ID             0x02
> > 
> > diff --git a/monitor/packet.c b/monitor/packet.c
> > index 64f75cf8e..76bb9f239 100644
> > --- a/monitor/packet.c
> > +++ b/monitor/packet.c
> > @@ -600,6 +600,12 @@ static void print_addr_type(const char *label,
> > uint8_t addr_type)> 
> >         case 0x01:
> >                 str = "Random";
> >                 break;
> > 
> > +       case 0x02:
> > +               str = "Public Identity Address";
> > +               break;
> > +       case 0x03:
> > +               str = "Random Identity Address";
> > +               break;
> 
> Usually the term Address is already part of the label so we don't need
> to repeat here, Random Identity also doesn't sound right, it should
> probably be Static Random or perhaps have Resolved Public and Resolved
> Static Random to indicate they are actually resolved address from RPA.

Those names are from spec actually but I agree that those are somewhat odd.
How about just using print_peer_addr_type() to print this?
Then we have: public, random, resolved public and resolved Random. This is
short and also makes output consistent with other events.

> 
> >         default:
> >                 str = "Reserved";
> >                 break;
> > 
> > @@ -9788,6 +9794,24 @@ static void le_chan_select_alg_evt(const void
> > *data, uint8_t size)> 
> >         print_field("Algorithm: %s (0x%2.2x)", str, evt->algorithm);
> >  
> >  }
> > 
> > +static void le_per_adv_sync_trans_rec_evt(const void *data, uint8_t size)
> > +{
> > +       const struct bt_hci_evt_le_per_adv_sync_trans_rec *evt = data;
> > +
> > +       print_status(evt->status);
> > +       print_field("Handle: %d", evt->handle);
> > +       print_field("Connection handle: %d", evt->handle);
> > +       print_field("Service data: 0x%4.4x", evt->service_data);
> > +       print_field("Sync handle: %d", evt->sync_handle);
> > +       print_field("SID: 0x%2.2x", evt->sid);
> > +       print_addr_type("Address type:", evt->addr_type);
> > +       print_addr("Addres:", evt->addr, evt->addr_type);
> > +       print_le_phy("PHY:", evt->phy);
> > +       print_field("Periodic advertising Interval: %.3f",
> > +                                                       1.25 *
> > evt->interval); +       print_clock_accuracy(evt->clock_accuracy);
> > +}
> > +
> > 
> >  struct subevent_data {
> >  
> >         uint8_t subevent;
> >         const char *str;
> > 
> > @@ -9871,6 +9895,9 @@ static const struct subevent_data
> > le_meta_event_table[] = {> 
> >                                 le_scan_req_received_evt, 8, true},
> >         
> >         { 0x14, "LE Channel Selection Algorithm",
> >         
> >                                 le_chan_select_alg_evt, 3, true},
> > 
> > +       { 0x18, "LE Periodic Advertising Sync Transfer Received",
> > +                                       le_per_adv_sync_trans_rec_evt, 19,
> > +                                       true},
> > 
> >         { }
> >  
> >  };
> > 
> > --
> > 2.24.1


-- 
pozdrawiam
Szymon Janc



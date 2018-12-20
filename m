Return-Path: <SRS0=5zPD=O5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1952EC43387
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Dec 2018 18:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF6A217D9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Dec 2018 18:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="Hxhhywcq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbeLTSD0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:03:26 -0500
Received: from mail-lf1-f52.google.com ([209.85.167.52]:36100 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbeLTSD0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Dec 2018 13:03:26 -0500
Received: by mail-lf1-f52.google.com with SMTP id a16so2059483lfg.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Dec 2018 10:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=aWFwTPPFYHgbg/D10ttJrY71Pj4+yXCBHsKQq4gKRWA=;
        b=HxhhywcqUJ9XBDAZiHaiPQNJZ1ppja4DqAizk/GJ4TXFotbqJfpSYfuAIbIVCu2k5h
         B5LQnFVt6Xfe97tjGb0MsdpfrFokyDEzI1zCDxMbcmRusNOnUoIO+ZQRVKzDoxsgzyqq
         ZDQPfe9a1nLh7/XifmUUcmt24ERyrHo8w2nRWiAqHZsuI51mue8poAAGz1w3E/IN+TpF
         2hNK2zv2RZt51fSD313I9399im6ht5JZ41c2A6+1+wdB01rElpw8Pwuclj9TfqmQUM6f
         y9i+AevMJbiaozV2Vb2wgx1HIpt5LnM2iyIrgxkiPrCooWmhjjzjju9LMNWiLz8Q0Y7y
         V0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=aWFwTPPFYHgbg/D10ttJrY71Pj4+yXCBHsKQq4gKRWA=;
        b=NUwlecYmJJIxdUn44TNvRiNiZksCF/QJnCaIPbxqc3BWq/E8VvEcbOIS2HJZiGXals
         BjMxut8cHc6CnLdnf3biGuJ5/Kw+PEym5h3iGYmAazE8tunsRN61EvooLldwHHsM0sg7
         MUB7i1g+qslk/8aGHNc3oqY7l1DMUgAd2suhx8sBO908u1FeQwm3sLFCZHj4TyIjH1Cv
         yLAWurXfJ0+ivKAMQNkLFtctPPmYciF9NWhNMviAEsy7dWJeNvQlDHIPiq9QokrloMpn
         s4koszDXYTmWSgmPTcYWGi/i0Pjo7shB08IByp6B27TojGOKDi2wzZHxsoNU0yDPg4Cz
         GPbA==
X-Gm-Message-State: AA+aEWZM7wt19hOpzVPJozlRRoJ16pUCihNfEPT0bUG8UbzeeXjzCtEX
        0OOxl+IrcJ1dET13vcDkMoF9W4Lo4+A=
X-Google-Smtp-Source: AFSGD/UUZM0+P94cjZTQRCGl8YBUo4CHe/SpkRkJNrJCJZUBNVZ7ckJMBoh4UT/lMtSdvNUK/vvSWw==
X-Received: by 2002:a19:c396:: with SMTP id t144mr15383662lff.110.1545329003323;
        Thu, 20 Dec 2018 10:03:23 -0800 (PST)
Received: from kynes (apn-31-2-85-140.dynamic.gprs.plus.pl. [31.2.85.140])
        by smtp.gmail.com with ESMTPSA id b21sm4494202lfi.7.2018.12.20.10.03.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 10:03:21 -0800 (PST)
Date:   Thu, 20 Dec 2018 19:03:18 +0100
From:   Michal Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Advertising report address types in mesh-io-generic
Message-ID: <20181220180318.gwsj6aflihlppbgu@kynes>
Mail-Followup-To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20181220161707.lxrzzvknqa64pmyc@kynes>
 <DEBB0CAA2616974FAE35E4B560B9A4375D8E337C@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DEBB0CAA2616974FAE35E4B560B9A4375D8E337C@ORSMSX101.amr.corp.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Brian,

Thanks for taking time to look into this.

On 12/20, Gix, Brian wrote:
> > 	if (evt->addr_type != BDADDR_LE_PUBLIC &&
> > 			evt->addr_type != BDADDR_LE_RANDOM)
> > 		return;
> 
> Address types can be BR/EDR (0x00), LE Public (0x01), and LE Random (0x02).
> 
> This filters out BR/EDR advertisements, which are not supported in Mesh. (should be LE Only).
Hmm. Correct me if I'm wrong, but the Bluetooth Core 5.0 spec,
Volume 2, part E, chapter 7.7.65.2 "LE Advertising Report Event", which
I believe we're dealing with, because of:

static bool dev_init(uint16_t index, struct mesh_io *io)
{
    ...
	bt_hci_register(tmp->hci, BT_HCI_EVT_LE_META_EVENT,
						event_callback, io, NULL);

and

static void event_callback(const void *buf, uint8_t size, void *user_data)
{
    ...
	switch (event) {
	case BT_HCI_EVT_LE_ADV_REPORT:
		event_adv_report(io, buf + 1, size - 1);
		break;

says that "address type" in that event is one of:

0x00 Public Device Address
0x01 Random Device Address
0x02 Public Identity Address (Corresponds to Resolved Private Address)
0x03 Random (static) Identity Address (Corresponds to Resolved Private
     Address)

and nowhere does it mention BR/EDR.

I don't think we're supposed to even receive BR/EDR addresses via HCI LE
Meta Event.

cheers
--
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND

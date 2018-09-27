Return-Path: <SRS0=a08L=MJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A5AC43382
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Sep 2018 20:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D949216E3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Sep 2018 20:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com.br header.i=@yahoo.com.br header.b="e23GMW01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D949216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=yahoo.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeI1Cd1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:33:27 -0400
Received: from sonic302-22.consmr.mail.gq1.yahoo.com ([98.137.68.148]:38245
        "EHLO sonic302-22.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727295AbeI1Cd1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Sep 2018 22:33:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com.br; s=s2048; t=1538079207; bh=0IA22sytR9BgZP9P5aTau9WymlBT/WsNeAZI3KVn/cQ=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=e23GMW01DpyNuCNVbnEDYQ+IS+5tK6ghuiFQIHCi81eBBGTOT3InZH1l20SEUGDzOoLuxnLvIx/W2OZAhlKkZ0MkLlkCRAO9PvNygHHl14xQNdT2DEaMDBcgPICxQLSRA3HBwJR3XuRttfoADdCwPsdxQJVnAXq2AOn0q4yEfXU3Grk6gy0OJXNwhu18+SP3iScv5ZkbZNrFyNg0Vp5inaovhcC7Z53i34BUnbPupA6SubgPxORqHchfTrEaul+EFFEa5pLHl5DPOcFnkeQKjRHGCMuCzucXPrJykj7eNZosZ2K+1AvTgynC2sHW7LcBVL/hiUsTv/PirUAG2Fo18g==
X-YMail-OSG: 9klGuS8VM1mMfSPLjvwyDdAi5PRWgk9mJSLrKt5bUMtluIc.jOcQDQyk9pY56Zj
 M2gTxsSU2UaQdvvGuM8PWzXUmOJn7J5yjubT3xlUkvzJ6F1y2TY236C1YdLnMRESF5rtAghtjlKi
 tKoE5HFqg3b1sjFK83pKa3xq_zwLhdfKpaftqQeTGROn3E0llgJpZiV38QIzQKJpbCfm3qPR.mV3
 5jKH6RMuynvSGQ4zdq5S5xWN4urGO91RUC97KcTaF86vPzkRfQnd6PsZL8QRqVgyTRpnjZ5UxxjH
 uM3snUBE_HWbol38HVcbCJGjJeRJWJ.R1DrTwLmClAWjWY_0ono1_6M_hn4VdwQpKzPq8xHnh6ze
 sd8FOo0vuRQg8CIYWHx21Tio4fkghaVuHqYT4ywNfkg4mWBrBw9vO3cPX_DuYbWJM9w4ErNeoEUi
 1D_7UxXsK5tVz7yud8.eqdNz35oX4zHMdIYjbaYSjnMdS_UBjYLqnmSijI3HwjKWsI57C8AvWcv_
 AQFEge.s_o155iU8svnXVMEbN6Zkz7H_g2kZyZ.fAUxxAPpvS4GVuSqSHONKHWBqBh2f29EHCP.D
 nxkbKaZDubJoG7JWMVJGvUaixCkOTjtUd4czyZ1dnihs_SXGES3G3xb8w4o09X4OIf_uPqnPsZ6Y
 _k0VsHkfFPO4khOYdEiueW0PMz6xEHxBzNURecTy7QTCXx9p_El8OE47XCLhM5AZifHHLJl1ARCf
 IWc4je85GJZM0ruCmuCWJLkZl9jTaUvZc9tm3sG.tAm_6YjWpm2UJRpTBIXc9tmYK92OiVLK_4O8
 RuWO_xId7w.15urYtuqvUIU4kRShEfMEuUbyO_.Drnt9UjBD8VzsAyPi_yp9YN4m6mlkc1CCNpq4
 K3HLmAd2aLnw0_NWCuoCsdE1_Yxt_46GoAA29o3cVG.GV80_fUU81zGRUB1NopBkaAyDaBMfrhBg
 ub8GMw296AT8VctUpfHIEx_e1Xj27fquQO1yCnPl0WAZ7mcT_4p2OrBN4AIFFEOMLTRd_
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Thu, 27 Sep 2018 20:13:27 +0000
Received: from 177.81.17.223 (EHLO giustizia.org) ([177.81.17.223])
          by smtp401.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID a0b42890f20093135d91920e28fb057f;
          Thu, 27 Sep 2018 20:13:23 +0000 (UTC)
Date:   Thu, 27 Sep 2018 17:13:50 -0300
From:   Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] ath3k: add more information to error message
Message-ID: <20180927201350.GA19318@giustizia.org>
References: <20180907233603.GF3379@giustizia.org>
 <5CF8F067-C9A1-4028-847A-0B25DB00F61A@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5CF8F067-C9A1-4028-847A-0B25DB00F61A@holtmann.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi, Marcel,


On Thu, Sep 27, 2018 at 12:47:11PM +0200, Marcel Holtmann wrote:
> Hi Luiz,
> 
> > When there is an error in either ath3k_load_firmware() or
> > ath3k_load_fwfile(), the inlined function ath3k_log_failed_loading() is
> > called receiving the error returned and both the block size requested to
> > load and the size actually loaded. These values are printed in an error
> > message using the macro BT_ERR.
> > 
> > This patch creates a new function which does the same but also receives
> > the "count" variable, in order to show more information when a failing
> > firmware loading happens. The calls to the older function were changed
> > to the new one.
> > 
> > This event is being monitored in a laptop with an adapter which
> > identifies itself as 0cf3:0036, where sometimes there are errors in the
> > firmware loading process.
> > 
> > Signed-off-by: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
> > ---
> > drivers/bluetooth/ath3k.c | 12 ++++++++++--
> > 1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
> > index 3a8c47efea55..ebc312cb4412 100644
> > --- a/drivers/bluetooth/ath3k.c
> > +++ b/drivers/bluetooth/ath3k.c
> > @@ -209,6 +209,14 @@ static inline void ath3k_log_failed_loading(int err, int len, int size)
> > 			err, len, size);
> > }
> > 
> > +static inline void ath3k_log_failed_loading_2(int err, int len, int size,
> > +						int count)
> > +{
> > +	BT_ERR("%s err = %d, len = %d, size = %d, count = %d",
> > +			"Error in firmware loading",
> > +			err, len, size, count);
> > +}
> > +
> 
> just change the the original ath3k_log_failed_loading to include the count parameter.
> 

Ok, fine. I'll send it in a next message.

Many thanks,

Luiz

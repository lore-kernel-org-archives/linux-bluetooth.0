Return-Path: <SRS0=a08L=MJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC06C43382
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Sep 2018 16:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD12216FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Sep 2018 16:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com.br header.i=@yahoo.com.br header.b="ddaTAFY+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD12216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=yahoo.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeI0Wdr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:33:47 -0400
Received: from sonic303-21.consmr.mail.ne1.yahoo.com ([66.163.188.147]:40902
        "EHLO sonic303-21.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727262AbeI0Wdr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Sep 2018 18:33:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com.br; s=s2048; t=1538064886; bh=8iWjVyH2MtBf6YVadhIOJQHCBO1NmbWDyU5stUIAwu4=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=ddaTAFY+2XqDxxy0s2vF8NjDqNb60Iiqdt+H1UcriXB2VsbJzr+0aq5KYP5w3FUN5c2U9LjFiChesxvUjJwzcRNyd4cp7VWMIB0fdQ6bZsJ4z9tfDNw3umN82t9a3coAF2QBty2gw2Itv/dEoUMg0WYDMXSAIuKitSpvatcVK/cMikNG8bmT+pXuz80xJU7QdYR0y1kFsjkGEPJMUmPjkqOumu0AUqIO2BOSuSFLh03thBHbI+CfpN/RB97L3B+ZuQz7LfW6kV0fSUtW8RDEDVCX7qErk4hvpAnfNz+ZNjhUgDRyqExj9D0v+TTvAb9E5btPiNLBHR47MG3glj7A3g==
X-YMail-OSG: iOx2YGEVM1n83DuvaGLStv63lJva50OUuj3v7NSBb5FGbCoZoGOFr0npdocqFol
 uBnNXiq1WHRdqKjiWmvi4_DnLLQYkB0FPQqtpxM0W4FMviquvUFjLeruNTaulHj3HwcFccSborat
 2EvAe8OwYudLqaYOdhpDlXRBBjQRa9p.BfX.d3yIs1OhutM2ocK5dVpQvn6shUows5GaVgAbbtSg
 dFQIkLx0prKiFQo.v5xsikd677X1v8RvvwT6mtjIRZwNey8OmKO6NmoA4E3I2sLXKcudUrpmeSOw
 281jC1vHwhoi6BgmuShL9v1wuCS5NJy.qlcauvTdZHmLWCxb6fHzg_V1HWBDM1kk0COXZYrvEV.h
 rFnijMTwWpXUrUlsaWTpAf6CyaW_MRJeMeD57b63MqUSi3xp9i4Va4E29oqoTwh.GVBpFnfwciDI
 NMmrdw3RNNFND62BkAoqDrtgbjOSoy5h0FUG9VLzESMXIHkeCvogHY12Bsc65HnndBwIVNSQ0mWQ
 clZ7Cm6w4TJEEhr.JNOQtyf5v0ukwyoJs8oXU2SxDaILk7Ep4g9f68uNDQZSiL39tNhjbh.._3zm
 LnHS6b4OMl9tvRc_RYKlNRAOP7ImtH.FtpigJBTzbP_Fr7.nQRNWTfrwOWbPSRNBAa0yPV_5IsIC
 H9O_IkeAB6i2rfb6QVg0qrF3gPmKmjZPL.ZNOq79NyuD9qM_esXqac3MGrgWwuh9ZtyF1JJRsGyq
 b0Y3JxLCH2bHnjcQRYs3An7682Rymcz6K6P1j5nz0LH0tL2rQj.GemYkIGKoz3HZzSZAlJRGQxyZ
 8zRYojVdZY.pDY9kv00yvsdl2q1hHt0FwYwdCNA395onOjKPkptxKN1pAaEtCWatdtl6NSOjYV46
 oHq6e3qCNt7MIxPXAMWACdwiDM70Mby6yRZAVgzO6XoFPLUEdSOQQN077wg6zIN1.Z7YCXrdk088
 MrF7FufbcuY.BTCIKPaQm97OqnBxuayfFB451Pkr3rW_oClPrVjkybaF2rli2J4sGFPQ-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Thu, 27 Sep 2018 16:14:46 +0000
Received: from 177.81.17.223 (EHLO giustizia.org) ([177.81.17.223])
          by smtp415.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0fcb3ef72484f4fbc915e1a8a79552a3;
          Thu, 27 Sep 2018 16:14:43 +0000 (UTC)
Date:   Thu, 27 Sep 2018 13:15:13 -0300
From:   Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] ath3k: add warning when switch pid is not working
Message-ID: <20180927161513.GD23822@giustizia.org>
References: <20180907233549.GE3379@giustizia.org>
 <BE213F03-E020-4046-BF60-8723902BCD71@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BE213F03-E020-4046-BF60-8723902BCD71@holtmann.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi, Marcel,

On Thu, Sep 27, 2018 at 12:48:17PM +0200, Marcel Holtmann wrote:
> Hi Luiz,
> 
> > This patch adds a warning message in the ath3k driver when
> > ath3k_switch_pid() returns error.
> > 
> > This event happens in a specific laptop, with an adapter which
> > identifies itself as 0cf3:0036. Surprisingly, the adapter works even
> > after this event - hence a warning is chosen instead of an error.
> > 
> > The current version of ath3k doesn't check the return value of
> > ath3k_switch_pid() and so this event may remain undetected in the
> > original version.
> 
> if works anyway, why bother with a warning? I have no idea what benefit this has.
> 

I analyze this issue as having three possible cases:

(1) the function works, and so, no problems, no warnings;

(2) (my case) the function fails but the system works as it should do;
in this case I would agree with you, but

(3) the function fails and this affects the whole system (let's say, the
VID:PID doesn't change as intended); in this case there's a problem and
the admin should be in a better position if one can be watched by this
warning.

Based on the code, there's no way to diferentiate (2) and (3), so IMHO a
warning would be justified.


Best regards,

Luiz

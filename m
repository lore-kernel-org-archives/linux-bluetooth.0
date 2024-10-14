Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0CA7404E
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 05:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728883884; cv=none; b=Bb/w7X+rj3fdUuzpAY1EfhosNQacJMnzXPj60nhUgXRe5X5MV7PmX+JB3vJGmyh8klT99gxEJphCj6nbWUgLK/TfnJVcxJ95hOLUaPBHxSUNpt8f1RXeXO2BA7G53MeDC0i+KxxXO5qjNxdcZ7eWP8BvY4flmZ1c+PsYMZMoTBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728883884; c=relaxed/simple;
	bh=u4RzUYHbnGJ5N06wBhupCMKC4HVkniq2CS2z/X4y1pA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqoV5CKdWZP4U0oULwTUs7mJr+NnufeSP5mQrzBf39ZkrM2lSKgprVFdgXlunhbQjJ7m3a0C/LSAITz1VKoIOmUYIxHKPy9Sn4ksNxZ7TJbPGuTuJ++qJi32AXnOW6qtdyZq1LjhQMakCHS7o8qDYyDNGp7L3sVjhjjdPeGy9JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPP6c/jv; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPP6c/jv"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e5a62031aso685866b3a.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Oct 2024 22:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728883882; x=1729488682; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mJZibUAEIpgxeL3lvO439ieXkiS2fNrp6QPpuQT5LcE=;
        b=GPP6c/jvhSUbG13A35NVzxRl9zvCCRw3lbHe3ASaL4VP+pYqnOdK4imlnzqu1avxnQ
         ZnlvuqB2IGZrqTQjcH0U+IFdcya2epQKh9Is1uDbv1u2mr/WW+HF0x4tdIMWf1Jd8DCV
         rnKAUu8y5BhzlK87oMCnl4zuCgkIJVxvaGtS7F/iOyfqpdtg9fZU3J4hsHbPLkmVmlpH
         O2lavK9YgYoPg9jhnTaA6gWCRyhJ/hctrNMJU+zH6KLERhf7SAFpeGUERigu3AED6r1L
         66Zy+hyEggSy3fIwqO5T6HeHSFe+CcIgmO/jnRJd1cyPvlXTod90XZ+WMa4D/3H/kzXC
         IndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728883882; x=1729488682;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mJZibUAEIpgxeL3lvO439ieXkiS2fNrp6QPpuQT5LcE=;
        b=knC1DyaSyCCXrRgWp0f3CskSMaeEVIO6tq7Ic634ErB5k2Irw6ipfMpggXgH5FEunB
         XZyKH6DVlYG/pn6GBoK0kKvHb6atc1BjG7Yby/8S0VVfexq1+3vyVK1kUgOV56EUheNo
         I+HWVmHNvUWPQENqMdkSetl+1hEFELAQqpcZGpIeHE07eGyS643d9tnjwFp+WYxoZb8g
         LrrBQ6zHdgw/RSd1qAuxIyjjtnERQ1O8zKtLCbpo0sTxcnpseAbh4yeAl59+dJVEB4/M
         Q5519+6yAxLmaOaCOLUY9OO3+0SxD5/cF5iFt7/6ve4o2c9P+W/29KAzsr9Qe4KtyY75
         2u3g==
X-Gm-Message-State: AOJu0Yxy8KhQ3CuPCDAsf+g/QHXYeFUQbx8TPLu4GyAtPQwVYB+0xI2R
	Smc4VpqL8K5k9DbfN2Cnqi1veb79m+IS8SNjzD2xQq/5s+LYvu+VUKfMRQ==
X-Google-Smtp-Source: AGHT+IEWWqAE1BMsumqtQhsv2O9zI5vN80WVyGpq4DY15MTXVSEiPmhRvySWWeK39xW7cV95bxjzCg==
X-Received: by 2002:a05:6a00:10c5:b0:71d:f15e:d023 with SMTP id d2e1a72fcca58-71e4c152644mr11677513b3a.11.1728883881962;
        Sun, 13 Oct 2024 22:31:21 -0700 (PDT)
Received: from JUNHO-NEOSTACK. ([221.154.134.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e5aec67a8sm2305311b3a.194.2024.10.13.22.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 22:31:21 -0700 (PDT)
Message-ID: <670caca9.620a0220.33cf6c.4855@mx.google.com>
X-Google-Original-Message-ID: <ZwysppfWDq9CZphy@JUNHO-NEOSTACK.>
Date: Mon, 14 Oct 2024 14:31:18 +0900
From: Junho Lee <tot0roprog@gmail.com>
To: Brian Gix <bggixx@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/4] mesh: Implement lower transport layer for
 segmentation and reassembly
References: <66ff99e5.630a0220.2b5d14.8e61@mx.google.com>
 <b34b48bb-bf86-4a50-90fb-b0ff147c1be8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b34b48bb-bf86-4a50-90fb-b0ff147c1be8@gmail.com>

Hi Brian,

On Sun, Oct 13, 2024 at 12:27:18PM -0700, Brian Gix wrote:
> Hi Junho,
> 
> There are some check-patch failures on your patchset.
> 
> Can you fix these (and any others you find with check-patch) and resubmit?
> The ones below are only from patch 1 of 4...  patch 3 applied cleanly, but 2
> and 4 also could not be applied until patch 1 is fixed.
> 
> Thanks,
> Brian
> 

Sure. I had already fixed that part, but I didn't resubmit it because I
was writing in some unit tests as Luiz advised.

I resubmitted it a while ago, so please check it. If I run into any patch
issues again, I'll fix it and resubmit.

> On 10/4/24 12:31 AM, Junho Lee wrote:
> > -			send_net_ack(net, sar_in, expected);
> > +		if (sar->flags == expected) {
> > +			/*
> > +			 * According to MshPRTv1.1: 3.5.3.4, if the destination
> > +			 * is a unicast address and a segment is received for a
> > +			 * completed message, it sends one acknowledgment within
> > +			 * a period of:
> > +			 *	[acknowledgment delay increment * segment reception interval]
> WARNING:LONG_LINE_COMMENT: line over 80 characters
> #774: FILE: mesh/net.c:2207:
> +             *    [acknowledgment delay increment * segment reception
> interval]
> 
> 
> >   	/* Msg length only definitive on last segment */
> >   	if (segO == segN)
> > -		sar_in->len = segN * MAX_SEG_LEN + size;
> > +		sar->len = segN * MAX_SEG_LEN + size;
> > +
> > +	/* Send ACK only if DST is unicast address. */
> > +	if(IS_UNICAST(dst)) {
> ERROR:SPACING: space required before the open parenthesis '('
> #875: FILE: mesh/net.c:2283:
> +    if(IS_UNICAST(dst)) {
> 
> > +	 * segmented. Flush if it is not segmented or if the transmission
> > +	 * failed.
> > +	 */
> > +	if (result && segmented) {
> > +		struct mesh_sar_tx *sar_tx = mesh_sar_tx_new();
> > +		bool is_unicast = IS_UNICAST(dst);
> > +		sar_tx->ack_received = false;
> WARNING:LINE_SPACING: Missing a blank line after declarations
> #1010: FILE: mesh/net.c:3565:
> +        bool is_unicast = IS_UNICAST(dst);
> +        sar_tx->ack_received = false;
> 
> 

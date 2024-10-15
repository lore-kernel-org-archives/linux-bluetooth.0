Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B2A1C9B68
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 09:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728985722; cv=none; b=c9jaZQnx47cYPOW9GBG/iv/TkyXxDWqbfSJ7zmQVjUiiFoncFW7dMSM2lNzOf8JBVwyqFMo3jhx69M11QPnKrYaFGU2NlqssBFs/2PoCsDWtFP8PyLoJTng20tB7hOPyXUELKt48k+cAUwSvQHrBWpr043j3BcCwbX0h/SoHdJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728985722; c=relaxed/simple;
	bh=yYb9sb5AxiXLVlD3bVkK64FKKxtA8VrXUNvbw1gtuts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jarius+8/B5YIrXR9nahzWEcQUBvk6mjvh9zBum2DjycSq+XT5nc9rMGh8fbjjPjcyE4FYB2iSCz0l4xp8bbw4v5tt9lxskgd/UVDCx+9i3Gv+ODZRdkOrwj07vvZDXNFdUUcNiY3osuuU08MgraWWEi8Agh0EdJO4UAs+u4Cjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iwDMg2Qt; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iwDMg2Qt"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a994ecf79e7so788310466b.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 02:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728985718; x=1729590518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1teDS0JJcna/90ckTpcvCS/IaGCA4XWx1Jz7qyJi5jg=;
        b=iwDMg2QteR0yvQQM8Nr9teOoWqzj45RezjE8fzK0xcJK1mpdZzVBOXiw5YrjND2Gn2
         Mqo4KoPBtdmjzEThnKdagd4ypoBC1COy25D+624kMRHZ1ld7KlairyjXLUxkrFDxUPtS
         vruKcjH7YHyLWQxFtKOHarjn1uv6vBJw8+vdesNq4GN6ZPXgB79JKynZt3eVoYBO8PhR
         09kKyjNo2F9CjbYkdI7+/hYOWMLeZ0Trn1zpeYwX31stqr7HpVxhHMnw1nmRAsDhkXzn
         By/WZbBBG8VJglj34kTh+hry6tBMoV00Lz4x0fwIiqPvW8kgqApwOMdzap/i6WjR2+Gf
         hytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728985718; x=1729590518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1teDS0JJcna/90ckTpcvCS/IaGCA4XWx1Jz7qyJi5jg=;
        b=JUsiz/1Eah4ei8fTi+xggs/5iK8tL+Bpbn64vm8xXVCRkt1ZUdQfUirCR4k+cV0SY0
         ppZbonHKX2DL73XXv58BFY3IGIKQTVU7sKgyPfdAD+YIJxMzEeJ13iKBBbvSD0EcmKGI
         sSx4oTuAghMEXBwlYtN6srGa9snMC1MDD6jo5LnD+yE+2tvZiu5Wn7mMQldSlSHLzGtC
         9Xlwcbr9nQ3g0gLW5BWso/YcTx4w4tOw9H1G/o/XwA4y66DK9tjFMbzNblLON/lS4dvu
         J9rwBIBiH4MnU2abVRjU8TW28kmiTS1FgDnRcpS0oi9ke3rC0YUvwoIy/ej56IZM5MAK
         gvdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk636a/73BmoncZaQ0OBfUADnuwuS4aQCaABtZrnKqF5n7N+s19GwfJ9qPq6m3aUmyUVZgisfRww0JklRfdcw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa0kGJrAIgl47xKn84CrOpybBQy1OANG0a62iUDcAt4NjPbvrq
	WlHIVsNUPiTUBnUAbtmVcfXASGGfb2qlld4I4R1awm52SvRXmtqUNOA/1SAiObZoXjoVt1rn/8N
	G
X-Google-Smtp-Source: AGHT+IHVV5gB4sO2s8rG8UOt0XzDKS6ScXRIKX4PKjbNf6jNN37IksWraaka1Knc+QX36AetoAcjJg==
X-Received: by 2002:a17:907:869f:b0:a99:fc3d:7c76 with SMTP id a640c23a62f3a-a99fc3d7e78mr723129666b.37.1728985718522;
        Tue, 15 Oct 2024 02:48:38 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29850a36sm49903666b.181.2024.10.15.02.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 02:48:38 -0700 (PDT)
Date: Tue, 15 Oct 2024 12:48:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Everest K.C." <everestkc@everestkc.com.np>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, skhan@linuxfoundation.org,
	kernel-janitors@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2][next] Bluetooth: btintel_pcie: Remove structually
 deadcode
Message-ID: <8a4a8915-d59a-407d-9f93-f047370cca62@stanley.mountain>
References: <20241015045843.20134-1-everestkc@everestkc.com.np>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015045843.20134-1-everestkc@everestkc.com.np>

The subject has a typo.  s/structually/structurally/

> The intel bluetooth module was successfully built after the change
> without any errors.
> 

Delete this sentence.  It should just be assumed that changes don't break the
build.  You can put that code isn't tested under the --- cut off line, if you
want to put a warning message.  But we don't need this in the permanent git log.


> This issue was reported by Coverity Scan.
> https://scan7.scan.coverity.com/#/project-view/51525/11354?selectedIssue=1600709
> 
> Fixes: 5ea625845b0f ("Bluetooth: btintel_pcie: Add handshake between driver and firmware")
> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> ---
  ^^^
Cut off line.

regards,
dan carpenter


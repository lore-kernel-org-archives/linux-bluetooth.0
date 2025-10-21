Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72B9283FF1
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Oct 2025 21:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761082204; cv=none; b=aqJi6ji8wdbUZsdV2cUjCIqDIBqj1f+4tHBuVK8sYhR3ood/PwphfE66EkL/CdXwQw6l1yi/t/pPh0rUK5NMJwq641UpQvEZpVlnFd1OpIKTYheJVj2x6S2vvH3czfjm/WhRvKzXFO3HZepQZORVzuWEVD+zaWiNX1WdXJ/W6U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761082204; c=relaxed/simple;
	bh=dwqMl/vbpfqiF6alkHk5Yx63NAGPmT9VgqTEeDD6a4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upmePwN0/fiNT+PQA58nSy+7dJJ+eaRVwXaZhJca8ExhuGzZdu745uTaDcB/Xmrr6fiAIR63APId0Ov2dFYe6dY4551hy/fsg1wX2sGuVqPI57z6oSm/GFbB7K1SqkmO3EpEWb3GsuozmJWrs05YKhjAOifK28U7YEBn/pEHr3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=T5pb4ClE; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="T5pb4ClE"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b6a0a7f3a47so5647017a12.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Oct 2025 14:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1761082202; x=1761687002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EpZNM3XgwJ16I+fZmWCMaO7DLj0Pq/ew1phxLV7Le84=;
        b=T5pb4ClEb04hNTu5kowJOKmmnkqS42iBHe9aJGyrRtUI4gFgVq9LUOAC6sT6sUMPUI
         UMGfPJ6fL4Uhu1Vm1e1QlvbB8O3G4xAJchX0U9rGOiJRSirn72OOgAcAtpmH+IUk156E
         GlRzyOtpHJgUoChL7ldReZORVpjHRJdl03Sg6ajh/DEk9ochw9YpncIInAlfUrCnE8YG
         Z+k9BSCnHKZO1dKWNHaXCY8bSxq3ceiDGz2gCYRKDL3HStK6r69mN6MVR0nC91ne3Qo4
         UUmz9IAQHGR7Gz/REAjmz2bBBrwhvU7Rez/qOX/EhQ4v68tH69u3sf4neUJQNmppgwRc
         juUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761082202; x=1761687002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpZNM3XgwJ16I+fZmWCMaO7DLj0Pq/ew1phxLV7Le84=;
        b=hrrLobmPyS1BOQ+vImh/NU1UkH9isN8Kfcjw2AhZtNFPCt8TSaUILBoe/OBUI19Xoo
         1xKOHB92sYMoVdmDz5RQaQv11yzMoykLsRRo2iyP381WeaZBS67HYD5Uc4VC2INEttcX
         hFRvj1usuj+FbBW8jTQwaTEyAW6aFx9vKe5Jk9F+sfu7hhssGyO+D+7Sgtf8DZIgeelt
         nOlf8BtDXKSNXv7yzrLg8x/cKTjzAEiLRNNLvjW9/RcGRF6YblzByak8EmOFoWXXUAqo
         GrVgtbxTjJS+M7pO9emHhk95vke4WnLinBtqqY56pxE7UtaWfaW05LpPViRIADqEBsmq
         yMwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOCB/5f3aJc64sc0MQWwCmVUYAn76MSNyJUr3YNFqnWB1LhZwka2y/rRDCAOCoVNI4Ql70wlSn93YmLD9Wauc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu7/3+wthbUCjClJKVdNm1ldX9kjE/7VYuBI2tPv1TYHGfgyUm
	b3Ep1JMzGybh7P/GXc/0pVGIVrgJN3NAHdV0R/8Eb9E3KxG5OczpuSPo8yktIIYGWKNvOoHYhYJ
	Ovsdh
X-Gm-Gg: ASbGnctBCbHue2t6zGBysQjPOMTQHg3vt0TAQ/TLQcySc9YejJ01FFdIX42r7skGDlE
	IDMSXvTn/IwGGZWjMKfsJ6sSKoANGslcLHzVtIjA4BOAYsOvsNS8vZ5lU+VYT+BRzp+6hKcugeO
	IH9RSik49II2GxfgKtJTyOhyB08NZDZCMEnPxSXdfKKpCnVbxAHIzCl5GWM4V3Bn6bxKWXmenra
	UIvqpkAqhPFsiLLPBUiGcEQx+AkaMPMTBiHsoz965iO0mYAlrhB8emt+0gb4WPVMm7OQQtFS4vy
	vDDDCf8WXBFMmMDuakSxfvnv1fC0JwjOUtx7uT5pAR/mN8cdR0ShsisDJ2UBeqcAKn66Sb17IcU
	QZnuFQUO9NM42uv09vBPmBmHhYz23scxZA1DPHeAHjNkrBqGT1DgRIavUyKfbcsXA4omwkHe0+9
	rBpFJSxM+7P+hR
X-Google-Smtp-Source: AGHT+IFQPQVLF62iSQjgKED/7MJICfhrVLj1XS5eTii3vZpdYHBP+K2MnZ4pOMVYwQSUDUzd3dAjAg==
X-Received: by 2002:a17:903:3bc4:b0:26d:353c:75d4 with SMTP id d9443c01a7336-290c99a9669mr215805815ad.0.1761082202003;
        Tue, 21 Oct 2025 14:30:02 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5850sm118793665ad.66.2025.10.21.14.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 14:30:01 -0700 (PDT)
Date: Tue, 21 Oct 2025 14:29:59 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Francesco Valla <francesco@valla.it>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Erratic behavior in btnxpuart on v6.18-rc2 - and a
 possible solution
Message-ID: <aPf7Vz5K6P7frdlf@mozart.vkv.me>
References: <6837167.ZASKD2KPVS@fedora.fritz.box>
 <aPf5DZVYrc2YAXXT@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aPf5DZVYrc2YAXXT@mozart.vkv.me>

On Tuesday 10/21 at 14:20 -0700, Calvin Owens wrote:
> On Tuesday 10/21 at 22:53 +0200, Francesco Valla wrote:
> > Hello,
> > 
> > while testing Bluetooth on my NXP i.MX93 FRDM, which is equipped with an IW612
> > Bluetooth chipset from NXP, I encountered an erratic bug during initialization.
> > 
> > While the firmware download always completed without errors, subsequent HCI
> > communication would fail most of the time with:
> > 
> >     Frame reassembly failed (-84)
> > 
> > After some debug, I found the culprit to be this patch that was integrated as
> > part of the current (v6.18) cycle:
> > 
> >     93f06f8f0daf Bluetooth: remove duplicate h4_recv_buf() in header [1]
> > 
> > The reason is simple: the h4_recv_buf() function from hci_h4.c, which is now
> > used instead the "duplicated" one in the (now removed) h4_recv_buf.h, assumes
> > that the private drvdata for the input struct hci_dev is a pointer to a
> > struct hci_uart, but that's not the case for the btnxpuart driver. In this
> > case, the information about padding and alignment are pretty random and
> > depend on the content of the data that was incorrectly casted as a
> > struct hci_uart.
> > 
> > The bug should impact also the other platforms that were touched by the
> > same patch. 
> 
> Hi Francesco,
> 
> Thanks for investigating, this makes sense to me.
> 
> Funny enough, I specifically tested this on btnxpuart and saw no
> problems. I suppose some kconfig difference or some other innocuous
> patch moved structure fields around such that it triggered for you?
> Not that it really matters...
> 
> > For the time being, I'd then propose to revert the commit.
> 
> Adding back all the duplicate code is not the right way forward, IMHO.
> There must be some way to "mask" the problematic behavior for the
> drivers which stash the different structure in drvdata, right?

Actually, the right approach is probably to tweak these drivers to do
what the Intel driver does:

https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/bluetooth/hci_intel.c#n869

    static int intel_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
    {
            struct hci_uart *hu = hci_get_drvdata(hdev);
            struct intel_data *intel = hu->priv;

I'll spin that up unless I hear better from anyone else :)

> Any thoughts from anybody else? I should have time to spin something up
> tomorrow, if nobody beats me to it.
> 
> Thanks,
> Calvin
> 
> > Thank you
> > 
> > Regards,
> > Francesco Valla
> > 
> > [1] https://lore.kernel.org/linux-bluetooth/be8edf7f8ba8dea6c61272b02fb20a4ac7e1c5a5.1756179634.git.calvin@wbinvd.org/
> > 
> > 
> > 
> >  
> > 
> > 
> > 

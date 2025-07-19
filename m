Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC442882C6
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Jul 2025 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752941064; cv=none; b=i6zjQ5k3ZrFC47HWm/Oae5LuZHJDtXPO0nb/+c9FmdIskdo3yfwZNJM9ZqT/F6t1+wOaL1bwDvBxIHO1ak4EksBWspY8tiVGpeDN030jCoJBF0SNhmaj/ZL5GBn4xXo0nuJs5rKKZ2nav5Q9gLp081U3zp0baCMY2SBCLEtd5Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752941064; c=relaxed/simple;
	bh=dtOI65LhgHFtv82udLEOmmxkyTgXRIG9O2WAf0dESLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOXOOYMvSR01JqAISOIZ1lpkpcPBtJF5vmsLJ3Yn5InpD2BNR2KQfwonTdndQ/byqtUHbF3eY2sK0fwBhRXIyPPKfdfkmf4FjnrieBo2ijJlDxNl4HIln7cRV/HIeTgcMOVOHNpHjyXugQ0GJWco+03P2iZaNOlvzT9kwLN2GEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=YDeobr0h; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="YDeobr0h"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-748e63d4b05so1903262b3a.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Jul 2025 09:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1752941062; x=1753545862; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5d/ib6Wai1Z2ZOHQMq63LhaGxiIClkPv7o7Qpq/YpQ=;
        b=YDeobr0hsKAWnrAZUsAGGZ5ELNVVvihSQZnubYFhEE1oYAZ7U5E3EANRvqlHz9U4Xr
         gmNCjfQRVtL5QcjXEQHr3jBxmPhm5KQJ3V7xiAec/1JfbBdvzONISkC/lCO/plK53c5c
         VsDcEhDmfHODJVsCs0qnnSOK17h73CxR5kVl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752941062; x=1753545862;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5d/ib6Wai1Z2ZOHQMq63LhaGxiIClkPv7o7Qpq/YpQ=;
        b=dVFRUcCuPk0OphZXK1dmrLlX+9XA5yRQXaXu4btcH6YIJfQzztgRQwXF/xvLUuVs93
         qLOfqNK1k0GyPawttik1FL0AcFKmLztoWGyAKcpyUHdYTex8EML510nzU/D3xGn2+Dcc
         /DY422AWrHfoanaby4DQVMnfxOwbnPJWWy7pbqZTfeAFIloPhp3qkLvZe8zj/mgn9gZI
         e+MCZ4xzWXxF/uG2ZbXS2l5Nu7w/f4lSg7PcRVKF8l9dsaLIN3uoWdv5Ck02W+R32hba
         mySjpeEZgVcezwClYq08ymAitnx0J0F5jhJVRbHEOgrP8V/sMFrVIR9H33MFIKKNNR7x
         EdvA==
X-Gm-Message-State: AOJu0YyO2s7LSPx6sqUBpKKPfk+0OS0jNZajbbD6seHNrAKKLG1cPgkl
	ifsOcwIVxokN4CBemfWUQwd2A8bivUpfw2N0d7E3Xh25mjWQLobbfya2fhBu/NXI7qM=
X-Gm-Gg: ASbGnct0yxvMYNwkGWshOvpC59qnqVJ+ef1li3Uq/EQE/OrUo3qUgRkNIxA4rOB9PwA
	+jt0YuYHJPVSC0QzAJ3FK2YR/aZ58oCzFn0HojaIfclOyc8rBI4hT/PwwKwAFUc3s3sur1LfaXZ
	cirUzwQiFSn6PXL3Z4Ayfmf49d2lPWInPVMGhN7GW/jnRhaSLy6Yepil5fIkIe9D21BdlbjBcZK
	6Wox08ZPO0ZyDapc0/eJQRKi+iNIhJmYtOIePeeI2oJfcEBi2aWBdiZ/MqydogYgQY7bzgu8eeX
	kOTBi6GbdAsnavhaW81AIyrk5lzpZgkZYivE1xzptqmHxGVg/PcZSsnLcrMVXaXHvU2begmax8Y
	XcyiY3Tf5FVDUOtVVk+Th
X-Google-Smtp-Source: AGHT+IH83v5eeEPPaT8st6SyrtwMkBgJMeKccmYxqQZlY0VGJM8lFIkCGR8IEOwRJZLtQja0yF7isA==
X-Received: by 2002:a05:6a00:2d08:b0:74c:efae:ffae with SMTP id d2e1a72fcca58-75722376ce1mr16590166b3a.5.1752941062361;
        Sat, 19 Jul 2025 09:04:22 -0700 (PDT)
Received: from localhost ([101.127.220.50])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-759cb157629sm3063739b3a.87.2025.07.19.09.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 09:04:21 -0700 (PDT)
Date: Sun, 20 Jul 2025 00:04:19 +0800
From: Chris Down <chris@chrisdown.name>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@fb.com, Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_event: Mask data status from LE ext adv
 reports
Message-ID: <aHvCA4YFoQPbFChv@chrisdown.name>
References: <aHfd_H6c9MheDoQP@chrisdown.name>
 <CABBYNZJo48983SWhxcB7UzWXPeUofRCMhQ8mJjih-rJoTET3_Q@mail.gmail.com>
 <aHoCQ_RfBl5Zm4oQ@chrisdown.name>
 <CABBYNZJ60JUyz30u8QXvv6OO5dAu1A5-JDB_jJ=H_yR6+WYfng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CABBYNZJ60JUyz30u8QXvv6OO5dAu1A5-JDB_jJ=H_yR6+WYfng@mail.gmail.com>
User-Agent: Mutt/2.2.14 (516568dc) (2025-02-20)

Hi Luiz,

>Try to capture one of them using btmon and then add to the patch description.

Thanks, I have one now and will add for v2.

>> >> -       if (evt_type == LE_EXT_ADV_NON_CONN_IND ||
>> >> -           evt_type & LE_EXT_ADV_DIRECT_IND)
>> >> +       if (pdu_type == LE_EXT_ADV_NON_CONN_IND ||
>> >
>> >I'm not sure I would keep checking for  LE_EXT_ADV_NON_CONN_IND, maybe
>> >just return LE_ADV_NONCONN_IND, LE_EXT_ADV_NON_CONN_IND is not
>> >actually a bit it is the absence of any bits being set, so I guess the
>> >only invalid adv are the ones for legacy which seem to require a bit
>> >to be set.
>>
>> So are you thinking of doing this?
>>
>>    if (!(pdu_type & ~(LE_EXT_ADV_DIRECT_IND)))
>>            return LE_ADV_NONCONN_IND;
>
>We can probably return early on if (!evt_type) return
>LE_ADV_NONCONN_IND since there is no point in evaluating it if it is
>zero.

I guess you meant `if (!pdu_type)`? That correctly handles the 0x40 case (where 
pdu_type becomes 0), but it would miss non-connectable directed advertisements 
(PDU type 0x04), right? Or maybe you meant something else?

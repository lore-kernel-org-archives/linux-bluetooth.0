Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141751DFDB1
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 20:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730148691; cv=none; b=apGfaGnrIFE5rpyOvWwhfaIXlw22J/gZ+m18exHPZABqvb+T9qvfehaByxwdH9Eq87IUG+y1ODG5WXkDv+cBuhuQA3y5/xtvgUSpZrg7bFI2J6/bchpBThp5fMo5ZoX4JCC8j4JwRrcgU7mK0JQEXk0b+sVYiLvd7G9+z/XBLdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730148691; c=relaxed/simple;
	bh=ARzfwaP5/S/8O6r4MRu/7ERevkqY2uTZC+pi5zW+/Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPtC5JdlzYoiwooy8vVqqInBkPuKnm1gcimFSHBpXhyvxxMWx/bw9OpDYGFGkuaH8I7g4HSAOSCryYzsddB7r/tiXVYYZxhsq/AVKs43Q1JvyUXxrOvMRxjQvmnuTQ90QZ3K0TcztBdPIyDI1eJDPIqRCaAQtmNsytcF4TrYjTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igorinstitute.com; spf=none smtp.mailfrom=igorinstitute.com; dkim=pass (2048-bit key) header.d=igorinstitute-com.20230601.gappssmtp.com header.i=@igorinstitute-com.20230601.gappssmtp.com header.b=I8YedQ5R; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igorinstitute.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=igorinstitute.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igorinstitute-com.20230601.gappssmtp.com header.i=@igorinstitute-com.20230601.gappssmtp.com header.b="I8YedQ5R"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c9978a221so50574365ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 13:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igorinstitute-com.20230601.gappssmtp.com; s=20230601; t=1730148689; x=1730753489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hfmZt0R7/zET+vxilvTiOuZs1nD7DgUBbF7JxQILOPA=;
        b=I8YedQ5RZL4m+vsGl/JO85m0tm+shIHa5dVgSFrVDRX1Zlaj07k4FhNYQo+8lJzXUo
         w+PvZwloMEdp7uFoo782GQHhCSFzvSPA70QsDIjNJ/RAtvWVFAz6VSMVhu9lZtjLuk7H
         CnFSmW9wokGGA7IWsuoYtdGvRF+wRdCZRSWgCc4BZtiSWZcFMwiB5COsvIJY4j2Vr3/O
         hOYJrFFFhWgQc+rrKS3efN/AYQ1ecEbuJzvLbzLSrFY0N2YPA24CtioDSX16By5NNqd5
         e0fZCgd6d9GGPa1+M78vQ7fEp5ml9KX8T71Z2pROippqupM3UkMuGAdBPaOV5iOCeSEM
         mr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730148689; x=1730753489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfmZt0R7/zET+vxilvTiOuZs1nD7DgUBbF7JxQILOPA=;
        b=GyTJr9pm3SMcGP36MCCZh8BXyVuREoOAqAfunpyE+akX6alkvRT40wtCJXgo7TFZFt
         YZmi5xTf57zCjD4ATXKVMElmHkG/l4UIAQ0Zn2ppGSe+VglA+KXqAXKve+jDblw6pCML
         KQGeSn+E1hv2Aq3/ESIhZf6Lda7rIHfiMBZurTI8BW5cISR7T4v6lxkJRc2zRrCDW3Fa
         tEb+7Z2FFghlMOIEotpPAihNjcadHAcMoPT+02EDmzXxGDKU99aZvIvJOeKIqSeXxcb3
         3Bi9wGETzd+Pc+7K05ukWv38cFNePFyEbc7nHC18Eg75XJhUoQLpP4kM0JVk0eZQXBdN
         7FSw==
X-Gm-Message-State: AOJu0YwoNUfJ7B0Rr9SNSaHs/ur0hkSrJ+KAt1tSDmhy0iZoXQ4LULsU
	vE5iDxm2ul2TUaIzVP4brqKeq1yz6NMDz+Rz49a1eMSRACBmDG8PCRTYp8wOESE=
X-Google-Smtp-Source: AGHT+IE/9A9WmS650q0HHDlxqih4CBA14hjYWhLqeTAv/wddFbUO1Txr5PaS3r4yxhLYt9lqECvGDA==
X-Received: by 2002:a17:903:183:b0:20c:fa0b:5297 with SMTP id d9443c01a7336-210c6b011b2mr103208165ad.26.1730148689212;
        Mon, 28 Oct 2024 13:51:29 -0700 (PDT)
Received: from localhost (118-92-78-251.dsl.dyn.ihug.co.nz. [118.92.78.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc08883esm55377505ad.301.2024.10.28.13.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 13:51:28 -0700 (PDT)
Date: Tue, 29 Oct 2024 09:51:23 +1300
From: Daniel Beer <daniel.beer@igorinstitute.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 2/2] source: clean up outstanding AVDTP requests if
 the stream goes away.
Message-ID: <Zx/5S32GbBsV+any@fermat.nev>
References: <20241025202141.158946-1-daniel.beer@igorinstitute.com>
 <20241025202141.158946-2-daniel.beer@igorinstitute.com>
 <CABBYNZLjNgTe6E0f6oKuap+VLttiaGse3_vP3ZYFxiO7mmNfog@mail.gmail.com>
 <Zx/Ft7upRYfGVD4f@fermat.nev>
 <CABBYNZ+=chpkTNhB=P2RM2c2V7Vxe9wUDdrWi-KkqOmc2wmV5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABBYNZ+=chpkTNhB=P2RM2c2V7Vxe9wUDdrWi-KkqOmc2wmV5Q@mail.gmail.com>

On Mon, Oct 28, 2024 at 01:37:30PM -0400, Luiz Augusto von Dentz wrote:
> Ok, then perhaps it is a good idea to have these applied, that said it
> would have been great to have this type of test automation upstream in
> the future so we can catch regressions if we ever change this logic
> for some reason.

Hi Luiz,

I would like to be able to share the test setup, but unfortunately it's
a difficult-to-replicate hardware setup plus some proprietary control
pieces.

I see that the patches failed a lint check due to the trailing period in
the commit message. Would you like me to resubmit, or are you happy to
edit those?

Cheers,
Daniel

-- 
Daniel Beer
Director of Firmware Engineering at Igor Institute
daniel.beer@igorinstitute.com or +64-27-420-8101
Offices in Seattle, San Francisco, and Vancouver BC or (206) 494-3312

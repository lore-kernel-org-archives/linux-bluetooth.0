Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43D933CE88
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 17:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781803915; cv=pass; b=PuqZJ32P+uBHvzSU83YA1H+KqaJWCMlFlRiNXlsEmydTJxmft0qRZM618hYsR961/UL+hDouHImVGtq9iHAwNzSL+ts36ekSijs0zQtmbHW7jOFyaEbEM5WHJGwdu2bRw33SnEcjXt8Lx7n30sQosTFZwhu1b+Er2oqTk7vJyYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781803915; c=relaxed/simple;
	bh=w2igSNafB8rRkz34PL3aXd5X8rRZ53Z+j8a0yv+A11I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s6J3RpEaIOzfnQZKH4XB1T94av7xPNz6KtdNMZUpcMq9ERW0LiwVZ6Y4GehrHB9oiabXFw1zzpjR8fhAB729nbgd47RiRl2R7a2PlSG9hJuhz3VoC/tlJ+aFCsrCpIVmrQ0JZsDmk4rfakwVVzQ2SEs64iFPqo8wnrs6RaCKZyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrAW6rgV; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrAW6rgV"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7ff05e5d009so15205987b3.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 10:31:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781803914; cv=none;
        d=google.com; s=arc-20240605;
        b=g4O3dOz8rVaWoSUgmCy/juO5RzXbdr4vrEZ+nLHjEtfx3Qkr4ip6w4/S4FMu4efQGm
         mUtLAevkeGggH0taFZa8Dg72/jqFy1FI93Va+5dglyM1kngQVeNKQy5F3g/C0X1aL39b
         7WyHuu7ngG2UImIxFsqAy9mF+yQ5Rv7XiGauTUsCOt6e8d+oJZy5Y36OWIpsm/LXxX60
         bOziVay1CCp9rypcq2u6kvnYead7fUNoSaAPi77lq4hXFC/4G2k1FU5QsvmLOB5MPo06
         qAokjwkAfgEVti9S0oFE/NsSDppnQRkRa0pjjCr7fy70FihU2rS+lYTJv9wLdok6sZf/
         8JWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=w2igSNafB8rRkz34PL3aXd5X8rRZ53Z+j8a0yv+A11I=;
        fh=76VB9tIYpD6k8zJrPN2DRmDOMO+UakxnpzRbiBVXLXw=;
        b=X5gNsbJu5rXyPsJh78s/jX35KsOkgHmpJp4y8jOPaX0Lu1ZiSqIIyUDP7O1pUkC9Vp
         Qsz/ecCaonZYuMA8r9z327GJgWBRrpKn1/8U0MGGL/QOohLo6v3eoZqoPLSb0shTMEY0
         vcU4W6gxIrlVM0RN1gjeS9G/cEe4Tl4z+Z4mc5il0U7HmDraPLPH0jeCWKBjTkmDW8kQ
         zVii2UaUK2KmRDTodCWYMM0xuno63IQ/HWBBuSMCqbxBY/yauGC25O2ir5dr+Qk1myCP
         F7wRVSpm3jRqySTo9IE2rzQc4rnKNckp00k77B2HCPHOFtTU/gA6FJAaXnUKldGEA+L3
         MDzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781803914; x=1782408714; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w2igSNafB8rRkz34PL3aXd5X8rRZ53Z+j8a0yv+A11I=;
        b=nrAW6rgVNtntFl4SXqMEBhiulzflAmw6Puoy0j89X7Fhm90WfUYbKqJzO7XPn1V8Y9
         MNam1VmZSP5uZisZnFzGAzAINNK5Syg43xzzob7Q6gwgt+UAMoMSXndpyva6/SXgWFyp
         XVpVW3XC2JWG9J2Et5NITDLb/zfRtOTjjXAxSDLbhYbvg5Us5xocniRUQOOrVzmPoxMT
         UP+sKDM2Tu2Hl3htqnE7HDfxDxw0aD2U4Mi5zhQsOwe4uUU5Kt73EBrcsmNQRoNeCwdo
         OXZPAb6wSWb15cx0HJ3kc5v3eHOuGjSLBt7ljR4TvqLtVKYNX1YtiLWTcT/EeW+GXXxI
         M0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781803914; x=1782408714;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2igSNafB8rRkz34PL3aXd5X8rRZ53Z+j8a0yv+A11I=;
        b=dmidIfJ/Dtu4GTCsMy6Vb71jBcnoQxsXdOZbIdpzDXqM9QSuumVw5VqFFYWUjIrdbl
         9RAjBFzEyOLSRVqTj4NE9QtWZ6wX+n2/+afeSTtmpeUFZRtzWzQhFu2EkflbxBkXCZp9
         MtBjeHIa2ezXyQH0zi3bK1I6PMrW92Cly3nxeR5f60jeNumof7nU6webioDM7NeY4FJ1
         4x8PXUOcJ4LuYkUqzB3/+AdxhN/O5R4wwSPdKGA2o64sRxry7UUoDB+R99xMUGY0NZ8N
         MYDTTUGJpaewZbaYxq6zKZMRHCmiFmnnVhegaFH7YsMR3JxzAbzzN3UkIXbs5Q/D9wuR
         MHtg==
X-Forwarded-Encrypted: i=1; AFNElJ+WeaFzftKZGY8dgtShKfLnOE97++buQ6ktq7ejjXCxYzUT/5lAxsGjTHP8aIBKlXxofFEQhew6FzYzb5gSJZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoQ5S3j6jeCZLATiTR2Zvz/e6psKC2ItNOivTpV89kai5FuHFB
	5q/IpeaFsib3B7Lwrfw1MBbi7QPgp0EGkvi22PWe1jEglERmsJPFGa7AWrrrBgj4NZsWzYXfJBI
	c21fJEVhcRtpTyAMVhtW/yJp+GYRp9kg=
X-Gm-Gg: AfdE7cnsARnJ/qI/MKEu3VlkBFYCEXQF9VW0DAJh6RAWQnn/t6ESZUVI1OD8efByvDq
	51EfsKaM8q/Om1NQ/rrHBQtwSlTc50mJiXMvucHauirMwmRmzn6TUfwlmw9Wpz/vpPsrnHg8NT/
	kFQDGfYpN+RGe+d3Pp7mKgA/DrlBnID9HTelSVuUZnbvPMglQg2inZzA3e3+VixHT8UB0rEJ+AY
	1HsuxG+E+z4P0/r9brCwADnXd9K3tKRbsjWQ3MBMo9QCOCea0OIM3/HFgHdLs9HbnA+h9xvXD8=
X-Received: by 2002:a05:690c:7205:b0:7fd:69b1:72ab with SMTP id
 00721157ae682-7fe5b8d9c5fmr99629067b3.7.1781803913696; Thu, 18 Jun 2026
 10:31:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618102134.3339999-1-zzzccc427@gmail.com> <CABBYNZJVx7NphF8FmTGYLwCGVnrhyq=4sdHtwvAvPoktidGh2g@mail.gmail.com>
In-Reply-To: <CABBYNZJVx7NphF8FmTGYLwCGVnrhyq=4sdHtwvAvPoktidGh2g@mail.gmail.com>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Fri, 19 Jun 2026 01:31:41 +0800
X-Gm-Features: AVVi8CcZsxnlGtFMtroTIYNVX9zIGE3QrTSP_gCOgyYcZ3tgxhMUe0MtOh1X_yo
Message-ID: <CAFRLqsVao1JxtkEwnPgHFder+7A9V27-8_5hczaqBw3-6MYxdw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: mgmt: copy pending command data under the list lock
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Luiz,

> Or we could just add a kref to mgmt_pending_cmd so mgmt_pending_find
> can return a reference which is then unref'd when finished accessing
> it.

Thanks for the review and suggestion.

I looked into the kref approach. It does look cleaner, but it changes the
lifetime contract of mgmt_pending_find() and requires auditing all callers
and the removal/completion paths. I am not fully confident I can make that
broader mgmt_pending_cmd lifetime change correctly for this.

If you would prefer to make the kref-based change, I would really
appreciate it and would be happy to keep testing it with my reproducer.
If you would prefer me to respin it instead, I may need more specific
guidance.


Best regards,
Cen Zhang

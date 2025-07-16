Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA6C2641F9;
	Wed, 16 Jul 2025 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678850; cv=none; b=hYpJtRhoc+ueey7LL8PUE9hmN3K2A5sZTKgyrplNvs6YWE0zhute7w3C0kzqw7JElm5v66nhEqRCFxVxhUx0BZD15eSx63tybvutp/n/paIz+pEXFsg7il35zIZ3S56z4Nqt6PnlRIGE+82bXfUmlaoIZiVobWS6ZcXcZbGTp/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678850; c=relaxed/simple;
	bh=Flsd7kS22FIpdj4IHrumyJz1cX39T+xmLof5cwJKtFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YMkIIFtlyl9QJgQAEkmHZ+vpzW0RBJsattZl448tocBPOTX4734h+XI1A1K7GOQW2ZP6a5u8qoFEKZng0EJ/eE9gG/n+X49v73v5g2CcKSDFdsdmKVXRoL95ZZk7kaasNCuMDkqPmusR66dw596kLHLB0TGsy3UTCOQjheCIeIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qq/ziE8r; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qq/ziE8r"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32f144d0db8so172521fa.0;
        Wed, 16 Jul 2025 08:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752678847; x=1753283647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Flsd7kS22FIpdj4IHrumyJz1cX39T+xmLof5cwJKtFU=;
        b=Qq/ziE8rbzwyAfZC86ouRIlgyY9yJp6I1jUWv+pUexrgBsKkhQEEfs4A1AwS5rvJ/o
         MGS5SF1Iq6l3i0pEhc7hBiEAmK9yc49lnhCNqHRJx2y6Tb+kpQfVYXUPY/Z7vJfDrxSA
         0YqZDqiRNw+N2+IJvJSkd+bh8gBTrQsN+ZzWWe31f7HXIAZRUCyJ8hCe1iYQnh0BK1bV
         9rctIsq1VnNGcZuU5dhR8a5yQeSyg0fQ+fIPES8o7nHEfbp3kPZhZ/NYveWHwy7i/u6P
         ZTT7JZHkgarkZV4TFlRHzisvJXFP71cDetyi0QTFTG9Zu4eS0Z2WgKrOXepQ1J+qz1JK
         2qUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752678847; x=1753283647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Flsd7kS22FIpdj4IHrumyJz1cX39T+xmLof5cwJKtFU=;
        b=mOWUsX7AYdrdugluAsMC1JSDNFCZYKSMSqWfhPe9WFWwuPTlG73z0b7WdM0C3YOkdt
         5QIP16/SdAA9rWomz8b77YeNo1RGcpzWrS5swbQwzTBvdOk2l6vP3mL/Aw0jqzGgjLAu
         c+S/oCZ727C1qD+mJ4j8RvAAB+an/BAg8WrVMDhIN/irKi4REeXpKnXTBxxPaTAtGkcx
         AnsgSlsfTUaLdynj4RkDOLLZjILwL2BycC2ah6+GHNQ2LxGxRae4qW/F+wYue99lcJZ/
         ShydaFM10IXV5oJovRWdsFdIHWL7e0XfK8brINvSOwoM4VJKjWbYRmoe7SqO6jIbXjIU
         n2/w==
X-Forwarded-Encrypted: i=1; AJvYcCUbc1gCtBVxKk+t8M2X9Eo5rLaQ80dHa4z6PL//3dXhFUhdX0cOWsT12Ng+J7kIMn0FDOYcccAF6SEnmivK@vger.kernel.org, AJvYcCWSbir8p8vRcC4RoOBokDa8zCDghzHgsSx1UnWeltspctFDWcduOGLn5WbS05sZzNTsIRQyuiNBkMHGeM3LRh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKcfPeyAySWvy6soBt1E2wptrXh5UjjUvrSql+V78lTKHnv0ex
	MDu474KuxAjfbYjR3uUh64JhQG4MEvytT+tLc4Tn7iUxzMygdiEOyB+M/70JSUFzXMKwRKAjf8u
	PBtNVUg5Gd0sBUer5F6ZTOW9YTVGaxkwtdA==
X-Gm-Gg: ASbGnctYv41l0dB6UNKdeNEr1/Tc4SN1UFclhgn+pp6XA6Of1ak9/OX8vyp8uANSLof
	QkVadszPXWuGW/M3n3+0n9XlcI7Gh4zC186iCW0jftsfjhKHHW/awy2db1MuE/ryj9j4Cz+mAGu
	RfrBPGXnJZShYRKvmjhLBBlEcm0+SiwCvX2uqzYnmGxaXoqrO0+qhIG+EZjylSjKeU66kKofiRO
	FcvSQ==
X-Google-Smtp-Source: AGHT+IH7KVt8Q4jwGwL7RJPZHFMoXnqqp9Nchj7M3SnUU5u0V9MoRzKGEtGta870O9aM1bF8qvqlbCo5iNHdx/PdJn4=
X-Received: by 2002:a05:651c:4103:b0:32a:e7b9:1dc9 with SMTP id
 38308e7fff4ca-33081111813mr17377171fa.3.1752678846264; Wed, 16 Jul 2025
 08:14:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <257a13b8-6d60-21b3-c714-c6cb74b7b091@salutedevices.com>
 <a408927c-3743-71de-b806-87fd404bb9a2@salutedevices.com> <943f7a75-d1e8-2833-1ae4-f6979008868e@salutedevices.com>
In-Reply-To: <943f7a75-d1e8-2833-1ae4-f6979008868e@salutedevices.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 16 Jul 2025 11:13:53 -0400
X-Gm-Features: Ac12FXz8v_Uaon-w__2rBCPz8XijJTdtFUJUpRx4dpPUH5_Do4epzTESXv9BjLA
Message-ID: <CABBYNZKDJ+qmzcVtzDpuMd5McUWKFZWmp7Uv7NcoaQ9MLS=WuA@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: hci_sync: fix double free in 'hci_discovery_filter_clear()'
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, oxffffaa@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@salutedevices.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arseniy,

On Wed, Jul 16, 2025 at 11:04=E2=80=AFAM Arseniy Krasnov
<avkrasnov@salutedevices.com> wrote:
>
> Hi, sorry, 2 weeks, pls ping

Just resend.

> Thanks
>
> On 30.06.2025 14:08, Arseniy Krasnov wrote:
> > Hi, sorry, 2 weeks, pls ping
> >
> > Thanks



--=20
Luiz Augusto von Dentz

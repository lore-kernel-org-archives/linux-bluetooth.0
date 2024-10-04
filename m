Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E2D1D9A7A
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Oct 2024 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728054994; cv=none; b=VwLaipZ6lU0YEf0apNZpAQb0/kbBH8tLX3ghaxcTKS15BKQTILW/rcORuWNtlLdSAyCUgW1CzXyu8phmISZ897jFP/ZVJnjo9BLdwsO6qpChIfjsRwLkFi8CPbXIUZo5bDMJ6THuDKohaPYBSDgqBDPwDsuIHMUOBfBi8TwqUXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728054994; c=relaxed/simple;
	bh=89sb01V9pRdMe9qcCICLZa+NNGWwf3PuQsjDlpPqHXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J3p1gfoXOFZws2Hf4ghbYnSKCv1N4L/Xf431/KekdaFmIgbAUqSlDaelrTyjlwSUPNq2vkU8W3wB8DpF3ekzk5hkF+koihgzZJ6EyzS09+STEme7pia4DH10hzpgm78oph+GMgeh5Teh/qeM8K/6dhrTECcr7y1vDI1XsY7o3y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwFXsORz; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwFXsORz"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2faccada15bso23506311fa.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Oct 2024 08:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728054989; x=1728659789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cIsiWLQHN7LIPdob4g+cQxUEW1ARuqgWQoSvrIzjXU=;
        b=iwFXsORzo26qV4iuL1O0SGw8tKrS14niQC1v2j1BDrfNmccQ/QY8Ci1vziPL7SyIs5
         OzK6fG5C3jO+qEN/RjajpYagNlIriuRC6wnetpu5Ot/koRMsgB78AyH6XtDxy/eUP10p
         bWONzZApzfMKtyRFkFu+3X84PPXgpxeBr5t+X/r6P3rqsOrjg8oQ65C6TBh1bDBYblSQ
         zO1zDrITvAEFuIH3TvhGa9vN459s87BtOyfy+rky0KKrOBKGg74op4NqZH2Fu5qKMDuF
         eKDelOd36kzEm1tt1JHqkLCCyUrQJanU+kA+pMUiBxk6/cejr4XVdLH8B3csc5z+vV64
         jXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728054989; x=1728659789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8cIsiWLQHN7LIPdob4g+cQxUEW1ARuqgWQoSvrIzjXU=;
        b=Xq+tGffRF9kWCZFFfIemSSKTpj1HQ7e+BDXUK3GuV+pmqpBuq9puA0OeustPbWo2Gq
         c4F+xadDCpFIgjMRyCR6NV3jZm2jsuqOctvCLo7h6UtUNfZegJmW0gib198XzooPUARL
         eGaiOoXqZl8QApped17K69ESo8qHUinNMVyiR3+xRM87d4DMVS7zRy+KrUOYycsJNAIL
         pMrOuK7ez3CNrK/Re9llm/sUMlu1/04P1uUuvbATOSu8Mvtr/RJuh5wD0rcOlZRDj9V/
         PZDRd/6xmxwUN4bGtvVCPQvKvnG2diZ37AaH+FEQrcnrP+G6/tWrZoSRcNxXj6rmO2eJ
         1prA==
X-Gm-Message-State: AOJu0YzhNOKeU/Kgri6WHXgtN2mY9mBnkUeP5YclkxGWK7QTrQYAMZSN
	pDzHzsOPhIfoSOC1iIHVTezYxEH8a1jYMXVvm5uQW/Y1T9KxEl5sT5BaBRaf1L/Ok7w/okyNDyZ
	bnsfRQYmAN0YVSMfqFQ6lPCD82y6Eyg==
X-Google-Smtp-Source: AGHT+IEv6tmrmH6S7ICu83DLYTKzlq6q8eUZQbj9WDOWkYQzJDfHrTBLZmBA7NeRSJAnk9OD7rdCYo2IfR96Ac7fDVU=
X-Received: by 2002:a05:651c:1055:b0:2fa:d84a:bd83 with SMTP id
 38308e7fff4ca-2faf3c52d5emr11752051fa.24.1728054989335; Fri, 04 Oct 2024
 08:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66ff99a1.a70a0220.1fac1d.b37c@mx.google.com>
In-Reply-To: <66ff99a1.a70a0220.1fac1d.b37c@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 4 Oct 2024 11:16:16 -0400
Message-ID: <CABBYNZ+waey5srQd23fnUGT_65T2TdF7npmXRo8P+rW+m-B7UQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/4] mesh: Fix segmentation behavior of Lower
 transport layer
To: Junho Lee <tot0roprog@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, bggixx@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 4, 2024 at 3:30=E2=80=AFAM Junho Lee <tot0roprog@gmail.com> wro=
te:
>
> These is implementations of segmentation and reassembly, except for the
> friend feature for LPN nodes, implemented according to Mesh Protocol 1.1
> section 3.5.
>
> Junho Lee (4):
>   mesh: Implement lower transport layer for segmentation and reassembly
>   mesh: Add mesh conf for SAR Transmitter and Receiver
>   mesh: Fix inserting NULL into bool type arguments to false
>   mesh: Add features of Segmented Control message
>
>  mesh/crypto.c       |  69 ++--
>  mesh/mesh-main.conf | 107 ++++++
>  mesh/mesh.c         | 125 ++++++-
>  mesh/mesh.h         |   2 +
>  mesh/net.c          | 868 ++++++++++++++++++++++++++++++--------------
>  mesh/net.h          |  33 +-
>  6 files changed, 881 insertions(+), 323 deletions(-)
>
> --
> 2.34.1
>
>

Lets see if Brian has some free time to review this set, one thing
that might help in the future is if we do some unit testing to cover
the testing spec, it is probably a lot of work but I think we add them
over time, with that it would be a lot easier to check if something
breaks.

--=20
Luiz Augusto von Dentz

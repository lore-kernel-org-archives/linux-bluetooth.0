Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59781CAA9
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722442991; cv=none; b=HdU0404GbxxjE0VDpCVqR2YbL0sZoNIjNn6Sk3W1bXnlxRTV806KIL5PjIy7sVy/ERxz771ihWKUDka7aXwbDwYwTsSOMQVcSbWkLhOMLFUhMoSNHgsWP0mFwXOP0GG24pXRsxk/Okdhk6+UNWyElRirsZxKCAgaSqgt3v+1Q94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722442991; c=relaxed/simple;
	bh=tmxKZOqQCijCft0eHCD2+++pyfc+gXQ1biWz+a4Ds/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCMCxrlZr4fMTsVtjChBGP9X88gHIOFQF8Fp5cBgqXxOY1ac5ZjL8RdIXi5ZMKEwCdQtIeieuB4VYXRrA3M4eWUl7k31TMhVEEGMMZoa/UAIbZ7SR+4XNXCuCRpxU9EbyzvmdaeBqyKtJe3X1AVoSD8mte8tpDUTTOpv/mgqWQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grkKlLVB; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grkKlLVB"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f01e9f53e3so87954451fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 09:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722442988; x=1723047788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ysi/4722CXklzqeIG7G3oFD2bHIHajIT+woaSQIF5cA=;
        b=grkKlLVBTuC+Cv5vQLQ3JykQqgy+38gfiIdDaTzTO8KqoisbXYeJ7V5RmqnH4IY2EZ
         HCSSk70NqdhlpXi/xhSXgGFFP9fDuKUAiPNII5MJVOaH6j6L+L9MjmCzyeo8eOd2DtmX
         m2CXh/H+GG0Zmhx29gL+RnXMj2wFOdlmsr5YIR8dkuOg34usaIawYhOPAl4X14AJhoV0
         1GdzWNS+i6zW0XalBXTwYmb2URnp8I6FsRqyHYJGYgl0zao6H3bteXhDQQKpGkiFseUA
         6le5ZvzRj9cTwSKhVlYwQ5eWGw6WQWSgiU9gqWMHEdlrDDPLg/ih3ii9HMmJNsTV/ziW
         vHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722442988; x=1723047788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ysi/4722CXklzqeIG7G3oFD2bHIHajIT+woaSQIF5cA=;
        b=SoAL7PX1b3UzTVK2pQmGa/hd4jMcnuFDRkX/FuHr1HOVoeCWn3YsiyLlcn8jmim+jW
         LMDh9z2RTcW0I9kE3E0VwT1LxOIiKW1d7wv2z4qYeCdsHBaGHApuTs2lPKdXOZNdGWnv
         /+aIWtzA+LqBj6L6JFI/FnYygs2K5uVuF67iagdFaogaf/tfNWelVCbbChGs0B8weMzw
         SWJTiem0qwCmNgS+Wf1PIBAoDU9q5kU9FtxMqVUmC2y5y6JlbY2tXI8WvF2c7lwTNV1E
         IvQwTGlKFNqfXYHtK7zcHjDc/nAUdc1icbOi51CoYTn0jLdGIHa/iayY/lfGyZoc541M
         ihDg==
X-Gm-Message-State: AOJu0YzJfTbepzXHy0K0+HgEvhPo0lEYz59j2fPX0Ifqk8dl7cdIbjze
	xk9NiV4S0MDMUO344SXPRYdltHbxDRn6Htu5NcdqcTbcJvd3oAEw0NTr1zXJqBaxoISwMjsEvE1
	ybubExL1NEZulTwTTa/8t+TbH70E=
X-Google-Smtp-Source: AGHT+IEhJW3WURqW3rbfl8bmNFunJOZHSanwJ0pw9894CptSbuKxqSld+KcpgbWCPcEJ8bH19Xexd70MVOkfWdy3L3s=
X-Received: by 2002:a2e:b714:0:b0:2ef:17ee:62a2 with SMTP id
 38308e7fff4ca-2f12ee1185bmr119648961fa.14.1722442987508; Wed, 31 Jul 2024
 09:23:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731061713.435586-1-vlad.pruteanu@nxp.com>
In-Reply-To: <20240731061713.435586-1-vlad.pruteanu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 31 Jul 2024 12:22:54 -0400
Message-ID: <CABBYNZ+R9rqX66fXXfLLnfMDwEHgpx9p3S2Ds7b8LB_V9CCEag@mail.gmail.com>
Subject: Re: [PATCH BlueZ v5 0/8] Add 'broadcasting' state
To: Vlad Pruteanu <vlad.pruteanu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	iulia.tanasescu@nxp.com, andrei.istodorescu@nxp.com, pav@iki.fi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Wed, Jul 31, 2024 at 2:17=E2=80=AFAM Vlad Pruteanu <vlad.pruteanu@nxp.co=
m> wrote:
>
> This series adds a new 'broadcasting' state for transports created by
> the Broadcast Sink device as a result of scanning a Broadcast Source.
> Such transports will remain  in the 'idle' state until the user
> selects them, at which point they will be moved to 'broadcasting'.
> PipeWire detects these transports and automatically acquires them.
>
> The transport selection is done using the 'transport.select' method,
> that this series implements. This allows the user to select the desired
> stream when running the setup with PipeWire since it acquires any
> transport that is broadcasting.
>
> Termination of the sync to a BIS is done using the 'transport.unselect'
> method, that also involves a 2 step process. The first step is the call
> to this method, which changes the transport's state to idle, with the
> second step being done by the audio server which detects this change
> and releases the transport.
>
> Vlad Pruteanu (8):
>   doc/media: Add 'broadcasting' state and 'Select' method
>   transport: Add 'broadcasting' state
>   transport: Add 'Select' method
>   client/player: Expose transport 'Select' method to the user
>   transport: Broadcast sink: wait for user to select transport
>   doc/media: Add 'Unselect' method
>   transport: Add 'Unselect' method
>   client/player: Expose transport 'Unselect' method to the user
>
>  client/player.c                  | 100 +++++++++++++++++++++++++++++++
>  doc/org.bluez.MediaTransport.rst |  31 +++++++++-
>  profiles/audio/transport.c       |  90 ++++++++++++++++++++++++----
>  3 files changed, 207 insertions(+), 14 deletions(-)
>
> --
> 2.40.1

I'm planning to apply this set later today, let me know if you have
any objections.


--=20
Luiz Augusto von Dentz

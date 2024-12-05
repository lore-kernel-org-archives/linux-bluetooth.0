Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726071773A
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Dec 2024 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733410853; cv=none; b=ZRciXR+iCdDiKMyVZ+JETrF9Tvu9A4GHLjV0Cq9FBndw8zAdapcAWEppRvySJGe3OllB5lUqY84D0sfi39deuFGJ3UpRDrHV1xTX9xhwslyDeweSkNfSf2HMrQyJLTTqr4NVFdWG3en+8hLifM1GLNFqxcPOPI4MRG4R5mudmf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733410853; c=relaxed/simple;
	bh=mcsGT6+GxYLKxLvriuxaCfxz6j4EU+YjuIFvIy6/4uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GXc1MYipONIRiojseFcFQq89+weyMyz851XHTuOcAvQXab05Cz898Oy3Nfeqai1Le6SN18VyIT2BVGqn8uJLlmQNBrEU5tBk4LIe3ZKgHhSjf2Cp//Klq9uEHNSvGATX9e6LNc9JQs28PcpcZhO2Mblb+SGqxyFD+y1TppSvwhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8aWyFRf; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8aWyFRf"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ffe2700e91so8756291fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Dec 2024 07:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733410849; x=1734015649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwrO5YdojDTKFz6T5h12HCEei90ZkJL6pmRQ1fZLetQ=;
        b=D8aWyFRftVfESLqgUy/Xu5K4gywjpPn92WE3NuWjMj7ym4A89b9P1hdYSbK2xphOgQ
         tCbNI4gI8M1uwxsKHKq8eT4RxdVPK0Bk/DYk8+jx7GapI/ozmt0d8+QIMrN6NblLnvl9
         Sdsw14AnHcFFDwvW8XsMlzssZVoExxm5w/mJ4AE/LkHErCooD7+5goPx3Uim46TSRUcE
         YWeKD+Sxrtk6NU9z74eMjw94YAwiqNp5m9Ad2k2HqubjwUubiCUf/DALkoqk0fYAmP6I
         6lYuTaYPCIFnSzN98O+wr46Ez3dFZAgR5k9X4Qdtwt0K8/sMzfwJFDw0/kWFzMxH3V4/
         u+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733410849; x=1734015649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwrO5YdojDTKFz6T5h12HCEei90ZkJL6pmRQ1fZLetQ=;
        b=T1bM5NtuQYfIOvRAwD9E5ZLLpX9AA+79Zzr002Vz1J94b/8A8dMtY/7N5OqRQ2LWlI
         nQ+zXhAxd0kHXm5a1Lh029jEDa65JEFn/ny1n9QJEJTpRnY62Yn2lxGQbyDNUU6f9Kka
         DSKmFr4JhNMihM+SxNpIxOhTH2tWHFF7AVqhBodhhqPL4Phwg8smXmqZEjAFJjhNxrDy
         S+873wtJyUOkN4ivxLRT1Z4fhreN5ZudSFPy8Hh+5P/qtb9KUEYqLWMZoh7i1PfABUAv
         r59Cbp7TNokaumN8jZC2Csv0w/7+UdV+xkvnYHp7zd4UrPUe81834e6zlztsSi76gpRw
         /UKA==
X-Gm-Message-State: AOJu0Yyhx9oYTlG6ATvAtjQ8Jjw98/ZSnmvWkCuK9MmTfhWiCQK8D+sS
	SUmVSAKCqMRVb4AXgZMYkGn8FL9wIR38/QusCGxsfawuKzvSuQTn3KlXFzRrKG+k98j7TkI+F2Q
	+PlII2nC7FEYFmAvyWVoIkq7muNQvHA==
X-Gm-Gg: ASbGnctqIdMytTkz4HBg9TBAF6rDBAanMhkPyu9qdXe3upjoSHwuaLbk0MrprLBm8JZ
	k3MqooNlyrDOpWynpU5Kb64FvKl844yD9
X-Google-Smtp-Source: AGHT+IGDCirSS+O6fAgnbxjqi5zmYqb9hp8K2+/QkV59wOQbuY7NBkmlZku4KGTN6WnlkpQ4uAMfLf/4uo75YNckA6U=
X-Received: by 2002:a2e:8050:0:b0:300:16c0:b67 with SMTP id
 38308e7fff4ca-30016c00fcbmr28336411fa.33.1733410848268; Thu, 05 Dec 2024
 07:00:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205133233.1738092-1-fiona.klute@gmx.de>
In-Reply-To: <20241205133233.1738092-1-fiona.klute@gmx.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 5 Dec 2024 10:00:35 -0500
Message-ID: <CABBYNZJE_zK-enNFyHG4-8dCksj3TxAZRQZ4Q+OxibksnSKoZg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Leave config files writable for owner
To: Fiona Klute <fiona.klute@gmx.de>
Cc: linux-bluetooth@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, 
	Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastian, Emil,

On Thu, Dec 5, 2024 at 8:35=E2=80=AFAM Fiona Klute <fiona.klute@gmx.de> wro=
te:
>
> This is needed both so the owner can adjust config as needed, and for
> distribution builds to be able to move/delete files as part of the
> build without adjusting permissions themselves. Limiting writes from
> the running service needs to be done in the systemd unit (already the
> case) or init script.
>
> See also: https://lore.kernel.org/linux-bluetooth/4d1206df-598b-4a68-8655=
-74981b62ecca@gmx.de/T/
> ---
>  Makefile.am | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile.am b/Makefile.am
> index 297d0774c..29018a91c 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -32,7 +32,7 @@ confdir =3D $(sysconfdir)/bluetooth
>  statedir =3D $(localstatedir)/lib/bluetooth
>
>  bluetoothd-fix-permissions:
> -       install -dm555 $(DESTDIR)$(confdir)
> +       install -dm755 $(DESTDIR)$(confdir)
>         install -dm700 $(DESTDIR)$(statedir)
>
>  if DATAFILES
> --
> 2.45.2

Any comments regarding these changes, shall we also use 0755 in the
systemd service?

--=20
Luiz Augusto von Dentz

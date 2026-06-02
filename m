Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8D02C187
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 21:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780437239; cv=pass; b=COHWoaTIlyhlgHzihJge79Kb+Tc7Ru+IEeNesH9o7bYgiehgheo4tARdULs4q+GMVD/iZSeWTdgR8OWXx0kBtbY8AILnAf4TMN73mSV2CDbqtS05o3o8f8HOL8jd4mSbYDsF/X7s30rpY0ZgOZFxClUPbZvrSxv+uVoYAxQLSpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780437239; c=relaxed/simple;
	bh=6RN3p/+DHEF6XWeCMV73lpleeal5/Dk9sHEI4BZ29Ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uzjt6p3NnAHfZdIgR3WqdD9M7Lp64DqKNqbibilnh05D2sehNk9lF+MnFzbW+n2aEagsXAbsTPBUUFxQOlrlpCIBJXern6YmojHViOLjfVk0s1V9zYtMpY6ajx1KtaC380xmuJ45Whzbzwi2FZNdpKePJHraOXZUtsZLXi1/Mio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fti+luHT; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fti+luHT"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7dbcb505578so67422487b3.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 14:53:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780437237; cv=none;
        d=google.com; s=arc-20240605;
        b=WOfvCuFf6XGJsBZY7qklg8e/H8+Ysktkqr3cZqkXD0rPP4OhgxV3fhJBc3ju/y0OKE
         MAbQY7bnkBLZxCCqjMO03R5WoQQoE2dN5dhEOnwucbRBkHyNV40Nzmd8UDqncEaSYjVm
         WJ2L/217/Elv/HgcuIFGlmQs4iQpMCxNsGBbRxS5PhH3cwI1XxvqDcT6SSRpD5t+6CVi
         PVaDF3q/EUHJi3VO1ZuOQAEGFnC18X1raPCXR2OezXjOFEBLzKif7CL45Gj0BztugBva
         vnvV0K5SprwTcB6/8SFnXFLRjt8iXCFt/8PShAKmLXeOkn0QF+Zd6fx7pTQAB+a2Xz9o
         hNKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9XRQlINlMzbZVFCeFX0n1adVNajMBkIsswmN5r7ALEE=;
        fh=umZ6h4Y6O+9RWCn6+GzPdlF4ehfjFjYtXpA+Teh7Uek=;
        b=ipUpOBRMtCmBv6+Jr/KUu8QsazjG09LpnoWbqgv845Ab6U1ffGp7x5GH3zK4WIyXrY
         kpoAAcvAJsAV7igaLK3u5g3uHmkGInHV7bG17ZBTivJAyxjQbuvmjbgtb1CzUP0A396d
         FRaTtRXx6n9PjvWACb7gupTlk9j+0qRSoriQUeffWmLT5yrdnHTqsMD+uiiG2mqmwLqi
         6cYfxYcRmcnyICmDz3lKw3fjVU1o/RzLuDfRer/vpzMW8lct8Ln3UoxjW1RH/VbgXQWk
         XzDFq2C7oKdi0pxpNHn6+VsfDEi/qJv2nsh6AVJyMRbYs/cvelUWHmdfPAGeIJAsn56V
         HYGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780437237; x=1781042037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XRQlINlMzbZVFCeFX0n1adVNajMBkIsswmN5r7ALEE=;
        b=Fti+luHTHLQb8ZeOIOdY0gl1hFczM9hegCEv5PVfuSPneLlSeoHPrGdE0OU5ovrJwD
         2ulnO5hJZ0eVCxc75x73YZFQPhnluXSwxYAA9NYbd/7pl/m3/c8GPwQgltToLcqLbCsn
         jLhjIgVZbFJrdg/3wSaOi1bbPAK9fQ1VJjr8i6irPeoMyVwkhK7VuRJZWM6DNXsaTzCk
         W6xfGqd19WijpyeW0MpGR2kJTYtlhg9VsSNC96mHS9I690YmUfPqi0ISB+NxMold2I1d
         90vJNluBbOm+7BhP/ztW7OuFtA9VnkXADcv9JmSLE3Qtmc/TDbLSgy9xbg2F2zeevDaA
         tUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780437237; x=1781042037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9XRQlINlMzbZVFCeFX0n1adVNajMBkIsswmN5r7ALEE=;
        b=ltLuuF9FeAyYQFyiZ/puO2j/BgPBdNHB33U3yxPjg3Ns9/X1n+SScdCmkPGmW90Uow
         Q7Z9iQV3acDm5ZBotSsuIti2NkPEdSSO75UQkL3IRP8l4b/7TJht2epP7nt9TY7qkcQz
         7RTp8tSEFJjklWR1EJ5iyjU+/iQV5CzgiKFnyppMPcU5jd9OhvbxZ+1P/O1xRGvDpOs4
         0fyU5J5Tb7VxVIoDUNnrcVjd+t+ekh7MWiJVIsgAazVSK5FMoIALwpgB6h2Lb90bFyoF
         uMluxntMqYYloY7Lk7/XZv7iWrwJsAQ2CYI9i1GSXJPLaJTOvDK9ua4BIXrEZCroovf5
         AIuA==
X-Forwarded-Encrypted: i=1; AFNElJ/vaXJ4vFBWPtkXGVXq21hPTaJ5VNGg9OQUKUWqGWaPCwokTLszwXzsizo7VEoI1vlDD+nPAVbs6UKZ7ahtLe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX7niTVewZAcnXM53l54W5CDzBZMq4OQJVZem1Aq5/VDUuVeeq
	cH9X3q0wbu0deTS9Wg/RlMRcvqPMfOwJPbYoHezc8xwEFYuaHrqtDmqU0A6KvqEyRVS2k7NEUve
	kTeNjEZ3AJAySuYCbHyMNn7XUon5bFdBIGB00
X-Gm-Gg: Acq92OEsyit6WHtlce5F7wRx6SjmRCbVETcWB8cCXwmJUpZfjW91vY3Fo99B/UPleIV
	9HqjuDBfeSMFFuy4xaj9BlcXIIqgxBMraMQsP5rIky9VJQmzFZF0zQjmqbHviqtIMZJISGYJLl6
	OihMluk4pn8tFSR3k54O0FmvVuqLS+5rqg9NWWq1vbpnBhMaRWX7ChlNrUzzSU50rtMBCretFDQ
	XFYSt+maTYY8efwo7y1FzkJuwqc/G4okrvKbUyB9mo0QuDHQP/KmuF6ahK6m4WqrT2ZCcREcdvg
	JHorDS0iPdtV8rKOdPvCP9xdOVUKDofcuokX8ECjmZIi8XWRfKOCdTNQWw==
X-Received: by 2002:a05:690c:c52e:b0:7b2:9347:7bdf with SMTP id
 00721157ae682-7ea4ca9256fmr7863827b3.37.1780437237238; Tue, 02 Jun 2026
 14:53:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515143819.1157807-1-michael.bommarito@gmail.com> <CABBYNZKh-J9sHf3ma=HJTBz=j0QL+eEti_0hOAJU=4Okm4Lz1A@mail.gmail.com>
In-Reply-To: <CABBYNZKh-J9sHf3ma=HJTBz=j0QL+eEti_0hOAJU=4Okm4Lz1A@mail.gmail.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Tue, 2 Jun 2026 17:53:46 -0400
X-Gm-Features: AVHnY4IVQxKjxy_wHGwvTDdCZWxzdI4J_ZApxw8BBHBIYlq0blGDpyuJMgH-sDo
Message-ID: <CAJJ9bXy1TdDt1Cx54=SP1Ww+VVdP2qjD7OS=j=MMYSrsUS3Vpg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: MGMT: validate Add Extended Advertising Data length
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Daniel Winkler <danielwinkler@google.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 4:17=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> That is probably a bug in bluetoothd but it breaks backward compatibility=
.

Ah, darn.  Should we config gate the kernel side to make it easier for
distros to decide or make backport decisions easier?  Or just hold
back on pulling the change unless / until the bluetoothd issues are
resolved?

Thanks,
Mike

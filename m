Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9C62F6591
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303761; cv=pass; b=VNYmNfWR5UgwizE8TR43x2730KqmR6CSMiX1691sm6DkHcnlR9+bt2zvYxOrpV3CO2z1mct97hwiExNdQ26lLN/tbksZzWy0hX+D9Fu1FcFmy+lNSv/CDCbtIGhXxwGX8fGf9ZkEQtYR0j5CBX7GwGMngJjIAWf8nA6gvgppqOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303761; c=relaxed/simple;
	bh=xTF9iRWEHuYDDlvbR1iFxJajc+HQuPwMuQU7iIVa1mA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g2dB0b6Z6gZ8nHUZbToLcHQ7QjdZ0hs/SAEIcDXQVXvBwBXcnjWBG57cPLQSCzZ54nCb7tN4agh6dr+1Bkzi7o+szeDkX8HSlazLswhR2tTgACcv2nZkpwrFTLIeg12Z5O9AM+SC2LmLrMHhfVnuStkU4i5+TpqfJt7DRWeBkQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sekc4nrP; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sekc4nrP"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-81e86df8987so23999067b3.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 08:56:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784303759; cv=none;
        d=google.com; s=arc-20260327;
        b=hAZZtL1o0YeSH9Va6pwdZymYkcqBbLkcOSWn97ZDcdMRNzAvRK6nB6QIhslM35+X3u
         1KC0pa+oAefvN1eeb6XSYus3WbUtfOQR5iFgH6vBqR3JwoY+JALozKP0dU7lUKLFj7m9
         4xzkjwFJul55aRX5wlljMMScNgNeoQanMTvUdB1E5i2HIYvyINw9cVOByebSGg4m4fDJ
         PtQG33Hbz82q3ROug9RUji30vTS1OLbZh5r3nDW7/89kecO/AxY7ciKD9WEItLkiz5jG
         4lJBnl8gvTNTQqF4PDS4BhOSZz9h7epQCcSmvYQfs6c53awuhaH9mCQ/FtdCwfUtEj2P
         Itmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xTF9iRWEHuYDDlvbR1iFxJajc+HQuPwMuQU7iIVa1mA=;
        fh=Ng9zYEbSa7rXa2SX0NNat/9YYxLNcJ4vwRl7zALU7x8=;
        b=ELXTT8wYH0n2xZbrD/8OTRGOq3sJHyZsuh+ySrmHmi1CpvMnCnVwoTlXdtsAOfmd9Q
         JBSBJ0yaws8lDg7roIY0V37BPAdHQE+Ox+AAZ0AhXibpHdx2m6YgfyBpZzrlX+fXFV+c
         rhjqZ2pqcHN4izRZuqqq3/VRV6cECd0twAQ244yAyMkqsz08JORRN/w4Pbst4tkmfg1u
         ykEXrU1naaDCR4SBQ9JWMRADMgDY7yi6WoOhlQxmwod8odcq6VoLoShiqWRDeUzoNkx6
         BHIZdVcIc0z4LCHP7TJO8LO724USlhYSfQRT5rpyjwfIaFuyVTSoT3afi9w9pCEpRwIU
         evPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784303759; x=1784908559; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xTF9iRWEHuYDDlvbR1iFxJajc+HQuPwMuQU7iIVa1mA=;
        b=sekc4nrP5i1Gz19ku1k7AT6VlTJ+8/+mJH9AEUS9aeF2fHkZRtWEw+kWhyODU+KWjA
         Kh+CGPRfhlcfPuE1e+I09GIgFTo2YT55ogEshT3IrRijSpY9VLf81czpi6LhAoJrt2f6
         NEXV8MXZCnbBy3U2VeHv22Uut7Eh2phXFSmnRHuUgmspUvCThvcXOqFpPC4lUvr/ToiB
         iSwcMaG32lxQ03DWuLyTCrTubSfe78m8RRp/1dW06qW9dBcGldH401Visc0oD8DWbwiZ
         wp8UGYyJVxalhWwAcUKnl/n4SbVmVY6aMbVND4eNJZTt3xbNnj55lh+fylBJKsVtvm3I
         Q6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784303759; x=1784908559;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xTF9iRWEHuYDDlvbR1iFxJajc+HQuPwMuQU7iIVa1mA=;
        b=j3FoJyArwOBNpR3nAE3J67xZaav1eiAk2ekUNaR+MrL92c//99VDTYs0gtYWTmIzhy
         LKR5NWJr6nz8KMoCNM1+DlqOe1fUV31iRZmbiYJN6jjyCqGXG0eTiMeIpPn0Zq/odRPT
         uwgYFoy0yaYmLJ6SFMGMDIzubG9TgurPcSEI8NbOrY6wPJL6n8LAksh4CA/UIx+0G1fT
         vy8V1WvIfd9vtuz8+YFa91oVmb1M6b2PG9I3LvAhG4oGDssiMBUUqRv/eIEsy16PVdFG
         QEgFApymOz5mG64++OMJEzIUXeduSZBOVTW4v2TdD/VvOgSosxsi5Nf9yLl3Hi2oU9fA
         wQlw==
X-Forwarded-Encrypted: i=1; AHgh+Rp8ul96YQ1chKlwov4nvs+5LLyakeD+O4bdVz4Wsc+PJ+x8pfC/qSKw9chRqL/pi+hdrn/1hTeD5QmBBgQ2HQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz95yNznEJHS2gXS1V/sh6KlMWgqmtzSFPiQwRa0MzOWnQosHvR
	ZqUWJaRuON01UkYixvdhKhluStrHHoIPFjVlRHCS6eWSQXBF3xi7ZSXNb0oslG22TwnXJ72Wntc
	TOgm/IFYYVNBRXPTlhRrZ5lMDgFKg1Oz9baZnjlk56uGb
X-Gm-Gg: AfdE7clWC2sxPChg8879NmKReGOs84xcsyX2GvKKT1IvbhaBxzWWYl50WcHq1y629LX
	wtMFM5YGWQ4ihV6EHEt6Eo4dOWmvYbK/imAQKRYcpw74hlHXFJIJ4eaY0ZolKiHpoZed/HfutPU
	pn6dfbB+PXojeO7ylJ0abcWG9i2Tj+vf1pOU6OK2lteQpVPwIEXTgivMMd6ssGCwPYz2zVyI6Y5
	uSw6PLMRy/A/izdlCcnvWAk+EW6NwuNb2VlzIWz3BfimWJuk1OM6oKWXqT7KUeUQQcNEXZPLTc=
X-Received: by 2002:a05:690c:316:b0:81e:7bfd:f2ec with SMTP id
 00721157ae682-81ef2760bb0mr11561637b3.19.1784303759143; Fri, 17 Jul 2026
 08:55:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703060024.570535-1-zzzccc427@gmail.com> <CAFRLqsVdaKE63gAKVuAjv++CM1z8hX1hYh6N3BxHkVaoyKnKVw@mail.gmail.com>
 <CABBYNZKQKpt9gdJUYb6YS_6ryGZLjrofO0OEpu4jsvmA7f00uw@mail.gmail.com>
In-Reply-To: <CABBYNZKQKpt9gdJUYb6YS_6ryGZLjrofO0OEpu4jsvmA7f00uw@mail.gmail.com>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Fri, 17 Jul 2026 23:55:48 +0800
X-Gm-Features: AUfX_mzyGlSedcfC03oQ6n8QQgLRE11i808sfLdjSdEhq0hMjKs8Kfc5dBPvBNY
Message-ID: <CAFRLqsWQmsNGWnoxwSSUBJ3rCJzY5G0nuY=-=2TM5mz1oif86Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: MGMT: dequeue queued mesh send before freeing
 canceled tx
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

Luiz Augusto von Dentz <luiz.dentz@gmail.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=
=8817=E6=97=A5=E5=91=A8=E4=BA=94 23:50=E5=86=99=E9=81=93=EF=BC=9A
>
> If you really want to bump it just resend it. Sending pings like this
> won't retrigger the CI to pick it up and test it.

Thanks for the clarification. I'll resend it next week.

Best regards,
Cen Zhang

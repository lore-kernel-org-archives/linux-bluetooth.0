Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB8337C936
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 07:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187022; cv=pass; b=HWLrse2k7U3fR+usvFccm8GpslVAzpnn2lu6TtYg/5NxhOAo0fiHZzNYFln/jkRHRSSB6gszH/9pzm0iw9749ISnbm3m4aDMXms3ya2TS2a8OD7o/tDjhkA1cHgbpUupXg1t8QX2da5kdePrBriihSBrC9uwgf1FeUZWzQvAKCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187022; c=relaxed/simple;
	bh=Cqt6Fu+sk8V6mLKmZzliQOQ130R6uksTirlfpR1CVrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xvlh5Eg8DcKbU1EcdlFGibBRoGN/1U6SuuK4oFykiasieiZYoU4G6H9VCIlDHe4z2Qe3c5tsfPvdAJAYI/56qzORt3XFXmOtSyvWfK95swvkg9uym80BuvC19mnhB82iB721V9QCPf35dNIUKtyvk18kiFJGtbNsGKKogw3s/eE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdFTF936; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdFTF936"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a9a26ce219so153111a12.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2026 00:57:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791187019; cv=none;
        d=google.com; s=arc-20260327;
        b=hg8CrXaA5k6ZNgwswoxUUMOeOlPbwbFXf2VRrbsi0IJxqtEd8vG/DrBtc9E0Vwx6aI
         ME/IX8hXq+vDzvTSVqR3m/9WeDIDKz129NpxiOUR1XkhWdDRzqQTzdNsioVhPf3/pTdh
         igfK85DypOYKXRZtysheHc3XMlFPNrZuevyd/0QyFafLQE9C7Usci4stB0EfZbgFDIuQ
         bOLnPxI7xL1nI0y69Pcq3lKzJrtEwXZk4zYt8/S09dnqul0BHDYe8msMRut5EbILuMRK
         RBDrLjGpswgGnOEpVjzdr9WguSwQMNHeDKRZFQ0oOgmkaLf1jObEh54ggi7hHTh/4r1G
         S+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cqt6Fu+sk8V6mLKmZzliQOQ130R6uksTirlfpR1CVrU=;
        fh=vy5lDTjoHiEJTPTMWaS3U/8lLabKZNCFhQu77qmxfxc=;
        b=olM3TGTHV6oZwiaJDv9hutrKhVwTk7U4W4eIcDixlLb0/kEyBkwTkFh9jZmkrnLH5x
         4kmKJ1LGCQ+q4ukUYHdvO4Rz01ZhEcquwae+OuZOEVqUuahtX/RlO9DyB01ko4POKFnU
         V2/mU8QeLd2k73n1JlgBZDzfF34AdXj2biL/m9EGN4QvznwlxZ1dONl49BelHbDR9ehp
         YMdPEoAX3Hnxr9Aq87DLEGyrVGx9sfjqmdv7YmXsl7jMVP4NllHS2TETuTR3bh69H0eh
         7V4EUOFN5lUVprhi67j03NqFBMSs/Jmy+bWPA9bAVHSxp5G+sAThof1iaHYUtKE3VgNT
         AUpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791187019; x=1791791819; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cqt6Fu+sk8V6mLKmZzliQOQ130R6uksTirlfpR1CVrU=;
        b=NdFTF936OLuM/81O1dlM+ND24KqVqhozqAzWRiQFixsNqqaeCAd3FPwgM9BMQEv1Qd
         VlwakQ3Jbexah13atoyKeaBwMHoFyr+Pt409dWN8TuvbyTo5MosAQR7DrhX1z4JFNzox
         6VIlz2f8MXudLIrFBg9pWKeBBD1tlb/PJIbT3dG4+kzIaft/VAYXVpXLrWo1fml1ighR
         ZzLVdexNT3AFUvcRK8/piOsjRTQAhRiloy8BrvPG8xi9n4Nia9W1CbrAq8BPZbMdSQI8
         U4SBR/9zsyigUNMkoKoYCfKC3KRGSY9qef4Qq4z7AJiCc3M7TXr2dHrVejzHG8o85fEL
         PhQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791187019; x=1791791819;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cqt6Fu+sk8V6mLKmZzliQOQ130R6uksTirlfpR1CVrU=;
        b=X3kTmykFZkm5q9/tgrfLoaECbkowT/J/CGLJRwFkfIgT8lx5mX0YMvx8eAS4zWT18e
         4+MDeIzRRqioDVZJ3LCP6gCamSIx7Z5ld2Pp98uORrmQ4elZ9HELIK11vPjhYHTSXZUw
         ViA8D7CgPY+kax6M+k92fiMDIDDLGw49BL4WQbyvYbqEeTOxjrARLu3fmj1K10X3Gb1U
         gJrtfqzC2lUwTIqbVnjp0m2YQLo2OvjDQQitS+9lFn6mlqqBiRdNwG5MqIsu/pVi9lh5
         xiFTme+KUCr571/lO4qiVgeM7vSh/EiAkaGUJUV/Fu5+cNb2XObJfOGLoZOJMTuK+OzZ
         xNKw==
X-Forwarded-Encrypted: i=1; AKwUvBwDqwffNM2RCwNUd3QnVo9yNQbfa/UQK1TLn3zmTX0UzZFO/Lywrxnz87b/UVw8TeAJXUsGgfdeFg1lsWsgiJc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLzNFsvX/5A/tZgdNNWuxmWOzFNka6m2xggE+AhDgnqVmABWXWh
	3bRHxnPsw+ZMCBcNDYm9rN0AwM75pgOM+2IE2lQIzYwjcN1D85NXP3IaZ685zGKH7YfQYBlKIiH
	lClhksRpCAPNTxBl7aYevCuzIX+Jk4wk=
X-Gm-Gg: AYBFou2ochs4yKq72RA/WXznLTLSA1ytOdkY4RPb+Jh3s9+G9MmPH1PjPSyvGT5GGmj
	tNQjb+3NGCb/91WZKi0epnNBQkOd1mVAXcwdqwmoepCL36y5/GDI7LhEIwJf19wquwbiWZeOhyD
	BkVYiEt2WUpxEiLTDrdLacqOHaZSgB+Py8Wk4/ftspeKuRYZ9U3MyevrdlmKZbI/hvAHIo6zmKh
	/pfaHxlHm/N/RD21Oeirg7u5bVrDLfufhI/oePhd/IN3+vc2wbnEjgDJlvD+LGf8jwNTSia/i16
	iQ9ycd60LwQoB+8/74G7vtxpFuQvyyLlfH93xuGFn6As+hp0U0ZvOqin2y27/Z2bUiuNispNsU6
	8p4MHnP+Lc8I=
X-Received: by 2002:a05:6402:3228:b0:6aa:d21c:9c18 with SMTP id
 4fb4d7f45d1cf-6af9e2f9d57mr8176215a12.3.1791187018776; Mon, 05 Oct 2026
 00:56:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261004162458.3968546-1-nicoyip.dev@gmail.com> <225d8d84c8e5155d5af0adfbea270eeeda326021.camel@iki.fi>
In-Reply-To: <225d8d84c8e5155d5af0adfbea270eeeda326021.camel@iki.fi>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Mon, 5 Oct 2026 15:56:46 +0800
X-Gm-Features: AclHuK9vopQGKPch616H4XPEsAiU40667tZEfF-9543oK_7dTTKxojOLxqJFuSY
Message-ID: <CAAo+4rV9B=QUBAWZfpHL_W8jCoCLTqv79kha6G-x0UZP9Swm_A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: ISO: Serialize concurrent connect calls
To: Pauli Virtanen <pav@iki.fi>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 1:16=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> ma, 2026-10-05 kello 00:24 +0800, Chengfeng Ye kirjoitti:
> > iso_sock_connect() checks the socket state before taking the socket loc=
k
> > and drops the lock again before setting up a connection. Two callers ca=
n
> > both pass the admission check while the socket is open or bound.
> >
> > Caller A can copy its destination for route selection, then caller B ca=
n
> > replace the socket destination before A binds or connects the CIS. A
> > then uses B's destination with the route selected for its own request.
> > B can also proceed after A attaches a connection and sets BT_CONNECT.
> > For deferred BIS setup, B can bind a second BIS and overwrite
> > iso_pi(sk)->conn, leaving the first connection's reference and conn->sk
> > back-pointer stranded. Concurrent CIS connects can likewise replace the
>
> Memory safety probably should be enforced somewhat down the calls,
> likely __iso_chan_add() should reject adding a different iso_conn to sk
> if it already has one, since that looks like it leaks the
> iso_conn_hold() reference and the back pointer association.

Hi Pauli,

Thanks for the review. I have just sent v2 with the check in __iso_chan_add=
().

I also adjusted the outgoing BIS and CIS callers to handle conflicting
attachments early. The BIS check prevents modifying a reusable
connection before attachment is rejected. The CIS check releases the
HCI hold acquired by the current attempt on rejection, while
preserving same-connection reuse for deferred setup.

Best regards,
Chengfeng

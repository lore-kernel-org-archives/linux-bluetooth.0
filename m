Received: from mail-yx2-f22.google.com (mail-yx2-f22.google.com [74.125.224.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7BF41CB4C
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 19:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.150
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499796; cv=pass; b=Zou2+ecux+I961j+DhOyvSUYuIJ79p9Y3yfbHX8yLxwF9D14vOi9QOmeZp1yOjFy2RyBeOByBLy2mLW//NoWN8DV+rCywq+zXK+KD41LVAhnO5j/EG6THP029gTNTSom0WZA4KqViKDCtZOqdHxiifnCJ8Nr9BKKZCY0T+cR4Ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499796; c=relaxed/simple;
	bh=qXq/IP+wG35Y9ctxb4rJVIeyhdtgKyqMuYb9Sujr+40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqL78rdyyRbYTEUiKa428hXNbjIWig9sJE9d8XZvc+mcuJpFUVbK+IC353EaOSi7DLYdT+B3N+A6/+/kqvT/1ssD2kn7aeIT3xGMj76oGEZKasiiAIshJ6iVBWtDuzYaWExReiO/iDQW5SKQcSAFWJTa7p5D2sL/V+UbQDTGp3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfDyQnMz; arc=pass smtp.client-ip=74.125.224.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfDyQnMz"
Received: by mail-yx2-f22.google.com with SMTP id 00721157ae682-85d4ddd1d91so959337b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 12:16:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789499793; cv=none;
        d=google.com; s=arc-20260327;
        b=KHajog16QdL7VML6f/qp1KlMoo9Xr0QgBrRrslCLHW6/J5QtCTClmc1X0YL/Bp8RXy
         yumDMtA7xXJS1eogXTA4TpUdeiFUGz5waXwXcDOhz/Xey4lVVcCO+cQxEzTgFm/B4CP/
         /nOBKAx/EMIcZM5bZcri1SNcFJ68E1kt0fuRxWpLh+ng9QcAWC8zXuhUp6h7RHLXoUp9
         q3v3uwI5t70ke1BoQ6xDQj2Ox+g3TcIoGo21XOn7nLqwrigSR32l4kZeOu4z/cu3AU1y
         ZqUj/vQZBUYm1jcuGfreS+kZX0TKB0qbhztP6Bnoq88G2PFBx/JD5pIE5OcwdSRFeR8U
         Zfjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MpL80pv09E/LLYkePzuWDbqyU+RJlTYLhbM6+QzZG70=;
        fh=sS3qD6jZHBE+B6luxk8f/GbZUJJvdPOmJJNESME7xFI=;
        b=q9xzvg6F0/n0GWdyTUWwACk+JFwxlrEhM0P3C7LMug86PNxAMXF2iQ75jXvVw9QpKs
         F9euybwcdsvEndQkSw3H3wamEfTsctjISt0ThRUIxKWzLu3pimzW1IaKGnAGCoOfQTxd
         r29MiuAwFZKMb3SVeM653+6c+aj/9M2o2D7deZCS9IQJiwTs6IZwubNsKybF7WSPCEM5
         JsUF+pyOf8G5YiL1DeMySMBrF77rfaZwT7woP7syUyFRLP2iDtQyMzEVYFe8955Nv1t1
         vZOJiiFbZ+vHGGMzpdqWsjwU6CNNIEw+ZBLWprrsox/MtaVTgW+b3ReqwPOebtEgWGS4
         Apuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789499793; x=1790104593; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MpL80pv09E/LLYkePzuWDbqyU+RJlTYLhbM6+QzZG70=;
        b=QfDyQnMzmGz+Mlw6PX4HKxt4tiAOUu3O5677WF+zwkoeRVm7dT03Tsjydio+UXSCpP
         PxJq8rPHGA1G/9mc7/g/Y3ZjQoPMgu6fyEHEILkSsAdOBxMCAAm8h/bHANc/xMn0yM00
         ANWIwEUPHzxZOVQM5Ts46+LKempxbPsirsDaJIvThNtk7glFICD/c9ekqg7gjRoZKmxm
         a15dzVj2ujYbX/ynZkyO/qsYu+I6JLfmUJTJobbSwwGcUMdDkCAj7YptRVq8tc1rCITd
         WovgGlT/lbIFHuVRej4sww3jIAQTV6pRsemMENoeywKB3via6OAh/QH1fZC/Uxdp+Da1
         afsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789499793; x=1790104593;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MpL80pv09E/LLYkePzuWDbqyU+RJlTYLhbM6+QzZG70=;
        b=GVZHUyIWeeR/Ir34c8yXQTIkHKmyOVbFJPzaUmJkucKtd+xpnzCLj5y1bybKDYe800
         Oe6DJOctV7nZ067dwhrgFItblIQFKRRyfirrIv7R9gHKMKEWLS0IKAF8gm5YhzX1E+RP
         r0A0votkgenfDMxgveeuPHLcT6HZWZzw0/nTZdmohUsd+vU1p6fOXYjrRSM61M7hPKQD
         Qz563/8QRxcO+6US6Gx7HauW6rROcmorO0rBa3pD3UHyOkeFOw8oxeaGygVg2TfGFsE/
         FAgigTXOeSGvDuuDRL3oFLhSf8HDdLoi5nvZ6tZ6w5NfExf5zPkEI+Lt4c3GsDwi3i35
         tNUA==
X-Forwarded-Encrypted: i=1; AKwUvByHsfQnbRh5Kr9Ef5tiu9HObdUacA7PfuWXHVipzBOn/ruLDvGuzdt40Tn015WT3JPPZGmLX7s1TAciRDmqL7g=@vger.kernel.org
X-Gm-Message-State: AFuF++k+RLnNVE4ZFjkZGaUzqDW/3/gEhnZSjV0GEEBAY4SF9bvnkyUT
	Vp1hfmFQj9EFfMBFItVU7vkFDzWcyssKNKOmzLZ9oBN1pz3Sg0qTFwh4NQBPeAEKCxaynL/ldeY
	PDSbFU0aR4v76KbDEaizEHfY/ZebZCUM=
X-Gm-Gg: AYBFou3G+Ts19W67l9Q29n+tBHuTPspGT8iJI2kn2QzQDkYyW/GXGNn10VZ21uggezk
	+wEqhEOCMFeaFZZu2tDws4rNExETo8TKFcrmAk1DfoJxn3hdQbS+wPTHYaIne5tZsGqGSF259pz
	VnZPSPE8+AC2fthseSwK8EUpv9tGwJjRsJoLODhvBS6Lq4fA3VP0ZOaNKIE3xdo+ue7ovohS2eS
	ms78ErIckNqtrbEsZvRgQLpK/t49ETfpZwFzZkhyvCDW3E9pmPo25ioarZyprS/Z4GG7V0QmbNZ
	no/1Mdw9AKE6ahY1oAdWzWW9AdYlQnrC6dJtrEYpbcCeFOIMLmwJD0CrIZs2n54/pDn/K6/Bx/N
	xxgDz1GnwhcPAjFW0j1zk3f3Cnv5chu8bIItnVC0ESwk=
X-Received: by 2002:a05:690c:34c9:b0:886:70a9:3ad2 with SMTP id
 00721157ae682-88d20597e82mr43362677b3.15.1789499792652; Tue, 15 Sep 2026
 12:16:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907172648.457103-1-luiz.dentz@gmail.com> <20260908135708.552fcead@kernel.org>
 <a0e8bc1e-c237-41fb-b448-9594bd484cfe@sirena.org.uk> <CABBYNZKrSve8b=Acj2qu0YBuEZ9u9xHJe-ffRb+78x5KPY8Ntw@mail.gmail.com>
 <d5676b70-f60b-4ce6-b6e6-de564d5c0a29@sirena.org.uk>
In-Reply-To: <d5676b70-f60b-4ce6-b6e6-de564d5c0a29@sirena.org.uk>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 15 Sep 2026 15:16:21 -0400
X-Gm-Features: AcwNN1UsRm7OeWs90ouRy-sgT7iYXR6jPSxvfvxEerVxDP4pW0LdsgBtnpFL-XY
Message-ID: <CABBYNZLKnQsypBR8Kbx4QFL9KfnVXRhO9_d5BHYQCabVZSY34g@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2026-09-07
To: Mark Brown <broonie@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Tue, Sep 15, 2026 at 2:26=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Tue, Sep 15, 2026 at 02:07:39PM -0400, Luiz Augusto von Dentz wrote:
> > On Tue, Sep 15, 2026 at 1:46=E2=80=AFPM Mark Brown <broonie@kernel.org>=
 wrote:
>
> > > FWIW I do keep reporting signoff issues to them:
>
> > >    https://lore.kernel.org/r/aqQARvWlSUQEHMtw@sirena.org.uk
> > >    https://lore.kernel.org/r/ap6Ze-_ckuTFyCMH@sirena.org.uk
> > >    https://lore.kernel.org/r/04d6aba2-bf5c-4e73-8ba2-1fe57218fbd9@sir=
ena.org.uk
>
> > These have been fixed though:
>
> > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-nex=
t.git/commit/?id=3D8d463624a249b6023e1bac6a5ebb0853a9c96d26
> > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-nex=
t.git/commit/?id=3Dbe1cc4fae4cb7d506ad01fa7746db363c41dcb6e
> > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-nex=
t.git/commit/?id=3D9ec9d1ade8ae7a3bd3cc061534d767fe305bedb6
>
> Sure, they do mostly seem to go away eventually but I'm usually sending
> reminders, and apparently at least some of these issues are making it
> into upstream pull requests so it seems the reports weren't acted on.  I
> did ask in the last of those mails if you should be a contact for the
> tree given that you seem to be doing a lot of the updates but never
> heard back on that - should I make that update?
>
> Given the issues caused by the unusual workflow for the tree I do send a
> lot of reports of issues in bluetooth.

Are you referring to the unusual workflow where fixes are merged to
bluetooth-next first, then to bluetooth (which changes its ID), and
finally merge to net? Changing the order to have Bluetooth first and
then bluetooth-next would require reworking the CI so it could
determine that it is a fix and then use Bluetooth as a base just to
avoid ID changes.

--=20
Luiz Augusto von Dentz

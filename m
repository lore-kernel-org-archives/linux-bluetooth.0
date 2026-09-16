Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9374D39023D
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 18:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789582676; cv=pass; b=I28AfYFmpiDVDMYzKnua0oHJitp4cPPFJrl+y/H7rBqbRBoDB5SqKAlonAQQGIEDjE1RcYxqi0Xj2BUCaF6JSZgC/WUUE752LfMDBQerldTORZE5hBTKYXNwgcqUimSbPnKxp6b3hcFd8pKhg348QqssTZwCzeg6l2Hf6n3agRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789582676; c=relaxed/simple;
	bh=71+ixLMzVQbSx7KArl73IkOHZ2xr9fuvCFcSSySVUiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sesNDvGpQE93g0agnutwqR54Bib2D0Txac4hrlSp+BcCO+O+dGHzBOy9s50E07qfYcWHaLUbHTogpMRbXKc760/0eqX5q5+eQxy2S/GAUz5pj6RZ6rqq4mM5LjcxE1Xbc6jtJKJD7h61wP6jPPHlqsGjmDaC1jng+K1CPZy/nds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8GG0cQr; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8GG0cQr"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab22370so1165091d50.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 11:17:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789582666; cv=none;
        d=google.com; s=arc-20260327;
        b=raNjjtBKMxykWcqeYdKzaHCv/ERCCYmPlf8n0y5Vt18PW64danp4lXOk65YzdCBsV8
         aboIKGGGhqUUdYQQp6A5AnFSggSStdRB1PEz+hsmmF/v/9Sh9+pfb7QpRdMH+ozI7BZA
         pTPdvfofCZsMYNALWkPrVo/8rYP5nF0dS98wbqnjMC9KQEL0phWrMc0XQ2vx3zyU9Ewu
         NP7APk+tzbIpZkyznKuvs91hE6aWpeYKC0VNRzgbfrTpWeSjjLA6bdG+bUD29zJfklDe
         hW9GJwc3kr0eRS3jIzR9cD7AXAmTGQeYxPFMNiOGBXO1VE0EVMiDN44lzniO+g0iMA5P
         j1Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=71+ixLMzVQbSx7KArl73IkOHZ2xr9fuvCFcSSySVUiQ=;
        fh=wVUpkwdEsO0mQ2CrMGRxmt8yp5kGK86gsbEB91I1ogs=;
        b=mi3ReoJmGo7ybcoSp5zs0Lf4mH2/VwPGx8YtBDVzD8iRsBDouC5eCnJ1dWUretlB3x
         JLgje6VXi1Uqclm0tmqYPjCoZA4CgpnWpgqPJVrTY2AadMeABUQz7l5zrrvM/vgVWgS/
         h1kPbSMxLi1dsJpqaXMTFVPt+mZGp8DbrvP/bdXqK0souSstSCm5VqseHnYalxkIg3fv
         P3T4D5VngErh8+2hygxUlRwYFDtf/CvCHPL9CWuSGSN4xg+hEmtve1Ugv9HRZXYW9ryS
         H9/mXJ2mD4ARp4TduOAfRbj3l4oa0QcZgF5SbZMKp2ayNlYxM7hUtunQwyj9nWu7hdSL
         FCHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789582666; x=1790187466; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=71+ixLMzVQbSx7KArl73IkOHZ2xr9fuvCFcSSySVUiQ=;
        b=D8GG0cQrXjfdKRm9wNQEsJEWU9oYGeRiTkHhjdpJAYiULFxjgSDjqcLxAojrxz/t3q
         SnQJNKAEML6dAS3xd0evlCPigWfQHo4PmIh9f7+IncDtt/ZD+O+oQBJdyA8iFB6S6C6+
         nOqlqS4Gt1tz7xNY0EkaKkmQTGyglcrcLm9+Da/Y/5e6E7dD8no7EPTtsWvAN6aDErkP
         XQTcwMl3Vn4Akx7nHZ4tv8x7kktx2+E8jDySytkt4cI9WcSxIXf6p9NYjSGsOcJD31j3
         VZKoMmAZfoRSu1lVTw8+7qe0VHdwBBXkgrtoPJMCOE0eZs/p+AnbRI9CNnU8vQha4dlP
         c+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789582666; x=1790187466;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=71+ixLMzVQbSx7KArl73IkOHZ2xr9fuvCFcSSySVUiQ=;
        b=Kyk3Fp9fT2c3MJrPXNv1fh3Gfmo/nZ14jPENoDJJzx9qsL2zHjVRMrrWMBlnKLB8qm
         Y16c1JddkfJPuOZMDrYCOoVa/nA/9Rwg1AQzA0nXFXlroDiOI2zm9q7UkSuxXHWjTd86
         qAvN93YnswOgzmMMNFfJEF+QIIi8FiaQ+YCfwu45Xb7ZV9M78R2pP37TOu82PB/0PN8u
         QdaoNL8rDYdB8gg3XJDgZx+/UzRZtwqHZ02ZVEEbxtnWJHnK1ztgAB4uGLZEgXked0i+
         BPymTqQwy6w0Yd05kDZzxM859vYLjyAfnby2HMVLC0UgNW+PjTtOFhQldJLCa4OGs3Sn
         +u3w==
X-Forwarded-Encrypted: i=1; AKwUvBwHsKw8MAiJGGO1IxyH3z8Lrlw71WbjFmqkmShlrPHo7gPWjycsBZmEH2mZeVblWor+Y8vvH6ILH7zbNLypyQ8=@vger.kernel.org
X-Gm-Message-State: AFuF++k5uuhmaN9buEUpM4fuNSURIBjRGyLnOPi5w5PQoyVQ1rOiA+53
	eOt45gctzk2khsjI15CYt171YELk2OdA0b3etatsNMUEeCO+QxVkea4p4IulfQ5dkvH1UcRUMRR
	cS+mqXgVGajfJyJ6usiqa95aCgeRumIU=
X-Gm-Gg: AYBFou2CabsAiE5JccVMhqgVLdrlc/R1kS1JClzQSwwbzMp4cjytJhh1nCnvjsOyY34
	bFEzIWAjQwSKcUGmd/s4veGkeX5lmgD1dZk8wBkZeW3zdmeT97bKvjeQGDTcRxCSERIA2IUDTX+
	KhrcLp9QZaSecKM/aQu6N3LElpHwZ3CjcVtZQdtyx96/nvrYKZLNcYMxeBZKcu9RQNVEKwpEr07
	SHqb9o3QAa61FcLbnNOVgSHjt3WPudNyPA8jIhGG2ByjRNA4s0Hl/AWpys51tDpGW8RbtPrOhBG
	ndPPq/IMQjYGauqK14XzQep/i/yUXZwza1ZTjSVyuSp/bto9fZhLAbitRg6vZ1tSvzWgYXdeVqX
	aOZA9gN/iRzs7/q74c8ERttGDGQ6zaMymJwKs55UMBBp0hcMx5nvC
X-Received: by 2002:a05:690e:138c:b0:66f:c1be:315d with SMTP id
 956f58d0204a3-67163291a67mr1457852d50.52.1789582666426; Wed, 16 Sep 2026
 11:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907172648.457103-1-luiz.dentz@gmail.com> <20260908135708.552fcead@kernel.org>
 <a0e8bc1e-c237-41fb-b448-9594bd484cfe@sirena.org.uk> <CABBYNZKrSve8b=Acj2qu0YBuEZ9u9xHJe-ffRb+78x5KPY8Ntw@mail.gmail.com>
 <d5676b70-f60b-4ce6-b6e6-de564d5c0a29@sirena.org.uk> <CABBYNZLKnQsypBR8Kbx4QFL9KfnVXRhO9_d5BHYQCabVZSY34g@mail.gmail.com>
 <064ec40d-66bb-4f69-ae1c-65cfed3581b4@sirena.org.uk> <CABBYNZJWcrvkx=6DekHxZzcrGjHwiqmSuwXqzHNV1=7BctThGA@mail.gmail.com>
 <aqnMueXiCztLUn-w@sirena.org.uk> <CABBYNZ+A+bNZ0THj0EZ4KfMj6wPMhD6hvbt5FP-exZnqxb4E-Q@mail.gmail.com>
 <6ce3c671-12e3-4057-9610-23efe14832cf@sirena.org.uk>
In-Reply-To: <6ce3c671-12e3-4057-9610-23efe14832cf@sirena.org.uk>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 16 Sep 2026 14:17:35 -0400
X-Gm-Features: AcwNN1W_n_JWDmPObAQFwyQQcqcRS0ohE6q1zHG-qJ_cbD4eagEDvwjzvohFxRo
Message-ID: <CABBYNZKiy+t_GC9dL6nraiH26m+2U=kuAF8NMAPNW-BhtOSovA@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2026-09-07
To: Mark Brown <broonie@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Wed, Sep 16, 2026 at 2:15=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Wed, Sep 16, 2026 at 02:12:28PM -0400, Luiz Augusto von Dentz wrote:
>
> > I incorporate the merge back into my workflow:
>
> > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-nex=
t.git/commit/?id=3D967788508ba263e22d856f971c9118dc1a73f6ff
>
> > Hopefully this should stop showing conflicting/duplicate IDs at your en=
d.
>
> Thanks!
>
> > Yep, you can add me as a contact person for both the bluetooth and
> > bluetooth-next trees.
>
> With your luiz.dentz@gmail.com address?

Yes.

--=20
Luiz Augusto von Dentz

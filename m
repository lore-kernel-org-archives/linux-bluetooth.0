Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72894949E4
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780592040; cv=pass; b=BFo5TxFYNPW+czaCJEiOJEYbf1A5Ka0t0kVn4brhUAKbx3NtYk1Cj/KtKRszfY9uATqmT4o1npwcAJt/uBkPM8SH9aCFq3M4pV+A+jH9HfthIeNb/VjJ1194IGrfUm2qyN6eiRDjVUdfDNupFjVpzES6SAE7SSZQVIVXztusc4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780592040; c=relaxed/simple;
	bh=D/uwye06QrRIKv3cNu0SbRX4VabFTiVs435F5iIUNPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8xKjBZofxZ9iS4INaNmdw9k7Wk6eDwNVZFjnlxbV/UqEbmP6YF5b/xNHwt9XmWvGY3zCZRrEychtBvs/9b6D6dvybB7rhxbQEjzdwUQriWYTjBX2I5B9KQTyi5ryf2nqGO7xbEghMfCaFo3eYVN26So7pseUBYGtZtKQCthj/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHhqm5aE; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHhqm5aE"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-660390a8999so1130781d50.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jun 2026 09:53:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780592038; cv=none;
        d=google.com; s=arc-20240605;
        b=K7XH/6xAfRD9lM5Lmuqud72XLqPMWivE+B5oG3lmCSkYuK6OkKrsvA+qivfF5cJ7B+
         jhEa0xO9uxRUqRWInJ9vbxgU/qkM8/9WIUKHasszUE7lGjn9r3S+v13mDdkr86E1CbqM
         JQ1mk4QjNkurQ5URZGL7Xfqg8gcX6tnI2hxyrB/O7/Q2DURR5MVpYu4ZGDTNsGMV2cee
         QnL7rPJllZZMbItWx3v2IsT+tpzsrNoMgntz96S+E5K61EqJBiJUVPsmb+WocqCo04cB
         J8uLjCFFFaIRKp2DvldHZ19NhSVFDaoDTs8g3AV7Je9KjqAbHBsT4TlMMhepB7Adqqcn
         VUOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JZKm2djLj5jJXGRjBnfbVWIi/VTaPpCEDJ59838Qg08=;
        fh=ene6wgnat2kPdhn9+TRiGOEhq/8uTVFt1KuGZIXVi1s=;
        b=RVQGzrwfU3PArntsVgIPDkV1NwMYcoiO1o5EMbECvRDrPcUxRQuHRauKGZ8AACirQw
         zjdyUxw5N2cWqz6+fKRNSwYU45mbwADe1/JHkLfHl9IhgVRjqOOCv48e9MdDVoMu6861
         w/gUwRXbAniia+8hlOVq8hqTFtHjQl2YOMQhGK2uZ3QvpriEDb9mtRU3TFi0KRQccz7I
         asabywk1nCy4EHGHin55ovN/CXOXZzp+TB/y9qvgAJpgxCQkqvl3rnx8hgRMBxey2Bek
         ougZ+VwbbJAgmWDQf5KK8ptQRAiypX0Lbgi2VSraHS1cDu/BXu0geQ4xRr1AAo9xbWuJ
         t9og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780592038; x=1781196838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZKm2djLj5jJXGRjBnfbVWIi/VTaPpCEDJ59838Qg08=;
        b=XHhqm5aEfab5qmgA3/fnxPs/O9IWuXnZbpZe+crhi73yosLaYCe9mA9AfbAvDZoF+4
         psDk+jlq12wkEh8yaG6hzhzaUWeyN6WdDLtP4jqcfmTvJXyRksXuQxnuktevGVjly1cY
         +bhVUU9cpmMbIoVbIE6EqRFoGXCZRmHLtO3cNvFxd/BdIcHBImOKcGyJpQrjqANS1af+
         ol7xDZFjbYh97kP8HMCbmx8J2bkwGF7suQiLzxO+kIP1JBkb7qVQwEgNNI1iAB/zaXFA
         xIDSfnJhpXoEssKkFY3Rgw+tOWDuS2cd7Sz3yWN4f3/rDtAVqFmhWylGM3pCu0HcYopD
         NCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780592038; x=1781196838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JZKm2djLj5jJXGRjBnfbVWIi/VTaPpCEDJ59838Qg08=;
        b=GcalFeUgWNcDVFL+JpvJma66eEV/RO15ytHrs9Iy/EGDYXuIBwh65gspQQSx6+VLiI
         5xtfcbHaDipveKqMdLgJsmMZaEJZgu0CG/Q+o4N69ydP+D9Ds22R3lw9UG4wmiJMKcfR
         /a6sCRr1pDQ6jV5g+Hzjb9zrTJONyPAtw3kHg8trH8JXGc81speetH1u9Dht1Hsmyz6F
         CeveRu+rKyta8zaA6vJa7UG6Tv0q8yVdS1PaEJR2I7oWcxhiUjJf0cyF06pD1LSk8ON7
         qwI3VMme7z+j3y/t6ViM7XaCfiWMcHinXc+EZ290YFMBZ6qAuecMHDOh5jXjpE1y+UdC
         oveg==
X-Forwarded-Encrypted: i=1; AFNElJ/Vu+Wn2BwVonOEKQBo7dTolKOEZkYf6B8AmDGv0bsoHdgFadNmp78+w+iq5qqY8Z5vhgXuW35R93nXvZaOOKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS+ecsRcjEWMj7aChoTRkW0Lrr1TJz6oOHPttiqn4LvnXB/No7
	qG4m9tkoyXZICtM9LFe/VFKxLnnxVn6tt2ZpvaXSi8MLrraaXJaUl/RgWEeh1B8dNRtwr9twIHj
	+Vq6wODXxP2wg/aCKfFdzzoSa3J7cbjM=
X-Gm-Gg: Acq92OHuOS7z6TQL/Nsv5QZrXrwalhTH6BopabQLDHWZqc+L8vzpbOYrPNvS5vpF78g
	3PGPAKY9jIXKBNsmRWgCbyFYKBqsBkyVYf0Y0K6Xy2Ch0pPWi5F86PDIy5NL6SHD+HhEx4crlk2
	dLtqeMrWnTB/DoMTMRABqbwXwXrhKbcAhysaPm+ZIy/4SOYRS2+XqSZPDF/FFcSVaaw5Jzvbnb/
	vDgpZmMl+jMcwxq1iQ8pZmETnjJiPnKpxTFErPh1Q8ITwD+Afo92fRuTYvmFKtpRQbQynwUR9D7
	Q/vtVjTqnhbBre2FqIqBksqwjRX/f2h8xBuLYRGSykv1ahXEWlAGHqsLqV+V2kONw4r0Ph1pinO
	cg5l7
X-Received: by 2002:a05:690e:4847:b0:654:1261:8b3f with SMTP id
 956f58d0204a3-660dbe73c0bmr5455216d50.16.1780592037755; Thu, 04 Jun 2026
 09:53:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604004125.715884-1-tim.bird@sony.com> <CABBYNZ+j8M4LrG1V0ESrtG3sWR4vgstHGjQQauekBFf3B7DD6w@mail.gmail.com>
 <MW5PR13MB56328C7D133CCC8C584CAE27FD102@MW5PR13MB5632.namprd13.prod.outlook.com>
In-Reply-To: <MW5PR13MB56328C7D133CCC8C584CAE27FD102@MW5PR13MB5632.namprd13.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 4 Jun 2026 12:53:45 -0400
X-Gm-Features: AVHnY4J1ESN5FOXtmCjg0ViWCo2_UVXkexDG5DS5Tczyehay_u8__9w8YnoeRoc
Message-ID: <CABBYNZKv=+atEF6Ko6Zs=uc+KtK+4xq2Ak_Re4H8jA45gkwtdA@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Add SPDX id lines to some source files
To: "Bird, Tim" <Tim.Bird@sony.com>
Cc: "marcel@holtmann.org" <marcel@holtmann.org>, "jannh@google.com" <jannh@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "kiran.k@intel.com" <kiran.k@intel.com>, 
	"chharry@chromium.org" <chharry@chromium.org>, "gustavo@padovan.org" <gustavo@padovan.org>, 
	"prameela.j04cs@gmail.com" <prameela.j04cs@gmail.com>, 
	"salvatore.benedetto@intel.com" <salvatore.benedetto@intel.com>, "maxk@qualcomm.com" <maxk@qualcomm.com>, 
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On Thu, Jun 4, 2026 at 12:41=E2=80=AFPM Bird, Tim <Tim.Bird@sony.com> wrote=
:
>
>
>
> > -----Original Message-----
> > From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > Hi Tim,
> >
> > On Wed, Jun 3, 2026 at 8:44=E2=80=AFPM Tim Bird <tim.bird@sony.com> wro=
te:
> > >
> > > Many bluetooth source files are missing SPDX-License-Identifier
> > > lines. Add appropriate IDs to these files, and remove other
> > > license lines from the headers.
> > >
> > > Leave the warranty disclaimer in files where the license ID is
> > > GPL-2.0 but the wording of the disclaimer is slightly different
> > > from that of the GPL v2 disclaimer.
> > >
> > > It is not different enough to cause licensing conflicts, but is
> > > kept to honor the original contributors' legal intent.
> > >
> > > ---
> > > V1 -> V2:
> > >  - Leave different warranty disclaimers (which is most them)
> > >  - Remove files recently removed from drivers/bluetooth from the patc=
h
> > >
> > > Signed-off-by: Tim Bird <tim.bird@sony.com>
> >
> > `git am` doesn't pick up your Signed-off-by because it is after ---`,
> > it seems to be considered a comment.
>
> Ah crud!!  What a dumb mistake on my part.
> Thanks for the heads up.
>
> Should I send a v3 to fix this?

I can readd it manually if you are not planning a v3 to address other comme=
nts.

--=20
Luiz Augusto von Dentz

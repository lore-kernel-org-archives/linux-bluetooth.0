Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946472071FE
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Oct 2024 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730211311; cv=none; b=nsFzylVwAPe+mITRjrOZi+xBmNZz12u+7UqmUQ8gMN1wMYo3AJGA0VtkP0J6blnwhNqLmN39MTG+WrnyRc5F3RfiFJ0xd6cmZJ6ho9uy2OQ6J2Rdmv3zfNUBOvkB7TTjK0SqG6IHIeziJiQVPX6KfDoUS3Lr0Yut5pKRx42jXVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730211311; c=relaxed/simple;
	bh=fPHqiDse51RgOJB30ww6gUS3FI9MgL2pSVQidDBmcEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=omM9x4o+yJWA8MGs0bQWWyGdzXsk2o76TRJtdazuddFl1GJOBv9cPumxBBNC3ucBGmP9WWI71swVJh/tiwQxUQPT5M35V5Y0n9AzyT2Zec7fGQG7di/CdPze0jJ8Kbw++plnp8ScV7mkmJz3L0Bne8+14Ah2eKsmVgYhQ6hRmPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAGJiM7l; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAGJiM7l"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539d9fffea1so5151872e87.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Oct 2024 07:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730211308; x=1730816108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVfbXQXGo2t5uccFxcoHFhW21XCaxdghUFx82cNE3Jw=;
        b=HAGJiM7lbs3oOnQgYzNkz7w3GjPsQ/9cZqs8jXbBtujCLw/1DzfFR4xoGNJNIIUG7D
         gUn29+JBQ+gwmaPQN+GlyCySdcewYM8ZrbkRcpkRLd2HA5A+iVdQal9IwkqcCnR5udNa
         I2Qd6hDROeKX+sFd/S8aBTfvq0CbamFoM66Hoo4fzCjwt1Kh4vVBSngcXxvTSKR6B8p9
         xviH4YNgoMZGA7TOqTnVby5sJf+muwfJ2k9pz/+rRuvNZIRR2Nl2JAEsHvgmnxlZgzi1
         PSaqaQ3f118Cyb6Vrb6xPU0vpwLXBLDkZX3dIMRMKoV0vkKt6pSfRdfRLvx2KnwRCBG8
         54QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730211308; x=1730816108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVfbXQXGo2t5uccFxcoHFhW21XCaxdghUFx82cNE3Jw=;
        b=iYa1ZMfCpuGzSk1d3XjGihr3sKa9l6pmN3DC6QZpTXj5t2wm/j3zkovi365r5ur+00
         rGS8KPblB8JjljzwJ6j6SMtGl4cMRKq8b0FiRzTr07qRlJhq/8EC3RkAgI9CWjIhNLLF
         rs1LztW5cB4OwGONCrBc++RpdIZzUMyjdNgNPnPHrY33Y7OyYRbVUG5kFx7Ym+dE+CJs
         JmsXh3GpAjy/MhsHrK8Vkk9xMPTar5LhwYXIeTOynrmo+TgzjD1sbpzJ+zBI/RZPTsT4
         WHupBQop+ss5kDe6MrhRiFBu/d8o2Dmm8VeT1nDpxgn5/2DvTxtkKuMGwWvP9LYpFFeI
         B4BA==
X-Gm-Message-State: AOJu0YyBgyatI4E7Axy8i7NZNZaE48TLuYw+AZ5XQK8jzeuDOf9FqwjW
	KHPRk0IBYQLb0nxvF2TpNJntVfTiE/qGqe8NbeS/5rCS8aRJZ7T6rO0/LkN/460s/lKSWyEgnGh
	Q9syctTs+I6pPJUOOcFYwW5lJ7VwzYZ1S
X-Google-Smtp-Source: AGHT+IF++L0Co6x8wtnVoPBuC0V2IBH7jg1RZdj7ThfNx/4BbXCTs64elWOkI8T7HB+1sdF8ySQZ3syT5VBtArGIvME=
X-Received: by 2002:a2e:a552:0:b0:2f7:7d69:cb5d with SMTP id
 38308e7fff4ca-2fcbddf6f52mr61845431fa.0.1730211307438; Tue, 29 Oct 2024
 07:15:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028105326.3159618-1-quic_amisjain@quicinc.com>
 <CABBYNZKj+pr5yLmrOEcDH9LCDBpvaq0XeBuN8nDzB1SnkNbY-Q@mail.gmail.com> <bb86f6f947174e85813b225d8a51f101@quicinc.com>
In-Reply-To: <bb86f6f947174e85813b225d8a51f101@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 29 Oct 2024 10:14:54 -0400
Message-ID: <CABBYNZ+TQp8FOcvOYzEjRTcvFh0ijTOf6qMnN3cFEc1TG25g6A@mail.gmail.com>
Subject: Re: [PATCH v1] obex : Fix for PBAP GET request in PTS testing
To: "Amisha Jain (QUIC)" <quic_amisjain@quicinc.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"Mohammed Sameer Mulla (QUIC)" <quic_mohamull@quicinc.com>, "Harish Bandi (QUIC)" <quic_hbandi@quicinc.com>, 
	"Anubhav Gupta (QUIC)" <quic_anubhavg@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Amisha,

On Tue, Oct 29, 2024 at 7:59=E2=80=AFAM Amisha Jain (QUIC)
<quic_amisjain@quicinc.com> wrote:
>
> Hi Luiz,
> The default param added here is corresponding to 'MaxlistCount' attribute=
 (tag id - 0x04) which should be 65535 if it is not specified by client as =
per the PBAP spec. The value 65535 means that the number of entries is not =
restricted.
> Here is the explanation of application parameter header -
> default_apparams[] =3D { 0x04, 0x02, 0xff, 0xff }
>
>       0x04 - Tag id (for MaxlistCount)
>       0x02 - length
>       next 2 bytes are value - 0xffff

Let's have it as comments of this code, preferably quoting the spec
text directly including the section and page.

> Thanks,
> Amisha
>
> > -----Original Message-----
> > From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > Sent: Monday, October 28, 2024 7:57 PM
> > To: Amisha Jain (QUIC) <quic_amisjain@quicinc.com>
> > Cc: linux-bluetooth@vger.kernel.org; Mohammed Sameer Mulla (QUIC)
> > <quic_mohamull@quicinc.com>; Harish Bandi (QUIC)
> > <quic_hbandi@quicinc.com>; Anubhav Gupta (QUIC)
> > <quic_anubhavg@quicinc.com>
> > Subject: Re: [PATCH v1] obex : Fix for PBAP GET request in PTS testing
> >
> > WARNING: This email originated from outside of Qualcomm. Please be wary
> > of any links or attachments, and do not enable macros.
> >
> > Hi Amisha,
> >
> > On Mon, Oct 28, 2024 at 7:10=E2=80=AFAM Amisha Jain <quic_amisjain@quic=
inc.com>
> > wrote:
> > >
> > > This change is required for passing below PTS testcases - 1.
> > > PBAP/PSE/PBD/BV-02-C 2. PBAP/PSE/PBD/BV-03-C 3. PBAP/PSE/PBD/BI-01-C
> > > 4. PBAP/PSE/PBD/BV-13-C 5. PBAP/PSE/PBD/BV-14-C 6.
> > > PBAP/PSE/PBD/BV-17-C
> > >
> > > For all the GET phonebook request sent by PTS has no extra params
> > > added in it, therefore PBAP server is rejecting the request by sendin=
g
> > > 'Bad Request' as response.
> > > So appending few default params in GET request to avoid testcase
> > > failure.
> > >
> > > ---
> > >  obexd/plugins/pbap.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c index
> > > 4175f9de8..3c23815ba 100644
> > > --- a/obexd/plugins/pbap.c
> > > +++ b/obexd/plugins/pbap.c
> > > @@ -524,6 +524,11 @@ static int pbap_get(struct obex_session *os, voi=
d
> > *user_data)
> > >                 };
> > >                 buffer =3D default_apparams;
> > >                 rsize =3D sizeof(default_apparams);
> > > +       } else if (!rsize && g_ascii_strcasecmp(type, PHONEBOOK_TYPE)
> > > + =3D=3D 0) {
> >
> > Hmm, where do these values come from though? Are they defined in the
> > PBAP spec, if they are then we can probably quote the spec.
> >
> > > +               static const uint8_t default_apparams[] =3D {
> > > +                       0x04, 0x02, 0xff, 0xff };
> > > +               buffer =3D default_apparams;
> > > +               rsize =3D sizeof(default_apparams);
> > >         }
> > >
> > >         params =3D parse_aparam(buffer, rsize);
> > > --
> > > 2.34.1
> > >
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

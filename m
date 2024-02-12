Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A81A290A
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 08:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707726657; cv=pass; b=SNL2kHaP7D4W7mf+z3Mbx2BrEuQESiKP6wVbePQ0vpvwLbpZIMvOObf79x1M7x00IyTUzVz5JZqzHTREozJvYKAffzR4w2Yk2G0TZOkTTO9ibPKNVXBv45Q7oWSt3NinopLucIrRAci7XCo4wSUQZkrgAi4RyShLar3WLdhwv8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707726657; c=relaxed/simple;
	bh=EI+gL1Y6g3M4Uls0RQio6Wc/pgodEzXi5Zpz1vAlusA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=o4cupHlkQOeD08I++vYPluujageTWlp0fTedd8yfsLoDzEhDnuHhflB9boFQIhQWR0VuLdig+o4ZzUS4NzT8GNWfMMba3xpwcQJc146cwF1stjjBJTu7wHEIr9WUTxB9sjwX7IlykuLjVKUEAvf29TlQpoNpHGpfrs+0BI7AI4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lab.zgora.pl; spf=pass smtp.mailfrom=lab.zgora.pl; dkim=pass (2048-bit key) header.d=lab.zgora.pl header.i=mk@lab.zgora.pl header.b=O7DuczVK; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lab.zgora.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lab.zgora.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lab.zgora.pl header.i=mk@lab.zgora.pl header.b="O7DuczVK"
ARC-Seal: i=1; a=rsa-sha256; t=1707726651; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eqBrMm/KfAyaMDNy0b6N77bZ+ERTJTf38NfCHJrZDfGrOCTza4CbVylr41WfNtNVN5ZrHlZgvMIXIS7JlFh1mDbfKV47tQ5026Ym3wRs/ZBlq14UV/I/v0NFysiTwx+E1UBUUUiX5jJO0CpK9Rxc/aVlNzLXFgXJ0UArWb7Azyk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1707726651; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fN+P7JsAZjaMMCmQb10e+qiVBETjnx1sc2HEOsazf5g=; 
	b=WLJcumao7/4l1yL+YTMggFGqOCYeU3EPaNOZsjmDXZIznIuusY6l2gCM3hXh6Vygf3JB/zK+2tWfqsoI8EKWPBb1dneedFnprTBUlK9ZcMkl/36o/DAHWSVJc+Brx08r7rMXICxxxNf8BmrMf03YBk1v/iJa8w1iaWEh4gsHDAM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=lab.zgora.pl;
	spf=pass  smtp.mailfrom=mk@lab.zgora.pl;
	dmarc=pass header.from=<mk@lab.zgora.pl>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1707726651;
	s=mail; d=lab.zgora.pl; i=mk@lab.zgora.pl;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=fN+P7JsAZjaMMCmQb10e+qiVBETjnx1sc2HEOsazf5g=;
	b=O7DuczVKiPtIjPxz+vuQqJ4uoKr65bdczYj1oLywycw1Z6tuHKELawobl0NOlg2z
	73Oqz2Zw2RS4PY7FaAuyEe+GlaptwvecG/5iximcT1jfADbAyg7AJZbG7469SVvdQcF
	bDmSm5jXgWd2c6tIZwOKn2h70DqWuY4RM5pJ8gaDFhxYOrhRBU+RG6idBvloytKxYgI
	3X5Wl7e/6UiqTMJPOja0GzSrUVQZcF4/lsIIpMph5V87GJ4X/zVOnx1inT4dAIiij49
	fLax2II8qiY7trO3T+pmIvoSTngGcMSKCgbeYuTXhPsLEREgj1FZB1to66eUKTAJIaJ
	z3ZoIPKl2Q==
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1707726647991871.2086403775431; Mon, 12 Feb 2024 00:30:47 -0800 (PST)
Date: Mon, 12 Feb 2024 09:30:47 +0100
From: Mariusz Kozlowski <mk@lab.zgora.pl>
To: "Mariusz Kozlowski" <mk@lab.zgora.pl>
Cc: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
	"linux-bluetooth" <linux-bluetooth@vger.kernel.org>
Message-ID: <18d9c70b2a0.d3e08593351442.8477048035206577660@lab.zgora.pl>
In-Reply-To: <18d356110eb.1120f313b408792.7694888926917426249@lab.zgora.pl>
References: <20240121100328.1200839-1-mk@lab.zgora.pl> <CABBYNZKW8odyLb_BQcXXpjAKjPzHRhXVCbxvcg54VkoeULeHnw@mail.gmail.com> <18d356110eb.1120f313b408792.7694888926917426249@lab.zgora.pl>
Subject: Re: [PATCH BlueZ] btmon-logger: Fix stack corruption
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Luiz,

---- On Tue, 23 Jan 2024 09:12:50 +0100 Mariusz Kozlowski  wrote ---

 > Hi Luiz,=20
 > =20
 >  > Hi Mariusz,=20
 >  >=20
 >  > On Sun, Jan 21, 2024 at 5:04=E2=80=AFAM Mariusz Koz=C5=82owski mk@lab=
.zgora.pl> wrote:=20
 >  > >=20
 >  > > Version 3 capability masks are 64 bits in size.=20
 >  > > ---=20
 >  > >  tools/btmon-logger.c | 12 ++++++------=20
 >  > >  1 file changed, 6 insertions(+), 6 deletions(-)=20
 >  > >=20
 >  > > diff --git a/tools/btmon-logger.c b/tools/btmon-logger.c=20
 >  > > index a770ad575..1f6db3751 100644=20
 >  > > --- a/tools/btmon-logger.c=20
 >  > > +++ b/tools/btmon-logger.c=20
 >  > > @@ -161,14 +161,14 @@ extern int capset(struct __user_cap_header_st=
ruct *header,=20
 >  > >  static void drop_capabilities(void)=20
 >  > >  {=20
 >  > >         struct __user_cap_header_struct header;=20
 >  > > -       struct __user_cap_data_struct cap;=20
 >  > > +       struct __user_cap_data_struct cap[_LINUX_CAPABILITY_U32S_3]=
;=20
 >  >=20
 >  > Ok, but this doesn't change the field, it makes it an array, or are=
=20
 >  > you talking about the following note:=20
 >  >=20
 >  > Note that 64-bit capabilities use datap[0] and datap[1], whereas=20
 >  > 32-bit capabilities use only datap[0].=20
 >  >=20
 >  > In that case Ive just pointed out to this note to explain why this is=
 needed.=20
 > =20
 > For version 3 caps (64 bit masks) a single struct __user_cap_data_struct=
 is not=20
 > big enough and capget() writes past the end of cap structure on the stac=
k. To=20
 > accomodate version 3 cap masks the cap structure needs to be 2x bigger.=
=20
=20
What is the status of this patch? I don't see it either accepted or rejecte=
d.

 >  > >         unsigned int mask;=20
 >  > >         int err;=20
 >  > >=20
 >  > >         header.version =3D _LINUX_CAPABILITY_VERSION_3;=20
 >  > >         header.pid =3D 0;=20
 >  > >=20
 >  > > -       err =3D capget(&header, &cap);=20
 >  > > +       err =3D capget(&header, cap);=20
 >  > >         if (err) {=20
 >  > >                 perror("Unable to get current capabilities");=20
 >  > >                 return;=20
 >  > > @@ -177,11 +177,11 @@ static void drop_capabilities(void)=20
 >  > >         /* not needed anymore since monitor socket is already open =
*/=20
 >  > >         mask =3D ~CAP_TO_MASK(CAP_NET_RAW);=20
 >  > >=20
 >  > > -       cap.effective &=3D mask;=20
 >  > > -       cap.permitted &=3D mask;=20
 >  > > -       cap.inheritable &=3D mask;=20
 >  > > +       cap[0].effective &=3D mask;=20
 >  > > +       cap[0].permitted &=3D mask;=20
 >  > > +       cap[0].inheritable &=3D mask;=20
 >  > >=20
 >  > > -       err =3D capset(&header, &cap);=20
 >  > > +       err =3D capset(&header, cap);=20
 >  > >         if (err)=20
 >  > >                 perror("Failed to set capabilities");=20
 >  > >  }=20

Thanks,
Mariusz


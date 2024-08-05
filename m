Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4E7155743
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Aug 2024 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722872264; cv=none; b=oqMtljvfzkU14/TgH2whYJzgopJ8G1H7IbXKqFHVS1PfUxw+UkaZ/K1jS/pfF7r19UoezKN5TId5rv6oeNnfoUCbG8bLrnA9EdKMcHX3YwZEYuocMz5dbBRKMQ+wzuE6V3fi0rkctGZnjWWw2yNpevqCBcfBVx2QOIx4S4u3gBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722872264; c=relaxed/simple;
	bh=vPqT1LsRUhzdz5tX8Igt01zDoqgjDD7BT4lQOT5a82M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0R7riPyOY03zxHZJ/A6UTGmAXNRMzjO0lASUvy+JoJzfGVSffw5zzlR96HfNelVz08/jEe2iXSdH4qgLRqNr861CJlyeBVXuVpLNca7IwyLeMb0qPx9H8kZpNRx83lbozF3mNgVhoROGipVprrTBkVUOTemjjb6XAC/5gPBv+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ja0RR2HY; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ja0RR2HY"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso158449531fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Aug 2024 08:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722872261; x=1723477061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPqT1LsRUhzdz5tX8Igt01zDoqgjDD7BT4lQOT5a82M=;
        b=ja0RR2HYlGLQRVJobY4FQzMCiaAA/f4rR35yi+dIQWtDoYGElLe9p63b/FpJmL8I+t
         W0kgqc6sJ776BN17bYVAYIRkm+CrJ6YnauIka5cLjYyLj2lPU3VnoKUnhW5B1zEpckgv
         imHirghZiciMO1xkL/Lejp9kdctrkmi5PTU4NfPCN7aqH+eBgx6Bq0VS748p1spTvUAE
         fkJf7n2hUbPongdq+7TYKo5v0MvDM20rB8aerrUFIXNXGRdX8S1WQjxJmoVlRZ891vSN
         Q7a8lplTSiNTFNgLuuIMSy+rwl8pLfpxlJFNuNZdf+qtarQrar/AbRnK7WcBAA/xxTCC
         27/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722872261; x=1723477061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPqT1LsRUhzdz5tX8Igt01zDoqgjDD7BT4lQOT5a82M=;
        b=utWYdQutkimBmHdBpYnFHkIF1x6bzQ8Z0fm2TQhOAsqC9PFBa4VTWwkNSmOh7JqURq
         HAUhXzjS8ObXzowwB69DtO2UnDNUEfJ93KatP7n2x+qLlg/nX92tZR8xFOXeuDdzObf6
         Wm9MkpegqkOqfsHpZsHaO3vAJH+wbbVp6fHP/4/5nTRHmvXmrxMsKxCtS5Wn+LbGkIhT
         HKnJ4rfhQAShcGfXkz16OeKmV1vLBoXMbhh9FGFj5N3sU2YY84CZETA8lTKZnz1dz2HH
         otBsDlRnN+bYlehIOrHDP6IES713MrnQvl9u4LfyfWZeIr2Ijmvmim/2dbx5uajqm2cv
         FnNQ==
X-Gm-Message-State: AOJu0Yz/DrlId3a4Wp/RlKNeVLL5+HTVeYRP8FodABZT8z99HtLe1JyL
	Z59cEZ9WFxc+mSWduCKJGlLA/39ST5D0udN2agu0n3UUUc557MjRc+UYzcks6nvxYhLKdlgNYbL
	l4CpQN6fERTUVINsxLrjUpsChvG21oGvt
X-Google-Smtp-Source: AGHT+IH7Tv7powp4HokKk1mED76g8qQY4px9oLJUIkFVDmrfWgVv0lODup2hdLBBkgK6XEqTgalgAmgZ3XqylKJOrrA=
X-Received: by 2002:a2e:9b03:0:b0:2ef:2422:dc21 with SMTP id
 38308e7fff4ca-2f15ab5cd3amr94552901fa.43.1722872260613; Mon, 05 Aug 2024
 08:37:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <GVXPR02MB8256E67B738C97EC57D1FA0F9CBE2@GVXPR02MB8256.eurprd02.prod.outlook.com>
 <CABBYNZ+HwmhFhUZsSnhW1KU-cXQhHKGt3xJeCX1sxt6xyBBnHw@mail.gmail.com>
 <CABBYNZLCDU+vQFzdYKoUCKvuWMGUPbjxoHJYCVsE3J1=1i3iww@mail.gmail.com> <GVXPR02MB8256A0C28CB1DECA4A299D679CBE2@GVXPR02MB8256.eurprd02.prod.outlook.com>
In-Reply-To: <GVXPR02MB8256A0C28CB1DECA4A299D679CBE2@GVXPR02MB8256.eurprd02.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 5 Aug 2024 11:37:27 -0400
Message-ID: <CABBYNZJo1mgSF6dyq8XdjK9dtQCRTj7xcgH6ED7m6TrPBtX=vQ@mail.gmail.com>
Subject: Re: GATT characteristic for only LE or BR/EDR
To: Alexander Ganslandt <Alexander.Ganslandt@axis.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On Mon, Aug 5, 2024 at 11:21=E2=80=AFAM Alexander Ganslandt
<Alexander.Ganslandt@axis.com> wrote:
>
> Hi Luiz,
>
> On Mon, Aug 5, 2024 at 15:12 Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > Hi Alexander,
> >
> > On Mon, Aug 5, 2024 at 9:04=E2=80=AFAM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Alexander,
> > >
> > > On Mon, Aug 5, 2024 at 8:31=E2=80=AFAM Alexander Ganslandt
> > > <Alexander.Ganslandt@axis.com> wrote:
> > > >
> > > > Hello!
> > > >
> > > > I found a previous discussion about this here: https://lore.kernel.=
org/all/59CDEBDF.3090200@digi.com/t/, but there was no conclusion. Now I'm =
having the same issue 7 years later :)
> > > >
> > > > I'm trying to pass BT SIG tests but fail on two test cases: GATT/SR=
/GAR/BI-34-C and GATT/SR/GAR/BI-35-C. To my understanding, in order to pass=
 these tests, you need to register a GATT characteristic that is readable o=
nly through LE or BR/EDR, but not both at the same time. However, when I re=
gister a service+characteristic through bluetoothctl, it is automatically r=
egistered for both LE and BR/EDR. To verify this, I use gatttool with and w=
ithout "-p 31" to connect over BR/EDR and LE respectively, and the characte=
ristic shows up in both. Based on the previous discussion, and based on rea=
ding the BlueZ API, there doesn't seem to be a way to only support ONE tran=
sport for a characteristic? Is this conclusion correct?
> > >
> > > You can detect what bearer it is connected via:
> > >
> > > bluez/doc/org.bluez.GattCharacteristic.rst at master =C2=B7 bluez/blu=
ez =C2=B7 GitHub
> > >
> > > Looks like we are missing one of the options is link which can be
> > > either LE or BR/EDR:
> > >
> > > bluez/src/gatt-database.c at master =C2=B7 bluez/bluez =C2=B7 GitHub
> >
> > Here is the commit that added support for it which specifically targets=
 BI-34-C:
> >
> > gatt: Add implementation of link option =C2=B7 bluez/bluez@e577e47 =C2=
=B7 GitHub
> >
>
> Many thanks for the info! If I understand this correctly, is the idea to =
implement a custom GATT server with two characteristics, where you check li=
nk_type in ReadValue to only allow BR/EDR for one of the characteristics, a=
nd LE for the other? And if the wrong transport is used you respond with th=
e error the test expects?

Yeah, we could perhaps add support for something like that into
bluetoothctl directly so we could have a script registering the
attributes and then responding based on the link type.

> If so, I will try doing this and report back the result if it passes the =
tests, just for future reference to other poor people that run into this is=
sue :)

Yeah, btw you might be interested in the following discussion as well
if you are actually planning on qualifying BlueZ:

https://github.com/orgs/bluez/discussions/817

> > > > If so, how can one pass these BT SIG tests? In the previous thread =
I linked, the "solution" seemed to be to write an application that simply r=
ejects the read request for a certain transport, but this seems like more o=
f a hack than a solution to me. Is there any other solution?
> > > >
> > > > Very thankful for any thoughts!
> > > >
> > > > Best regards,
> > > > Alexander
> > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
> >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
> BR,
> Alexander



--=20
Luiz Augusto von Dentz

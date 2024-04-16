Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD16D12CD91
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277150; cv=none; b=Ga0PcfwLVvUfIPvk98L8A4dUbkzUqNssh0U28VkizvrygGV0EPdWAdXcjcGABINGHyuLZoyJ1/q1jJY9pw8qEb7vbA3bhQZt4q5QZNw7sS/A20WADr7QZwVYGo2afvSKNg45QP9zyoQzIoGPKo7QqnmGpA4AW9gfTwlilIwpOi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277150; c=relaxed/simple;
	bh=1FBNTL5fUpeM2HLSZTmpUVEwkVR5jSE8R/qx8PoWLlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hX5shE2P/4hxHtWrio7kwxBfLvgibJIsdbih9JIaGJu98FqIxgj1lVhWOnSpk7NbmuEo5zBX+8w9TpRoqmlaxQAWEUcVjirRYz3W4pWBpDQ4l81A5+YxBp2Lf0efm98o0yZNjNr5LdODwM6wD+zV5hTTE5ICsCbU0aXktcKk43E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpbZMWMe; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpbZMWMe"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2dac77cdf43so15442541fa.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 07:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713277144; x=1713881944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiEihCupVgpva7ZjRACXxPhOWCHQAzXeeOX7FJDM+SE=;
        b=mpbZMWMe7IZh4fD0xlnz5VUmtIoeAdZELZiYb0nMEoG+Anu6NnEewIOT1VjiD5mONx
         KQ/mhaHQ6hWy4vsMUOmOoqlOIFIB0v0H84FGje9ZqPDtSdQlqPxtrO8ftZ9e8k6vYIP4
         7n/ja0R+LVgGwbhbQFDLNj1p11ndYvh1Q/QwkwN4HQUEK6hz+rWUyaw7ZD1/rXiV0SBc
         WieA/2efYj47pUCBymkHbS44fp6dyuOS2q9Qrb7l/c6oW7TSiYMy+sZ+seOXup+eNCuq
         FMAmh0KU1pDb98jdz9BlLOxRr7M1AXiLjMNB7zbN23nQAIbCEpRU0if03xBtuRxzRxt5
         nHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713277144; x=1713881944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tiEihCupVgpva7ZjRACXxPhOWCHQAzXeeOX7FJDM+SE=;
        b=rwvV4DMFz98xE+2iP4E8tblBco4kKaxl60DA9RFUl6TLaceq/GRS+WluUPRH6ZQOtf
         PIbbdNJ+O43rKfFIQpjvJUU/bKcxUe+uQ3ZIqDvWOeDp8uYKBcDtcx+x3yMpLQCm1OeM
         2EJHpH81hKtvUc5Myg2axOtoV+gr21ZDuGLepI4HtDF2zA2cyLKk1SPGI5IIN2by87SU
         eoZ6akQtHxWHsyYsFOAWgc1fUmOVL53MiC/hrjj1J9N3Q+kxl90uLkpbvfL35eGSzswy
         FmnNG7wMOoCyPmPmYAnjHlkHhUcWs/ZXjBSU2YBJ3JYPzzrdhDUhF/m9xxbdq4NCaw3t
         2XDg==
X-Gm-Message-State: AOJu0YxsFsoELHHT6jvr75Fzq0DV6c8XlI4OxydYu7iRwZi2T+5hQs82
	czA4AzvuogN1UT2dL/HTF22JurvM2+1bhVka4m4bRVPmnPiNp1jK8R/+nt0mLBYKppbh2HcmZV0
	vvaHpWpVtA1QDzSgpfZCwWxYX1ce1pg==
X-Google-Smtp-Source: AGHT+IGF2vORN1UpAWctNfFpjXygo5ICOHpO0Rp/DrpNnYiGFLCQompRRA2LcmH2HR8bGnHc7IsI5fQ6eB46lRHLasU=
X-Received: by 2002:a05:651c:1027:b0:2da:b35b:eafb with SMTP id
 w7-20020a05651c102700b002dab35beafbmr2715834ljm.29.1713277143614; Tue, 16 Apr
 2024 07:19:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415144430.34450-1-vlad.pruteanu@nxp.com> <20240415144430.34450-2-vlad.pruteanu@nxp.com>
 <CABBYNZ+DXQf6UF-uHSwY4RSA5NjKaFZjEeQvjHWjj5zYL1OdJw@mail.gmail.com> <VI1PR04MB53899910065D0817F54C5868FE082@VI1PR04MB5389.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB53899910065D0817F54C5868FE082@VI1PR04MB5389.eurprd04.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 16 Apr 2024 10:18:50 -0400
Message-ID: <CABBYNZLR9OBako_bBpJFx1A5nV-GYyzVczRb64vOcey2m_X2sw@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH 1/1] Bluetooth: hci_event: Fix setting of
 unicast qos interval
To: Vlad Pruteanu <vlad.pruteanu@nxp.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	Claudia Cristina Draghicescu <claudia.rosu@nxp.com>, 
	Mihai-Octavian Urzica <mihai-octavian.urzica@nxp.com>, 
	Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>, Iulia Tanasescu <iulia.tanasescu@nxp.com>, 
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vlad,

On Tue, Apr 16, 2024 at 6:22=E2=80=AFAM Vlad Pruteanu <vlad.pruteanu@nxp.co=
m> wrote:
>
> Hello Luiz,
>
> > -----Original Message-----
> > From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > Sent: Monday, April 15, 2024 6:07 PM
> > To: Vlad Pruteanu <vlad.pruteanu@nxp.com>
> > Cc: linux-bluetooth@vger.kernel.org; Claudia Cristina Draghicescu
> > <claudia.rosu@nxp.com>; Mihai-Octavian Urzica <mihai-
> > octavian.urzica@nxp.com>; Silviu Florian Barbulescu
> > <silviu.barbulescu@nxp.com>; Iulia Tanasescu <iulia.tanasescu@nxp.com>;
> > Andrei Istodorescu <andrei.istodorescu@nxp.com>
> > Subject: [EXT] Re: [PATCH 1/1] Bluetooth: hci_event: Fix setting of uni=
cast qos
> > interval
> >
> > Caution: This is an external email. Please take care when clicking link=
s or
> > opening attachments. When in doubt, report the message using the 'Repor=
t
> > this email' button
> >
> >
> > Hi Vlad,
> >
> > On Mon, Apr 15, 2024 at 10:45=E2=80=AFAM Vlad Pruteanu
> > <vlad.pruteanu@nxp.com> wrote:
> > >
> > > qos->ucast interval reffers to the SDU interval, and should not
> > > be set to the interval value reported by the LE CIS Established
> > > event since the latter reffers to the ISO interval. These two
> > > interval are not the same thing:
> > >
> > > BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 6, Part G
> > >
> > > Isochronous interval:
> > > The time between two consecutive BIS or CIS events (designated
> > > ISO_Interval in the Link Layer)
> > >
> > > SDU interval:
> > > The nominal time between two consecutive SDUs that are sent or
> > > received by the upper layer.
> >
> > I assume they are not the same because the ISO interval can have more
> > than one subevents, but otherwise if BN=3D1 then it shall be aligned, s=
o
> > we are probably missing the BN component here.
> >
> I don't think that there's any need for setting the SDU Interval of the q=
os
> here since it has already been set by the host prior to issuing the LE Se=
t
> CIG Parameters command, so the controller will have to respect that
> value. Since the it has been set by the host, to be used by the controlle=
r,
> to me, it seems a little bit redundant to derive the SDU Interval
> once again based on parameters received on this event. I think that
> continuing to use the initial value set by the Host should suffice.

Yeah but how about the receiver case? Or you expected that we set the
QoS settings as a server as well? We need to confirm that this works
in both directions or actually I don't think this would work with the
likes of iso-test/isotester because there is no BAP layer seating
above it to configure the SDU interval it really needs to come from
the ISO socket itself.

> > > ---
> > >  net/bluetooth/hci_event.c | 4 ----
> > >  1 file changed, 4 deletions(-)
> > >
> > > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > > index 868ffccff773..83cf0e8a56cf 100644
> > > --- a/net/bluetooth/hci_event.c
> > > +++ b/net/bluetooth/hci_event.c
> > > @@ -6824,10 +6824,6 @@ static void hci_le_cis_estabilished_evt(struct
> > hci_dev *hdev, void *data,
> > >
> > >         pending =3D test_and_clear_bit(HCI_CONN_CREATE_CIS, &conn->fl=
ags);
> > >
> > > -       /* Convert ISO Interval (1.25 ms slots) to SDU Interval (us) =
*/
> > > -       qos->ucast.in.interval =3D le16_to_cpu(ev->interval) * 1250;
> >
> > This most likely needs to be le16_to_cpu(ev->interval) * 1250 *
> > ev->bn, anyway it probably makes sense to indicate what the BN is
> > causing this problem.
> >
> > > -       qos->ucast.out.interval =3D qos->ucast.in.interval;
> > >
> > >         switch (conn->role) {
> > >         case HCI_ROLE_SLAVE:
> > >                 /* Convert Transport Latency (us) to Latency (msec) *=
/
> > > --
> > > 2.40.1
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

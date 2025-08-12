Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45407080E
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 20:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755030606; cv=none; b=Q5cGU+HGnVMJvVxj8OBUUffqCvkt2uv4mOchwoICQoSGrryY3+BpaXVVTyXuyTNfdjvtgZ6WCDPtlpCH4uWV1goEPiwgO68a/0LXYz1cuf3LA8O8SMoPveK+lG0BVVcCrlo4vGfuRqyVTdy5n+KfF26Ha/NPGBamNOH6PRDfdIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755030606; c=relaxed/simple;
	bh=Oyxbv68YWPt46/2aSchhQGalB/wo7pDMy8QD4sVx6wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FdDu+BLM9rjEF/yEyvsHugK3ck7i43B5VXXD+ncipfRHQPqdykPH4jUoIlT2ySlKaAqKIwh+J93H3vbVsi2ks5TUVSGLufDntWXA41nI4jxBIgeKiFVaj0qWAZYtZRK4X51abLU0wPl65UtxG9Z0YhU4VmqOR+PzxvqTnfFvjmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aU1ziyR6; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aU1ziyR6"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-555024588b1so6678928e87.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 13:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755030603; x=1755635403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OX90UMoDFpxwt39vMtLR/ycH/gStBdkwSYJMpxVVqaI=;
        b=aU1ziyR6WMjIXuUIKDDL2t/UG7SunowvwlwMvVKU/f4n2UdIrRmkrOkBsIs6ZL/vuh
         28p7SQB+k9Ofahu2PEGZ/lJCqvrqgfk40CgwWNfU24twqj3ruoAn80aSVXnR+RHHIjYf
         RHXNF6qYc0YFIUDwqsqHv+58MbqWtxwedcQ3liRvWjIMNSnuwXGwOZyvWL/748iBjzs2
         JNLBX5Li1sFISv58V52/d3C7OJnu9FQdDHO1dly7au0Sl+tXKe3A9ShHrWctm/aNqk7X
         0PDQrpgUTJtuhzGiqLjF9KczVQFrEiEKBEKFW7/AgOSu8B1UVfRiOWUAV2tbVXk970T8
         QX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755030603; x=1755635403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OX90UMoDFpxwt39vMtLR/ycH/gStBdkwSYJMpxVVqaI=;
        b=GFqGw9/ohtpPbblTJUa1uBWyyXAopV7FddYniV3bx+dTTwlXuTnQMeszMTU+Wz0R4Y
         pxxSpZyAiUomstlKOPOJcvljcaZu+D1sUY+WNrB5ZE0Uuw54nZRFH0IcQD9TF9DI0qIP
         KKlGE06yjQT9DqKvdQIokiMYasN9GUCbbsL1XR/s/eF+wVKKE2tDKWILCTTvzNqwnOD8
         RvoXfdPZOGtLVJAwPCxwJ30hT1SPTEtx6dxT4bXpkmAyDDboHlkOonupw8XHuugNYjVR
         fycBQPHVb/jiP5jSDBv2DariWSMX1PlieiyWLJGWFWA7H2rkM4aAk4IxU2Dj8FD5usO2
         xZgQ==
X-Gm-Message-State: AOJu0Yy7qqRyKyY4kViQGZ92MAFLf0rZO7GDASSMHW9jH+9ScSxJeaNv
	A/C1oyFBnPPvKQPTFOj8Fe4a+aknCFI/4NVzTRM48uCyTw1YoG2JRcgeJv/q4RvoVy0VlM0WDjG
	INqM6sTX/7gB4erJPYagyHSzyMFP33Ds=
X-Gm-Gg: ASbGncudimVN0LBs8ODL1zb+4caEsPvwR4t8xkXeGleH2TikD9H7INKETnQJAWfhZnC
	lFw8wW4IgcTcF2T8ok/8EpIFCKMbdwFL2uP+m1KVxWGNACfO9m5gnCNDJttVZlZqhy+m7iJCAfU
	jdYagtHqVnyS3GasvfVPWjVBqLLwLdr+vQgaNff6Jfy6I+LQA98TO5x8UDdEtGBfPzH1ybr/QT6
	2dEFv9QqOxE9rY6
X-Google-Smtp-Source: AGHT+IGYEvwhfsjXeFNqdsUvqscWxoVyLMHExBKDcn+zdretE6lDZu0ec7557nYqPoG/SFKklXyRK8PosWCENLTAYZ8=
X-Received: by 2002:a05:6512:3c84:b0:55b:7cc9:41f4 with SMTP id
 2adb3069b0e04-55ce0149a7emr142484e87.2.1755030602673; Tue, 12 Aug 2025
 13:30:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812195323.1522605-1-luiz.dentz@gmail.com>
 <20250812195323.1522605-3-luiz.dentz@gmail.com> <a5a68086-adad-416a-b276-ab03fa53bea1@molgen.mpg.de>
In-Reply-To: <a5a68086-adad-416a-b276-ab03fa53bea1@molgen.mpg.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 12 Aug 2025 16:29:48 -0400
X-Gm-Features: Ac12FXzvYOO8Fv1W1PHwFYke2T_WcpaQygz_ainvorIVJLc8dxfRwmKsITEM130
Message-ID: <CABBYNZ+P39Sgsc+7HZVbN+PuWB=4wEs-ga3bN8n7q52YwtyEPQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] Bluetooth: hci_conn: Make unacked packet handling
 more robust
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Tue, Aug 12, 2025 at 4:03=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> Dear Luiz,
>
>
> Thank you for your patch.
>
> Am 12.08.25 um 21:53 schrieb Luiz Augusto von Dentz:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This attempts to make unacked packet handling more robust by detecting
> > if there are no connections left then restore all buffers of the
> > respective pool.
>
> Did you find this in code review, or was a bug reported?

Internal testing has run into a problem where some packets are never
TX for some reason, we are still accessing if this is going to help
but it is not an actual fix and more of a way to improve the handling
of unacked packets.

Now I'm curious, why this sort of question seem to be recurring, we do
encourage as much details as possible, but I don't think we ever said
that it is required to disclose what sort of test or bug report it
came from, especially if they come from internal testing which cannot
be referenced anyway, so was there anything unclear with the commit
message?

> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >   net/bluetooth/hci_conn.c | 34 ++++++++++++++++++++++++++++------
> >   1 file changed, 28 insertions(+), 6 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index e6cea51b3eab..4bd2e4cd477f 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -1152,22 +1152,44 @@ void hci_conn_del(struct hci_conn *conn)
> >       disable_delayed_work_sync(&conn->auto_accept_work);
> >       disable_delayed_work_sync(&conn->idle_work);
> >
> > -     /* Handle unnacked frames */
> > +     /* Handle unnacked frames:
> > +      *
> > +      * - In case there are no connection restore all buffers to the p=
ool
> > +      * - Otherwise restore just the buffers considered in transit for=
 the
> > +      *   hci_conn
> > +      */
> >       switch (conn->type) {
> >       case ACL_LINK:
> > -             hdev->acl_cnt +=3D conn->sent;
> > +             if (!hci_conn_num(hdev, ACL_LINK))
> > +                     hdev->acl_cnt =3D hdev->acl_pkts;
> > +             else
> > +                     hdev->acl_cnt +=3D conn->sent;
> >               break;
> >       case LE_LINK:
> >               cancel_delayed_work(&conn->le_conn_timeout);
> >
> > -             if (hdev->le_pkts)
> > -                     hdev->le_cnt +=3D conn->sent;
> > -             else
> > -                     hdev->acl_cnt +=3D conn->sent;
> > +             if (hdev->le_pkts) {
> > +                     if (!hci_conn_num(hdev, LE_LINK))
> > +                             hdev->le_cnt =3D hdev->le_pkts;
> > +                     else
> > +                             hdev->le_cnt +=3D conn->sent;
> > +             } else {
> > +                     if (!hci_conn_num(hdev, LE_LINK) &&
> > +                         !hci_conn_num(hdev, ACL_LINK))
> > +                             hdev->acl_cnt =3D hdev->acl_pkts;
> > +                     else
> > +                             hdev->acl_cnt +=3D conn->sent;
> > +             }
> >               break;
> >       case CIS_LINK:
> >       case BIS_LINK:
> >       case PA_LINK:
> > +             if (!hci_conn_num(hdev, CIS_LINK) &&
> > +                 !hci_conn_num(hdev, BIS_LINK) &&
> > +                 !hci_conn_num(hdev, PA_LINK))
> > +                     hdev->iso_cnt =3D hdev->iso_pkts;
> > +             else
> > +                     hdev->iso_cnt +=3D conn->sent;
> >               hdev->iso_cnt +=3D conn->sent;
> >               break;
> >       }
>
>
> Kind regards,
>
> Paul



--=20
Luiz Augusto von Dentz

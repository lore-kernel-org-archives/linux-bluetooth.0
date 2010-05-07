Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?= <santoscadenas@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH 6/6] Change end of line from DOS to UNIX
Date: Fri, 7 May 2010 10:15:44 +0200
Cc: linux-bluetooth@vger.kernel.org,
 marcel@holtmann.org
References: <1273184832-8265-1-git-send-email-santoscadenas@gmail.com> <1273184832-8265-6-git-send-email-santoscadenas@gmail.com> <20100506225633.GA15821@jh-x301>
In-Reply-To: <20100506225633.GA15821@jh-x301>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201005071015.44774.santoscadenas@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

El Friday 07 May 2010 00:56:33 Johan Hedberg escribi=F3:
> Hi,
>=20
> On Fri, May 07, 2010, Jose Antonio Santos Cadenas wrote:
> > Files tools/ubcsp.c and tools/ubcsp.h had DOS end of line now they
> > are changed to UNIX end of line
> > ---
> >  tools/ubcsp.c | 2360 ++++++++++++++++++++++++++++---------------------=
=2D------
> >  tools/ubcsp.h |  414 +++++-----
> >  2 files changed, 1387 insertions(+), 1387 deletions(-)
>=20
> Thanks for these cleanup patches. I've pushed the first five upstream
> but am a little bit hesitant about this sixth one since it essentially
> replaces every line in the existing file and I'm not sure if it's worth
> having that obfuscating the commit history (e.g. git blame wouldn't be
> useful anymore). Marcel, do you have any opinion about having a patch
> like that in the tree?

That's what I put this in a separate patch. I just wanted to note that some=
 files had this=20
end of line. One of them had also some lines with DOS end fo line and other=
s with UNIX eol.

>=20
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

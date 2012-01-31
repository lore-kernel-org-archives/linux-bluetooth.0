Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1327961101.1955.186.camel@aeonflux>
References: <1327504207-18275-1-git-send-email-octavian.purdila@intel.com>
	<1327961101.1955.186.camel@aeonflux>
Date: Tue, 31 Jan 2012 12:12:04 +0200
Message-ID: <CAE1zotLmJ8DNX5x5=XwYbR3mEJL_G8GtY56YzeGf6dY=bc+gsQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: fix RFCOMM session reference counting issue
From: "Purdila, Octavian" <octavian.purdila@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gopala Krishna Murala <gopala.krishna.murala@intel.com>, Nick Pelly <npelly@google.com>,
	=?UTF-8?B?THVrw6HFoSBUdXJlaw==?= <8an@praha12.net>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: multipart/alternative; boundary=0015175cb2c8d8288e04b7d031b3
List-ID: <linux-bluetooth.vger.kernel.org>

--0015175cb2c8d8288e04b7d031b3
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Jan 31, 2012 at 12:05 AM, Marcel Holtmann <marcel@holtmann.org>wrote:

I can follow your argumentation and seems reasonable to me.
>
> Have we run this against the BITE tester just to double check that not
> by some stupid coincident it breaks qualification?
>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
>
>
Hi Marcel,

Thanks for the review.  I have ask around but we don't have a BITE tester
available at our site. Is there any software tool we can use instead?

Thanks!
Tavi

--0015175cb2c8d8288e04b7d031b3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 31, 2012 at 12:05 AM, Marcel Holtmann <span dir=3D"ltr">&lt;<a =
href=3D"mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt;</span> wrot=
e:<br><br><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
I can follow your argumentation and seems reasonable to me.<br>
<br>
Have we run this against the BITE tester just to double check that not<br>
by some stupid coincident it breaks qualification?<br>
<br>
Acked-by: Marcel Holtmann &lt;<a href=3D"mailto:marcel@holtmann.org">marcel=
@holtmann.org</a>&gt;<br>
<br>
</blockquote><div><br>Hi Marcel,<br><br>Thanks for the review.=A0 I have as=
k around but we don&#39;t have a BITE tester available at our site. Is ther=
e any software tool we can use instead?<br><br>Thanks!<br>Tavi<br></div>
</div>

--0015175cb2c8d8288e04b7d031b3--

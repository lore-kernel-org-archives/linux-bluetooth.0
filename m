Return-Path: <cyrus@holtmann.org>
From: "Xu, Martin" <martin.xu@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"martin.xu@linux.intel.com" <martin.xu@linux.intel.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH] obexd/client: Add client session properties
Date: Mon, 8 Jul 2013 00:21:13 +0000
Message-ID: <29981E9CC6590A438DB8A519AEB0053010D3476F@SHSMSX103.ccr.corp.intel.com>
References: <1373017106-4571-1-git-send-email-martin.xu@linux.intel.com>
 <CABBYNZKF67RPpERkQ7RfmQx+Jc_tPz=-Wv3pGrAw=nJqc2=brg@mail.gmail.com>
In-Reply-To: <CABBYNZKF67RPpERkQ7RfmQx+Jc_tPz=-Wv3pGrAw=nJqc2=brg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
> Sent: Friday, July 05, 2013 18:04
> To: martin.xu@linux.intel.com
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH] obexd/client: Add client session properties
> 
> Hi Martin,
> 
> On Fri, Jul 5, 2013 at 12:38 PM,  <martin.xu@linux.intel.com> wrote:
> > From: Martin <martin.xu@linux.intel.com>
> 
> Please add a description why are the changes necessary.
> 
> > ---
> >  obexd/client/session.c |   38 ++++++++++++++++++++++++++++++++------
> >  1 file changed, 32 insertions(+), 6 deletions(-)
> >
> > diff --git a/obexd/client/session.c b/obexd/client/session.c index
> > 8d32ed0..e9cbf00 100644
> > --- a/obexd/client/session.c
> > +++ b/obexd/client/session.c
> > @@ -630,9 +630,6 @@ static gboolean get_source(const
> > GDBusPropertyTable *property,  {
> >         struct obc_session *session = data;
> >
> > -       if (session->source == NULL)
> > -               return FALSE;
> 
> I guess you haven't read carefully may comments from the last time, did
> you? This should not be necessary here, otherwise create another patch.
Looks like I lost your last mail, could you repeat that.
For others comments, I will resend the patch.
Thanks!

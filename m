Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Feb 2012 14:59:08 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Mikel Astiz <mikel.astiz.oss@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH obexd 3/6] client: fix incorrect error check
Message-ID: <20120214125908.GE19427@x220.ger.corp.intel.com>
References: <1329143945-4934-1-git-send-email-mikel.astiz.oss@gmail.com>
 <1329143945-4934-3-git-send-email-mikel.astiz.oss@gmail.com>
 <CABBYNZK+AD+62MRVwaRqSxEuu81DO7KETkPzX8dP=R6WUHpDFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CABBYNZK+AD+62MRVwaRqSxEuu81DO7KETkPzX8dP=R6WUHpDFg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Feb 14, 2012, Luiz Augusto von Dentz wrote:
> On Mon, Feb 13, 2012 at 4:39 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> > From: Mikel Astiz <mikel.astiz@bmw-carit.de>
> >
> > Previous statement always returned success.
> > ---
> >  client/pbap.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/client/pbap.c b/client/pbap.c
> > index 4910536..c58557d 100644
> > --- a/client/pbap.c
> > +++ b/client/pbap.c
> > @@ -301,7 +301,7 @@ static gboolean pbap_setpath(struct pbap_data *pbap, const char *location,
> >        }
> >
> >        obc_session_setpath(pbap->session, path, pbap_setpath_cb, pbap, err);
> > -       if (err != NULL) {
> > +       if (*err == NULL) {
> >                g_free(pbap->path);
> >                pbap->path = path;
> >                return TRUE;
> > --
> > 1.7.6.5
> 
> Nice catch, ack.

This is still not right. With Mikels patch the code would be trying to
read a pointer value from the memory address 0 if NULL was passed as
err. What you really want is to check for the return value of
obc_session_setpath and if take this if-branch if it is greater than 0
(the function returns a guint), i.e. the value of err doesn't matter
here (since the caller of pbap_setpath is allowed to pass either NULL or
non-NULL).

Johan

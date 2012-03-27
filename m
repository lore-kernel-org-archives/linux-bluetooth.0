Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120327115017.GH14481@x220>
References: <1332516126-6665-1-git-send-email-jefferson.delfes@openbossa.org> <20120327115017.GH14481@x220>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
Date: Tue, 27 Mar 2012 08:52:48 -0400
Message-ID: <CA+_d9qeA4M8NKcrFYSrj4aN2S-hHe0odsxVRpbeRtJ-tfbViyw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gatttool: Update interactive prompt if connection
 is lost
To: Jefferson Delfes <jefferson.delfes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan.

On Tue, Mar 27, 2012 at 7:50 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>
> Hi Jefferson,
>
> On Fri, Mar 23, 2012, Jefferson Delfes wrote:
> > In interactive mode, when connection is lost, the prompt used to remain
> > in "connected" state. This patch fixes that case, by always showing the
> > actual connection state.
> > ---
> >  attrib/interactive.c |   11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/attrib/interactive.c b/attrib/interactive.c
> > index be81424..47ddcf6 100644
> > --- a/attrib/interactive.c
> > +++ b/attrib/interactive.c
> > @@ -56,6 +56,7 @@ struct characteristic_data {
> >  };
> >
> >  static void cmd_help(int argcp, char **argvp);
> > +static void cmd_disconnect(int argcp, char **argvp);
>
> We should really try to avoid forward declarations when possible and the
> cmd_* functions should be reserved for real user entered commands and
> not as generic helpers as you're trying to do. So I'd factor out code
> from cmd_disconnect into a static helper function somewhere above both
> cmd_disconnect and cmd_connect, call it e.g. disconnect_io().

Ok, I'll do these changes.

> > +static gboolean channel_watcher(GIOChannel *chan, GIOCondition cond,
> > +                             gpointer user_data)
> > +{
> > +     cmd_disconnect(0, NULL);
> > +
> > +     return TRUE;
> > +}
>
> Shouldn't this be returning FALSE instead of TRUE so that the watch
> doesn't get left hanging around GLibs watch lists wasting memory?

Oops! You are right. I didn't know about this. I made some tests in
valgrind now and I did see some still reachable extra bytes.

> Johan

I'll send a replace for this patch.
Thanks.

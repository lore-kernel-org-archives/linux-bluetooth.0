Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Apr 2014 15:37:32 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCHv4 01/20] android/avrcp: Add avrcp_connect_browsing()
Message-ID: <20140402123730.GA14673@aemeltch-MOBL1>
References: <1396268714-4056-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CABBYNZK8EL6yd1mttuLxX5_MEeiBi1G6mAN9rRY9tiABuM3hUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZK8EL6yd1mttuLxX5_MEeiBi1G6mAN9rRY9tiABuM3hUg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Apr 02, 2014 at 02:30:18PM +0300, Luiz Augusto von Dentz wrote:
> Hi Andrei,
> 
> On Mon, Mar 31, 2014 at 3:24 PM, Andrei Emeltchenko
> <Andrei.Emeltchenko.news@gmail.com> wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >
> > Add support for browsing channel
> > ---
> >  android/avrcp-lib.c | 6 ++++++
> >  android/avrcp-lib.h | 2 ++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
> > index 1a2fa2a..393ab54 100644
> > --- a/android/avrcp-lib.c
> > +++ b/android/avrcp-lib.c
> > @@ -293,6 +293,12 @@ struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t version)
> >         return session;
> >  }
> >
> > +int avrcp_connect_browsing(struct avrcp *session, int fd, size_t imtu,
> > +                                                               size_t omtu)
> > +{
> > +       return avctp_connect_browsing(session->conn, fd, imtu, omtu);
> > +}
> > +
> >  void avrcp_set_destroy_cb(struct avrcp *session, avrcp_destroy_cb_t cb,
> >                                                         void *user_data)
> >  {
> > diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
> > index 0b867aa..ca7a57f 100644
> > --- a/android/avrcp-lib.h
> > +++ b/android/avrcp-lib.h
> > @@ -207,6 +207,8 @@ struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t version);
> >  void avrcp_shutdown(struct avrcp *session);
> >  void avrcp_set_destroy_cb(struct avrcp *session, avrcp_destroy_cb_t cb,
> >                                                         void *user_data);
> > +int avrcp_connect_browsing(struct avrcp *session, int fd, size_t imtu,
> > +                                                               size_t omtu);
> >
> >  void avrcp_register_player(struct avrcp *session,
> >                                 const struct avrcp_control_ind *ind,
> > --
> > 1.8.3.2
> 
> This patch-set is now upstream, Ive end up redoing much of the API
> though since it was not using the callback mechanism.

Have you applied the last patch?

Best regards 
Andrei Emeltchenko 


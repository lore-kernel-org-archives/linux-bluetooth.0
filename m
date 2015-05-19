Return-Path: <cyrus@holtmann.org>
Message-ID: <1432019084.4843.12.camel@gmail.com>
Subject: Re: [RFC BlueZ v3 1/2] audio/avdtp: Add a2dp vendor codec match
 callback
From: Chan-yeol Park <chanyeol.park@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Chan-yeol Park <chanyeol.park@samsung.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 19 May 2015 16:04:44 +0900
In-Reply-To: <CABBYNZ+ArOx-J-WDQq3JQO8VMhte9P8Wg5KNqvazGZxHA-tkcA@mail.gmail.com>
References: <1431955990-16506-1-git-send-email-chanyeol.park@samsung.com>
	 <CABBYNZ+ArOx-J-WDQq3JQO8VMhte9P8Wg5KNqvazGZxHA-tkcA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, Luiz
On Mon, 2015-05-18 at 17:42 +0300, Luiz Augusto von Dentz wrote:
> Hi Chan-yeol,
> 
> On Mon, May 18, 2015 at 4:33 PM,  <chanyeol.park@samsung.com> wrote:
> > From: Chan-yeol Park <chanyeol.park@gmail.com>
> >
> > When matching remote SEP to local SEP avdtp does not compare vendor
> > codecs properly, i.e. neither vendor ID not codec ID are checked,
> > which may cause wrong endpoint to be selected in case there are more
> > that one endpoints using vendor codec on remote.
> >
> > This patch fixes it by making avdtp matching a2dp vendor codec by
> > a2dp's call back.
> > ---
> >  profiles/audio/a2dp.c  | 41 +++++++++++++++++++++++++++++++++++++----
> >  profiles/audio/avdtp.c |  7 ++++++-
> >  profiles/audio/avdtp.h |  6 +++++-
> >  3 files changed, 48 insertions(+), 6 deletions(-)
> >
> > diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> > index 31c5086..291be35 100644
> > --- a/profiles/audio/a2dp.c
> > +++ b/profiles/audio/a2dp.c
> > @@ -925,6 +925,35 @@ static gboolean close_ind(struct avdtp *session, struct avdtp_local_sep *sep,
> >         return TRUE;
> >  }
> >
> > +static gboolean a2dp_vndcodec_matched(void *remote_vndcodec, void *user_data)
> > +{
> > +       struct a2dp_sep *sep = user_data;
> > +       a2dp_vendor_codec_t *remote_codec = remote_vndcodec;
> > +       a2dp_vendor_codec_t *local_codec;
> > +       uint8_t *capabilities;
> > +       size_t length;
> > +
> > +       if (sep->endpoint == NULL)
> > +               return FALSE;
> > +
> > +       length = sep->endpoint->get_capabilities(sep, &capabilities,
> > +                                                       sep->user_data);
> > +       if (length < sizeof(a2dp_vendor_codec_t))
> > +               return FALSE;
> > +
> > +       local_codec = (a2dp_vendor_codec_t *) capabilities;
> > +
> > +       if (remote_codec->vendor_id != local_codec->vendor_id)
> > +               return FALSE;
> > +
> > +       if (remote_codec->codec_id != local_codec->codec_id)
> > +               return FALSE;
> > +
> > +       DBG("vendor 0x%08x codec 0x%04x", btohl(remote_codec->vendor_id),
> > +                                               btohs(remote_codec->codec_id));
> > +       return TRUE;
> > +}
> 
> That was not what I has initially in mind, anyway Im not against
> adding a callback to interact with avdtp_find_remote_sep but perhaps
> it should happen when registering the endpoint so AVDTP code don't
> need to check if codec is 0xff, instead it just call the callback if
> it exists after checking the codec. That means adding a match callback
> avdtp_sep_ind:
> 
> diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
> index 1b02232..2d55a20 100644
> --- a/profiles/audio/avdtp.h
> +++ b/profiles/audio/avdtp.h
> @@ -172,6 +172,8 @@ struct avdtp_sep_cfm {
>  /* Callbacks for indicating when we received a new command. The return value
>   * indicates whether the command should be rejected or accepted */
>  struct avdtp_sep_ind {
> +       gboolean (*match) (struct avdtp *session, struct avdtp_local_sep *lsep,
> +                                       struct avdtp_remote_sep *rsep);
>         gboolean (*get_capability) (struct avdtp *session,
>                                         struct avdtp_local_sep *sep,
>                                         gboolean get_all,
> 
I thought that struct avdtp_sep_ind are strictly related to AVDTP signal
between devices and it should be called from remote command. So I think
a2dp vendor case is little bit different wit them.

But if we use it, I agree call back could be more simpler than adding
callback in avdtp_find_remote_sep().

I would raise v4. 
> >  static gboolean a2dp_reconfigure(gpointer data)
> >  {
> >         struct a2dp_setup *setup = data;
> > @@ -939,7 +968,8 @@ static gboolean a2dp_reconfigure(gpointer data)
> >         }
> >
> >         if (!setup->rsep || sep->codec != rsep_codec->media_codec_type)
> > -               setup->rsep = avdtp_find_remote_sep(setup->session, sep->lsep);
> > +               setup->rsep = avdtp_find_remote_sep(setup->session, sep->lsep,
> > +                                                       a2dp_vndcodec_matched);
> >
> >         posix_err = avdtp_set_configuration(setup->session, setup->rsep,
> >                                                 sep->lsep,
> > @@ -1769,7 +1799,8 @@ static struct a2dp_sep *a2dp_find_sep(struct avdtp *session, GSList *list,
> >                                 continue;
> >                 }
> >
> > -               rsep = avdtp_find_remote_sep(session, sep->lsep);
> > +               rsep = avdtp_find_remote_sep(session, sep->lsep,
> > +                                                       a2dp_vndcodec_matched);
> >                 if (rsep == NULL)
> >                         continue;
> >
> > @@ -1835,7 +1866,8 @@ unsigned int a2dp_select_capabilities(struct avdtp *session,
> >         cb_data->user_data = user_data;
> >
> >         setup->sep = sep;
> > -       setup->rsep = avdtp_find_remote_sep(session, sep->lsep);
> > +       setup->rsep = avdtp_find_remote_sep(session, sep->lsep,
> > +                                                       a2dp_vndcodec_matched);
> >
> >         if (setup->rsep == NULL) {
> >                 error("Could not find remote sep");
> > @@ -1934,7 +1966,8 @@ unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
> >                         break;
> >                 }
> >
> > -               setup->rsep = avdtp_find_remote_sep(session, sep->lsep);
> > +               setup->rsep = avdtp_find_remote_sep(session, sep->lsep,
> > +                                                       a2dp_vndcodec_matched);
> >                 if (setup->rsep == NULL) {
> >                         error("No matching ACP and INT SEPs found");
> >                         goto failed;
> > diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> > index f38188f..ab07128 100644
> > --- a/profiles/audio/avdtp.c
> > +++ b/profiles/audio/avdtp.c
> > @@ -1198,7 +1198,8 @@ static struct avdtp_local_sep *find_local_sep_by_seid(struct avdtp *session,
> >  }
> >
> >  struct avdtp_remote_sep *avdtp_find_remote_sep(struct avdtp *session,
> > -                                               struct avdtp_local_sep *lsep)
> > +                                               struct avdtp_local_sep *lsep,
> > +                                               avdtp_vndcodec_matched_cb cb)
> >  {
> >         GSList *l;
> >
> > @@ -1226,6 +1227,10 @@ struct avdtp_remote_sep *avdtp_find_remote_sep(struct avdtp *session,
> >                 if (codec_data->media_codec_type != lsep->codec)
> >                         continue;
> >
> > +               if (codec_data->media_codec_type == 0xff && cb)
> > +                       if (cb(codec_data->data, lsep->user_data) == FALSE)
> > +                               continue;
> > +
> >                 if (sep->stream == NULL)
> >                         return sep;
> >         }
> > diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
> > index 1b02232..5886691 100644
> > --- a/profiles/audio/avdtp.h
> > +++ b/profiles/audio/avdtp.h
> > @@ -277,9 +277,13 @@ struct avdtp_local_sep *avdtp_register_sep(struct queue *lseps, uint8_t type,
> >                                                 struct avdtp_sep_cfm *cfm,
> >                                                 void *user_data);
> >
> > +typedef gboolean (*avdtp_vndcodec_matched_cb) (void *remote_vndcodec,
> > +                                                        void *user_data);
> > +
> >  /* Find a matching pair of local and remote SEP ID's */
> >  struct avdtp_remote_sep *avdtp_find_remote_sep(struct avdtp *session,
> > -                                               struct avdtp_local_sep *lsep);
> > +                                               struct avdtp_local_sep *lsep,
> > +                                               avdtp_vndcodec_matched_cb cb);
> >
> >  int avdtp_unregister_sep(struct queue *lseps, struct avdtp_local_sep *sep);
> >
> > --
> > 2.1.0
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
Thanks!
Chanyeol


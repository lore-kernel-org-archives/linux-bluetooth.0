Return-Path: <cyrus@holtmann.org>
From: Bharat Bhusan Panda <bharat.panda@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, cpgs@samsung.com
References: <1413875185-16860-1-git-send-email-bharat.panda@samsung.com>
 <CABBYNZ+ugOkF0OYQ9ovUFhOyFyGgUjh9Eay+o-fW2Qu20S9C8Q@mail.gmail.com>
In-reply-to: <CABBYNZ+ugOkF0OYQ9ovUFhOyFyGgUjh9Eay+o-fW2Qu20S9C8Q@mail.gmail.com>
Subject: RE: [PATCH v2] obexd/mas: Add Support for MSETime filter
Date: Tue, 21 Oct 2014 19:35:12 +0530
Message-id: <01b901cfed38$1a2668b0$4e733a10$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz

> >  obexd/plugins/mas.c | 36 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >
> > diff --git a/obexd/plugins/mas.c b/obexd/plugins/mas.c index
> > fb97fe3..5379a01 100644
> > --- a/obexd/plugins/mas.c
> > +++ b/obexd/plugins/mas.c
> > @@ -30,6 +30,7 @@
> >  #include <glib.h>
> >  #include <fcntl.h>
> >  #include <inttypes.h>
> > +#include <sys/time.h>
> >
> >  #include <gobex/gobex.h>
> >  #include <gobex/gobex-apparam.h>
> > @@ -228,6 +229,33 @@ static void
> g_string_append_escaped_printf(GString *string,
> >         va_end(ap);
> >  }
> >
> > +static gchar *get_mse_timestamp(void) {
> > +       struct timeval time_val;
> > +       struct tm ltime;
> > +       gchar *local_ts;
> > +       char sign;
> > +
> > +       gettimeofday(&time_val, NULL);
> > +
> > +       if (!localtime_r(&time_val.tv_sec, &ltime))
> > +               return NULL;
> > +
> > +       if (difftime(mktime(localtime(&time_val.tv_sec)),
> > +                                                       mktime(gmtime(&time_val.tv_sec))) < 0)
> > +               sign = '+';
> > +       else
> > +               sign = '-';
> > +
> > +       local_ts =
> g_strdup_printf("%04d%02d%02dT%02d%02d%02d%c%2ld%2ld",
> > +                                       ltime.tm_year + 1900, ltime.tm_mon + 1,
> > +                                       ltime.tm_mday, ltime.tm_hour,
> > +                                       ltime.tm_min, ltime.tm_sec, sign,
> > +                                       ltime.tm_gmtoff/3600,
> > + (ltime.tm_gmtoff%3600)/60);
> > +
> > +       return local_ts;
> > +}
> > +
> >  static const char *yesorno(gboolean a)  {
> >         if (a)
> > @@ -243,6 +271,7 @@ static void get_messages_listing_cb(void *session,
> > int err, uint16_t size,  {
> >         struct mas_session *mas = user_data;
> >         uint16_t max = 1024;
> > +       gchar *mse_time;
> >
> >         if (err < 0 && err != -EAGAIN) {
> >                 obex_object_set_io_flags(mas, G_IO_ERR, err); @@
> > -358,6 +387,13 @@ proceed:
> >                 mas->outparams = g_obex_apparam_set_uint8(mas->outparams,
> >                                                 MAP_AP_NEWMESSAGE,
> >                                                 newmsg ? 1 : 0);
> > +               /* Response to report the local time of MSE */
> > +               mse_time = get_mse_timestamp();
> > +               if (mse_time) {
> > +                       g_obex_apparam_set_string(mas->outparams,
> > +                                               MAP_AP_MSETIME, mse_time);
> > +                       g_free(mse_time);
> > +               }
> >         }
> >
> >         if (err != -EAGAIN)
> > --
> > 1.9.1
> 
> Please check your coding style.
> 
> WARNING:LONG_LINE: line over 80 characters
> #30: FILE: obexd/plugins/mas.c:245:
> + mktime(gmtime(&time_val.tv_sec))) < 0)
> 
> WARNING:LONG_LINE: line over 80 characters
> #39: FILE: obexd/plugins/mas.c:254:
> + ltime.tm_gmtoff/3600, (ltime.tm_gmtoff%3600)/60);
> 
> total: 0 errors, 2 warnings, 60 lines checked

I have fixed the warnings and submitted v3 patch  for the same.

Best Regards,
Bharat


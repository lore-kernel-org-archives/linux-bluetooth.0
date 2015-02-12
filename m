Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1423738818-30130-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1423738818-30130-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Thu, 12 Feb 2015 15:25:27 +0200
Message-ID: <CABBYNZLPKii-UXeVQuZQeETTMz-0veXNy_-KKrHdYcRT4mSRpQ@mail.gmail.com>
Subject: Re: [RFC] android/avdtp: Fix SEID assignment
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Feb 12, 2015 at 1:00 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Fixes SEID generation for avdtp. Currently SEIDs were assigned assuming
> that SEID are registered and unregistered in the same order like:
> seid = g_slist_length(seps) + 1
> which makes it possible to reuse similar SEIDs
> ---
>  android/avdtp.c   | 32 +++++++++++++++++++++++++++++---
>  unit/test-avdtp.c | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 62 insertions(+), 3 deletions(-)
>
> diff --git a/android/avdtp.c b/android/avdtp.c
> index 22c492b..20f27d4 100644
> --- a/android/avdtp.c
> +++ b/android/avdtp.c
> @@ -45,6 +45,7 @@
>  #include "../profiles/audio/a2dp-codecs.h"
>
>  #define MAX_SEID 0x3E
> +static uint64_t seids;
>
>  #ifndef MAX
>  # define MAX(x, y) ((x) > (y) ? (x) : (y))
> @@ -3350,20 +3351,44 @@ int avdtp_delay_report(struct avdtp *session, struct avdtp_stream *stream,
>                                                         &req, sizeof(req));
>  }
>
> +static uint8_t avdtp_get_seid(void)
> +{
> +       uint64_t temp = seids;
> +       uint8_t id = 1;
> +
> +       while (temp >>= 1)
> +               id++;
> +
> +       if (id > MAX_SEID)
> +               return 0;
> +
> +       seids |= (uint64_t) (0x01l << id);
> +
> +       DBG("seids 0x%04lx id %d", seids, id);
> +
> +       return id;
> +}
> +
> +static void avdtp_clear_seid(uint8_t seid)
> +{
> +       seids &= ~(0x1l<<seid);
> +
> +       DBG("seids 0x%04lx cleared bit %d ", seids, seid);
> +}

This is a pretty good idea, perhaps we can create a set of helpers
including to this for us since I see some other users for it.

>  struct avdtp_local_sep *avdtp_register_sep(uint8_t type, uint8_t media_type,
>                                                 uint8_t codec_type,
>                                                 gboolean delay_reporting,
>                                                 struct avdtp_sep_ind *ind,
>                                                 struct avdtp_sep_cfm *cfm,
> -                                               void *user_data,
> -                                               uint8_t seid)
> +                                               void *user_data, uint8_t seid)
>  {
>         struct avdtp_local_sep *sep;
>
>         sep = g_new0(struct avdtp_local_sep, 1);
>
>         sep->state = AVDTP_STATE_IDLE;
> -       sep->info.seid = seid;
> +       sep->info.seid = avdtp_get_seid();
>         sep->info.type = type;
>         sep->info.media_type = media_type;
>         sep->codec = codec_type;
> @@ -3396,6 +3421,7 @@ int avdtp_unregister_sep(struct avdtp_local_sep *sep)
>         DBG("SEP %p unregistered: type:%d codec:%d seid:%d", sep,
>                         sep->info.type, sep->codec, sep->info.seid);
>
> +       avdtp_clear_seid(sep->info.seid);
>         g_free(sep);
>
>         return 0;
> diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
> index 03fd4b1..00b72f1 100644
> --- a/unit/test-avdtp.c
> +++ b/unit/test-avdtp.c
> @@ -39,6 +39,8 @@
>  #include "src/log.h"
>  #include "android/avdtp.h"
>
> +#define MAX_SEID 0x3E
> +
>  GSList *lseps = NULL;
>
>  struct test_pdu {
> @@ -567,6 +569,35 @@ static void test_server_0_sep(gconstpointer data)
>         execute_context(context);
>  }
>
> +static void unregister_sep(gpointer data, gpointer user_data)
> +{
> +       struct avdtp_local_sep *sep = data;
> +
> +       lseps = g_slist_remove(lseps, sep);
> +       avdtp_unregister_sep(sep);
> +}
> +
> +static void test_server_seid(gconstpointer data)
> +{
> +       struct context *context = create_context(0x0103, data);
> +       struct avdtp_local_sep *sep;
> +       int i;
> +
> +       for (i = 0; i < MAX_SEID; i++) {
> +               sep = avdtp_register_sep(AVDTP_SEP_TYPE_SINK,
> +                                               AVDTP_MEDIA_TYPE_AUDIO,
> +                                               0x00, TRUE, &sep_ind, NULL,
> +                                               context,
> +                                               g_slist_length(lseps) + 1);
> +               g_assert(sep);
> +
> +               lseps = g_slist_append(lseps, sep);
> +               avdtp_set_lseps(context->session, lseps);
> +       }
> +
> +       g_slist_foreach(lseps, unregister_sep, NULL);
> +}
> +
>  static gboolean sep_getcap_ind_frg(struct avdtp *session,
>                                         struct avdtp_local_sep *sep,
>                                         GSList **caps, uint8_t *err,
> @@ -774,6 +805,8 @@ int main(int argc, char *argv[])
>          * To verify that the following procedures are implemented according to
>          * their specification in AVDTP.
>          */
> +       define_test("/TP/SIG/SMG/BV-06-C-SEID-1", test_server_seid,
> +                       raw_pdu(0x00));
>         define_test("/TP/SIG/SMG/BV-05-C", test_client,
>                         raw_pdu(0x00, 0x01));
>         define_test("/TP/SIG/SMG/BV-06-C", test_server,
> --
> 2.1.0

Please split the unit test, Id probably put it first so it causes the
problem you are trying to fix.


-- 
Luiz Augusto von Dentz

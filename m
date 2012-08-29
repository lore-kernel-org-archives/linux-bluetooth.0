Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1346217303-21521-1-git-send-email-srinivasa.ragavan.venkateswaran@intel.com>
References: <1346217303-21521-1-git-send-email-srinivasa.ragavan.venkateswaran@intel.com>
Date: Wed, 29 Aug 2012 11:23:27 +0300
Message-ID: <CABBYNZK+8u=uXgMezU9igc1s1QM=HYspxGUxwpdhJxp_JM7EfA@mail.gmail.com>
Subject: Re: [PATCH] client: Fix crash on map module
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Srinivasa Ragavan <srinivasa.ragavan.venkateswaran@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Aug 29, 2012 at 8:15 AM, Srinivasa Ragavan
<srinivasa.ragavan.venkateswaran@intel.com> wrote:
> gboolean is expected to hold 0/1. But it is holding int return from strcasecmp
> which crashes DBusMessage at  _dbus_return_val_if_fail
> (*bool_p == 0 || *bool_p == 1, FALSE);
>
> Trace:
> 0  0x00007ffff7328d95 in __GI_raise (sig=6) at raise.c:64
> 1  0x00007ffff732a2ab in __GI_abort () at abort.c:93
> 2  0x00007ffff78d0655 in _dbus_abort () at dbus-sysdeps.c:94
> 3  0x00007ffff78c75f1 in _dbus_warn_check_failed at dbus-internals.c:289
> 4  0x00007ffff78ba28b in dbus_message_iter_append_basic at dbus-message.c:2538
> 5  0x00000000004201c3 in append_variant at client/dbus.c:44
> 6  0x000000000042024e in obex_dbus_dict_append at client/dbus.c:65
> 7  0x000000000041dcc9 in parse_read at client/map.c:423
> 8  0x000000000041dfa7 in msg_element at client/map.c:518
> 9  0x00007ffff7b323b9 in emit_start_element at gmarkup.c:986
> 10 0x00007ffff7b33b44 in g_markup_parse_context_parse at gmarkup.c:1323
> 11 0x000000000041e1ad in message_listing_cb at client/map.c:586
> 12 0x000000000041744c in session_terminate_transfer client/session.c:743
> 13 0x00000000004174d7 in session_notify_complete at client/session.c:758
> 14 0x000000000041755a in transfer_complete at client/session.c:778
> 15 0x000000000041f57b in xfer_complete at client/transfer.c:521
> 16 0x000000000040efdf in transfer_complete at gobex/gobex-transfer.c:102
> 17 0x000000000040f418 in transfer_response at gobex/gobex-transfer.c:221
> 18 0x000000000040b320 in handle_response at gobex/gobex.c:948
> 19 0x000000000040bbc1 in incoming_data at gobex/gobex.c:1191
> 20 0x00007ffff7b2f94a in g_main_dispatch (context=0x62f130) at gmain.c:2515
> 21 g_main_context_dispatch (context=0x62f130) at gmain.c:3052
> 22 0x00007ffff7b2fd10 in g_main_context_iterate at gmain.c:3123
> 23 g_main_context_iterate at gmain.c:3060
> 24 0x00007ffff7b3010a in g_main_loop_run (loop=0x62e1b0) at gmain.c:3317
> 25 0x000000000041527d in main at client/main.c:175
> ---
>  client/map.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/client/map.c b/client/map.c
> index e606cb2..4f07fcb 100644
> --- a/client/map.c
> +++ b/client/map.c
> @@ -400,7 +400,7 @@ static void parse_size(struct map_msg *msg, const char *value,
>  static void parse_priority(struct map_msg *msg, const char *value,
>                                                         DBusMessageIter *iter)
>  {
> -       gboolean flag = strcasecmp(value, "no");
> +       gboolean flag = strcasecmp(value, "no") != 0;
>
>         if (flag)
>                 msg->flags |= MAP_MSG_FLAG_PRIORITY;
> @@ -413,7 +413,7 @@ static void parse_priority(struct map_msg *msg, const char *value,
>  static void parse_read(struct map_msg *msg, const char *value,
>                                                         DBusMessageIter *iter)
>  {
> -       gboolean flag = strcasecmp(value, "no");
> +       gboolean flag = strcasecmp(value, "no") != 0;
>
>         if (flag)
>                 msg->flags |= MAP_MSG_FLAG_READ;
> @@ -426,7 +426,7 @@ static void parse_read(struct map_msg *msg, const char *value,
>  static void parse_sent(struct map_msg *msg, const char *value,
>                                                         DBusMessageIter *iter)
>  {
> -       gboolean flag = strcasecmp(value, "no");
> +       gboolean flag = strcasecmp(value, "no") != 0;
>
>         if (flag)
>                 msg->flags |= MAP_MSG_FLAG_SENT;
> @@ -439,7 +439,7 @@ static void parse_sent(struct map_msg *msg, const char *value,
>  static void parse_protected(struct map_msg *msg, const char *value,
>                                                         DBusMessageIter *iter)
>  {
> -       gboolean flag = strcasecmp(value, "no");
> +       gboolean flag = strcasecmp(value, "no") != 0;
>
>         if (flag)
>                 msg->flags |= MAP_MSG_FLAG_PROTECTED;
> --
> 1.7.7

Applied, thanks.



-- 
Luiz Augusto von Dentz

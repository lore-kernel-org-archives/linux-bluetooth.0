Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1395149399-27531-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1395149399-27531-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Date: Tue, 18 Mar 2014 16:58:55 +0200
Message-ID: <CABBYNZKzM5_ggPA9XE78OMZg8b5gkthGozze-M07JEKuYRqX+w@mail.gmail.com>
Subject: Re: [PATCH_v2 1/8] android/client: Add AVRCP set_player_app_value_rsp support
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Tue, Mar 18, 2014 at 3:29 PM, Ravi kumar Veeramally
<ravikumar.veeramally@linux.intel.com> wrote:
> ---
>  android/client/if-rc.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/android/client/if-rc.c b/android/client/if-rc.c
> index 60c3247..2e93c02 100644
> --- a/android/client/if-rc.c
> +++ b/android/client/if-rc.c
> @@ -46,6 +46,14 @@ SINTMAP(btrc_media_attr_t, -1, "(unknown)")
>         DELEMENT(BTRC_MEDIA_ATTR_PLAYING_TIME),
>  ENDMAP
>
> +SINTMAP(btrc_status_t, -1, "(unknown)")
> +       DELEMENT(BTRC_STS_BAD_CMD),
> +       DELEMENT(BTRC_STS_BAD_PARAM),
> +       DELEMENT(BTRC_STS_NOT_FOUND),
> +       DELEMENT(BTRC_STS_INTERNAL_ERR),
> +       DELEMENT(BTRC_STS_NO_ERROR),
> +ENDMAP
> +
>  static char last_addr[MAX_ADDR_STR_LEN];
>
>  static void remote_features_cb(bt_bdaddr_t *bd_addr,
> @@ -196,6 +204,33 @@ static void set_volume_p(int argc, const char **argv)
>         EXEC(if_rc->set_volume, volume);
>  }
>
> +/* set_player_app_value_rsp */
> +
> +static void set_player_app_value_rsp_c(int argc, const char **argv,
> +                                       enum_func *enum_func, void **user)
> +{
> +       if (argc == 3) {
> +               *user = TYPE_ENUM(btrc_status_t);
> +               *enum_func = enum_defines;
> +       }
> +}
> +
> +static void set_player_app_value_rsp_p(int argc, const char **argv)
> +{
> +       btrc_status_t rsp_status;
> +
> +       RETURN_IF_NULL(if_rc);
> +
> +       if (argc <= 2) {
> +               haltest_error("No response status specified");
> +               return;
> +       }
> +
> +       rsp_status = str2btrc_status_t(argv[2]);
> +
> +       EXEC(if_rc->set_player_app_value_rsp, rsp_status);
> +}
> +
>  /* cleanup */
>
>  static void cleanup_p(int argc, const char **argv)
> @@ -211,6 +246,7 @@ static struct method methods[] = {
>         STD_METHODCH(get_play_status_rsp,
>                                         "<play_status> <song_len> <song_pos>"),
>         STD_METHODCH(get_element_attr_rsp, "<num_attr> <attrs_id> <value>"),
> +       STD_METHODCH(set_player_app_value_rsp, "<rsp_status>"),
>         STD_METHODCH(set_volume, "<volume>"),
>         STD_METHOD(cleanup),
>         END_METHOD
> --
> 1.8.3.2

Applied, thanks.


-- 
Luiz Augusto von Dentz

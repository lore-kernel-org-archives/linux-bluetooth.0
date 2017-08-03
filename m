Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <57331670-a1aa-3fa5-1280-86aa997dd2a1@jp.fujitsu.com>
References: <57331670-a1aa-3fa5-1280-86aa997dd2a1@jp.fujitsu.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 3 Aug 2017 12:30:15 +0300
Message-ID: <CABBYNZKSADLQgVy19VBptrw8jxicVpTSgOp56CDP=q0YeE+kdg@mail.gmail.com>
Subject: Re: [PATCH Bluez] profiles: Fix memory leak of avrcp player
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Aram,

On Thu, Aug 3, 2017 at 7:10 AM, ERAMOTO Masaya
<eramoto.masaya@jp.fujitsu.com> wrote:
> Fix the following problem that occurs in the case of D-Bus fails to
> register media player path with org.bluez.MediaPlayer1.

Has this actually happened? Im asking because if that does happen it
probably because the already exists and we might want to return it
instead, though the fix seems good and I might apply it anyway.

>  120 (104 direct, 16 indirect) bytes in 1 blocks are definitely lost in loss record 197 of 235
>     at 0x4C2FB55: calloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
>     by 0x50D2770: g_malloc0 (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
>     by 0x43817A: create_ct_player (avrcp.c:3331)
>     by 0x439928: avrcp_addressed_player_changed (avrcp.c:3639)
>     by 0x439928: avrcp_handle_event (avrcp.c:3716)
>     by 0x42F738: control_response (avctp.c:840)
>     by 0x42F738: session_cb (avctp.c:1005)
>     by 0x50CD049: g_main_context_dispatch (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
>     by 0x50CD3EF: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
>     by 0x50CD711: g_main_loop_run (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
>     by 0x40CD10: main (main.c:778)
> ---
>  profiles/audio/avrcp.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 2c1434d..eaba210 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -3335,8 +3335,11 @@ static struct avrcp_player *create_ct_player(struct avrcp *session,
>         path = device_get_path(session->dev);
>
>         mp = media_player_controller_create(path, id);
> -       if (mp == NULL)
> +       if (mp == NULL) {
> +               g_slist_free(player->sessions);
> +               g_free(player);
>                 return NULL;
> +       }
>
>         media_player_set_callbacks(mp, &ct_cbs, player);
>         player->user_data = mp;
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz

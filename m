Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170207234043.14003-2-eu@felipetonello.com>
References: <20170207234043.14003-1-eu@felipetonello.com> <20170207234043.14003-2-eu@felipetonello.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 8 Feb 2017 14:45:09 +0200
Message-ID: <CABBYNZJ0Cs8UZ9g0hB_mJpTF7jrAwK3JPNuWA1wgwH_fciEFaw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] profiles/midi: Add safer buffer setter function
To: "Felipe F. Tonello" <eu@felipetonello.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Felipe,

On Wed, Feb 8, 2017 at 1:40 AM, Felipe F. Tonello <eu@felipetonello.com> wrote:
> This function helper makes buffer operations more consistent and adds
> boundary check when its available.
>
> Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>

We don't use Signed-off-by on userspace, please remove it.

> ---
>  profiles/midi/libmidi.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/profiles/midi/libmidi.c b/profiles/midi/libmidi.c
> index ac090b59eb60..4b4df799fc2e 100644
> --- a/profiles/midi/libmidi.c
> +++ b/profiles/midi/libmidi.c
> @@ -52,6 +52,13 @@ inline static uint8_t buffer_reverse_get(struct midi_buffer *buffer, size_t i)
>         return buffer->data[buffer->len - (i + 1)];
>  }
>
> +inline static void buffer_reverse_set(struct midi_buffer *buffer, size_t i,
> +                                      const uint8_t byte)
> +{
> +       MIDI_ASSERT(buffer->len > i);
> +       buffer->data[buffer->len - (i + 1)] = byte;
> +}
> +
>  inline static size_t parser_get_available_size(struct midi_write_parser *parser)
>  {
>         return parser->stream_size - parser->midi_stream.len;
> @@ -314,7 +321,7 @@ static size_t handle_end_of_sysex(struct midi_read_parser *parser,
>         time_low = buffer_reverse_get(&parser->sysex_stream, 0) & 0x7F;
>
>         /* Remove timestamp byte */
> -       parser->sysex_stream.data[parser->sysex_stream.len - 1] = 0xF7;
> +       buffer_reverse_set(&parser->sysex_stream, 0, 0xF7);
>
>         /* Update event */
>         update_ev_timestamp(parser, ev, time_low);
> --
> 2.11.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz

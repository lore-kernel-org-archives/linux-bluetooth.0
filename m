Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1462287391-5140-1-git-send-email-vcgomes@gmail.com>
References: <1462287391-5140-1-git-send-email-vcgomes@gmail.com>
Date: Tue, 3 May 2016 18:25:17 +0300
Message-ID: <CABBYNZJUg7JdDuphStvb-n1_q9ssKVVRsx4z4X_e=mondtaOoA@mail.gmail.com>
Subject: Re: [PATCH] gdbus: Fix the ordering of signals
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vinicius Costa Gomes <vcgomes@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Tue, May 3, 2016 at 5:56 PM, Vinicius Costa Gomes <vcgomes@gmail.com> wrote:
> Consider the following example:
>
> /foo
>   properties: "A", "B"
>
> /bar
>   properties: "C", "D"
>
> If during a given mainloop iteration, property "A" of object '/foo' is
> changed, then properties "C" and "D" of '/bar', lastly "B" of '/foo',
> the current code will emit the PropertiesChanged signals in following
> order: "A", "B", "C", "D".
>
> This may confuse applications that have a dependency on the order of
> those signals.
>
> This fixes the ordering, so in the example, the order becomes:
> "C", "D", "A", B". This is considered not to be a problem, as
> applications may use the flag G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH, so
> property changed signals are emitted as soon as possible.
>
> The solution is for each object, to reschedule the signals everytime a
> signal is emitted.

So any changes actually pushes the object to last in the idle queue. I
guess this is fine provided we don't have more problems with this
ordering, this is a bit unfortunate side effect of grouping it seems,
otherwise we would have to emit several more signals to keep the order
the same. We might also keep some documentation about this design
choice though, making clear that in case the object update shall not
be put to last then G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH shall be used.

> ---
>  gdbus/object.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/gdbus/object.c b/gdbus/object.c
> index a220101..fc94e5e 100644
> --- a/gdbus/object.c
> +++ b/gdbus/object.c
> @@ -635,11 +635,16 @@ static gboolean g_dbus_args_have_signature(const GDBusArgInfo *args,
>
>  static void add_pending(struct generic_data *data)
>  {
> -       if (data->process_id > 0)
> -               return;
> +       guint old_id = data->process_id;

Actually why didn't you just replace the return with
g_source_remove(data->process_id)? I guess that should be enough to
force it last since g_idle_add should probably be using a list and
appending the data it should be enough to move it back after others.

>         data->process_id = g_idle_add(process_changes, data);
>
> +       if (old_id > 0) {
> +               /* If there was an old idler, remove it. */
> +               g_source_remove(old_id);
> +               return;
> +       }
> +
>         pending = g_slist_append(pending, data);
>  }
>
> --
> 2.8.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz

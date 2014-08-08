Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1407402231-32496-1-git-send-email-luiz.dentz@gmail.com>
References: <1407402231-32496-1-git-send-email-luiz.dentz@gmail.com>
Date: Fri, 8 Aug 2014 14:01:52 +0300
Message-ID: <CABBYNZKnSMJehqJ6HpoYP3kVfnRDE9Upf33rsQHJJA99Ef9RFA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] input/hog: Remove unnecessary variables
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Aug 7, 2014 at 12:03 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> ---
>  profiles/input/hog.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/profiles/input/hog.c b/profiles/input/hog.c
> index 30f9ed1..b9aba65 100644
> --- a/profiles/input/hog.c
> +++ b/profiles/input/hog.c
> @@ -333,33 +333,30 @@ static void forward_report(struct uhid_event *ev, void *user_data)
>         struct report *report, cmp;
>         GSList *l;
>         uint8_t *data;
> -       int size, type, id;
> +       int size;
>
>         switch (ev->u.output.rtype) {
>         case UHID_FEATURE_REPORT:
> -               type = HOG_REPORT_TYPE_FEATURE;
> +               cmp.type = HOG_REPORT_TYPE_FEATURE;
>                 break;
>         case UHID_OUTPUT_REPORT:
> -               type = HOG_REPORT_TYPE_OUTPUT;
> +               cmp.type = HOG_REPORT_TYPE_OUTPUT;
>                 break;
>         case UHID_INPUT_REPORT:
> -               type = HOG_REPORT_TYPE_INPUT;
> +               cmp.type = HOG_REPORT_TYPE_INPUT;
>                 break;
>         default:
>                 return;
>         }
>
> -       id = 0;
> +       cmp.id = 0;
>         data = ev->u.output.data;
>         size = ev->u.output.size;
>         if (hogdev->has_report_id && size > 0) {
> -               id = *data++;
> +               cmp.id = *data++;
>                 --size;
>         }
>
> -       cmp.type = type;
> -       cmp.id = id;
> -
>         l = g_slist_find_custom(hogdev->reports, &cmp, report_cmp);
>         if (!l)
>                 return;
> @@ -367,7 +364,7 @@ static void forward_report(struct uhid_event *ev, void *user_data)
>         report = l->data;
>
>         DBG("Sending report type %d ID %d to device 0x%04X handle 0x%X",
> -                       type, id, hogdev->id, report->decl->value_handle);
> +               cmp.type, cmp.id, hogdev->id, report->decl->value_handle);
>
>         if (hogdev->attrib == NULL)
>                 return;
> --
> 1.9.3

Pushed.


-- 
Luiz Augusto von Dentz

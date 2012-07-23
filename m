Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1342533594-10413-4-git-send-email-chen.ganir@ti.com>
References: <1342533594-10413-1-git-send-email-chen.ganir@ti.com>
	<1342533594-10413-4-git-send-email-chen.ganir@ti.com>
Date: Mon, 23 Jul 2012 17:08:12 -0300
Message-ID: <CAKT1EBfTdVRp8i+atCQOLTNvv8kbRutmK03MYXRUaOuwNcuiog@mail.gmail.com>
Subject: Re: [PATCH 3/9] Battery: Discover Characteristic Descriptors
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Chen Ganir <chen.ganir@ti.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen Ganir:

On Tue, Jul 17, 2012 at 10:59 AM, Chen Ganir <chen.ganir@ti.com> wrote:
> Discover all characteristic descriptors, and build a descriptor
> list
> ---
>  profiles/batterystate/batterystate.c |   70 ++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>
> diff --git a/profiles/batterystate/batterystate.c b/profiles/batterystate/batterystate.c
> index 40663f6..18045ed 100644
> --- a/profiles/batterystate/batterystate.c
> +++ b/profiles/batterystate/batterystate.c
> @@ -50,8 +50,24 @@ static GSList *servers;
>  struct characteristic {
>         struct gatt_char        attr;   /* Characteristic */
>         struct battery          *batt;  /* Parent Battery Service */
> +       GSList                          *desc;  /* Descriptors */
>  };
>
> +struct descriptor {
> +       struct characteristic   *ch;    /* Parent Characteristic */
> +       uint16_t                handle; /* Descriptor Handle */
> +       bt_uuid_t               uuid;   /* UUID */
> +};
> +
> +static void char_free(gpointer user_data)
> +{
> +       struct characteristic *c = user_data;
> +
> +       g_slist_free_full(c->desc, g_free);
> +
> +       g_free(c);
> +}

Please fix the following warning:

profiles/batterystate/batterystate.c:62:13: error: 'char_free' defined
but not used [-Werror=unused-function]
cc1: all warnings being treated as errors

BR,
Claudio

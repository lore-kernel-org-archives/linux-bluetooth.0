Return-Path: <luiz.dentz@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1490971474-9719-1-git-send-email-bergo.torino@gmail.com>
References: <1490958237-9299-1-git-send-email-bergo.torino@gmail.com> <1490971474-9719-1-git-send-email-bergo.torino@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 3 Apr 2017 14:08:24 +0300
Message-ID: <CABBYNZLNGfZuw3qAXj5wTtNPXdxL3qTYD87TRZRBS1owN6U=FQ@mail.gmail.com>
Subject: Re: [PATCH v2] core: replace sizeof(filename) with PATH_MAX
To: Konrad Zapalowicz <konrad.zapalowicz@canonical.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Konrad,

On Fri, Mar 31, 2017 at 5:44 PM, Konrad Zapalowicz
<konrad.zapalowicz@canonical.com> wrote:
> From: Konrad Zapa=C5=82owicz <konrad.zapalowicz@canonical.com>
>
> This commit replaces sizeof(filename) with PATH_MAX to match the common
> scheme which is used in other places.
> ---
>  src/adapter.c     | 2 +-
>  src/shared/util.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 3dac7d6..3935460 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -7107,7 +7107,7 @@ static void store_csrk(struct btd_adapter *adapter,=
 const bdaddr_t *peer,
>
>         ba2str(peer, device_addr);
>
> -       snprintf(filename, sizeof(filename), STORAGEDIR "/%s/%s/info",
> +       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
>                                         adapter_dir(adapter), device_addr=
);
>
>         key_file =3D g_key_file_new();
> diff --git a/src/shared/util.c b/src/shared/util.c
> index 7878552..4b59fad 100644
> --- a/src/shared/util.c
> +++ b/src/shared/util.c
> @@ -117,7 +117,7 @@ unsigned char util_get_dt(const char *parent, const c=
har *name)
>         char filename[PATH_MAX];
>         struct stat st;
>
> -       snprintf(filename, sizeof(filename), "%s/%s", parent, name);
> +       snprintf(filename, PATH_MAX, "%s/%s", parent, name);
>         if (lstat(filename, &st) =3D=3D 0 && S_ISDIR(st.st_mode))
>                 return DT_DIR;
>
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Applied, thanks.

--=20
Luiz Augusto von Dentz

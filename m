Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0ff16352-9a23-f0b1-5691-d521b36dcd8c@jp.fujitsu.com>
References: <0ff16352-9a23-f0b1-5691-d521b36dcd8c@jp.fujitsu.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 26 Oct 2017 15:05:23 +0300
Message-ID: <CABBYNZL6v0qiMJ-73MQmB9nrQhNbq8h0e6fqyBtncRRfTB2E1g@mail.gmail.com>
Subject: Re: [PATCH BlueZ] obexd: Fix compile error due to lack of header
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eramoto,

On Thu, Oct 26, 2017 at 9:05 AM, ERAMOTO Masaya
<eramoto.masaya@jp.fujitsu.com> wrote:
> When compiling with gcc 7.2.0, gcc outputs the following messages.
> This patch adds the header stdlib.h to each obex-related header including
> functions with the type ssize_t, so the same problem does not also happen
> in case using there headers individually.

Weird this is just happening now, so what did change in 7.2? Usually
we have stdlib.h included in the c file not in the header.

>   In file included from obexd/plugins/mas.c:41:0:
>   ./obexd/src/obex.h:37:1: error: unknown type name =E2=80=98ssize_t=E2=
=80=99; did you mean =E2=80=98size_t=E2=80=99?
>    ssize_t obex_get_size(struct obex_session *os);
>    ^~~~~~~
>    size_t
>   ./obexd/src/obex.h:45:1: error: unknown type name =E2=80=98ssize_t=E2=
=80=99; did you mean =E2=80=98size_t=E2=80=99?
>    ssize_t obex_get_apparam(struct obex_session *os, const uint8_t **buff=
er);
>    ^~~~~~~
>    size_t
>   ./obexd/src/obex.h:46:1: error: unknown type name =E2=80=98ssize_t=E2=
=80=99; did you mean =E2=80=98size_t=E2=80=99?
>    ssize_t obex_get_non_header_data(struct obex_session *os,
>    ^~~~~~~
>    size_t
>   In file included from obexd/plugins/mas.c:43:0:
>   ./obexd/src/mimetype.h:36:2: error: expected specifier-qualifier-list b=
efore =E2=80=98ssize_t=E2=80=99
>     ssize_t (*get_next_header)(void *object, void *buf, size_t mtu,
>     ^~~~~~~
>   In file included from obexd/plugins/mas.c:46:0:
>   obexd/plugins/filesystem.h:24:1: error: unknown type name =E2=80=98ssiz=
e_t=E2=80=99; did you mean =E2=80=98size_t=E2=80=99?
>    ssize_t string_read(void *object, void *buf, size_t count);
>    ^~~~~~~
>    size_t
> ---
>  obexd/plugins/filesystem.h | 2 ++
>  obexd/src/mimetype.h       | 2 ++
>  obexd/src/obex.h           | 2 ++
>  3 files changed, 6 insertions(+)
>
> diff --git a/obexd/plugins/filesystem.h b/obexd/plugins/filesystem.h
> index f95773beb..441b377a2 100644
> --- a/obexd/plugins/filesystem.h
> +++ b/obexd/plugins/filesystem.h
> @@ -21,6 +21,8 @@
>   *
>   */
>
> +#include <stdlib.h>
> +
>  ssize_t string_read(void *object, void *buf, size_t count);
>  gboolean is_filename(const char *name);
>  int verify_path(const char *path);
> diff --git a/obexd/src/mimetype.h b/obexd/src/mimetype.h
> index 79529b890..52b544073 100644
> --- a/obexd/src/mimetype.h
> +++ b/obexd/src/mimetype.h
> @@ -21,6 +21,8 @@
>   *
>   */
>
> +#include <stdlib.h>
> +
>  typedef gboolean (*obex_object_io_func) (void *object, int flags, int er=
r,
>                                                         void *user_data);
>
> diff --git a/obexd/src/obex.h b/obexd/src/obex.h
> index fc1674755..769bbcd8a 100644
> --- a/obexd/src/obex.h
> +++ b/obexd/src/obex.h
> @@ -22,6 +22,8 @@
>   *
>   */
>
> +#include <stdlib.h>
> +
>  #define OBJECT_SIZE_UNKNOWN -1
>  #define OBJECT_SIZE_DELETE -2
>
> --
> 2.14.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Luiz Augusto von Dentz

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1384173438-21708-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384173438-21708-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1384173438-21708-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Mon, 11 Nov 2013 15:20:21 +0200
Message-ID: <CABBYNZJMGQHVog9cPDqqLfe7ocdBy4UTrW+T9a6SjWWE=qd6=w@mail.gmail.com>
Subject: Re: [RFCv1 2/9] android: Avoid unneeded includes
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Nov 11, 2013 at 2:37 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Declare struct mgmt in adapter.h. This avoids including mgmt.h in
> every file using adapter functions like socket and hid.
> ---
>  android/adapter.h |    2 ++
>  android/hidhost.c |    1 -
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/android/adapter.h b/android/adapter.h
> index c62b859..3bda9d9 100644
> --- a/android/adapter.h
> +++ b/android/adapter.h
> @@ -23,6 +23,8 @@
>
>  typedef void (*bt_adapter_ready)(int err);
>
> +struct mgmt;
> +
>  void bt_adapter_init(uint16_t index, struct mgmt *mgmt_if,
>                                                         bt_adapter_ready cb);
>
> diff --git a/android/hidhost.c b/android/hidhost.c
> index 683938f..8c3e9f6 100644
> --- a/android/hidhost.c
> +++ b/android/hidhost.c
> @@ -38,7 +38,6 @@
>  #include "lib/sdp.h"
>  #include "lib/sdp_lib.h"
>  #include "lib/uuid.h"
> -#include "src/shared/mgmt.h"
>  #include "src/sdp-client.h"
>  #include "src/glib-helper.h"
>  #include "profiles/input/uhid_copy.h"
> --
> 1.7.10.4

Well it looks like we need to find a proper place for the mgmt
interaction, or then perhaps pass the fd and use mgmt_new on adapter
but that seems to require some work as it does create a different mgmt
objects with different queues which I don't think is safe to use.


-- 
Luiz Augusto von Dentz

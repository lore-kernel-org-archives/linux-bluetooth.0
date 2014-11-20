Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1416459821-16478-1-git-send-email-armansito@chromium.org>
References: <1416459821-16478-1-git-send-email-armansito@chromium.org>
Date: Thu, 20 Nov 2014 15:54:18 -0800
Message-ID: <CAHrH25TwHi2pJzsBqKm-4tZWZ8jPfpnJcq415RG6zCmSbiGUpw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] shared/gatt-server: Fix bug in bt_gatt_server_unref.
From: Arman Uguray <armansito@chromium.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> On Wed, Nov 19, 2014 at 9:03 PM, Arman Uguray <armansito@chromium.org> wrote:
> This patch adds a check for NULL argument in bt_gatt_server_unref.
> ---
>  src/shared/gatt-server.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
> index 2ef9269..ef91289 100644
> --- a/src/shared/gatt-server.c
> +++ b/src/shared/gatt-server.c
> @@ -1215,6 +1215,9 @@ struct bt_gatt_server *bt_gatt_server_ref(struct bt_gatt_server *server)
>
>  void bt_gatt_server_unref(struct bt_gatt_server *server)
>  {
> +       if (!server)
> +               return;
> +
>         if (__sync_sub_and_fetch(&server->ref_count, 1))
>                 return;
>
> --
> 2.1.0.rc2.206.gedb03e5
>

ping.

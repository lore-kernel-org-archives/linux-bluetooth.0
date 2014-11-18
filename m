Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1416240492-6122-1-git-send-email-armansito@chromium.org>
References: <1416240492-6122-1-git-send-email-armansito@chromium.org>
Date: Tue, 18 Nov 2014 17:16:33 +0200
Message-ID: <CABBYNZKLGRM2WzN=gDuuzYBN66b5=ZYkeKdtN_R+AKKdTcwoLA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] tools/btgatt-server: Free and early return if
 device name has length 0.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Mon, Nov 17, 2014 at 6:08 PM, Arman Uguray <armansito@chromium.org> wrote:
> In the write callback for the device name characteristic, we should
> check early if the value is being truncated completely and free the
> value and return. Otherwise, the realloc call might correctly return
> NULL if called with a length of 0, which would be incorrectly treated as
> an error.
> ---
>  tools/btgatt-server.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
> index 2b89be1..c603b30 100644
> --- a/tools/btgatt-server.c
> +++ b/tools/btgatt-server.c
> @@ -160,6 +160,14 @@ static void gap_device_name_write_cb(struct gatt_db_attribute *attrib,
>
>         PRLOG("GAP Device Name Write called\n");
>
> +       /* If the value is being completely truncated, clean up and return */
> +       if (!(offset + len)) {
> +               free(server->device_name);
> +               server->device_name = NULL;
> +               server->name_len = 0;
> +               goto done;
> +       }
> +
>         /* Implement this as a variable length attribute value. */
>         if (offset > server->name_len) {
>                 error = BT_ATT_ERROR_INVALID_OFFSET;
> --
> 2.1.0.rc2.206.gedb03e5

Applied, thanks.


-- 
Luiz Augusto von Dentz

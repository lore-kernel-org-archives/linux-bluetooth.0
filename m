Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1415196669-582-1-git-send-email-luiz.dentz@gmail.com>
References: <1415196669-582-1-git-send-email-luiz.dentz@gmail.com>
Date: Thu, 6 Nov 2014 17:44:22 +0200
Message-ID: <CABBYNZ+3Qn6XAMcERgvF-DrT6cguWK4_AZCHm9hJvbmW89sbfA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] android/tester-gatt: Print handle for write
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Nov 5, 2014 at 4:11 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> ---
>  android/tester-gatt.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/android/tester-gatt.c b/android/tester-gatt.c
> index f99100d..97473e5 100644
> --- a/android/tester-gatt.c
> +++ b/android/tester-gatt.c
> @@ -1180,6 +1180,9 @@ static void gatt_att_pdu_modify(void)
>                 memcpy(raw_pdu + 1, &handle, sizeof(handle));
>                 memcpy(raw_pdu + 3, value, set_data_len - sizeof(handle));
>
> +               tester_debug("gatt: modify pdu write request handle to 0x%02x",
> +                                                                       handle);
> +
>                 break;
>         }
>         default:
> --
> 1.9.3

Both patches have been applied.


-- 
Luiz Augusto von Dentz

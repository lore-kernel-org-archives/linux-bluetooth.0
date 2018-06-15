Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1528919538-26014-1-git-send-email-tedd.an@linux.intel.com>
References: <1528919538-26014-1-git-send-email-tedd.an@linux.intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 15 Jun 2018 09:41:00 +0300
Message-ID: <CABBYNZ+UrOJVoCk4FCT0cU2PQwk_G49Knj10UtfmJ5QxDGw4Lw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] monitor: Fix printing params for HCI Intel DDC command
To: Tedd Ho-Jeong An <tedd.an@linux.intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Tedd Ho-Jeong An <tedd.an@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

On Wed, Jun 13, 2018 at 10:52 PM, Tedd Ho-Jeong An
<tedd.an@linux.intel.com> wrote:
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
>
> The offset of value for HCI Intel DDC command is incorrect.
> HCI Intel DDC parameter has a combination of following structure:
>
> struct intel_ddc {
>         u8  len;
>         u16 id;
>         u8  *value;
> }
>
> The offset of value should be sum of len and id which is 3.
> ---
>  monitor/intel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/monitor/intel.c b/monitor/intel.c
> index ce624be..4cd1788 100644
> --- a/monitor/intel.c
> +++ b/monitor/intel.c
> @@ -437,7 +437,7 @@ static void ddc_config_write_cmd(const void *data, uint8_t size)
>                 uint16_t param_id = get_le16(data + 1);
>
>                 print_field("Identifier: 0x%4.4x", param_id);
> -               packet_hexdump(data + 2, param_len - 2);
> +               packet_hexdump(data + 3, param_len - 2);
>
>                 data += param_len + 1;
>                 size -= param_len + 1;
> --
> 2.7.4

Applied, thanks.

-- 
Luiz Augusto von Dentz

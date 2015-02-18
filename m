Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1424243241-4294-1-git-send-email-bharat.panda@samsung.com>
References: <1424243241-4294-1-git-send-email-bharat.panda@samsung.com>
Date: Wed, 18 Feb 2015 10:37:09 +0200
Message-ID: <CABBYNZLT=x9UgM28MFU3ve88+k+WBbmEJH_bpC2Tm-C6W5x7Jw@mail.gmail.com>
Subject: Re: [PATCH v3] tools/btgatt-client: print read/write err messages
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bharat Panda <bharat.panda@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bharat,

On Wed, Feb 18, 2015 at 9:07 AM, Bharat Panda <bharat.panda@samsung.com> wrote:
> Convert att error codes to error messages for gatt read/write
> responses.
>
> e.g.
>
> [GATT client]# read-value 0x00D9
> [GATT client]#
> Read request failed: Authorization Required (0x08)
>
> [GATT client]# read-value 0x01E2
> [GATT client]#
> Read request failed: Invalid Handle (0x01)
> ---
>  tools/btgatt-client.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 48 insertions(+), 3 deletions(-)
>
> diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
> index cca3e2c..e59d5db 100644
> --- a/tools/btgatt-client.c
> +++ b/tools/btgatt-client.c
> @@ -74,6 +74,48 @@ static void print_prompt(void)
>         fflush(stdout);
>  }
>
> +static const char *ecode_to_string(uint8_t ecode)
> +{
> +       switch (ecode) {
> +       case BT_ATT_ERROR_INVALID_HANDLE:
> +               return "Invalid Handle";
> +       case BT_ATT_ERROR_READ_NOT_PERMITTED:
> +               return "Read Not Permitted";
> +       case BT_ATT_ERROR_WRITE_NOT_PERMITTED:
> +               return "Write Not Permitted";
> +       case BT_ATT_ERROR_INVALID_PDU:
> +               return "Invalid PDU";
> +       case BT_ATT_ERROR_AUTHENTICATION:
> +               return "Authentication Required";
> +       case BT_ATT_ERROR_REQUEST_NOT_SUPPORTED:
> +               return "Request Not Supported";
> +       case BT_ATT_ERROR_INVALID_OFFSET:
> +               return "Invalid Offset";
> +       case BT_ATT_ERROR_AUTHORIZATION:
> +               return "Authorization Required";
> +       case BT_ATT_ERROR_PREPARE_QUEUE_FULL:
> +               return "Prepare Write Queue Full";
> +       case BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND:
> +               return "Attribute Not Found";
> +       case BT_ATT_ERROR_ATTRIBUTE_NOT_LONG:
> +               return "Attribute Not Long";
> +       case BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION_KEY_SIZE:
> +               return "Insuficient Encryption Key Size";
> +       case BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN:
> +               return "Invalid Attribute value len";
> +       case BT_ATT_ERROR_UNLIKELY:
> +               return "Unlikely Error";
> +       case BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION:
> +               return "Insufficient Encryption";
> +       case BT_ATT_ERROR_UNSUPPORTED_GROUP_TYPE:
> +               return "Group type Not Supported";
> +       case BT_ATT_ERROR_INSUFFICIENT_RESOURCES:
> +               return "Insufficient Resources";
> +       default:
> +               return "Unknown error type";
> +       }
> +}
> +
>  static void att_disconnect_cb(int err, void *user_data)
>  {
>         printf("Device disconnected: %s\n", strerror(err));
> @@ -489,7 +531,8 @@ static void read_cb(bool success, uint8_t att_ecode, const uint8_t *value,
>         int i;
>
>         if (!success) {
> -               PRLOG("\nRead request failed: 0x%02x\n", att_ecode);
> +               PRLOG("\nRead request failed: %s (0x%02x)\n",
> +                               ecode_to_string(att_ecode), att_ecode);
>                 return;
>         }
>
> @@ -596,7 +639,8 @@ static void write_cb(bool success, uint8_t att_ecode, void *user_data)
>         if (success) {
>                 PRLOG("\nWrite successful\n");
>         } else {
> -               PRLOG("\nWrite failed: 0x%02x\n", att_ecode);
> +               PRLOG("\nWrite failed: %s (0x%02x)\n",
> +                               ecode_to_string(att_ecode), att_ecode);
>         }
>  }
>
> @@ -726,7 +770,8 @@ static void write_long_cb(bool success, bool reliable_error, uint8_t att_ecode,
>         } else if (reliable_error) {
>                 PRLOG("Reliable write not verified\n");
>         } else {
> -               PRLOG("Write failed: 0x%02x\n", att_ecode);
> +               PRLOG("\nWrite failed: %s (0x%02x)\n",
> +                               ecode_to_string(att_ecode), att_ecode);
>         }
>  }
>
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz

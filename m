Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1444728648-9374-1-git-send-email-luiz.dentz@gmail.com>
References: <1444728648-9374-1-git-send-email-luiz.dentz@gmail.com>
Date: Wed, 14 Oct 2015 11:08:55 +0300
Message-ID: <CABBYNZK4WvD9SeiR+ODTRSyLB0YzxhU4w7-gtNYyTnW1WGdAvQ@mail.gmail.com>
Subject: Re: [PATCH v2 BlueZ] monitor/avctp: Decode player features
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Oct 13, 2015 at 12:30 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This decodes the bits related to browsing channel which is useful to
> debug:
>
>> ACL Data RX: Handle 256 flags 0x02 dlen 68
>       Channel: 69 len 64 ctrl 0x0100 [PSM 27 mode 3] {chan 5}
>       I-frame: Unsegmented TxSeq 0 ReqSeq 1
>       AVCTP Browsing: Response: type 0x00 label 0 PID 0x110e
>         AVRCP: GetFolderItems: len 0x0036
>           Status: 0x04 (Success)
>           UIDCounter: 0x0000 (0)
>           NumOfItems: 0x0001 (1)
>           Item: 0x01 (Media Player)
>           Length: 0x002e (46)
>           PlayerID: 0x0001 (1)
>           PlayerType: 0x0001 (Audio)
>           PlayerSubType: 0x00000000 (None)
>           PlayStatus: 0x01 (PLAYING)
>           Features: 0x00000000003700050000000000000000
>             Advanced Control Player
>             Browsing
>             NowPlaying
> ---
>  monitor/avctp.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/monitor/avctp.c b/monitor/avctp.c
> index d06640e..232365e 100644
> --- a/monitor/avctp.c
> +++ b/monitor/avctp.c
> @@ -1813,6 +1813,45 @@ response:
>         return true;
>  }
>
> +
> +static struct {
> +       const char *str;
> +       bool reserved;
> +} features_table[] = {
> +       /* Ignore passthrough bits */
> +       [58] = { "Advanced Control Player" },
> +       [59] = { "Browsing" },
> +       [60] = { "Searching" },
> +       [61] = { "AddToNowPlaying" },
> +       [62] = { "Unique UIDs" },
> +       [63] = { "OnlyBrowsableWhenAddressed" },
> +       [64] = { "OnlySearchableWhenAddressed" },
> +       [65] = { "NowPlaying" },
> +       [66] = { "UIDPersistency" },
> +       /* 67-127 reserved */
> +       [67 ... 127] = { .reserved = true },
> +};
> +
> +static void print_features(uint8_t features[16], uint8_t indent)
> +{
> +       int i;
> +
> +       for (i = 0; i < 127; i++) {
> +               if (!(features[i / 8] & (1 << (i % 8))))
> +                       continue;
> +
> +               if (features_table[i].reserved) {
> +                       print_text(COLOR_WHITE_BG, "Unknown bit %u", i);
> +                       continue;
> +               }
> +
> +               if (!features_table[i].str)
> +                       continue;
> +
> +               print_field("%*c%s", indent, ' ', features_table[i].str);
> +       }
> +}
> +
>  static bool avrcp_media_player_item(struct avctp_frame *avctp_frame,
>                                                         uint8_t indent)
>  {
> @@ -1856,6 +1895,8 @@ static bool avrcp_media_player_item(struct avctp_frame *avctp_frame,
>
>         printf("\n");
>
> +       print_features(features, indent + 2);
> +
>         if (!l2cap_frame_get_be16(frame, &charset))
>                 return false;
>
> --
> 2.4.3

Applied.


-- 
Luiz Augusto von Dentz

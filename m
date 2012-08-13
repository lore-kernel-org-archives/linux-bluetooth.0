Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1344591300-1003-1-git-send-email-vani.patel@stericsson.com>
References: <1344591300-1003-1-git-send-email-vani.patel@stericsson.com>
Date: Mon, 13 Aug 2012 14:27:20 +0300
Message-ID: <CABBYNZLMLCpfd_GzUMvtND6m0JJsuKLDCiyzvQAZkBrsV5U7vw@mail.gmail.com>
Subject: Re: [PATCH BlueZ V5 1/5] AVRCP: Add TG Record to support AVRCP Browsing
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vani-dineshbhai PATEL <vani.patel@stericsson.com>
Cc: User Name <linux-bluetooth@vger.kernel.org>,
	Joohi <Joohi.rastogi@stericsson.com>, Vani <vani273@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vani,

On Fri, Aug 10, 2012 at 12:35 PM, Vani-dineshbhai PATEL
<vani.patel@stericsson.com> wrote:
> From: Vani Patel <vani.patel@stericsson.com>
>
> Adds SDP record to support browsing
> ---
>  audio/avctp.c |    4 ++--
>  audio/avctp.h |    3 ++-
>  audio/avrcp.c |   25 +++++++++++++++++++++----
>  3 files changed, 25 insertions(+), 7 deletions(-)
>
> diff --git a/audio/avctp.c b/audio/avctp.c
> index 074eabd..a20dba9 100644
> --- a/audio/avctp.c
> +++ b/audio/avctp.c
> @@ -802,7 +802,7 @@ static GIOChannel *avctp_server_socket(const bdaddr_t *src, gboolean master)
>         io = bt_io_listen(BT_IO_L2CAP, NULL, avctp_confirm_cb, NULL,
>                                 NULL, &err,
>                                 BT_IO_OPT_SOURCE_BDADDR, src,
> -                               BT_IO_OPT_PSM, AVCTP_PSM,
> +                               BT_IO_OPT_PSM, AVCTP_CONTROL_PSM,
>                                 BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
>                                 BT_IO_OPT_MASTER, master,
>                                 BT_IO_OPT_INVALID);
> @@ -1090,7 +1090,7 @@ struct avctp *avctp_connect(const bdaddr_t *src, const bdaddr_t *dst)
>         io = bt_io_connect(BT_IO_L2CAP, avctp_connect_cb, session, NULL, &err,
>                                 BT_IO_OPT_SOURCE_BDADDR, &session->server->src,
>                                 BT_IO_OPT_DEST_BDADDR, &session->dst,
> -                               BT_IO_OPT_PSM, AVCTP_PSM,
> +                               BT_IO_OPT_PSM, AVCTP_CONTROL_PSM,
>                                 BT_IO_OPT_INVALID);
>         if (err) {
>                 avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
> diff --git a/audio/avctp.h b/audio/avctp.h
> index d0cbd97..34b0c1c 100644
> --- a/audio/avctp.h
> +++ b/audio/avctp.h
> @@ -22,7 +22,8 @@
>   *
>   */
>
> -#define AVCTP_PSM 23
> +#define AVCTP_CONTROL_PSM      23
> +#define AVCTP_BROWSING_PSM     27
>
>  #define AVC_MTU 512
>  #define AVC_HEADER_LENGTH 3
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index d925365..ca40c1e 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -190,7 +190,7 @@ static sdp_record_t *avrcp_ct_record(void)
>         sdp_list_t *aproto, *proto[2];
>         sdp_record_t *record;
>         sdp_data_t *psm, *version, *features;
> -       uint16_t lp = AVCTP_PSM;
> +       uint16_t lp = AVCTP_CONTROL_PSM;
>         uint16_t avrcp_ver = 0x0100, avctp_ver = 0x0103;
>         uint16_t feat = ( AVRCP_FEATURE_CATEGORY_1 |
>                                                 AVRCP_FEATURE_CATEGORY_2 |
> @@ -252,13 +252,15 @@ static sdp_record_t *avrcp_ct_record(void)
>
>  static sdp_record_t *avrcp_tg_record(void)
>  {
> -       sdp_list_t *svclass_id, *pfseq, *apseq, *root;
> +       sdp_list_t *svclass_id, *pfseq, *apseq, *root, *apseq_browsing;
>         uuid_t root_uuid, l2cap, avctp, avrtg;
>         sdp_profile_desc_t profile[1];
>         sdp_list_t *aproto, *proto[2];
>         sdp_record_t *record;
> -       sdp_data_t *psm, *version, *features;
> -       uint16_t lp = AVCTP_PSM;
> +       sdp_data_t *psm, *version, *features, *psm_browsing;
> +       sdp_list_t *aproto_browsing, *proto_browsing[2] = {0};
> +       uint16_t lp = AVCTP_CONTROL_PSM;
> +       uint16_t lp_browsing = AVCTP_BROWSING_PSM;
>         uint16_t avrcp_ver = 0x0104, avctp_ver = 0x0103;
>         uint16_t feat = ( AVRCP_FEATURE_CATEGORY_1 |
>                                         AVRCP_FEATURE_CATEGORY_2 |

According to the spec if we register the browsing channel we should
set it in feature bits, btw apparently apseq_browsing is leaking
please make sure you run your patches with valgrind/gdb to catch this
type of errors.

-- 
Luiz Augusto von Dentz

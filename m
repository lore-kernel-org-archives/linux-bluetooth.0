Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1341912856-27192-1-git-send-email-vani.patel@stericsson.com>
References: <1341912856-27192-1-git-send-email-vani.patel@stericsson.com>
Date: Tue, 17 Jul 2012 11:44:39 +0300
Message-ID: <CABBYNZ+n91nT8tZ1ceBsAc_i76T0iT6bfLWp00n25Scrumptdg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/5] AVRCP: Rename variables used for control
 channel to improve redability
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vani-dineshbhai PATEL <vani.patel@stericsson.com>
Cc: User Name <linux-bluetooth@vger.kernel.org>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	Joohi <Joohi.rastogi@stericsson.com>, Vani <vani273@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vani,

On Tue, Jul 10, 2012 at 12:34 PM, Vani-dineshbhai PATEL
<vani.patel@stericsson.com> wrote:
> -typedef size_t (*avctp_pdu_cb) (struct avctp *session, uint8_t transaction,
> +typedef size_t (*avctp_control_pdu_cb) (struct avctp *session,
> +                                       uint8_t transaction,
>                                         uint8_t *code, uint8_t *subunit,
>                                         uint8_t *operands, size_t operand_count,
>                                         void *user_data);

Do you really need to change this, does the callback need to be
different for browsing?

> @@ -93,7 +94,7 @@ struct avctp *avctp_connect(const bdaddr_t *src, const bdaddr_t *dst);
>  struct avctp *avctp_get(const bdaddr_t *src, const bdaddr_t *dst);
>  void avctp_disconnect(struct avctp *session);
>
> -unsigned int avctp_register_pdu_handler(uint8_t opcode, avctp_pdu_cb cb,
> +unsigned int avctp_register_pdu_handler(uint8_t opcode, avctp_control_pdu_cb cb,
>                                                         void *user_data);

Same here, if we can keep the callback then we just need a single
function to register, internally we can add to different list.

-- 
Luiz Augusto von Dentz

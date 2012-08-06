Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1343976273-13448-1-git-send-email-vani.patel@stericsson.com>
References: <1343976273-13448-1-git-send-email-vani.patel@stericsson.com>
Date: Mon, 6 Aug 2012 11:20:32 +0300
Message-ID: <CABBYNZLY4msobcmFXW+u1gzwrBC-7KgED0VDaJ_2gqF5PZE_kw@mail.gmail.com>
Subject: Re: [PATCH BlueZ V2 2/5] AVRCP: Rename variables used for control
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vani-dineshbhai PATEL <vani.patel@stericsson.com>
Cc: User Name <linux-bluetooth@vger.kernel.org>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	Joohi <Joohi.rastogi@stericsson.com>, Vani <vani273@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vani,

On Fri, Aug 3, 2012 at 9:44 AM, Vani-dineshbhai PATEL
<vani.patel@stericsson.com> wrote:
> -       err = avctp_send_vendordep(player->session, player->transaction_events[id],
> +       err = avctp_send_vendordep(player->session,
> +                                       player->transaction_events[id],
>                                         AVC_CTYPE_CHANGED, AVC_SUBUNIT_PANEL,
>                                         buf, size + AVRCP_HEADER_LENGTH);

Git complain about this line, apparently you are leaving a whitespace:

Applying: AVRCP: Rename variables used for control
/home/vudentz/git/bluez/.git/rebase-apply/patch:390: trailing whitespace.
	err = avctp_send_vendordep(player->session,
fatal: 1 line adds whitespace errors.

>         if (err < 0)
> @@ -914,7 +915,7 @@ static uint8_t avrcp_handle_get_play_status(struct avrcp_player *player,
>
>         memcpy(&pdu->params[0], &duration, 4);
>         memcpy(&pdu->params[4], &position, 4);
> -       pdu->params[8] = player->cb->get_status(player->user_data);;
> +       pdu->params[8] = player->cb->get_status(player->user_data);

This one should be fixed in separate, it has nothing to do with other
changes you are introducing and could probably be applied very
quickly.

-- 
Luiz Augusto von Dentz

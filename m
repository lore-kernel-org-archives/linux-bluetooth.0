Return-Path: <cyrus@holtmann.org>
From: Vani-dineshbhai PATEL X <vani.patel@stericsson.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: User Name <linux-bluetooth@vger.kernel.org>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	Joohi RASTOGI <joohi.rastogi@stericsson.com>,
	Vani <vani273@gmail.com>
Date: Mon, 6 Aug 2012 10:47:27 +0200
Subject: RE: [PATCH BlueZ V2 2/5] AVRCP: Rename variables used for control
Message-ID: <747C1E83C744F44E9ACFB89FAEEC2C7B23D486AF3D@EXDCVYMBSTM005.EQ1STM.local>
References: <1343976273-13448-1-git-send-email-vani.patel@stericsson.com>
 <CABBYNZLY4msobcmFXW+u1gzwrBC-7KgED0VDaJ_2gqF5PZE_kw@mail.gmail.com>
In-Reply-To: <CABBYNZLY4msobcmFXW+u1gzwrBC-7KgED0VDaJ_2gqF5PZE_kw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> Sent: Monday, August 06, 2012 1:51 PM
> To: Vani-dineshbhai PATEL X
> Cc: User Name; Lucas De Marchi; Joohi RASTOGI; Vani
> Subject: Re: [PATCH BlueZ V2 2/5] AVRCP: Rename variables used for control
> 
> Hi Vani,
> 
> On Fri, Aug 3, 2012 at 9:44 AM, Vani-dineshbhai PATEL
> <vani.patel@stericsson.com> wrote:
> > -       err = avctp_send_vendordep(player->session, player-
> >transaction_events[id],
> > +       err = avctp_send_vendordep(player->session,
> > +
> > + player->transaction_events[id],
> >                                         AVC_CTYPE_CHANGED, AVC_SUBUNIT_PANEL,
> >                                         buf, size +
> > AVRCP_HEADER_LENGTH);
> 
> Git complain about this line, apparently you are leaving a whitespace:
> 
> Applying: AVRCP: Rename variables used for control
> /home/vudentz/git/bluez/.git/rebase-apply/patch:390: trailing whitespace.
> 	err = avctp_send_vendordep(player->session,
> fatal: 1 line adds whitespace errors.

Fixed and re-sent the patch.
> 
> >         if (err < 0)
> > @@ -914,7 +915,7 @@ static uint8_t avrcp_handle_get_play_status(struct
> > avrcp_player *player,
> >
> >         memcpy(&pdu->params[0], &duration, 4);
> >         memcpy(&pdu->params[4], &position, 4);
> > -       pdu->params[8] = player->cb->get_status(player->user_data);;
> > +       pdu->params[8] = player->cb->get_status(player->user_data);
> 
> This one should be fixed in separate, it has nothing to do with other changes
> you are introducing and could probably be applied very quickly.
> 

I have removed such changes and re-sent the patch. Will create new patch with such formatting errors.

> --
> Luiz Augusto von Dentz

Thanks & Regards,
Vani

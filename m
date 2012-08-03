Return-Path: <cyrus@holtmann.org>
From: Vani-dineshbhai PATEL X <vani.patel@stericsson.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: User Name <linux-bluetooth@vger.kernel.org>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	Joohi RASTOGI <joohi.rastogi@stericsson.com>,
	Vani <vani273@gmail.com>
Date: Fri, 3 Aug 2012 08:40:55 +0200
Subject: RE: [PATCH BlueZ 5/5] AVRCP: Add handler for browsing pdu
Message-ID: <747C1E83C744F44E9ACFB89FAEEC2C7B23D486AAAA@EXDCVYMBSTM005.EQ1STM.local>
References: <1341913055-19754-1-git-send-email-vani.patel@stericsson.com>
 <CABBYNZKAVFrZumVP+EyUR6=k9vAzp3T43-8u+Gevzg4d-5q64w@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> -----Original Message-----
> From: Vani-dineshbhai PATEL X
> Sent: Wednesday, July 18, 2012 4:19 PM
> To: 'Luiz Augusto von Dentz'
> Cc: User Name; Lucas De Marchi; Joohi RASTOGI; Vani
> Subject: RE: [PATCH BlueZ 5/5] AVRCP: Add handler for browsing pdu
> 
...
> > >         case AVCTP_STATE_CONNECTING:
> > > @@ -1244,6 +1315,12 @@ static void state_changed(struct audio_device
> > *dev, avctp_state_t old_state,
> > >                                                         AVC_OP_VENDORDEP,
> > >                                                         handle_vendordep_pdu,
> > >                                                         player);
> > > +               if (!player->browsing_handler)
> > > +                       player->browsing_handler =
> > > +                                       avctp_register_browsing_pdu_handler(
> > > +                                                       handle_browsing_pdu,
> > > +                                                       player);
> > > +
> >
> > avctp_register_browsing_pdu_handler is also too long, in fact this is
> > another that we should probably just reuse avctp_register_pdu_handler
> > and maybe create an opcode for browsing just so that it be can
> > registered using avctp_register_pdu_handler.
> I agree with you Luiz. I will make necessary changes.

Here, the browsing callback function (handle_browsing_pdu ) signature is different than 
control callback function (handle_vendordep_pdu). Hence, the handler shall be different and 
registering this handler is also different. So I will not be able to reuse avctp_register_pdu_handler
& avctp_unregister_pdu_handler. 

The Control handler is a list of handlers  for unit, subunit, passthrough & vendordep.
For browsing, I have not taken the list.

I tried to use the same functions above by generating on Opcode for Browsing, but I feel that defining new 
functions seem better and less complicated. Please review the next patch set and provide your feedback for 
the same.

> >
> >
> > --
> > Luiz Augusto von Dentz
> 
> Thanks & Regards,
> Vani Patel

Thanks & Regards,
Vani Patel

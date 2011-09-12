Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [PATCH BlueZ 2/5] AVRCP: rename avrcp_header to avc_header
Date: Mon, 12 Sep 2011 15:37:13 +0200
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <1315826997-13818-1-git-send-email-luiz.dentz@gmail.com> <1315826997-13818-2-git-send-email-luiz.dentz@gmail.com>  <CAMOw1v4-Rik3EtFhf7Q-YP8Fu2+6TU0FjH4WkkGHqtyu4PBKpQ@mail.gmail.com>
In-Reply-To: <CAMOw1v4-Rik3EtFhf7Q-YP8Fu2+6TU0FjH4WkkGHqtyu4PBKpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201109121537.13920.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> Hi Luiz

> >        sk = g_io_channel_unix_get_fd(control->io);
> > @@ -1451,19 +1451,19 @@ static struct pdu_handler {
> >  /* handle vendordep pdu inside an avctp packet */
> >  static int handle_vendordep_pdu(struct control *control,
> >                                        struct avctp_header *avctp,
> > -                                       struct avrcp_header *avrcp,
> > +                                       struct avc_header *avc,
> >                                        int operand_count)
> >  {
> >        struct pdu_handler *handler;
> > -       struct avrcp_spec_avc_pdu *pdu = (void *) avrcp + AVRCP_HEADER_LENGTH;
> > +       struct avrcp_spec_avc_pdu *pdu = (void *) avc + AVC_HEADER_LENGTH;
> 
> We might want to change this to:
> 
> struct avrcp_spec_avc_pdu *pdu = (avrcp_spec_avc_pdu *)(avc +
> AVC_HEADER_LENGTH);

I don't think this is correct, that would result in jumping
5 * (sizeof (struct avc_header)) bytes..

> This way we kill some warnings on ARM: arithmetic with void pointer

This should happen only if compiling with -Wpointer-arith or -pedantic.

-- 
BR
Szymon Janc

Return-Path: <cyrus@holtmann.org>
From: Vani-dineshbhai PATEL X <vani.patel@stericsson.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: User Name <linux-bluetooth@vger.kernel.org>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	Joohi RASTOGI <joohi.rastogi@stericsson.com>,
	Vani <vani273@gmail.com>
Date: Wed, 18 Jul 2012 12:29:46 +0200
Subject: RE: [PATCH BlueZ 2/5] AVRCP: Rename variables used for control
 channel to improve redability
Message-ID: <747C1E83C744F44E9ACFB89FAEEC2C7B234AABDE5C@EXDCVYMBSTM005.EQ1STM.local>
References: <1341912856-27192-1-git-send-email-vani.patel@stericsson.com>
 <CABBYNZ+n91nT8tZ1ceBsAc_i76T0iT6bfLWp00n25Scrumptdg@mail.gmail.com>
In-Reply-To: <CABBYNZ+n91nT8tZ1ceBsAc_i76T0iT6bfLWp00n25Scrumptdg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> Sent: Tuesday, July 17, 2012 2:15 PM
> To: Vani-dineshbhai PATEL X
> Cc: User Name; Lucas De Marchi; Joohi RASTOGI; Vani
> Subject: Re: [PATCH BlueZ 2/5] AVRCP: Rename variables used for control
> channel to improve redability
> 
> Hi Vani,
> 
> On Tue, Jul 10, 2012 at 12:34 PM, Vani-dineshbhai PATEL
> <vani.patel@stericsson.com> wrote:
> > -typedef size_t (*avctp_pdu_cb) (struct avctp *session, uint8_t
> > transaction,
> > +typedef size_t (*avctp_control_pdu_cb) (struct avctp *session,
> > +                                       uint8_t transaction,
> >                                         uint8_t *code, uint8_t *subunit,
> >                                         uint8_t *operands, size_t operand_count,
> >                                         void *user_data);
> 
> Do you really need to change this, does the callback need to be different for
> browsing?
> 
I used different for browsing as browsing would not require parameters like code, subunit.
But you are right, I can combine and use one. I shall make this change.

> > @@ -93,7 +94,7 @@ struct avctp *avctp_connect(const bdaddr_t *src,
> > const bdaddr_t *dst);  struct avctp *avctp_get(const bdaddr_t *src,
> > const bdaddr_t *dst);  void avctp_disconnect(struct avctp *session);
> >
> > -unsigned int avctp_register_pdu_handler(uint8_t opcode, avctp_pdu_cb
> > cb,
> > +unsigned int avctp_register_pdu_handler(uint8_t opcode,
> > +avctp_control_pdu_cb cb,
> >                                                         void
> > *user_data);
> 
> Same here, if we can keep the callback then we just need a single function
> to register, internally we can add to different list.
> 
Yes, you are correct, we can reuse the same function. I was not using list for storing browsing 
handler (a list is used for control, where there are unit, subunit, passthrough and vendordep). If I reuse
the same, we need to formulate an opcode for browsing. 
But, you are right. I shall merge two functions and avoid duplication of code.
> --
> Luiz Augusto von Dentz

Thanks & Regards,
Vani Patel

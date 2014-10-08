Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	'Dmitry Kasatkin' <d.kasatkin@samsung.com>,
	'Bharat Panda' <bharat.panda@samsung.com>, cpgs@samsung.com
References: <1412654816-14971-1-git-send-email-gowtham.ab@samsung.com>
 <1412654816-14971-6-git-send-email-gowtham.ab@samsung.com>
 <CABBYNZK2TpB61PvCs9L8t_LxV50+mifKZo9C67-0U4JzLm6wBw@mail.gmail.com>
In-reply-to: <CABBYNZK2TpB61PvCs9L8t_LxV50+mifKZo9C67-0U4JzLm6wBw@mail.gmail.com>
Subject: RE: [PATCH 5/6] obexd/messages: Add prototypes for MASInstance response
Date: Wed, 08 Oct 2014 17:39:35 +0530
Message-id: <001901cfe2f0$c26856c0$47390440$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> -----Original Message-----
> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> Sent: Wednesday, October 08, 2014 4:42 PM
> To: Gowtham Anandha Babu
> Cc: linux-bluetooth@vger.kernel.org; Dmitry Kasatkin; Bharat Panda;
> cpgs@samsung.com
> Subject: Re: [PATCH 5/6] obexd/messages: Add prototypes for MASInstance
> response
> 
> Hi,
> 
> On Tue, Oct 7, 2014 at 7:06 AM, Gowtham Anandha Babu
> <gowtham.ab@samsung.com> wrote:
> > ---
> >  obexd/plugins/messages.h | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/obexd/plugins/messages.h b/obexd/plugins/messages.h index
> > 00a16b1..3aaeec1 100644
> > --- a/obexd/plugins/messages.h
> > +++ b/obexd/plugins/messages.h
> > @@ -307,3 +307,19 @@ int messages_set_delete(void *session, const char
> *handle, uint8_t value,
> >   * session: Backend session.
> >   */
> >  void messages_abort(void *session);
> > +
> > +
> > +
> > +/* Retrieves MAS Instance Information for the given mas-instance id.
> > + *
> > + * session: Backend session.
> > + * mas_id: MAS Instance id requested by the MCE.
> > + *
> > + * Callback shall be called for every mas_instance_id request received
> from MCE.
> > + */
> > +typedef void (*messages_mas_instance_info_cb)(void *session, int err,
> > +               uint16_t size, const char *name, void *user_data);
> > +
> > +int messages_get_mas_instance_info(void *session, uint16_t
> mas_instance_id,
> > +                               messages_mas_instance_info_cb callback,
> > +                               void *user_data);
> > --
> > 1.9.1
> 
> You can drop using mas here since it is pretty obvious what it is for, also Im
> not sure we need the size in the callback since we can use strlen there.
> 
> 
> --
> Luiz Augusto von Dentz

I agree with you. I will update this comment for the patch[6/6] too. I will include this in v2. Still is there anything to be handled?

Regards,
Gowtham Anandha Babu


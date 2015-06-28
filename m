Return-Path: <cyrus@holtmann.org>
Date: Sun, 28 Jun 2015 19:09:31 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: =?iso-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>,
	inux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [4.1.0-07254-gc13c810] Regression: Bluetooth not working.
Message-ID: <20150628160930.GA1663@p183.telecom.by>
References: <CADDKRnA4-h61=Tp90Cgj7GsAOZhBX6Dr0ka_CncrCrHDbWLcvw@mail.gmail.com>
 <986DE56C-2E79-4CAD-9D32-89DAED9B449A@holtmann.org>
 <CADDKRnCAj1BrmZzO6ys3zXmPJgaFnppARjU6VvVJf9Aiox7+Ww@mail.gmail.com>
 <CADDKRnDchGURbrxt=herCnLiLfcqrRt=s_wMoBpuG25Ae32WYg@mail.gmail.com>
 <CADDKRnCx4AM9jnf5HfbkB0iNQqxsyLCTozCrasF2c8e7V2K_gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CADDKRnCx4AM9jnf5HfbkB0iNQqxsyLCTozCrasF2c8e7V2K_gw@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Jun 28, 2015 at 05:36:04PM +0200, Jörg Otte wrote:
> 2015-06-26 16:28 GMT+02:00 Jörg Otte <jrg.otte@gmail.com>:
> > 2015-06-26 12:03 GMT+02:00 Jörg Otte <jrg.otte@gmail.com>:
> >> 2015-06-26 11:37 GMT+02:00 Marcel Holtmann <marcel@holtmann.org>:
> >>> Hi Joerg,
> >>>
> >>>> Bluetooth is inoperable in current Linus tree and the
> >>>> first bad commit is:
> >>>>
> >>>> 835a6a2f8603237a3e6cded5a6765090ecb06ea5 is the first bad commit
> >>>> commit 835a6a2f8603237a3e6cded5a6765090ecb06ea5
> >>>> Author: Alexey Dobriyan <adobriyan@gmail.com>
> >>>> Date:   Wed Jun 10 20:28:33 2015 +0300
> >>>>
> >>>>    Bluetooth: Stop sabotaging list poisoning
> >>>>
> >>>>    list_del() poisons pointers with special values, no need to overwrite them.
> >>>>
> >>>>    Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> >>>>    Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> >>>>
> >>>> My BT adapter is an intel 8087:07da
> >>>> I reverted that commit and this fixed the problem for me.
> >>>
> >>> today we had a patch from Tedd fixing the list initialization in the HIDP code.
> >>>
> >>> diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> >>> index 9070dfd6b4ad..f1a117f8cad2 100644
> >>> --- a/net/bluetooth/hidp/core.c
> >>> +++ b/net/bluetooth/hidp/core.c
> >>> @@ -915,6 +915,7 @@ static int hidp_session_new(struct hidp_session **out, const bdaddr_t *bdaddr,
> >>>         session->conn = l2cap_conn_get(conn);
> >>>         session->user.probe = hidp_session_probe;
> >>>         session->user.remove = hidp_session_remove;
> >>> +       INIT_LIST_HEAD(&session->user.list);
> >>>         session->ctrl_sock = ctrl_sock;
> >>>         session->intr_sock = intr_sock;
> >>>         skb_queue_head_init(&session->ctrl_transmit);
> >>>
> >>> Could this be fixing it for you as well?
> >>>
> >> I will check this when I am at home in the
> >> afternoon.
> >>
> >
> > The patch works for me too.
> >
> Ok, this was a little bit hasty!
> I now see the following additional problems:
> 
> - System freeze on resume (occures always).
> - System freeze on shutdown (occures sometimes)
> - System freeze when BT-mouse is connecting (occures sometimes).
> 
> Then I can't do anything except power off.
> 
> This happens only if Bluetooth AND BT-mouse is activated.

OK, what happens if you just revert only list_del patch?

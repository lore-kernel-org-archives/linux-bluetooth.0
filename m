Return-Path: <cyrus@holtmann.org>
From: Vikrampal <vikram.pal@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	'Dmitry Kasatkin' <d.kasatkin@samsung.com>, cpgs@samsung.com
References: <1416577665-21876-1-git-send-email-vikram.pal@samsung.com>
 <CABBYNZJSxCADaEU5XLRaTUGY0AGu+8s_B+ojSAymszWiJNDNiw@mail.gmail.com>
In-reply-to: <CABBYNZJSxCADaEU5XLRaTUGY0AGu+8s_B+ojSAymszWiJNDNiw@mail.gmail.com>
Subject: RE: [PATCH 0/7] L2CAP control field + AVRCP browsing PDU parsing
Date: Wed, 03 Dec 2014 12:38:52 +0530
Message-id: <003e01d00ec8$0b325380$2196fa80$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> Sent: Friday, November 28, 2014 2:07 PM
> To: Vikrampal Yadav
> Cc: linux-bluetooth@vger.kernel.org; Dmitry Kasatkin; cpgs@samsung.com
> Subject: Re: [PATCH 0/7] L2CAP control field + AVRCP browsing PDU parsing
> 
> Hi Vikram,
> 
> On Fri, Nov 21, 2014 at 3:47 PM, Vikrampal Yadav
> <vikram.pal@samsung.com> wrote:
> > Support for ERTM control bytes adjustment, parsing L2CAP extended
> > control field and AVRCP SetBrowsedPlayer added in Bluetooth monitor.
> >
> > Vikrampal Yadav (7):
> >   monitor: Adjust for ERTM control bytes
> >   monitor: Make the parameter name generic
> >   monitor: Add functionality to store extented control in DB
> >   monitor: Extract extended L2CAP extended control field
> >   monitor: Add support for parsing L2CAP extended control field
> >   monitor: Add support for parsing L2CAP control field
> >   monitor: Add AVRCP SetBrowsedPlayer support
> >
> >  monitor/avctp.c |  86 +++++++++++++++++++-  monitor/l2cap.c | 242
> > ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
> >  2 files changed, 322 insertions(+), 6 deletions(-)
> >
> > --
> > 1.9.1
> 
> Sorry for the delay, this one got lost in my inbox, most patches seems to be
> missing the output they generate, could you please add it.

Most patches in this series are helper patches for the last patch in this series.
The final patch actually prints the output which shows the work done by
Other patches.
> 
> 
> --
> Luiz Augusto von Dentz

Regards,
Vikram


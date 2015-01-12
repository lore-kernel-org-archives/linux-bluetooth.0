Return-Path: <cyrus@holtmann.org>
From: Vikrampal <vikram.pal@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, cpgs@samsung.com
References: <1420619000-24211-1-git-send-email-vikram.pal@samsung.com>
 <CABBYNZ+5EHXEL8H7+pgnJWNih72fu_k2Qu6tJ9G7eQCfyJD-_A@mail.gmail.com>
In-reply-to: <CABBYNZ+5EHXEL8H7+pgnJWNih72fu_k2Qu6tJ9G7eQCfyJD-_A@mail.gmail.com>
Subject: RE: [PATCH 0/6] L2CAP control field + AVRCP browsing PDU parsing
Date: Mon, 12 Jan 2015 18:13:56 +0530
Message-id: <00dd01d02e65$7c6ff130$754fd390$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> Sent: Monday, January 12, 2015 6:04 PM
> To: Vikrampal Yadav
> Cc: linux-bluetooth@vger.kernel.org; cpgs@samsung.com
> Subject: Re: [PATCH 0/6] L2CAP control field + AVRCP browsing PDU parsing
> 
> Hi Vikram,
> 
> On Wed, Jan 7, 2015 at 6:23 AM, Vikrampal Yadav
> <vikram.pal@samsung.com> wrote:
> > Support for parsing L2CAP extended control field and AVRCP
> > SetBrowsedPlayer added in Bluetooth monitor.
> >
> > Vikrampal Yadav (6):
> >   monitor: Make the parameter name generic
> >   monitor: Add functionality to store extented control in DB
> >   monitor: Extract extended L2CAP extended control field
> >   monitor: Add support for parsing L2CAP extended control field
> >   monitor: Add support for parsing L2CAP control field
> >   monitor: Add AVRCP SetBrowsedPlayer support
> >
> >  monitor/avctp.c |  86 +++++++++++++++++++-  monitor/l2cap.c | 239
> > ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
> >  2 files changed, 319 insertions(+), 6 deletions(-)
> >
> > --
> > 1.9.1
> 
> Applied, thanks. Please make sure you follow the coding style, I had to fix a
> few lines that were over 80 columns.
> 
> 
> --
> Luiz Augusto von Dentz

Thanks! I surely will take care.

Regards,
Vikram


Return-Path: <cyrus@holtmann.org>
From: Bharat Bhusan Panda <bharat.panda@samsung.com>
To: 'Marcel Holtmann' <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, cpgs@samsung.com
References: <1428315384-4984-1-git-send-email-bharat.panda@samsung.com>
 <98490C74-4CA7-446A-A024-A270D63F0BA9@holtmann.org>
In-reply-to: <98490C74-4CA7-446A-A024-A270D63F0BA9@holtmann.org>
Subject: RE: [PATCH ] tools/hciconfig: Configure LE adv data flags
Date: Tue, 07 Apr 2015 15:33:20 +0530
Message-id: <00f201d0711a$15959f80$40c0de80$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,


> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Marcel Holtmann
> Sent: Monday, April 06, 2015 10:55 PM
> To: Bharat Panda
> Cc: linux-bluetooth@vger.kernel.org; cpgs@samsung.com
> Subject: Re: [PATCH ] tools/hciconfig: Configure LE adv data flags
> 
> Hi Bharat,
> 
> > Add support for LE advertisement data flags by adding a new command in
> > hciconfig tool "leadvflags".
> >
> > LE adv flag values can be refered from CSS 5, section 1.3.2, formats.
> > ---
> > tools/hciconfig.c | 121
> > ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 121 insertions(+)
> 
> this does not look like a useful addition to me. We have a proper mgmt
> support for LE advertising and this is just not helpful. You can achieve
the
> same with a hcitool cmd execution. Especially since there is no guarantee
> that the advertising data will be overwritten by the kernel at any point
in
> time. The kernel can not preserve data injected on HCI from userspace.
> 
Yes, I can get the same through hcitool too, thanks.
I have one query, in hciconfig, we can set "Non connectable undirected
advertising" in "leadv" command. Is there any way, we can set "connectable
undirected advertising with random address type" through any of the tools?
> Regards
> 
> Marcel



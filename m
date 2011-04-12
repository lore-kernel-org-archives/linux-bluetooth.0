Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1302581196.2572.249.camel@aeonflux>
References: <anderson.briglia@openbossa.org>
	<1302567158-18617-2-git-send-email-anderson.briglia@openbossa.org>
	<1302581196.2572.249.camel@aeonflux>
Date: Tue, 12 Apr 2011 06:56:25 -0400
Message-ID: <BANLkTinoW_bjCw=DwS2pMg-eM06Yq3MXLg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: MTU configuration for LE links
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Anderson Briglia <anderson.briglia@openbossa.org>, linux-bluetooth@vger.kernel.org,
	ville.tervo@nokia.com, johan.hedberg@gmail.com,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Apr 12, 2011 at 12:06 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> so how do you expect this to work exactly? In BR/EDR L2CAP you set the
> MTU details before calling connect(). With LE you expect to be connected
> and then tell the kernel what the limits actually are?

Yes. For LE, the MTU negotiation happens over the connected link
(using specific ATT commands).

> This sounds highly convoluted. And especially hijacking the existing
> command for it seems wrong. Using l2cap_sock_setsockopt_old() might have
> given it away that it is a bad idea to re-use that socket option for a
> new technology ;)
>
> So the real fact here is that the MTU handling/negotiation for BR/EDR
> and LE are different. Nothing is going to change this. So this should be
> also different from a socket option point of view.

One thing to consider is that there are a couple of MTU checks along
the L2CAP code. The issue which originated this patch is code such as:

                /* Check outgoing MTU */
                if (len > pi->omtu) {
                        err = -EMSGSIZE;
                        goto done;
                }

We understood that just letting omtu/imtu values on kernel reflect the
current connection MTU settings was the cleanest solution. What do you
propose? Bypassing these checks for LE?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil

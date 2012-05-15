Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1337009699-19831-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1337009699-19831-1-git-send-email-mikel.astiz.oss@gmail.com>
Date: Tue, 15 May 2012 10:15:12 -0400
Message-ID: <CAJdJm_MVPxMp9QG9_CBmGn0YeMc_Hbhiipy+brSXsqjMzFuRjA@mail.gmail.com>
Subject: Re: [RFC v0] Bluetooth: mgmt: Add device disconnect reason
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Mon, May 14, 2012 at 11:34 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> MGMT_EV_DEVICE_DISCONNECTED should expose the disconnection reason to
> userland.

There is "getsockopt(sock, SOL_SOCKET, SO_ERROR, &sk_err, &len)". Why
is it not enough?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil

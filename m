Return-Path: <cyrus@holtmann.org>
Message-ID: <1356369208.29264.46.camel@aeonflux>
Subject: Re: [PATCH] lib: use %m instead of strerror
From: Marcel Holtmann <marcel@holtmann.org>
To: Cristian =?ISO-8859-1?Q?Rodr=EDguez?= <crrodriguez@opensuse.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 24 Dec 2012 09:13:28 -0800
In-Reply-To: <1356362730-16557-1-git-send-email-crrodriguez@opensuse.org>
References: <1356362730-16557-1-git-send-email-crrodriguez@opensuse.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Cristian,

> Unlike strerror, %m is thread safe and we do not know
> to what kind of program libbluetooh is being linked too.
> ---
>  lib/sdp.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)

patch has been applied.

Regards

Marcel



Return-Path: <cyrus@holtmann.org>
Message-ID: <1349703809.27233.65.camel@aeonflux>
Subject: Re: [WORKAROUND BlueZ 1/3] gdbus: Add fallback to GetProperties
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 08 Oct 2012 15:43:29 +0200
In-Reply-To: <1349683884-22251-1-git-send-email-luiz.dentz@gmail.com>
References: <1349683884-22251-1-git-send-email-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> This adds a fallback for GetProperties method when it is not
> implemented.
> ---
> This set of patches are workarounds to old properties interface to be able to
> test new code until other components are ported.

I am not sure I want this at all. This is a nasty hack.

Especially since interfaces that previously had neither or only some of
these methods get these methods. Bad idea. It might work inside BlueZ
where we always added these methods, but in other projects some of these
methods had been left out since the properties where send via signals
with the object path being announced.

Regards

Marcel



Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1265738807.2383.6336.camel@localhost.localdomain>
References: <1265738807.2383.6336.camel@localhost.localdomain>
Date: Tue, 9 Feb 2010 22:44:51 +0200
Message-ID: <2d5a2c101002091244y7ddafc40mc8d565c8c86a2760@mail.gmail.com>
Subject: Re: [PATCH] osso-gwobex export
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Tue, Feb 9, 2010 at 8:06 PM, Bastien Nocera <hadess@hadess.net> wrote:
> Heya,
>
> Here's a patch to fix libgwobex not using a soname, and fixing a few
> build problems.
>
> I couldn't run the test suite, as gnome-bluetooth's ancient btctl Python
> module isn't around any more.
>
> Could I bribe someone into making a release that I could use for gvfs'
> ObexFTP module[1]?
>
> Cheers
>
> [1]: https://bugzilla.gnome.org/show_bug.cgi?id=609340

I thought the plan was to use obex-client daemon in gvfs backend, well
obex-client uses gwobex so it is mostly the same code, but it would be
good to know if there is there any specific reason, or reasons, not to
use obex-client as it is what we normally uses for testing obexd
functionality.

Regards,

-- 
Luiz Augusto von Dentz
Computer Engineer

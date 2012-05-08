Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1336483706-1533-3-git-send-email-dh.herrmann@googlemail.com>
References: <1336483706-1533-1-git-send-email-dh.herrmann@googlemail.com>
	<1336483706-1533-3-git-send-email-dh.herrmann@googlemail.com>
Date: Tue, 8 May 2012 11:30:31 -0300
Message-ID: <CAA37ikZW1H1zfPr8d5uonpY0SEZk=dbDQ+XsYhOytXg4ExuLAA@mail.gmail.com>
Subject: Re: [PATCH 3/3] Bluetooth: Remove batostr()
From: Ulisses Furquim <ulisses@profusion.mobi>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, gustavo@padovan.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Tue, May 8, 2012 at 10:28 AM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
> batostr() is not used anywhere and I don't see any reason why we should
> keep it. Use ba2str() instead.
>
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
> =A0include/net/bluetooth/bluetooth.h | =A0 =A01 -
> =A0net/bluetooth/lib.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 14 -------------=
-
> =A02 files changed, 15 deletions(-)

The patchset looks good to me. I'm also not sure we need another
specifier for snprintf().

Given we had static buffers instead of allocating them in the stack
every time it'd be good to hear from Marcel if we had a reason and if
it's still valid. IMO we don't have problems with stack usage in our
code paths now but I haven't actually checked it.

Regards,

--=20
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs

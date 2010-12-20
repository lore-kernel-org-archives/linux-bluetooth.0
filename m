Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTimNkaxqTShFMr4-5Dk+i3iFKDz_b6wHNKb-0fQX@mail.gmail.com>
References: <1292819346-27318-1-git-send-email-anderson.lizardo@openbossa.org>
	<1292819346-27318-3-git-send-email-anderson.lizardo@openbossa.org>
	<AANLkTimNkaxqTShFMr4-5Dk+i3iFKDz_b6wHNKb-0fQX@mail.gmail.com>
Date: Mon, 20 Dec 2010 07:36:20 -0400
Message-ID: <AANLkTi=9iFhHSK2p21eCDK8mT9Y-BPagCTd4XhTyGCer@mail.gmail.com>
Subject: Re: [PATCH 3/3] Fix memory leaks in btio/btio.c
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Dec 20, 2010 at 5:20 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> While I see the reference problem I don't really see how this could
> help since the application doesn't know about internal watches only
> the reference returned, so if the application releases its references
> btio won't release its own and in fact it can still call the
> application callbacks.

Sorry, but I don't understand the issue you describe here. The watch
created by e.g. bt_io_listen() needs to be destroyed at some point,
otherwise any destroy callbacks registered by the btio users will
never be called, and the reference added by the watch itself is not
decremented. You can see this by running valgrind with
--leak-check=yes with/without these patches.

Doing this during the daemon shutdown seems a good place, as it will
do other memory deallocations anyway.

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil

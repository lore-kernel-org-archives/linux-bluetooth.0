Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTi=9iFhHSK2p21eCDK8mT9Y-BPagCTd4XhTyGCer@mail.gmail.com>
References: <1292819346-27318-1-git-send-email-anderson.lizardo@openbossa.org>
	<1292819346-27318-3-git-send-email-anderson.lizardo@openbossa.org>
	<AANLkTimNkaxqTShFMr4-5Dk+i3iFKDz_b6wHNKb-0fQX@mail.gmail.com>
	<AANLkTi=9iFhHSK2p21eCDK8mT9Y-BPagCTd4XhTyGCer@mail.gmail.com>
Date: Mon, 20 Dec 2010 07:57:36 -0400
Message-ID: <AANLkTinwPiiJjT5FTtJam2nZkPRP_ORaxb-Q5D0O3xeO@mail.gmail.com>
Subject: Re: [PATCH 3/3] Fix memory leaks in btio/btio.c
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Dec 20, 2010 at 7:36 AM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Luiz,
>
> On Mon, Dec 20, 2010 at 5:20 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> While I see the reference problem I don't really see how this could
>> help since the application doesn't know about internal watches only
>> the reference returned, so if the application releases its references
>> btio won't release its own and in fact it can still call the
>> application callbacks.

After Johan's explanation on IRC about btio policy regarding keeping
state, I think I understand your comment now and I believe the patch
can be just ignored.

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil

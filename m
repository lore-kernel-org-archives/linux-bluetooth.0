Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1298068173-16518-2-git-send-email-claudio.takahasi@openbossa.org>
References: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
	<1298068173-16518-2-git-send-email-claudio.takahasi@openbossa.org>
Date: Tue, 22 Feb 2011 14:16:08 -0300
Message-ID: <AANLkTi=3xxs5DGCt5uLrHHMhEBAgO0mQczRoOorfX7gM@mail.gmail.com>
Subject: Re: [RFC v2 01/14] Move 64 and 128 bits byte order functions to bluetooth.h
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Fri, Feb 18, 2011 at 7:29 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> ---
>  attrib/example.c     |    1 +
>  attrib/gatt.c        |    1 +
>  attrib/interactive.c |    1 +
>  health/hdp_manager.c |    1 +
>  health/mcap_sync.c   |   17 -----------------
>  lib/bluetooth.h      |   41 +++++++++++++++++++++++++++++++++++++++++
>  lib/sdp.c            |   43 -------------------------------------------
>  lib/sdp.h            |    4 ----
>  src/sdp-xml.c        |    1 +
>  test/hciemu.c        |   16 ----------------
>  10 files changed, 46 insertions(+), 80 deletions(-)

Can we have this patch applied upstream? It seems a good refactoring
because removes duplicated code.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil

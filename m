Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1329821707-11817-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1329821707-11817-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1329821707-11817-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Tue, 21 Feb 2012 15:32:58 -0200
Message-ID: <CAA37ikbV5fq_BfbEBPFBsN9pHJb55c29Hf7o07jeJRDRLNqLpQ@mail.gmail.com>
Subject: Re: [PATCHv1 12/14] Bluetooth: Change locking logic in security_cfm
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Feb 21, 2012 at 8:55 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Change bh_ locking functions to mutex_locks since we can now sleep.
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   17 ++++++++++-------
>  1 files changed, 10 insertions(+), 7 deletions(-)

Looks good.

Reviewed-by: Ulisses Furquim <ulisses@profusion.mobi>

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1329821707-11817-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1329821707-11817-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1329821707-11817-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Tue, 21 Feb 2012 15:06:52 -0200
Message-ID: <CAA37ikbaW2CN6GQk-PaMRCBaCUzUg=Bx0aEoDnrsmamXZZNeHw@mail.gmail.com>
Subject: Re: [PATCHv1 07/14] Bluetooth: Use chan lock in timers
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
> Change locking in delayed works to chan lock instead of sk lock.
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   26 ++++++++++++++------------
>  1 files changed, 14 insertions(+), 12 deletions(-)

Looks good.

Reviewed-by: Ulisses Furquim <ulisses@profusion.mobi>

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs

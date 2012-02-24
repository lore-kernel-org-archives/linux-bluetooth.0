Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1330092000-9420-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1330092000-9420-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Fri, 24 Feb 2012 14:36:16 -0200
Message-ID: <CAA37ikZVgT3D0PLVCGvnfdarrBgqYqJCCwqV+F-G7=JxChNwKg@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: Remove duplicated code in l2cap conn req
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Feb 24, 2012 at 12:00 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> The same sequence sending L2CAP Connection Request was
> used in several places. Using subroutine makes those
> places easy to read.
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   49 +++++++++++++++++--------------------------
>  1 files changed, 19 insertions(+), 30 deletions(-)

Looks good to me.

Reviewed-by: Ulisses Furquim <ulisses@profusion.mobi>

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs

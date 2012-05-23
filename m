Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1337760349-301-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1337760349-301-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Wed, 23 May 2012 08:03:03 -0300
Message-ID: <CAA37ikagL6k+TEC6Q=Rb7ePE_nVvtua-HzT54MXAYxomcFNneg@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: Adds unlink to chan ops
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, mathewm@codeaurora.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, May 23, 2012 at 5:05 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> This helps to separate socket and socketless code. Now socket related
> operations moved to l2cap_sock in unlink callback for channels with sk.
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> Reported-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/l2cap.h |    1 +
>  net/bluetooth/l2cap_core.c    |   20 ++------------------
>  net/bluetooth/l2cap_sock.c    |   25 +++++++++++++++++++++++++
>  3 files changed, 28 insertions(+), 18 deletions(-)

Looks good also, keep up the work. :-)

Best regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs

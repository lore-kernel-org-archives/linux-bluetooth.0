Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1329834858-22816-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1329834858-22816-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Tue, 21 Feb 2012 15:42:33 -0200
Message-ID: <CAA37ikZvUdCgPqjDS=DjCzOn0Bz6MGpiiMmg_YuFBNLoQLvCeA@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: Add set_err to state_change callback
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Feb 21, 2012 at 12:34 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> There are several places in the code where l2cap_state_change and
> l2cap_chan_set_err used together. With combining them we remove
> socket lock in l2cap_send_disconn_req and simplify code in couple
> of other places with a price of adding extra parameter err to
> state_change.
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/l2cap.h |    3 +-
>  net/bluetooth/l2cap_core.c    |   58 ++++++++++++++++++----------------------
>  net/bluetooth/l2cap_sock.c    |    9 +++++-
>  3 files changed, 36 insertions(+), 34 deletions(-)

While I see the benefit of removing function calls and also some code
I'm not sure about this change now. We need to think of moving sock
handling to l2cap_sock.c and for that we may have to work more on
l2cap_ops indeed. However, we need to change ERTM state machine
handling first, I'd say.

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs

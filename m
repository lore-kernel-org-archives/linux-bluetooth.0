Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1329907389-31173-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1329907389-31173-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Wed, 22 Feb 2012 10:30:40 -0200
Message-ID: <CAA37ikarEd1wVZZoxH_Cy=jJfQ9is-cY+9y0U7eMWZH+1qxQsg@mail.gmail.com>
Subject: Re: [PATCHv2 0/3] Bluetooth: Change socket lock to l2cap_chan lock
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Feb 22, 2012 at 8:43 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Changing socket lock to L2CAP chan lock in L2CAP code. Needed for implementing
> protocols above L2CAP without creating sockets.
>
> Changes:
>        * PATCHv2: Rebase remaining parts against latest tree and merge all
>        patches dealing with converting sk lock to chan lock together following
>        recommendation from Ulisses and Gustavo.
>        * PATCHv1: Added extra line (per Gustavo comment)
>        * RFCv6: Same code but patches 2,3 and 4 from RFCv5 are merged together
>        following recommendations from review.
>        * RFCv5: Fixed locking bug in l2cap_data_channel, added locks in
>        l2cap_sock_shutdown function, fixed several styles issues.
>        * RFCv4: Better split patches so they looks more clear and obvious,
>        taking coments about naming change and delete unused vars. See diff change
>        from the previous version below:
>        * RFCv3: Split the big patch to several small (I believe logical) chunks,
>        remove unneded locks from cleanup_listen, use the same arguments for
>        locked/unlocked socket error functions.
>        * RFCv2: Convert l2cap channel list back to mutex from RCU list.
>
> Andrei Emeltchenko (3):
>  Bluetooth: Add unlocked __l2cap_chan_add function
>  Bluetooth: Change sk lock to chan lock in L2CAP core
>  Bluetooth: Remove socket lock check
>
>  net/bluetooth/l2cap_core.c |  173 +++++++++++++++++++++++++++-----------------
>  net/bluetooth/l2cap_sock.c |   28 +++++--
>  2 files changed, 125 insertions(+), 76 deletions(-)

I'm mostly ok with the patches. However, have you seen my questions on
reply to PATCHv1 08/14? Please, check that. Thanks.

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs

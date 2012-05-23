Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1337770651-9282-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1337770651-9282-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Wed, 23 May 2012 08:00:54 -0300
Message-ID: <CAA37ikbxf9bgZeHRwQ3svizkm6caQ_XyoMJEipw+i4y1mpmjjA@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: Add L2CAP chan ready op
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, May 23, 2012 at 7:57 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
>
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Addings ops->ready() helps to separate socket and socketless
> L2CAP channels.
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/l2cap.h |    1 +
>  net/bluetooth/l2cap_core.c    |   42 +++++++++++------------------------------
>  net/bluetooth/l2cap_sock.c    |   28 +++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+), 31 deletions(-)

Looks good to me. And we do need to refactor other parts in other to
push sock related code to chan->ops as well.

Best regards,

--
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs

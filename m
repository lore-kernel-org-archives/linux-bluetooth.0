Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1329747685-4163-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1329747685-4163-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1329747685-4163-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Mon, 20 Feb 2012 12:44:29 -0200
Message-ID: <CAA37ika4UfWnRMnRqx6tMH4+De2Z-BXXbPVgJFcWNSCeHD7riw@mail.gmail.com>
Subject: Re: [RFCv6 02/14] Bluetooth: Revert to mutexes from RCU list
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Feb 20, 2012 at 12:21 PM, Emeltchenko Andrei
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Usage of RCU list looks not reasonalbe for a number of reasons:
> our code sleep and we have to use socket spinlocks, some parts
> of code are updaters thus we need to use mutexes anyway.
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |  165 ++++++++++++++++++++++++++------------------
>  net/bluetooth/l2cap_sock.c |   10 +++
>  2 files changed, 108 insertions(+), 67 deletions(-)

Now it does look good to me. Thanks.

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs

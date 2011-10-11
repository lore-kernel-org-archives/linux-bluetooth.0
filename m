Return-Path: <cyrus@holtmann.org>
Date: Tue, 11 Oct 2011 10:55:57 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 4/4] Bluetooth: convert role_switch variable to flag in
 l2cap chan
Message-ID: <20111011135557.GA11864@joana>
References: <1318331074-32054-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1318331074-32054-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318331074-32054-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-10-11 14:04:34 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> role_switch variable inside l2cap_chan is a logical one and can
> be easily converted to flag
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/l2cap.h |    2 +-
>  net/bluetooth/l2cap_core.c    |    4 ++--
>  net/bluetooth/l2cap_sock.c    |    9 +++++----
>  3 files changed, 8 insertions(+), 7 deletions(-)

All four patches applied, thanks.

	Gustavo

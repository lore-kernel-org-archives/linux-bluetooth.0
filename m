Return-Path: <cyrus@holtmann.org>
Date: Thu, 6 Oct 2011 15:23:43 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 4/4] Bluetooth: convert role_switch variable to flag in
 l2cap chan
Message-ID: <20111006182342.GH5652@joana>
References: <1316181222-32634-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1316181222-32634-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1316181222-32634-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-09-16 16:53:42 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> role_switch variable inside l2cap_chan is a logical one and can
> be easily converted to flag
> ---
>  include/net/bluetooth/l2cap.h |    2 +-
>  net/bluetooth/l2cap_core.c    |    4 ++--
>  net/bluetooth/l2cap_sock.c    |   12 ++++++++----
>  3 files changed, 11 insertions(+), 7 deletions(-)

These four patches can came first. Please rebase them.

	Gustavo

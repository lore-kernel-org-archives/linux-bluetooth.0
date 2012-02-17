Return-Path: <cyrus@holtmann.org>
Message-ID: <1329472209.28848.168.camel@aeonflux>
Subject: Re: [PATCHv2 2/3] Bluetooth: Use symbolic names for state in debug
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 17 Feb 2012 10:50:09 +0100
In-Reply-To: <1329471657-18278-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1329471657-18278-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1329471657-18278-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Use state_to_string function in debug statements.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/l2cap.h |    3 ++-
>  net/bluetooth/hci_conn.c      |    2 +-
>  net/bluetooth/l2cap_core.c    |    5 +++--
>  net/bluetooth/l2cap_sock.c    |    2 +-
>  4 files changed, 7 insertions(+), 5 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel



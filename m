Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [4.1.0-07254-gc13c810] Regression: Bluetooth not working.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CADDKRnA4-h61=Tp90Cgj7GsAOZhBX6Dr0ka_CncrCrHDbWLcvw@mail.gmail.com>
Date: Fri, 26 Jun 2015 11:37:37 +0200
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>,
	inux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Message-Id: <986DE56C-2E79-4CAD-9D32-89DAED9B449A@holtmann.org>
References: <CADDKRnA4-h61=Tp90Cgj7GsAOZhBX6Dr0ka_CncrCrHDbWLcvw@mail.gmail.com>
To: =?utf-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joerg,

> Bluetooth is inoperable in current Linus tree and the
> first bad commit is:
> 
> 835a6a2f8603237a3e6cded5a6765090ecb06ea5 is the first bad commit
> commit 835a6a2f8603237a3e6cded5a6765090ecb06ea5
> Author: Alexey Dobriyan <adobriyan@gmail.com>
> Date:   Wed Jun 10 20:28:33 2015 +0300
> 
>    Bluetooth: Stop sabotaging list poisoning
> 
>    list_del() poisons pointers with special values, no need to overwrite them.
> 
>    Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
>    Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> 
> My BT adapter is an intel 8087:07da
> I reverted that commit and this fixed the problem for me.

today we had a patch from Tedd fixing the list initialization in the HIDP code.

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 9070dfd6b4ad..f1a117f8cad2 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -915,6 +915,7 @@ static int hidp_session_new(struct hidp_session **out, const bdaddr_t *bdaddr,
        session->conn = l2cap_conn_get(conn);
        session->user.probe = hidp_session_probe;
        session->user.remove = hidp_session_remove;
+       INIT_LIST_HEAD(&session->user.list);
        session->ctrl_sock = ctrl_sock;
        session->intr_sock = intr_sock;
        skb_queue_head_init(&session->ctrl_transmit);

Could this be fixing it for you as well?

Regards

Marcel


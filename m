Return-Path: <cyrus@holtmann.org>
Message-ID: <4D6EFF05.8080509@lundman.net>
Date: Thu, 03 Mar 2011 11:37:57 +0900
From: Jorgen Lundman <lundman@lundman.net>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: Linux 2.6.28-10 Oops in hci_send_to_sock
References: <4D69EE46.9050401@lundman.net>
In-Reply-To: <4D69EE46.9050401@lundman.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> register int evt = (*(__u8 *)skb->data & HCI_FLT_EVENT_BITS);

Ok, so skb->data has value 8, this is probably because the kernel sk_buff and 
the one I use to compile are too different. Sure enough. Intel uses a vastly 
different kernel not easily obtainable. But once I had it, this issue went away.

Sorry for the noise.

Lund

-- 
Jorgen Lundman       | <lundman@lundman.net>
Unix Administrator   | +81 (0)3 -5456-2687 ext 1017 (work)
Shibuya-ku, Tokyo    | +81 (0)90-5578-8500          (cell)
Japan                | +81 (0)3 -3375-1767          (home)

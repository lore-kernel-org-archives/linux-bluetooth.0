Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix bt_sock_recvmsg when MSG_TRUNC is not set
In-Reply-To: <1471003888-27124-1-git-send-email-luiz.dentz@gmail.com>
References: <1471003888-27124-1-git-send-email-luiz.dentz@gmail.com>
Date: Fri, 12 Aug 2016 11:22:06 -0300
Message-ID: <87popexe29.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Luiz Augusto von Dentz <luiz.dentz@gmail.com> writes:

> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Commit b5f34f9420b50c9b5876b9a2b68e96be6d629054 attempt to introduce
> proper handling for MSG_TRUNC but recv and variants should still work
> as read if no flag is passed, but because the code may set MSG_TRUNC to
> msg->msg_flags that shall not be used as it may cause it to be behave as
> if MSG_TRUNC is always, so instead of using it this changes the code to
> use the flags parameter which shall contain the original flags.
>

Taking a look at udp_recvmsg(), looks like this fix is indeed
necessary. And that patch that "fixed" sdpd-server.c may not be needed
at all.

Looks good.


Cheers,
--
Vinicius

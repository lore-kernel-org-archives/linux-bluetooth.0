Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: shutdown(3) and bluetooth.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20131112211125.GA2912@redhat.com>
Date: Wed, 13 Nov 2013 06:56:23 +0900
Cc: netdev@vger.kernel.org,
	"linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <DF4C2B40-BD87-4E88-911D-E3E5F488CAE4@holtmann.org>
References: <20131112211125.GA2912@redhat.com>
To: Dave Jones <davej@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dave,

> Is shutdown() allowed to block indefinitely ? The man page doesn't say either way,
> and I've noticed that my fuzz tester occasionally hangs for days spinning in bt_sock_wait_state()
> 
> Is there something I should be doing to guarantee that this operation
> will either time out, or return instantly ?
> 
> In this specific case, I doubt anything is on the "sender" end of the socket, so
> it's going to be waiting forever for a state change that won't arrive.

can you give us some extra information here. What kind of Bluetooth socket is this actually. From the top of my head, I have no idea why we would even wait forever. Normally when all low-level links are gone, the socket will shut down anyway.

Regards

Marcel


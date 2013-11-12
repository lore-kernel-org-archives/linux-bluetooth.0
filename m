Return-Path: <cyrus@holtmann.org>
Date: Tue, 12 Nov 2013 16:13:50 -0500 (EST)
Message-Id: <20131112.161350.946584501122269943.davem@davemloft.net>
To: davej@redhat.com
Cc: netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: Re: shutdown(3) and bluetooth.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20131112211125.GA2912@redhat.com>
References: <20131112211125.GA2912@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Dave Jones <davej@redhat.com>
Date: Tue, 12 Nov 2013 16:11:25 -0500

> Is shutdown() allowed to block indefinitely ? The man page doesn't say either way,
> and I've noticed that my fuzz tester occasionally hangs for days spinning in bt_sock_wait_state()
> 
> Is there something I should be doing to guarantee that this operation
> will either time out, or return instantly ?
> 
> In this specific case, I doubt anything is on the "sender" end of the socket, so
> it's going to be waiting forever for a state change that won't arrive.

Adding bluetooth and wireless lists.  Dave, please consult MAINTAINERS when
asking questions like this, thanks!

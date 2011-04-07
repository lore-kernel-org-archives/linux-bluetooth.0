Return-Path: <cyrus@holtmann.org>
Date: Wed, 6 Apr 2011 21:32:32 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [bluetooth-next 14/15] Bluetooth: Add support for SMP timeout
Message-ID: <20110407003232.GA28257@piper>
References: <1302054716-24534-1-git-send-email-vinicius.gomes@openbossa.org>
 <1302054716-24534-15-git-send-email-vinicius.gomes@openbossa.org>
 <20110407001418.GF2228@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110407001418.GF2228@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On 21:14 Wed 06 Apr, Gustavo F. Padovan wrote:
> * Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2011-04-05 22:51:55 -0300]:
> 
> > This patch adds support for disconnecting the link when SMP procedure
> > takes more than 30 seconds.
> 
> As this is a SMP procedure, doesn't make more sense put this timer in SMP
> code? It does not fit quite well to me in l2cap.

The only reason is that SMP code isn't able to tell that the pairing
finished or not. We only can tell that the pairing finished when we receive
the Encryption Changed HCI event or the connection is terminated.

And I don't think that SMP code has to be informed of any of these conditions.

> 
> -- 
> Gustavo F. Padovan
> http://profusion.mobi

Cheers,
-- 
Vinicius

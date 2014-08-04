Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 Aug 2014 11:36:32 +0200
From: Alexander Aring <alex.aring@gmail.com>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: linux-zigbee-devel@lists.sourceforge.net,
	linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v3 bluetooth-next] Simplify lowpan receive path so skb is
 freed in, lowpan_rcv when dropped.
Message-ID: <20140804093630.GD15334@omega>
References: <53DF4B10.7000209@xsilon.com>
 <20140804090403.GB15334@omega>
 <53DF4F7B.4090307@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <53DF4F7B.4090307@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Aug 04, 2014 at 10:16:43AM +0100, Martin Townsend wrote:
> The changes were made to a clone of bluetooth-next, do I have the right repository?
> 
> martin@martin-HP-ProDesk-490-G1-MT:~/workspace/bluetooth-next$ git ls-remote
> From git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
> 
yes, but maybe it's a little bit outdated. Try to update it, on top of
git log should be the patches:

http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/log/

- Alex

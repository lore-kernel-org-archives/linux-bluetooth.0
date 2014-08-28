Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Aug 2014 06:47:35 +0200
From: Alexander Aring <alex.aring@gmail.com>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	linux-zigbee-devel@lists.sourceforge.net,
	linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org
Subject: Re: [PATCH v2 bluetooth-next] Simplify lowpan receive path so skb is
 freed in lowpan_rcv when dropped.
Message-ID: <20140828044733.GA27453@omega>
References: <53DCE75C.2030305@xsilon.com>
 <20140821083945.GA29484@omega>
 <3DF0C18C-4A97-4A00-AB0F-9E01F72CE967@holtmann.org>
 <53FE446D.6040805@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <53FE446D.6040805@xsilon.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Martin,

On Wed, Aug 27, 2014 at 09:49:49PM +0100, Martin Townsend wrote:
> Hi,
> 
> I'll respin and include the memory leak fix and this patch and a couple of
> others I have and send as a series to bluetooth.  What bluetooth git
> repository should I base the series on?

Okay,

net-next is open. That means the merge window has closed. Fix the memory
leak in a separate patch based on bluetooth at first of your series. New
features based on bluetooth-next, if these depends on each other write
this after the "---" in your commit msg.


There is also a third solution to send bug fixes to -stable, for the
stable kernel release. Forget the -stable releases, there is too much
stuff which don't work and the code differs too much. In future we can
do that.


What bluetooth and bluetooth-next means is:

bluetooth	- current kernel release
bluetooth-next	- next kernel release

- Alex

Return-Path: <cyrus@holtmann.org>
Message-ID: <53DF4F7B.4090307@xsilon.com>
Date: Mon, 04 Aug 2014 10:16:43 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
To: Alexander Aring <alex.aring@gmail.com>
CC: linux-zigbee-devel@lists.sourceforge.net,
 linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
 Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v3 bluetooth-next] Simplify lowpan receive path so skb
 is freed in, lowpan_rcv when dropped.
References: <53DF4B10.7000209@xsilon.com> <20140804090403.GB15334@omega>
In-Reply-To: <20140804090403.GB15334@omega>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

The changes were made to a clone of bluetooth-next, do I have the right repository?

martin@martin-HP-ProDesk-490-G1-MT:~/workspace/bluetooth-next$ git ls-remote
>From git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git

- Martin.

On 04/08/14 10:04, Alexander Aring wrote:
> Hi Martin,
>
> still conflicts here:
>
> M	include/net/6lowpan.h
> M	net/6lowpan/iphc.c
> M	net/bluetooth/6lowpan.c
> M	net/ieee802154/6lowpan_rtnl.c
> <stdin>:91: trailing whitespace.
> 		
> warning: 1 line adds whitespace errors.
> Falling back to patching base and 3-way merge...
> Auto-merging net/ieee802154/6lowpan_rtnl.c
> Auto-merging net/bluetooth/6lowpan.c
> Auto-merging net/6lowpan/iphc.c
> CONFLICT (content): Merge conflict in net/6lowpan/iphc.c
> Auto-merging include/net/6lowpan.h
> Failed to merge in the changes.
> Patch failed at 0001 Simplify lowpan receive path so skb is freed in, lowpan_rcv when dropped.
>
>
> Save your work in a branch.
>
> Do you have bluetooth-next in your remotes? Then run "git remote update
> $REMOTE_NAME" and checkout $REMOTE_NAME/master, then use git cherry-pick
> to add patches from the branch.
>
> - Alex
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Return-Path: <cyrus@holtmann.org>
Message-ID: <1326095651.6454.140.camel@aeonflux>
Subject: Re: [PATCH 00/18] Cleanup HCI reference counts
From: Marcel Holtmann <marcel@holtmann.org>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Date: Sun, 08 Jan 2012 23:54:11 -0800
In-Reply-To: <1325947644-11736-1-git-send-email-dh.herrmann@googlemail.com>
References: <1325947644-11736-1-git-send-email-dh.herrmann@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> This is the same as my previous patchset but split into sequential patches. The
> first patch makes the destruct-cb optional so the patches 2-7 can remove the
> empty callbacks.
> Patches 8-14 make the remaining drivers drop the destruct-callback and directly
> free the driver data.
> Patches 15-18 then remove the (now unused!) destruct callback and then properly
> fixes the reference counts (same patches as already posted).
> 
> I hope the first 14 patches make clear that half of our drivers already work
> without the destruct callback and the other half can be safely converted into
> not using it. In fact, the drivers that use it introduce some memleaks which are
> fixed by simply dropping the callback and freeing everything right away.
> 
> I've added detailed commit messages to each driver. If a single step is unclear,
> please point me to it.
> 
> 
> By the way, this fixes several bugs we currently have, including some mem-leaks
> as described in the commits and the fact that hci_free_dev() currently
> *directly* destroys the hci object regardless of any previous calls to
> hci_hold_dev/hci_put_dev(). This is because the hci->refcnt counter is in no way
> linked to the lifetime of the hci object. See hci_sysfs the release_host
> callback which actually frees the hci object. It is in no way triggered by
> hci->refcnt.
> This patchset fixes all this and introduces proper reference counting.

I went through the patches again and after thinking about it for a bit,
this all looks good.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Johan, feel free to include this patchset into your tree.

Regards

Marcel



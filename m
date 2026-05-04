Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07664222580;
	Mon,  4 May 2026 06:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777875811; cv=none; b=jdXzyvwxHKVqAg1YvJKxw3e+gxJghVN1PNZKmbIW4DYBYzFY688bHMdXB3zpjR4rMUFDNoGRYV+fuvhxUyDWElmGs1Yxk9H0chOxSP3WTtL6vXnToyKOEhiYEUdVH4Bv5pCMAlpyuCWR/DcGKP8setDKgsM7FeHORKhUTnEVlrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777875811; c=relaxed/simple;
	bh=M2p2YLE/JJsLA8h4FleVrhqYQHUgfRz3l8jdG0jHFPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=my5qTh2TH9weNllFkYB633ZdXpnR5F6TmWGcRid6y0x3zjHqICVTcOeUMtSsOdOpivsHL43H+EKW2OpFn1KZBCrTAe7lBey1KZwrqQoh9kSKbWuHkAObzQo/11Fpxj1/kPwbh+c4RXSrxa9b6MBfr9+Y8Zm+ufLZYbe2ywuODs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nlt0j+1A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nlt0j+1A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1A1C2BCB8;
	Mon,  4 May 2026 06:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777875810;
	bh=M2p2YLE/JJsLA8h4FleVrhqYQHUgfRz3l8jdG0jHFPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nlt0j+1A/kerXp2iYBB9O67wKpDLmpEDYym+gaXNO1EVlIps8Dkv4VYERiKB5XWp3
	 Gf/yoGZ1RJ/IUVO71KTm4D0RkZHSzVoMBcs9OlLnj8vhfCHABche98jBDiq1MBjkAh
	 L8uvDXIOkHctOPKttkcVedUG1g+7F/l7YPZMQ2VE=
Date: Mon, 4 May 2026 08:22:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Conor Kotwasinski <conorkotwasinski2024@u.northwestern.edu>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	syzbot+d1db96f72a452dc9cbd2@syzkaller.appspotmail.com,
	syzbot+faeac5b54ba997a96278@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] sysfs: return -ENOENT from move/rename when kobj->sd
 is NULL
Message-ID: <2026050437-matter-concur-d533@gregkh>
References: <20260416150600.2148935-1-conorkotwasinski2024@u.northwestern.edu>
 <20260504050736.17672-1-conorkotwasinski2024@u.northwestern.edu>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504050736.17672-1-conorkotwasinski2024@u.northwestern.edu>

On Mon, May 04, 2026 at 01:07:36AM -0400, Conor Kotwasinski wrote:
> sysfs_move_dir_ns() and sysfs_rename_dir_ns() pass kobj->sd to
> kernfs_rename_ns() unconditionally. If sysfs_remove_dir() has already
> cleared kobj->sd, the NULL flows through and kernfs_rename_ns()
> dereferences it via rcu_access_pointer(kn->__parent), which KASAN
> surfaces as a stack-segment fault on the shadow lookup:
> 
>   Oops: stack segment: 0000 [#1] SMP KASAN PTI
>   RIP: 0010:kernfs_rename_ns+0x3a/0x7a0 fs/kernfs/dir.c:1752
>   Call Trace:
>    kobject_move+0x525/0x6e0 lib/kobject.c:569
>    device_move+0xe0/0x730 drivers/base/core.c:4606
>    hci_conn_del_sysfs+0xb8/0x1a0 net/bluetooth/hci_sysfs.c:75
>    hci_conn_cleanup net/bluetooth/hci_conn.c:173 [inline]
>    hci_conn_del+0xc36/0x1240 net/bluetooth/hci_conn.c:1234
>    hci_conn_hash_flush+0x191/0x260 net/bluetooth/hci_conn.c:2638
>    hci_dev_close_sync+0x821/0x1100 net/bluetooth/hci_sync.c:5327
>    hci_dev_do_close net/bluetooth/hci_core.c:501 [inline]
>    hci_unregister_dev+0x21a/0x5b0 net/bluetooth/hci_core.c:2715
> 
> syzbot has reported 35 hits with this signature across net, net-next
> and linux-next between July 2025 and January 2026, via both vhci
> release and HCIDEVRESET ioctl.
> 
> Return -ENOENT in that case, consistent with sysfs_create_dir_ns().
> The underlying ordering problem in bluetooth -- device_move() called
> after the target's sysfs has been torn down -- is a separate issue.
> 
> Reported-by: syzbot+d1db96f72a452dc9cbd2@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/687c6966.a70a0220.693ce.00a5.GAE@google.com/
> Reported-by: syzbot+faeac5b54ba997a96278@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=faeac5b54ba997a96278
> Fixes: 324a56e16e44 ("kernfs: s/sysfs_dirent/kernfs_node/ and rename its friends accordingly")
> Cc: stable@vger.kernel.org
> Signed-off-by: Conor Kotwasinski <conorkotwasinski2024@u.northwestern.edu>
> ---
>  fs/sysfs/dir.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
> index ffdcd4153c58..6664fae288c9 100644
> --- a/fs/sysfs/dir.c
> +++ b/fs/sysfs/dir.c
> @@ -108,6 +108,9 @@ int sysfs_rename_dir_ns(struct kobject *kobj, const char *new_name,
>  	struct kernfs_node *parent;
>  	int ret;
>  
> +	if (!kobj->sd)
> +		return -ENOENT;
> +
>  	parent = kernfs_get_parent(kobj->sd);
>  	ret = kernfs_rename_ns(kobj->sd, parent, new_name, new_ns);
>  	kernfs_put(parent);
> @@ -120,6 +123,9 @@ int sysfs_move_dir_ns(struct kobject *kobj, struct kobject *new_parent_kobj,
>  	struct kernfs_node *kn = kobj->sd;
>  	struct kernfs_node *new_parent;
>  
> +	if (!kn)
> +		return -ENOENT;
> +
>  	new_parent = new_parent_kobj && new_parent_kobj->sd ?
>  		new_parent_kobj->sd : sysfs_root_kn;
>  
> 
> base-commit: 36f35b8df6972167102a1c3d4361e0afb6a84534
> -- 
> 2.50.1 (Apple Git-155)
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BE51FCFE7;
	Wed,  8 Jan 2025 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736349061; cv=none; b=Uv90P29oSCWZFJZ0i++tS+UCHSrvdU3mnibkny1TgccBWgcHtG91c8OWvsbQGRfNiTTKFSfdfHO2iEokdeqJbzTjp408I7vkJXb5WfPksEmjv7h9OwHeVLC6SoKTlsgG4ASMaIWe+igHpeT4xAVqIS4gtrIZ7+twz0HljZgRnBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736349061; c=relaxed/simple;
	bh=0RbKboOM+92g16c4Ur3L0BMqqh5Hfv+3t1Onnzid7Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7qJeEX51+n3iU7UkL7rWEcgcxJDdrCcUdhF3iNaKok4pYMNK0UC+lhArMT+q7JmdTEFcGHlzrBpRS73/ZnLfVBLCtcKX33jrC+5vBJPx92jh6FkXsCaIsIQSNDO2SmKlvmIwKS1ZqlOQ9CFdttZ0SqWFwWiAI83MPqvFLwldhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bwvtqZWx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bwvtqZWx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC375C4CED3;
	Wed,  8 Jan 2025 15:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736349060;
	bh=0RbKboOM+92g16c4Ur3L0BMqqh5Hfv+3t1Onnzid7Uk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bwvtqZWxbN/+aJWRc/odvyiKPDIHrxt9jfV37H+9eMn7VQIGxKPrFmjA3WoUHNuaR
	 cyztDwfsJjJnYtmwKEYseQIR7i9S6abVy7wc/TEGYtZW2jC8mGBpENyGiOKZ8Nz+0W
	 Vb66ciX6q+yHl+EbNx1NAyyg71nSXTmQgFTH5piw=
Date: Wed, 8 Jan 2025 16:10:57 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Hsin-chen Chuang <chharry@chromium.org>,
	linux-bluetooth@vger.kernel.org,
	chromeos-bluetooth-upstreaming@chromium.org,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Allow reset via sysfs
Message-ID: <2025010853-stalemate-upheld-10f4@gregkh>
References: <20250103112019.1.I8342291b757b20cd4cdbbfe658dc58ed5df46565@changeid>
 <2025010829-used-halves-7342@gregkh>
 <CABBYNZLEG4rQBM6WYyRNJwOYWQU2ajyCTxWwe3+6aCYm=Gk4dQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZLEG4rQBM6WYyRNJwOYWQU2ajyCTxWwe3+6aCYm=Gk4dQ@mail.gmail.com>

On Wed, Jan 08, 2025 at 10:06:34AM -0500, Luiz Augusto von Dentz wrote:
> Hi Greg,
> 
> On Wed, Jan 8, 2025 at 7:34 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Jan 03, 2025 at 11:20:20AM +0800, Hsin-chen Chuang wrote:
> > > Allow sysfs to trigger reset via the cmd_timeout function in hci device.
> > > This is required to recover devices that are not responsive from
> > > userspace.
> > >
> > > Also remove the cmd timeout count in btusb since we only ever allow one
> > > command in flight at a time. We should always reset after a single
> > > command times out.
> > >
> > > Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> > > ---
> > > This commit has been tested on a Chromebook by running
> > > `echo 1 > /sys/class/bluetooth/hci0/reset`
> >
> > You forgot the required Documentation/ABI/ update for your new sysfs
> > file :(
> 
> Looks like I've missed that when reviewing these changes, anyway no
> pull-request has been made, I assume we should follow what is
> documentation on Documentation/ABI/README?

Yes, all sysfs entries must be documented that way.  We have a script in
the tree that you can run to verify that all entries are documented, but
I don't think anyone runs it very often :(

> Does it include debugfs
> entries as well or only sysfs are required to be documented?

Only sysfs as that's the only stable api, debugfs can change all it
wants :)

thanks,

greg k-h

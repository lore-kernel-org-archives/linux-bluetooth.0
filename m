Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493E01FE45D;
	Wed,  8 Jan 2025 16:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736352794; cv=none; b=saAmcEM+HQw8RWtBeDcLGLvqbxju9PTezj/sMlQeU40f/yulDTzHgQnpW2//pVPwpxn9h0TFWXaaciJUYmUwbPxYcBV2A/Kj6O0Mv504dsvoNSjjVUnwT4I0QGShlsxLnQIBqbnryYpJSy4nYO+OHPJm9n36CQxtd9rHeQMNFIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736352794; c=relaxed/simple;
	bh=T96IMoznZjXFrZDvY9AXecT/DDpr21PpFL281ZimX2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzrqqUq2ImUV7I9FEoPlBMurm9RGcZ48Bu+oyE/pjyR3dwsMcsJuKpPYQFGQHqm1xceFvcDsQuoqNvm2m1DhkhqSzAS5Wdz9GMB7BcsiAtVohLQv/vkGkdzW3VPrzm4085qDSPSZT9ABPNsMfxIhtoAPLjwPrqTh7HhS8njglNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fdny44/7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fdny44/7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DDA4C4CED3;
	Wed,  8 Jan 2025 16:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736352793;
	bh=T96IMoznZjXFrZDvY9AXecT/DDpr21PpFL281ZimX2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fdny44/7N6FGzLWmlANxIOZDg5yBQE/zrmgDN8rvvtF9EnMceVJSnonX1WQDsWNVI
	 IC/hasWlN+HWjFsl+FB1P6VNYbWHacDpFRGHsOi2Y8U3RrI/1Y/G3O7lyBoRJE6Lt8
	 08YnTERfZvEXWyYVoRAz05npvGuoTy4uCeTGG6a8=
Date: Wed, 8 Jan 2025 17:13:10 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Hsin-chen Chuang <chharry@chromium.org>,
	linux-bluetooth@vger.kernel.org,
	chromeos-bluetooth-upstreaming@chromium.org,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Allow reset via sysfs
Message-ID: <2025010859-finlike-reprise-1f7a@gregkh>
References: <20250103112019.1.I8342291b757b20cd4cdbbfe658dc58ed5df46565@changeid>
 <2025010829-used-halves-7342@gregkh>
 <CABBYNZLEG4rQBM6WYyRNJwOYWQU2ajyCTxWwe3+6aCYm=Gk4dQ@mail.gmail.com>
 <2025010853-stalemate-upheld-10f4@gregkh>
 <CABBYNZKM9BsNFq=uFiOws6Tvtc-NQGTnVrD8-AJb=N6-EQk3bA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZKM9BsNFq=uFiOws6Tvtc-NQGTnVrD8-AJb=N6-EQk3bA@mail.gmail.com>

On Wed, Jan 08, 2025 at 10:33:01AM -0500, Luiz Augusto von Dentz wrote:
> Hi Greg,
> 
> On Wed, Jan 8, 2025 at 10:11 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jan 08, 2025 at 10:06:34AM -0500, Luiz Augusto von Dentz wrote:
> > > Hi Greg,
> > >
> > > On Wed, Jan 8, 2025 at 7:34 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Fri, Jan 03, 2025 at 11:20:20AM +0800, Hsin-chen Chuang wrote:
> > > > > Allow sysfs to trigger reset via the cmd_timeout function in hci device.
> > > > > This is required to recover devices that are not responsive from
> > > > > userspace.
> > > > >
> > > > > Also remove the cmd timeout count in btusb since we only ever allow one
> > > > > command in flight at a time. We should always reset after a single
> > > > > command times out.
> > > > >
> > > > > Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> > > > > ---
> > > > > This commit has been tested on a Chromebook by running
> > > > > `echo 1 > /sys/class/bluetooth/hci0/reset`
> > > >
> > > > You forgot the required Documentation/ABI/ update for your new sysfs
> > > > file :(
> > >
> > > Looks like I've missed that when reviewing these changes, anyway no
> > > pull-request has been made, I assume we should follow what is
> > > documentation on Documentation/ABI/README?
> >
> > Yes, all sysfs entries must be documented that way.  We have a script in
> > the tree that you can run to verify that all entries are documented, but
> > I don't think anyone runs it very often :(
> 
> Do you recall which script it is? I'd like to include that in my hooks
> and in our CI so I don't miss it next time.

It's scripts/get_abi.pl


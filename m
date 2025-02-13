Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26947200132;
	Thu, 13 Feb 2025 10:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739441598; cv=none; b=LX5WwjmN2afkEg3xZ/5VHmRpvnHPJMTnA35B/7vqVb8/4m80AJ4mlK3JIp8zpHOOPET8Kpi0jlz7aKZtH7jQ832UaqFqAGsdBWVtZHsR0rdkq8hbq1qJpqmD4dd3vu5HHuNk6heMNymmrZ5gUvUJvXRmtD8IRIakGm+9cItCwHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739441598; c=relaxed/simple;
	bh=20OLqeMxi5b375ShKZ/eaJDM4oD7NMZZLvo46Vj8rBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lw/5D2J108rrByq4xFai4Ac3wtmo9ew84njI8xfEkrhtXv4Nk4BDEq6jHTbHlRYBNMDZv8uSd6e9feNLfwUPodb08RrkaGK3nyjJ4bw9/uqFoUNwLnPVNb+SYAkJFMY+SY+/5tKw/3tzFcF3rJltBncbFmfxx/Ur2yxINHctQBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x7iLD3u7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x7iLD3u7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF11C4CED1;
	Thu, 13 Feb 2025 10:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739441597;
	bh=20OLqeMxi5b375ShKZ/eaJDM4oD7NMZZLvo46Vj8rBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x7iLD3u7FNklh5ERcnMHjOFAzkRiiyowmNr/kfMrqLydhg8nWE0cXCA0bq6yv9YGi
	 MpU9Mf2D20AUCDxHTV4SOZTPH8akPwX8Liixsij2TRj151+lMJG7UkEQA0DqdfhMXY
	 QBPO1gycnrZ51ZJbHd3/MeLMrN7eT8Y0AUb0iJ6w=
Date: Thu, 13 Feb 2025 11:13:14 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hsin-chen Chuang <chharry@google.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
	chromeos-bluetooth-upstreaming@chromium.org,
	Hsin-chen Chuang <chharry@chromium.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] Bluetooth: Add ABI doc for sysfs isoc_alt
Message-ID: <2025021328-limes-hacking-2ddc@gregkh>
References: <20250213114400.v4.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <20250213034413.3808375-1-chharry@google.com>
 <2025021325-faction-upward-6395@gregkh>
 <CADg1FFc9_QH10UqxGqjf8hnJkHWjhy6EMPrfDCgvBx2OdOydLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADg1FFc9_QH10UqxGqjf8hnJkHWjhy6EMPrfDCgvBx2OdOydLg@mail.gmail.com>

On Thu, Feb 13, 2025 at 06:07:59PM +0800, Hsin-chen Chuang wrote:
> On Thu, Feb 13, 2025 at 6:01 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Feb 13, 2025 at 11:44:01AM +0800, Hsin-chen Chuang wrote:
> > > From: Hsin-chen Chuang <chharry@chromium.org>
> > >
> > > The functionality was completed in commit c04f2e4f4ea1 ("Bluetooth: Fix
> > > possible race with userspace of sysfs isoc_alt")
> > >
> > > Fixes: c04f2e4f4ea1 ("Bluetooth: Fix possible race with userspace of sysfs isoc_alt")
> >
> > Where is this git id?  I don't see it in linux-next, are you sure it is
> > correct?
> 
> This hash is the first patch of this series.

That's not a valid git id as it only exists on your local system and no
where else :(

> So I guess I should send this patch after the ancestors are all
> applied then.

Or better yet, include the api addition as part of the patch that
actually adds the new api.

thanks,

greg k-h

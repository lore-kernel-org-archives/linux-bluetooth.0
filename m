Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214BE3921F1;
	Thu,  2 Apr 2026 09:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775122542; cv=none; b=HinKR0HfHiRqlbZI9FuamwodkXfys3savUznIWndGifbQLIIBizxmsDRW3oGqw025T4CEMtSo20oCnQGoxtD3+v/xVy9hxWm9hJ+LTfllP0CQqUHWVCvjyKSpirJtdgnQS++DJeTK70M99ZIPtGyy1lrGVRjeHBfsV7pg3hucHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775122542; c=relaxed/simple;
	bh=MTZv4o2zkiSq5PJ8qidKDtoDf4MfEDQAeE2+FKcPUBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EksGXzEB1el+V9xujDtH9cp753PXjv3KYkYuO5ViZaRNlCWCbu4NaGI88InVkdrdvtdSxp/VMS92TcTIfD3dGIBpZ8Vgy5E1jEdq2iu1g8/mvC+sOhwIAx0sZYFRnv5dpqqfbQbpqFtijnUZ9KMDrNlYklL+2Uv4DEkOyCDt70I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exyOE6s5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exyOE6s5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274B5C116C6;
	Thu,  2 Apr 2026 09:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775122541;
	bh=MTZv4o2zkiSq5PJ8qidKDtoDf4MfEDQAeE2+FKcPUBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=exyOE6s58Qjj5WebJEhtYQs/+7UIRofSqkdMgtZqhq7xpF79OnQxeChaGKFKtzL2C
	 2t1Wvj6StGCKs9vuhCXNB6Qm+zNBuucsARtmhQP+PDaztHdTJqMYTIZKBV6r7uvvuS
	 mkkxMUM2vJkgWOx65OQeaqnhYqSuUO2AXcFcfyLv1CCm02tV2EWuhH+8D195z3cyD5
	 MeBUNDdJDcCEuaE/H5IiY+msqfaRtvtzJXiPfJMUXtmWFiwQmBmjEQo+UasUrnHdGQ
	 h1+/CDZ97BIJj0qQEAPqi4l3SVn60X9cJABcecVr4h+8wOTTm5ch/mD90winmEQKZh
	 yDziaj/Pd9hBQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w8ESg-00000009qeo-2q3X;
	Thu, 02 Apr 2026 11:35:38 +0200
Date: Thu, 2 Apr 2026 11:35:38 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH] Bluetooth: btusb: fix wakeup irq devres lifetime
Message-ID: <ac44aqMBNGD_X78b@hovoldconsulting.com>
References: <20260330093311.1621965-1-johan@kernel.org>
 <CABBYNZJeGyDAj2jUOyOA1gHRXDS8LeYzWfT-gQpXfTEzMCH4sw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZJeGyDAj2jUOyOA1gHRXDS8LeYzWfT-gQpXfTEzMCH4sw@mail.gmail.com>

Hi Luiz,

On Mon, Mar 30, 2026 at 03:17:33PM -0400, Luiz Augusto von Dentz wrote:

> On Mon, Mar 30, 2026 at 5:33 AM Johan Hovold <johan@kernel.org> wrote:
> > The OOB wakeup irq is device managed but its lifetime is incorrectly
> > tied to the child HCI device rather than the USB interface to which the
> > driver is bound.
> >
> > This should not cause any trouble currently as the interrupt is only
> > enabled during suspend, but it is technically wrong as the reference
> > counted HCI device could remain after the driver has been unbound.
> >
> > Note that the data passed to the interrupt handler is not device managed
> > and is typically freed before the interrupt during disconnect, but this
> > is also safe as long as the interrupt is disabled.

> https://sashiko.dev/#/patchset/20260330093311.1621965-1-johan%40kernel.org
> 
> Not sure if it is valid though.

I'm afraid it is.

I had missed that the devres behaviour changed in 2023 so that managed
resources are now also released when deregistering a device which has no
driver.

The point about a possible race if disconnecting while suspended is also
valid.

I've just sent a v2 here:

	https://lore.kernel.org/lkml/20260402092704.2346710-1-johan@kernel.org/

Johan

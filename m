Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EB51A2567
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 18:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350488; cv=none; b=ICx+Chmq77Cn1RFHpilaIrbgoQHJ8vepI2vC6Cj0fpHr2VibK466MfAMIpl6IcBfz5Y6GU6UwmIVdSzluw4x6VQzu025sMD7kEkOG3MJWytLHs/aVL5DkEtRXZZ/uvWy10d2LcisuLKdiOvpAk9Nvc0LiaZpNjU8UUc0TzL5YYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350488; c=relaxed/simple;
	bh=7kYiJsHLRtWt64/ro/9Ft8TeTVJJgjlPyJXkJe7kz8w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IymFxFYfw4KnXTPRBEtfaR+rXb/0BFdnOEev5YHM/Qks42a8htgw/qkGuCScOa0Igwz1A7fz8kVZ6+MvPlQWNZ1WfHpQWEmkbxIvQqS0R1qhG7CvnYVGHMESYrjUw8B8YVjnMh2cvUXiti6NX70BScor0jQGaSe17PgXzDVJGmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTGsx0VX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTGsx0VX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445FCC4CECF;
	Mon, 11 Nov 2024 18:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731350488;
	bh=7kYiJsHLRtWt64/ro/9Ft8TeTVJJgjlPyJXkJe7kz8w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jTGsx0VXBbuhJg0S0mtzcH3zpBatZq0h8+4EPLm26/yqfRZQN6rvGssrjG3jWvqus
	 vv05LiQ+dIV0pwJajnyxrzj5K5NMEAykdu7yxnZGeoFduw/9jn8WSQ9cn0z039VSKM
	 CT1n41NqViAPk7UOCnk4UbBBI7myGT22p3XE1NVCDsPiURNZ5y2ChrryZnu5nl8qIG
	 5QM+Uj9Q5WXDcnu27B3aJ0gDcVhUqUigeULM/EjT2j7TLer4GPlHxndAXqAxEmLP5B
	 CY+/5UfTH/cOqeuVQkC/Tf6EE/B5sLUrb7J3OzQdFewQRGg4XwSKBoIj5cG70hgy9k
	 96GEO+cVEIsxw==
Date: Mon, 11 Nov 2024 12:41:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Chandra Shekar Devegowda <chandrashekar.devegowda@intel.com>,
	linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com, Kiran K <kiran.k@intel.com>
Subject: Re: [PATCH v2] Bluetooth: btintel_pcie: Support suspend-resume
Message-ID: <20241111184126.GA1805689@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <693d09b6-edab-4ed4-8df5-11ca74bb02e6@molgen.mpg.de>

On Fri, Nov 08, 2024 at 10:18:54AM +0100, Paul Menzel wrote:
> Am 08.11.24 um 15:39 schrieb ChandraShekar Devegowda:
> > This patch contains the changes in driver for vendor specific handshake
> > during enter of D3 and D0 exit.
> 
> Please document the datasheet name and revision.

Please also include a section reference for this vendor-specific
handshake required for transitions between D0 and D3hot.

Most devices don't require this kind of code, and its existence is a
hint that extra work will be needed to maintain it.

Bjorn

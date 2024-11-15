Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C84918BC36;
	Fri, 15 Nov 2024 09:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731661721; cv=none; b=aMhCjFZ2xCdXSBWfXDYA4MHbsNzOrhORAvyUyofxN9DmyepTQzp1Bx6ocP9D2HDMfCcvLLqPAablqSFzFpKUX8p1exXoejieSGQh1HeCbPFxQ/0hArvRZRAia0aqowq0zZH94WZ9F6K2o4ICvAjY8FX/dadiPyNHwmGEoh09lpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731661721; c=relaxed/simple;
	bh=r3YLV+KiHAmSlOJ0CxwzIP4M4FT0zkB8q5+FWZmhaoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTrPkgTFBeD54tc8G+ZyZSYYa5b3UvB73+PF7ChBcdgK4L/aAoKDeVk8ovCe/zxmcPs3opbkX9SxKB8Ld6oBYHJaztjPxfluhrUMrD1ASLoBRJCe5HlpgJO1rbThU7PgvlDBlcEbdFwAgMgShBiE6q7dQpKLL3zXPXWoxAHldBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JiEFX/Ud; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiEFX/Ud"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25D3C4CED0;
	Fri, 15 Nov 2024 09:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731661720;
	bh=r3YLV+KiHAmSlOJ0CxwzIP4M4FT0zkB8q5+FWZmhaoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JiEFX/UddpK56W1+Ws+83khJWfSQnmAzzxT2yDx5X76v2tAIoPni5Z0vSLmAl252Y
	 r27LJI8XHyyXChLTuvjPmbu14SUiWEJh27bbBbmdt8aY6k0Bit/Mi7EnV3MDoHwRJk
	 uyB1ckMRSTMd6rm6x0e+Nz/uuLsT4+BrjPjyuIur+oLZu78m0s7X7vCgTwi2D0o84h
	 2zVKJnF17DVPK1BaD5KyaJb9wuVC9N3OrUW0etxYk+rHvZGi327eZoV85qPQWvPkz4
	 JwZuja0Bx7LlXwnF7oUu76egaUC4rujCm3iwiT7Z34Zm7CvIJ9BVXvOHEKsFrwNUce
	 wGabiFpzf/zNw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tBsJb-00000000153-1zbU;
	Fri, 15 Nov 2024 10:08:31 +0100
Date: Fri, 15 Nov 2024 10:08:31 +0100
From: Johan Hovold <johan@kernel.org>
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: Tim Jiang <quic_tjiang@quicinc.com>,
	Janaki Ramaiah Thota <quic_janathot@quicinc.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: QCA NVM file for the X13s (WCN6855)
Message-ID: <ZzcPj-br2qb_tiMf@hovoldconsulting.com>
References: <ZjNxfFJmCgIyq8J6@hovoldconsulting.com>
 <5aea3149-ba44-400f-acc6-1a3eca8a7e72@quicinc.com>
 <ZjOUWqor4q1Efy0W@hovoldconsulting.com>
 <f1b45d7d-27e0-4ad7-976c-670a0e0d136b@quicinc.com>
 <ZjOfdK41yLwkH25T@hovoldconsulting.com>
 <5549d7e4-06cb-4305-8cec-10e93e5fbbff@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5549d7e4-06cb-4305-8cec-10e93e5fbbff@quicinc.com>

On Thu, Nov 14, 2024 at 02:57:45PM +0800, quic_zijuhu wrote:
> On 5/2/2024 10:13 PM, Johan Hovold wrote:
> > On Thu, May 02, 2024 at 09:46:38PM +0800, quic_zijuhu wrote:
> >> On 5/2/2024 9:25 PM, Johan Hovold wrote:

> >>> Lenovo has made requests for X13s firmware from Qualcomm and pushed it
> >>> to linux-firmware [1], but they have not yet been able to get Qualcomm
> >>> to provide an NVM configuration file for Bluetooth (I think the problem
> >>> may be finding the right person to talk to inside Qualcomm).
> >>>
> >>> So I was hoping maybe you could help us with this since the difference
> >>> between 'hpnv21.bin' that you pushed to linux-firmware and what came
> >>> with Windows appears to be really small (e.g. just a few bytes).
> >>>
> >> let me try to find out the right person who will push this task at next
> >> monday.
> >> there are some other internal procedures before we can push BT firmware
> >> into linux-firmware.
> 
> have up-streamed 22 NVM files which come from WOS into linux-firmware as
> shown by below link, both hpnv21g.b8c and hpnv21.b8c are also contained.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/?id=77a11ffc5a0aaaadc870793d02f6c6781ee9f598
> 
> (^^)(^^).

This is really good news.

Thanks a lot for your help with this, Zijun.

Johan

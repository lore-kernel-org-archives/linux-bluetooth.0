Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CE47262A;
	Sun, 15 Mar 2026 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773587089; cv=none; b=i7U9JHqbudFhGeATX2MtKF1pvSWCb3NdDksZH06zMYuJirQ5dRBPlKCurZdDkVESgaEgh6g+03LoIrSHq9W10SEhwmeFL3MXnFK5VX7RKpmj4sVgW87rnYND70ql/LtgvWFFhskS66rUhnib8TPj2W4B1T/6HCpfP3Fjn03dyeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773587089; c=relaxed/simple;
	bh=22hRzVUqhEm77L9voUSqkR8kEB47a+7hiGRxVV5wCr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBw6oAekFhdRLO4FFUJoQTvwrQ3gN5qMlgCedAGQqTTPrW+mIXobedb/jqbNPrvFg3mrBeCwkyu60uNAhr3Mk1eRR36OFJi8PjEo2dlJURZ4y+SfbMpmUmiyHiQMqgg7eAW1HxZpId6dOBvEcm4Ajv+51F22IGyM1sVOaiMyB94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESv+RZSm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESv+RZSm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F73C4CEF7;
	Sun, 15 Mar 2026 15:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773587088;
	bh=22hRzVUqhEm77L9voUSqkR8kEB47a+7hiGRxVV5wCr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ESv+RZSmwKPpCavgFFGs73ecnixOLhFRiuxorjGJGlGgXd4ytcqtrzc7V6GNJFtTK
	 5SJRSIze9fVBIZGQNFS9TRZzpzC/ESujQvy4vPMqvtk4WpworGZbXCaXjK+ONH9+qU
	 AQcpZ1jwq/N+qBEvOcNuw7MxpTLn5AiAtvMkEcKmxu2rtkis5mwC5vY77PRP7X0WbE
	 r4B4N8lBNHQpmn5SIKYcXxCX39dcx02Fe2pTLJ7oTGLHeJibDHs1ITnaOme8ygHUev
	 DOTed17085zfjrWsmIv0j2d6wvQ0hB+ZEEwLWkGvGomS05E43rTwmvFkrJm4+ux1oI
	 zOIE+BOmUX22A==
Date: Sun, 15 Mar 2026 11:04:47 -0400
From: Konstantin Ryabitsev <mricon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, helpdesk@kernel.org, 
	davem@davemloft.net, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [GIT PULL] bluetooth 2026-03-12
Message-ID: <20260315-majestic-beluga-of-fragrance-cf42c6@lemur>
References: <20260312200655.1215688-1-luiz.dentz@gmail.com>
 <20260314104436.31bcf68b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260314104436.31bcf68b@kernel.org>

On Sat, Mar 14, 2026 at 10:44:36AM -0700, Jakub Kicinski wrote:
> To be clear I have pulled already, if any of the AI reports looks
> urgent please send a follow up.
> 
> Hello helpdesk! The patchwork reply bot has not been replying to pull
> requests for us in the last few weeks. Is this an intentional change?

It was an intentional change to make it work more reliably, but we clearly
failed because it stopped matching altogether. *sigh*

I think I found where the match was failing and added tests to check for it.
It won't work retroactively, but it should find future pull requests
(hopefully!)

Regards,
-- 
KR

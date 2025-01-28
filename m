Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2675C1AAA05;
	Tue, 28 Jan 2025 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738081816; cv=none; b=GLyrxwmzqpXS3y27FnwhXz8viIqtets35HBc9io//KkTdydzkHvWF6gIyC3VfBM55h0wuECp5KM7UWockMTmQsAVvMNik/i+Sl5rio2mHZWwJCRCe1A2pPcuTuauJ5VQTPmcQZK5xKZPLiLa63+v6gX1yBWxyG2Z7T8oUuOmNXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738081816; c=relaxed/simple;
	bh=kQoH88OREQFhU2aGs50KfDUNu5pMSTQMMHeJifMtNys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQ41oVHB1YETdE813ZqIkWqsKJ28lbjcKIiY1DgngFYyIvC+plgOHrYH+yQsaGT+kTK51N+KVrYNvugQb9JqwMRGwbbpqaGHMI0mtcZaCYO29qA2+HDnWZQoetGjU7kw/qcHjmLgvIDBaCWIRWbTFAEHF/glAdiY/nJ3wnKekcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1AaKtr6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1AaKtr6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF68DC4CED3;
	Tue, 28 Jan 2025 16:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738081815;
	bh=kQoH88OREQFhU2aGs50KfDUNu5pMSTQMMHeJifMtNys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R1AaKtr6qKKO9sXdidaim9oKmff2alYZka1tgahdVTqVv6DbGdVvIQ7STLTzhE0e7
	 QqpFpUpTKXEJ6MHhEyNUiXbN1ifvaLh68LCYo9GhUnjfN/U9GpuHgLI/sdHoIrW2Rh
	 VwThMN9ToPx++wfa5ttx6qxhGObxMpOvMgyYRGrnwJYmGjCR32yBq3HRTcG8fgjJtn
	 XOpvQ+ijkepsOclmogXkhM1OdIBcZy68cWKTosv7v4YLCHE3L/CeKBgrcQ3ZuwYtvx
	 jdX+Lj/oUbGn5EUookCzYa4IOM1LE/ehLE69tTnIRBapbXWxYug3/nflVfnZBDdzwu
	 XiGKeVfLlsAlw==
Date: Tue, 28 Jan 2025 16:30:11 +0000
From: Simon Horman <horms@kernel.org>
To: linux@treblig.org
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: MGMT: Remove unused mgmt_pending_find_data
Message-ID: <20250128163011.GD277827@kernel.org>
References: <20250127213716.232551-1-linux@treblig.org>
 <20250127213716.232551-2-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127213716.232551-2-linux@treblig.org>

On Mon, Jan 27, 2025 at 09:37:15PM +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> mgmt_pending_find_data() last use was removed in 2021 by
> commit 5a7501374664 ("Bluetooth: hci_sync: Convert MGMT_OP_GET_CLOCK_INFO")
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Simon Horman <horms@kernel.org>


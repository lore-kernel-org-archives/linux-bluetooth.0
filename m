Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203D21A073B;
	Tue, 30 Jul 2024 13:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347358; cv=none; b=TsGPKdwTrpOiPTHxUB5fxhDCNBidDDRIC1OH0BYqKZVZzKrL+VgNxUfcGprtOQAu6M78lCFNs3CNy7DBqEXg5von4gdNFEUbsGJDJfAxZ/w26iptXwW7tehikZTCDXGbjF9CjmQKHOtkJS7fvXzBAnFqFXU553Fsj2AgEi3w8jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347358; c=relaxed/simple;
	bh=Qk+x/ExJnMrKwBjPkAZKwzWVdXpOHdQCZCst/0y6FC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXfNUPBxKGKs4nOvARiJ72uB81B1CB7qOHfkL2msqPRw8wIWunu5lLnTuurEnsZEPY0e1gqxjeErbu8QPfCfRXIUQOj99Xhn56eaLOSx5JxtCE1Z0cXebZFazW+TxEh/WiIs/vyOvOHZxsfyp4J6CcVslyEES0zaodscyZIZhLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e2JVYrt3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e2JVYrt3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C922C32782;
	Tue, 30 Jul 2024 13:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722347357;
	bh=Qk+x/ExJnMrKwBjPkAZKwzWVdXpOHdQCZCst/0y6FC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e2JVYrt308B/XZY2tAdufFG5F40fye02lcD4eYsZcF6lk3XdiY76a0Wqbc+CInkQb
	 O0FMQ+pM9vh/SK8g8n39dwYOwsLrMbWusyTUm1rCYku8/iubmwgPc6rYRyPy+lb8DV
	 WBlQb0pZRcLSj19cmIkdL7Qp7GcsThoxpgmrYEuk=
Date: Tue, 30 Jul 2024 15:49:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Erpeng Xu <xuerpeng@uniontech.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, hildawu@realtek.com,
	wangyuli@uniontech.com, jagan@edgeble.ai, marcel@holtmann.org,
	luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, guanwentao@uniontech.com,
	luiz.von.dentz@intel.com
Subject: Re: [PATCH 6.1 2/3] Bluetooth: btusb: Add RTL8852BE device 0489:e125
 to device tables
Message-ID: <2024073009-scuttle-commodity-b72e@gregkh>
References: <20240729034247.16448-1-xuerpeng@uniontech.com>
 <19179A84E7AE6A51+20240729034247.16448-2-xuerpeng@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19179A84E7AE6A51+20240729034247.16448-2-xuerpeng@uniontech.com>

On Mon, Jul 29, 2024 at 11:42:31AM +0800, Erpeng Xu wrote:
> From: Hilda Wu <hildawu@realtek.com>
> 
> commit a36e1feacd048a014e42dcbba2aaca9a26d7cfe6 upstream

Not a valid git id.

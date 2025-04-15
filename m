Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6820C2222C5;
	Tue, 15 Apr 2025 23:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744759627; cv=none; b=E7UMylWhu449vTbRDxCm386lKMFZ4YawTGcIJ1vAweRVOsMOV6vLkWd5vyN7yhCU6pVIQvPoQIVwLBeKUyauHiFSODb27kIhyIC4CsVkmp+21Z1fOFMpfOWdLPzaZnja4TQh/PLpQewd5my9IMmN2Sg/IA75q9lLu22vFijw6Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744759627; c=relaxed/simple;
	bh=3Sir4+T4AwfnNy/8QK8vbEwvLVe1miGWHDLZq0uyyT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=II1JmNqBD/0GrUsLEmTOJ7GKtQVGXsFSAwJ+X409vyjneOiNs0zxbHkBDdr/XVZHCQHmuteK6l9l4vRTQCyFNgNmv+g6JL8i3dVnanERZ5g1C0ElFGn/6J/CkMdkkaEPZWGkZCwp+lN2c3LJOEjP00OpEQ7P6RZeuzBdfSqDLWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIo8SYty; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIo8SYty"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E89C4CEE7;
	Tue, 15 Apr 2025 23:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744759626;
	bh=3Sir4+T4AwfnNy/8QK8vbEwvLVe1miGWHDLZq0uyyT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hIo8SYtyHoSoPk7lqB1o5VyWLcsrN9ObJNjJM7opi7LfMakYyW9skhMN2wELTC95b
	 fMamKvJNicBpVQLjaXFK/JUL6H7aCuVUcpbfLv9u9RPqtYVMy2ZNhTRBd+kC4NZaXN
	 50SIVZFqhi/vt9fXL4M3n3gOUT4kKtQ1JQKmachq0VjrIAD+2yhWgZeSn8/7gi2DWX
	 Pu7fj8RRmRicIPjcQGqXF9A6qs+TVgBUV6VO0CdCwbtgZOpUMCsIuyKEgxo0Mm/Mqr
	 /kjVcANx6I7v6ppDZLd72i+ENJMIDM1CjUs40JFZQ7kGDl+Qvthn98ZW6tfxlKrp9k
	 HMwkNp/vaogpA==
Date: Tue, 15 Apr 2025 18:27:04 -0500
From: Rob Herring <robh@kernel.org>
To: patchwork-bot+bluetooth@kernel.org
Cc: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>, marcel@holtmann.org,
	luiz.dentz@gmail.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, amitkumar.karwar@nxp.com,
	sherry.sun@nxp.com, manjeet.gupta@nxp.com
Subject: Re: [PATCH v3 1/2] dt-bindings: net: bluetooth: nxp: Add support for
 host-wakeup
Message-ID: <20250415232704.GA956317-robh@kernel.org>
References: <20250414175952.403002-1-neeraj.sanjaykale@nxp.com>
 <174474844000.2765712.3519619421796978194.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174474844000.2765712.3519619421796978194.git-patchwork-notify@kernel.org>

On Tue, Apr 15, 2025 at 08:20:40PM +0000, patchwork-bot+bluetooth@kernel.org wrote:
> Hello:
> 
> This series was applied to bluetooth/bluetooth-next.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
> 
> On Mon, 14 Apr 2025 23:29:51 +0530 you wrote:
> > Add support for host wakeup on interrupt.
> > 
> > Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> > ---
> > v2: Use interrupt instead of host-wakeup-gpios. (Rob Herring)
> > v3: Fix errors in dt_binding_check. (Neeraj Kale)
> > 
> > [...]
> 
> Here is the summary with links:
>   - [v3,1/2] dt-bindings: net: bluetooth: nxp: Add support for host-wakeup
>     https://git.kernel.org/bluetooth/bluetooth-next/c/f68f62f57917

I happen to have no more comments in this case, but please let DT 
maintainers have a chance to ack/review bindings.

Rob

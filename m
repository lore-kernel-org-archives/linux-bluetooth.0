Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CE533A031;
	Thu, 20 Nov 2025 16:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763657005; cv=none; b=E7B8VmxRL+1MEFWDiZv0xuOlznE/GRfF2I/D/K8V0z3Ljq2dTZ60PhxYo6elGbnGJXHuF86JmPpYG+Q/IsC/sW0NAHec9kXCdJh6D8xUaFkB6CuakTSpUW90kbbNsOuBv7n0uZRnpiHWWSZIFzz3okoyaXV/BlcmnH0gcnKsRQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763657005; c=relaxed/simple;
	bh=dUIhrJg6evgAmwLYcdnUYtg1zhKvMCqiLE1HJR0Bnr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWTedJJZR0z/pcmgAqeRmaCExYE6gABy16cC+mFfXdKoV8T+dFg9zg0RQRWy52x7nXC+qMQ+Vcu2wp7i9xttkwV2wyNjeMd5cmiEE1ElrHbaNLm/gC1K5O6w3h9PwIVZcShrYqVxQyE6glqqrlAIAPlpJTeXTl/mGS/Ac70B7XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v/mbh+tv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v/mbh+tv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7B0C4CEF1;
	Thu, 20 Nov 2025 16:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763657004;
	bh=dUIhrJg6evgAmwLYcdnUYtg1zhKvMCqiLE1HJR0Bnr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v/mbh+tvB1KHelE1be9Z1/VEYxRSHACo9IxEASdHb3KE0sdGip0SRtZ/nrsQ3s43a
	 wzRPKSiS9wI05OiqkCN6i+qGXrTmC0DnuybsHOBiO0f5YQF+x83ctOIY1MtZpjSSmm
	 44yfUg8qlDLRdQhoDq8AT89dUiG9RFPbyBQd5qpY=
Date: Thu, 20 Nov 2025 17:43:21 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: incogcyberpunk@proton.me
Cc: Doug Anderson <dianders@chromium.org>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"marcel@holtmann.org" <marcel@holtmann.org>,
	"luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
	"sean.wang@mediatek.com" <sean.wang@mediatek.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] Bluetooth adapter provided by `btusb` not
 recognized since v6.13.2
Message-ID: <2025112001-omen-idealness-19d4@gregkh>
References: <jOB6zqCC3xjlPPJXwPYPb4MxHJOhxVgp380ayP7lYq-aT2iA5D8YCdMeCvq5Cp_ICZmqjpfgX8o9siQdlPu9DY4qgnL_zCjgqP23fXc-P4U=@proton.me>
 <T4YKnjuw-ZdA4uQjGVxQh-vqahAK_69kn20zfC_8R45iOxbdjo_tlIDwP5rTUyjn3NVUHYhG09VO2ryFtfLtgptBBhfXggFNAD2CVAwPcjU=@proton.me>
 <CAD=FV=WDx-WcosBWf2yd3sLx5pEyjOgbs_Y5RBF=+b=0q3dBww@mail.gmail.com>
 <5rFwJreAVujrYXDGZZxW32PHa6HZ29PEP4R5-dqS9dbU3FI__qe3zIUx31TIHO_LjuURCSwaGucSFBPeXAjf00XzAxTzXbmf1AaY6neyQ3Q=@proton.me>
 <CAD=FV=UCnt3nUktRyzUDp1agDFp3ZJo=t+xBbLCD6W7Jd0aF7Q@mail.gmail.com>
 <5vLxmZlxKXfznaWPi2ndxyj90dJN1FML_fINz027uaJP2rZK_nQu_41m7WA7Gnc1yy_XLw8KMWF18Y_keW-qKjHy0BBOQl0A92QiY7Kg004=@proton.me>
 <CAD=FV=WRYYYB+G4-7y7uVR8QCEEMp2iRfmtsAa29UfyNCVD=4Q@mail.gmail.com>
 <YrzH4CVQLf1BjCQDuWEnQ5oxWGrsTge_CHmEViJEDklOFwbMEylpl2KnmeiG1EgCm62OKNFG1JRu_b2bOVUbZZOZQwcSNHbUO1gR1GiN1rI=@proton.me>
 <CAD=FV=XUFEMAuLiFUR7pvPsWJP=_A=6=UGrFX9mobTV1M0gN=w@mail.gmail.com>
 <dA269ZfA6vvmePZBF3DBULVIDsK_zAWujzWKpPy44BQ0QGB6t6pG5JVTt8lwsArauLABj3oMiZVMEzM8GzjJKgx1iqQNwkICiGq9cNtaZak=@proton.me>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dA269ZfA6vvmePZBF3DBULVIDsK_zAWujzWKpPy44BQ0QGB6t6pG5JVTt8lwsArauLABj3oMiZVMEzM8GzjJKgx1iqQNwkICiGq9cNtaZak=@proton.me>

On Thu, Nov 20, 2025 at 04:35:27PM +0000, incogcyberpunk@proton.me wrote:
> So, now does this patch for the regression gets merged upstream for the next mainline and stable releases ? 

Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

for how this happens.

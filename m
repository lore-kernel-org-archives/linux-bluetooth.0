Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F6C18059;
	Fri,  1 Dec 2023 08:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HON8145R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9657C433C7;
	Fri,  1 Dec 2023 08:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701418540;
	bh=YoFu4LPWO9QU5eNuqWxX7pj3NgheRF1/KenUSdFTI/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HON8145Riy+nnpqdCrFRzlpl60eP40K3oG/GIsHOzUcSgu0sg9UaoJ54C8KAybmpK
	 W7/jd+hfWjSf9K9VKDufmfBwcy6+446sQr3UkyS+UbjKRFUw4Gjcpb95FDk3Yzig3B
	 fyu3u1L3kqG/2bG6xIH6CtT7/kmKNsz52Gismxjs=
Date: Fri, 1 Dec 2023 08:15:38 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Regression: Inoperative bluetooth, Intel chipset, mainline
 kernel 6.6.2+
Message-ID: <2023120119-bonus-judgingly-bf57@gregkh>
References: <ee109942-ef8e-45b9-8cb9-a98a787fe094@moonlit-rail.com>
 <8d6070c8-3f82-4a12-8c60-7f1862fef9d9@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d6070c8-3f82-4a12-8c60-7f1862fef9d9@leemhuis.info>

On Fri, Dec 01, 2023 at 07:33:03AM +0100, Thorsten Leemhuis wrote:
> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> for once, to make this easily accessible to everyone.
> 
> CCing a few lists and people. Greg is among them, who might know if this
> is a known issue that 6.6.4-rc1 et. al. might already fix.

Not known to me, bisection is needed so we can track down the problem
please.

thanks,

greg k-h

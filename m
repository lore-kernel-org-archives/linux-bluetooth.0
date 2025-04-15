Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B95619F11F;
	Tue, 15 Apr 2025 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744734572; cv=none; b=fADH3iGzmMEgmmoeb85I2GKOkUBMhlCi7s6eSB6uWa5trm1R4GdvHIZ/aSsCvKb6n9K9XmalJfKc86qQ3g7vIJDkZHW//toKH080Sm8G3iGx5NPu6HmFilJRdIeTHBsuuUHNqecvxWq+kksl8lKlAOSf372Y1yLEBeqSH8i9DDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744734572; c=relaxed/simple;
	bh=N0EmEElYpU/e4cDljzDCDa5v6XT89r7iNvCAZRNdzxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUwzydBirpHeqHDFyxmBOaV2P81qiN4pk88WqTQjRcyeMxp+JiYTC6GDQfDJxUBShKWtXwTTt1auK0mdZUvFDfcFPjSs+ID4aMTfF6u/b9OawBDVYHPqhPYqHS7CS8PvFjf6Zpy7aMiVhwQlTr69Q8MQ4be/2TpFLWlqM9BR9vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RC3prLA1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RC3prLA1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253D8C4CEEB;
	Tue, 15 Apr 2025 16:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744734571;
	bh=N0EmEElYpU/e4cDljzDCDa5v6XT89r7iNvCAZRNdzxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RC3prLA1Icp60GmlzXhlHlvfG5Fymk6EJ53q7SPjTFO91Ik/XUglo8irNzn4yJ/I/
	 jdbjLAGb3OX6NJ3t6I4aGZF/GSm+OVfQoDYhiSPzylt+c4whDAIUdWgyiS3IMFH+e2
	 V4kOm1pEbTBp4H3I8QXuwJuMnpCZ0subL8hJGbYxE0ZlB0KGPPLdSSWUow3bPNXUME
	 KQYATuYAbrjdbWCWGWZE9J7zEY3nz5U1JME3MfNExXDOQJYciTFxwV3J5a4sUxa6qu
	 F5Vc7Ye0Bc7qTcs33nVHGWWo7Li4GoZ9hjEACJK+PhQMty8KU5G6q65Zui4BS9Gw8y
	 ohZvlKC+/y9jQ==
Date: Tue, 15 Apr 2025 09:29:29 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: stable@vger.kernel.org, kernel test robot <lkp@intel.com>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	linux-bluetooth@vger.kernel.org, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Manish Mandlik <mmandlik@google.com>, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: vhci: Avoid needless snprintf() calls
Message-ID: <5b2vwh4a2gp25wovqx26rbeveo7q6nbwg7c5pnsbsddyg434yc@ug6zgdwg5xel>
References: <20250415161518.work.889-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250415161518.work.889-kees@kernel.org>

On Tue, Apr 15, 2025 at 09:15:19AM -0700, Kees Cook wrote:
> Avoid double-copying of string literals. Use a "const char *" for each
> string instead of copying from .rodata into stack and then into the skb.
> We can go directly from .rodata to the skb.
> 
> This also works around a Clang bug (that has since been fixed[1]).
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401250927.1poZERd6-lkp@intel.com/
> Fixes: ab4e4380d4e1 ("Bluetooth: Add vhci devcoredump support")
> Link: https://github.com/llvm/llvm-project/commit/ea2e66aa8b6e363b89df66dc44275a0d7ecd70ce [1]
> Cc: stable@vger.kernel.org
> Signed-off-by: Kees Cook <kees@kernel.org>

Thanks!

Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CDA13C9AE
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2024 07:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712733700; cv=none; b=UuOJxaStH8w2DrtKexJTbgpFJqPxsFtMaKZAnGsazuj9dARTRtt73ybzJ5nXsP53hJqtj4NNzQmmp7mdb0KCFheXDYQBtugMnbFUY2pCEX6zcpMUBggtm2SYJCxZrnIuirZn6uc0YyWdwsQ4btxfEkYl74cju5i54SvZatAqXzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712733700; c=relaxed/simple;
	bh=uSO+u+i76hu3JFSP2eQ8xNE7qQlRpc9KE0wV5ZEsMpA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=oAGiMeS69xmDqvyqTC4PO9pihU6EifCMbnygsnkhqLqtctQsR0648bJzRADomnMDifn6fa3XOmQqqRqRD0QsnWu5PcvVXGFG7/ofHstN3drLswKRqIhfyIZxpJzVjERHG9XPRF//0z71R0CW+jFAQ8rpkw2SuwPLE338pJioEck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2eZh8Ll; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2eZh8Ll"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27369C433F1;
	Wed, 10 Apr 2024 07:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712733699;
	bh=uSO+u+i76hu3JFSP2eQ8xNE7qQlRpc9KE0wV5ZEsMpA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=o2eZh8LlewfFEFV9HSF/855Y36WPvFYpo5SB3vSffpC0HkUvrcv67je/qzpTyisX2
	 EENgwOwBE964tAteqLNsFAsdgBL4NaWO+rGrJ4mb9FbbG3o3GWI1pvO37JDsbc4wxw
	 UnCA78cfpYjQjLDJPTzcidw6mFErB59d2ClsHeD7Rli+uBmOGeDJ2Rt50R+reDIxOF
	 Med+sRHTpZimAGrknAXRrTLaCrlLWb9+nx0tzH7ajQ5/yqV0mzGpFlirwX1aODrtsc
	 cuFreVJnJQmxqVHudkUYc7tOYzyWB72EfMXl8LeXAX1zAc3ATCP7qDbEvzl0UTX4W3
	 e9QP2mDzxQ2eA==
From: Kalle Valo <kvalo@kernel.org>
To: Wren Turkal <wt@penguintechs.org>
Cc: ath11k@lists.infradead.org,  linux-bluetooth@vger.kernel.org
Subject: Re: QCA6390 bluetooth doesn't work after warm boot or disable/reenable
References: <a03dace1-ca0f-41d6-8e2c-636e3b053a3a@penguintechs.org>
	<31bb6e18-ecee-49b3-87d7-50ab53e07447@penguintechs.org>
	<1b3d3937-6679-491e-a5c6-818ae8ac639a@penguintechs.org>
	<87sezwjums.fsf@kernel.org>
	<99e404ee-81ca-4dcc-811f-9c55fc52c551@penguintechs.org>
Date: Wed, 10 Apr 2024 10:21:37 +0300
In-Reply-To: <99e404ee-81ca-4dcc-811f-9c55fc52c551@penguintechs.org> (Wren
	Turkal's message of "Mon, 8 Apr 2024 11:35:47 -0700")
Message-ID: <871q7d1y4e.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

(please don't top post)

Wren Turkal <wt@penguintechs.org> writes:

> Thanks for letting me know. The wifi is working great. Thank you for
> your work on that.
>
> I doubt you will have time, but if you do have a chance to test it,
> that would be amazing. I would love to make sure that I am not the
> only person having this issue, if possible.

I don't use bluetooth for anything but I'll try to test it at some
point, though too busy to do it now. IIRC I had initially bluetooth
enabled on the kernel but later disabled it due to problems. It's so
long that I can't recall the details anymore.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

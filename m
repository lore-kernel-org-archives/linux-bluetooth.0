Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3792F9490;
	Thu, 17 Jul 2025 15:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767686; cv=none; b=Wjx/pMezDnJYlsmSBnBUdleUWlZ95FB1aQZ85hQk8WC4IK/l9Nwa8MJDQsieGuu7f/bq5VYIMTaDbJjxO9+bj2hodgcJhBcXRWlkg9+bJFnOr2tQgcNCR8k84gBylJKhVIbgwBHViBc9sWg4pOWwGAXmqdmAGyDQCIrkTs7ldc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767686; c=relaxed/simple;
	bh=CDTLcl/U6J5OTCspCAmB22phRI4HTyhQcezQ0XtNx3g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SwvWtiIhfu1Ih38HDUuKUxcYspwZF8IRm50iHK5YEeQhuaApRBcghT+gQSs2dzjXAtPaTEMYIv93FgIMFAZGNdNWYo7qYI25vn5yqlBWGb5nbfFXoYAz6o/CukLaMFXS6qxra1DPhAS52hloOXUNXDw8DGehlhkeMB4FgfqHCiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPuQb0OR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPuQb0OR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58F9C4CEE3;
	Thu, 17 Jul 2025 15:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752767686;
	bh=CDTLcl/U6J5OTCspCAmB22phRI4HTyhQcezQ0XtNx3g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aPuQb0ORPo8kV5gsRMA88+qAz9uOriIDU8ZHDsZUMFDZ50fgOV6+lRPi9hIxmf6Of
	 TF/Bmz4VXufUoqzdEJMSSjYefEVTDUx+RMmn2CYdVdOUc7dBIZ2tQfrowZBtGUUvsE
	 siPyOAemb5+oKfesUTnnyuiZ72RwjXhGz6piQtk6/p5MlpBmEOvQadOwMwLtX7i/Vd
	 ru4+cDpLVDWms9oAaAtY3wkls8sv5C3F3y+YTVMEhmwmYKpNZf+At50KsSELE12SHZ
	 WpKvtpBltnyL/7PpV2f2MRxm+o/2ebL6tm95oNQeqmX1Y2y5Z0VwgFyFDV5iPjHRTo
	 uQyOd5xnu52og==
Date: Thu, 17 Jul 2025 08:54:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [GIT PULL] bluetooth 2025-07-17
Message-ID: <20250717085444.2847ac02@kernel.org>
In-Reply-To: <CABBYNZKW8aG=sJP+iwk44ozvJwiv0wPkrPrOBrnFZ=39rA7-CA@mail.gmail.com>
References: <20250717142849.537425-1-luiz.dentz@gmail.com>
	<20250717083857.15b8913a@kernel.org>
	<CABBYNZKW8aG=sJP+iwk44ozvJwiv0wPkrPrOBrnFZ=39rA7-CA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Jul 2025 11:47:49 -0400 Luiz Augusto von Dentz wrote:
> > On Thu, 17 Jul 2025 10:28:49 -0400 Luiz Augusto von Dentz wrote:  
> > >       Bluetooth: hci_dev: replace 'quirks' integer by 'quirk_flags' bitmap  
> >
> > FTR this rename and adding the helpers does not seem to be very
> > necessary for the fix? I know Greg says that we shouldn't intentionally
> > try to make fixes small, but there's a fine line between following that
> > and coincidental code refactoring.  
> 
> I should have reworded that commit, it is actually a fix, not just
> renaming, we run out of bits on a 32 bits system due to usage of int
> as storage.

Right, but I think if the new bitmap was called quirks the existing
set_bit / test_bit call sites would have been just fine, right?
The bit ops operate on single ulong and bitmaps all the same.

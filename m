Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB251925BF;
	Tue, 24 Dec 2024 09:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735031809; cv=none; b=rN2d70OEH0Si2owd6vDeyql9a4lhk19n9KWOnX7AMTZCK0Rq5zK5G5o9QXmsWgVrFdTT0y2n7o1ZfSm5/NOzl82E2kyQo1tDxqRiO7zMugibl5fH4QmXmC48tAfdMET+s/XnWpkToKZ8tTm5Ze1AFv7yZqmZl2673oQViwiIovA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735031809; c=relaxed/simple;
	bh=68gQ61YFtNb5/b2Ev2aLsynR409DaN2niltpErMKk5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYGYLTJ3FVeC1ZvwUtI06h+TxHo2sFs/b/5Z+IVB7LI9I/E8GmFJWX9GN8LbmSE1Xr0ssY84Jw01twInWmHEfxbJ7V3aXBBUdsXZ8ZOR6qqBh5FkQcK8/gfazMX0kEcEuIRIe42dX7dnf4b26iIPX6U5qziJijFc+vSPtSQbF/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZsJ6ceZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZsJ6ceZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9BBC4CED7;
	Tue, 24 Dec 2024 09:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735031809;
	bh=68gQ61YFtNb5/b2Ev2aLsynR409DaN2niltpErMKk5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZZsJ6ceZ5zPOSXemu45/hILaSsPdBx2SDLP+LBwv5XQOWZOybeXORzW+RCOL7KIut
	 7s8fCz30nPzNtO0MPUph4zOmsbGXJoaRGlOteTHxG7sZoh718QcBTQ+iVZMZQFooVJ
	 174ZI95bERxaQbvnB4Ak5b1xoMfHSjZHbZGlI7jQFioGPoB1STPLvG69a4HfXSpiQp
	 4U3GXphBcjbyHsvIt//5vgRBjGdzjIOT8tMFjm/vwg6uZpwjDU5r1r3yFXyGpm+Vrc
	 cUfiJ/EOhRFp47M+M64XB3ajJXnDWlx8jleZOIFtaht/tt4w+ej10ALYJyIvdfOb6y
	 73ldnO8QMookQ==
Date: Tue, 24 Dec 2024 10:16:46 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com, linux-bluetooth@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/1] dt-bindings: bluetooth: update the wcn6750
 required properties
Message-ID: <mzfad53v2paz7cawaepvaqeht2rr5spxyctqrlniiqgyfyyqlv@ixhxcksd3guz>
References: <20241223135700.22660-1-quic_janathot@quicinc.com>
 <20241223135700.22660-2-quic_janathot@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241223135700.22660-2-quic_janathot@quicinc.com>

On Mon, Dec 23, 2024 at 07:27:00PM +0530, Janaki Ramaiah Thota wrote:

Subject: everything is an update... say something useful, e.g. use PMU
abstraction for WCN6750

> Drop the inputs from the host and instead expect the Bluetooth node to
> consume the outputs of the internal PMU.

On which device?

But anyway I have doubts this is correct. enable GPIO is a pin going
from the host, not from PMU.

> 
> Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> ---
>  .../bindings/net/bluetooth/qualcomm-bluetooth.yaml           | 5 -----
>  1 file changed, 5 deletions(-)
> 

I don't understand why this is v6 of previous patchset. There was no
such patch before.

Best regards,
Krzysztof


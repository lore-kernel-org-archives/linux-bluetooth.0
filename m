Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C2916F8EC
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 11:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341799; cv=none; b=P599kT1bzD6lZYF8ARVQ/DmSL8vHAnIzboPGlnIvuF2ddV7nV73Hee02UxGWr2HHsOLkc9wgXKIZWGKCMNNkhoxUZvR6ooPL/ITlW3vJJJUQUz117mJOn7VHLq1YYvEbkLkOmpeqVPhdDejwyQQqvfs9bpnIDDSPLlJdcNby4+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341799; c=relaxed/simple;
	bh=dB9lEhR99wWG16NltKxg/RxU4tJ7SzVL1IzTU/QKbmA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HpB5BIbv1wYARUlNP/CJjeP78Yl8WpY+q0KH2JEhNXrNvJBb/NQECBt7C9QSTduRWtW5mk3XVSoMBjdKaJto+I6wOwWsaE3E8vYPO72UFdIJvTNtyIYW1awxPZv8wUJO0LqonhAj1cQ/3GkhGi3I8KGfqEEG7yQYWT1CQdwN4X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id C9F5C20008
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 11:49:55 +0000 (UTC)
Message-ID: <2b58a84ecc072b0230643ac6df34292dff233ae1.camel@hadess.net>
Subject: Re: Fix a number of static analysis issues
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Fri, 10 May 2024 13:49:55 +0200
In-Reply-To: <663e0965.050a0220.980ca.5a23@mx.google.com>
References: <20240510091814.3172988-2-hadess@hadess.net>
	 <663e0965.050a0220.980ca.5a23@mx.google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net

On Fri, 2024-05-10 at 04:47 -0700, bluez.test.bot@gmail.com wrote:
> This is automated email and please do not reply to this email!
>=20
> Dear submitter,
>=20
> Thank you for submitting the patches to the linux bluetooth mailing
> list.
> This is a CI test results with your patch series:
> PW
> Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D8521
> 87

Noticed a couple of bugs in those patches, will send a v2 with some
more patches ASAP.

Cheers

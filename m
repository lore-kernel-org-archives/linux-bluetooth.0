Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9130E2BEC3E
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 May 2025 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747153953; cv=none; b=VeFt7HXYr0RcSscSBxeTisxtdiDbBQ4RbKHHBCSHDqowV1ZrjaAhp2lRX+8qfYJlLo9O5sL6lLQESZTs8tPRaHdyCM8SKHOPBUlVOzFT3QvJWZwzI+N0CCMqMBtMcqtUVXd3DkUg5FcKg6nL9giSf7JoEdExchlMpcxIGGZFI6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747153953; c=relaxed/simple;
	bh=oQIaL79Y0kEXKYAnn0Z8e5aHIirI0vIh0KNefRMEviQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AlOm++DcyMtgBVBYsDa4Sz6MGyZ2wl9dHy8GeQDRENjYEdATkhKbkpRUonRl1tky0w5k1JW9P7DXziwQlVYnj5TcPWp8IM+2DX/1K+J7NPq2cFOI6qB8VhpcZtbUMOHXi2sH3/dEIFOnhONxOHInH4vCRABC0izU/+lXicwsVJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id A27A4439BE;
	Tue, 13 May 2025 16:32:22 +0000 (UTC)
Message-ID: <a2416c5b308269d8bcc001338b33e8567fcbf979.camel@hadess.net>
Subject: Re: [BlueZ v4 9/9] client: Port "assistant" menu to pre_run
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 13 May 2025 18:32:22 +0200
In-Reply-To: <CABBYNZK7HSXqq-Nch-81UT7zE-hGisLmby+Ecv56irrqkrJrvA@mail.gmail.com>
References: <20250513093913.396876-1-hadess@hadess.net>
	 <20250513093913.396876-10-hadess@hadess.net>
	 <CABBYNZK7HSXqq-Nch-81UT7zE-hGisLmby+Ecv56irrqkrJrvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdegiedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepieffgfehtedtgefgjeeggfffgeeuvdegveekveejfeekkedujeehteffueefffeunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepvddprhgtphhtthhopehluhhiiidruggvnhhtiiesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: hadess@hadess.net

On Tue, 2025-05-13 at 11:51 -0400, Luiz Augusto von Dentz wrote:
> Is the flag above really required though, I mean the bt_shell_run
> shall only be run once and even if that is no the case the shell
> itself could be doing the checking if the submenu.pre_run has been
> called, anyway if that is required Id say we do this in a separate
> patch, just let me know since I can drop the use of pre_run_done flag
> while applying these changes.

You're right, you can drop it. I don't know why, I thought that
bt_shell_run() was being run for every user-provided command when run.

That's the problem with coming back to work on patches months after
another iteration...

Feel free to remove the pre_run_done checks before merging

Thanks for the quick review!

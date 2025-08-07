Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524B31400C
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Aug 2025 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754575784; cv=none; b=SyMpeRkvHlBm16ku+HMyx0glo6uZPw65kbO3ZS5cKIE2VKT5IERhbGKNmq7/CfX4qOksn4aEQIiJlroM1n2BfPDAIOGrH/rWwiXQEjxSdpA534QhDTcM88rTlyH1rS61HmAzfFL8yuI3rvidrPB9Nc8MRtre4GDGEjVm88+siPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754575784; c=relaxed/simple;
	bh=mpDuWp14kaKk+JI7Pjw5rH6P6n6G9yjeakOCjrzJn7Q=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bA+vQ95kNku0exgqnlPnE666YR8bYn9/p5hk2OJ5PVDB0zaittXP206/uALpd7aSh4At7S9TM/n3J/CqFGINlcuceT0vY8IfComkUqRl6uZ+iDIT4jwoz4G/lj6R/hqWN7eqA7onesE7mc1lTV51PL/2Qalzg+HL4rqX9ZmRoMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id AF4C04315F
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Aug 2025 14:09:31 +0000 (UTC)
Message-ID: <9c0c53c63ce45099faac4311e29287405a275306.camel@hadess.net>
Subject: Re: [PATCH BlueZ 1/3] build: Move library source to lib/bluetooth
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Thu, 07 Aug 2025 16:09:31 +0200
In-Reply-To: <20250807140424.937218-2-hadess@hadess.net>
References: <20250807140424.937218-1-hadess@hadess.net>
	 <20250807140424.937218-2-hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdduudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkffuhffvffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepueeviedvteekkefgfefffeethfejieekteffvdetjeehfeeileettddvueeludelnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: hadess@hadess.net

On Thu, 2025-08-07 at 16:03 +0200, Bastien Nocera wrote:
> This fixes the installed directory hierarchy not matching the source
> directory hierarchy.

Just an FYI, the include changes were made mechanically with a tool (I
used "rpl" as a search and replace), not by hand :)

Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C779C2F361C
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756140068; cv=none; b=A7pVqYWlH+3+XKWyCKtY1v/0RYQIaE/Q3tTTgJpxXV19Kkgep8JXL0rjTHwTIbbKeDOnEcAZOmq7UqYHpcd59W6WYMOh9xwtXA1nmj1+0PIb1OYQasbNbgpfFYYa2xVxoKFkRmH+ruziZyVYDmlTEpMVsGVwYelyZif38qNGiuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756140068; c=relaxed/simple;
	bh=G0il+k6Ibaf6T5nhJm/ATczNpjiLnicfxvtlwUFFN58=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QIjUjsj4jxluzfGPjJd28v7bDm89TUuLlUpJ0WJbhVxL0c2j2vlrrak0bIX8ZY2IeF3+c3Bb0jXib24abD1pq08ht/oeOJSy1um8d0F0W1YEUTwdYM+zBIAZbBBAXw0C6iEU4qjtMcBOkLxFgEvVZf2EL6PtWDf2GQK6y3fd3I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 86C4E43A47;
	Mon, 25 Aug 2025 16:40:58 +0000 (UTC)
Message-ID: <153fce6357dee9d70a04fb4a6c19a975e5c710b4.camel@hadess.net>
Subject: Re: [PATCH BlueZ] lib: Fix includes in installed header files
From: Bastien Nocera <hadess@hadess.net>
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Mon, 25 Aug 2025 18:40:58 +0200
In-Reply-To: <20250825154632.336611-1-arkadiusz.bokowy@gmail.com>
References: <20250825154632.336611-1-arkadiusz.bokowy@gmail.com>
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
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedvledtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeeuveeivdetkeekgfefffeftefhjeeikeetffdvteejheefieeltedtvdeuleduleenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefpdhhvghloheplgfkrfhvieemvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefngdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheprghrkhgrughiuhhsiidrsghokhhofiihsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: hadess@hadess.net

On Mon, 2025-08-25 at 17:46 +0200, Arkadiusz Bokowy wrote:
> Every public header file should be self-contained in terms of used
> symbols. To satisfy that, hci.h and hci_lib.h need to pull their
> direct dependencies, so users will not have to include bluetooth.h
> before using for example hci_lib.h.

I think it might have been useful if those 2 changes were single
commits, and you showed the compile errors you got so the fix is clear.

> ---
> =C2=A0lib/bluetooth/hci.h=C2=A0=C2=A0=C2=A0=C2=A0 | 3 +++
> =C2=A0lib/bluetooth/hci_lib.h | 6 ++++++
> =C2=A02 files changed, 9 insertions(+)
>=20
> diff --git a/lib/bluetooth/hci.h b/lib/bluetooth/hci.h
> index 8f59a535a..732477ec4 100644
> --- a/lib/bluetooth/hci.h
> +++ b/lib/bluetooth/hci.h
> @@ -17,8 +17,11 @@
> =C2=A0extern "C" {
> =C2=A0#endif
> =C2=A0
> +#include <stdint.h>
> =C2=A0#include <sys/socket.h>
> =C2=A0
> +#include <bluetooth/bluetooth.h>
> +
> =C2=A0#define HCI_MAX_DEV	16
> =C2=A0
> =C2=A0#define HCI_MAX_AMP_SIZE	(1492 + 4)
> diff --git a/lib/bluetooth/hci_lib.h b/lib/bluetooth/hci_lib.h
> index 2cb660786..eeb51411a 100644
> --- a/lib/bluetooth/hci_lib.h
> +++ b/lib/bluetooth/hci_lib.h
> @@ -17,6 +17,12 @@
> =C2=A0extern "C" {
> =C2=A0#endif
> =C2=A0
> +#include <stdint.h>
> +#include <string.h>
> +
> +#include <bluetooth/bluetooth.h>
> +#include <bluetooth/hci.h>
> +
> =C2=A0struct hci_request {
> =C2=A0	uint16_t ogf;
> =C2=A0	uint16_t ocf;

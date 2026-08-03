Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D5C437451
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Aug 2026 20:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785790633; cv=none; b=Gpthrgk2snxXA1ymE1l7D8tAdNBSXTWZk9stBdSuNDnO2FTNb9NDfm2AuPyWsNld93Mo392TDD3IwGOqNGheQVAR2J/vzyk8fZMc7tuj/+iCGRhyGKCKvVO0tdas2ZhaOnMiVb9VjopaLh1ulzZJKz0YRFzqiPEkrpAYQpnnazk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785790633; c=relaxed/simple;
	bh=ABJSF+LJ7aAzFfs5bJ4z56Jrv56/t0Exe4TA8n1X030=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hcsCRP4WRpQXOCWoxGF+7oQBQU9jNkA1IVKlK6Te+4DeW7lSuG6LS+Q5NEKHu2m0iJ1Ed3KCevxTpaUBtDBdwJSfllVZ1Pxrb9ykOz0RrkhyRcwPdWsRNX3HHEhxtKCl3tpw5ocMGVvLVce+Wax1JwC9dIJ1nTr7JWnC4Fv9mFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id A77213F5B3;
	Mon,  3 Aug 2026 20:56:41 +0000 (UTC)
Message-ID: <2a1b99854117a6fbde6a7e28a4fb33edf239fe1f.camel@hadess.net>
Subject: Re: [PATCH BlueZ 1/1] Add cover art support
From: Bastien Nocera <hadess@hadess.net>
To: Jan-Michael <jan.brummer@tabos.org>, linux-bluetooth@vger.kernel.org
Date: Mon, 03 Aug 2026 22:56:39 +0200
In-Reply-To: <20260803195620.255866-2-jan.brummer@tabos.org>
References: <20260803195620.255866-1-jan.brummer@tabos.org>
	 <20260803195620.255866-2-jan.brummer@tabos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTEypmkW/3emTyzVVEfuIwVgP68S4yxzAtesDZzKo3VAYaVT4tEIc1Tg3v/iYCjdy3YtySr/mbUYF+pBFzLtSmvXnNiwC1c5hHh5fvEH76UsYLVu++6++klOF0+xZBBFdUsa4XKmkA+MNiE4Lurwi8xRd76DV7WDopkkcI2BbKXcrCb+93I1IJ6M+4+px8eYl2nYJIHIfu04TMO//DGve3PLbg5iXSko8/vZwZdBlpTPzDmMbUO7Nqz4dPW++XaBInp7b3wiffldPf76oBQScs0+Qqiwy+CIdWXUUnTsQsPhxYD49Tf5RZ5ytH2WBXX/u6nYlZn6aibjnSNpoch7Wn29LCH/DlBBUdcNzX/g6V9v9YrB5lfc/2ftKIqmB+oS/vuPwYqs+l4sJ7BR+ArxxvTlsBRuZZAUapitBHfvtVS5Y1FwJ1H/G24K1OGVBVwAuaNASeFl1V5PmeyKFAENhRdG3IX9rvR36ria5yq1r6OZ/Y/gpOei4GdrLS3XPpOSxwVCRbmcb8SgC5kOMHrSGVoC450w4q41ZI/k/vbjsKAjAUdwOAEG3NE6icl4zgDGFw+sHoUs2pdibMqe8mPGDU1j2k4PjYiRngdXvns0PtcA6G5B/XOEz9QeQ5D30WS0Js6NytoshTvl0qiF1Dh/+kcl0i12E63KbTHHx7vTslg3/A
X-GND-State: clean
X-GND-Score: 0

Hey,

On Mon, 2026-08-03 at 21:55 +0200, Jan-Michael wrote:
> =C2=A0# Filesystem lockdown
> -ProtectHome=3Dtrue
> +# Cover art referenced by MediaPlayer1 metadata (mpris:artUrl)
> usually
> +# lives in the user's home directory (e.g. ~/.cache of the player),
> so
> +# bluetoothd needs read access to serve it via the AVRCP BIP
> responder.
> +ProtectHome=3Dread-only

This is going to be a show-stopper.

Having a root-running daemon rummaging around in user's files is not
something we want *at all*.

Cheers

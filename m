Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8539E40DFD1;
	Thu,  4 Jun 2026 11:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572770; cv=none; b=iLFUAea6Ph1jZ77KL/jC3iF1uvSGKwTd2eHeWaxtq+XYAvrCgtZpDrQsFchTQg4/ntpgnO+ekhqbpoWHJUELcl10mCwJ3+MA1qIr4bmpxixnSJWWFty1Wa6uwy4N49yHaiN9DZ2P9hxEeiCF48OBcjLnYcQJGk3RgcGIz2onRdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572770; c=relaxed/simple;
	bh=W0vaia/Wzt+8dAhVf4d2JD5guaMN8cVnXui3gULrwR4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oyuc9SYzVE7ZfW2vADBjTW9aRnqLOikzkkM66Miz9vB7d+Z/5Cxkln+Zrhuyg79JiJIM8ylqZmB1VE6gei1k4hV6Aui+X8///uK1SpuT4nHev60e6KErG7oqwzCFHZc3uWzSj1r8+z9iROQa6Y/3ZfaLuY3pu85B/sFa8ylrOhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id DFD763EC24;
	Thu,  4 Jun 2026 11:32:43 +0000 (UTC)
Message-ID: <1b4540a3814b2e6106f48435df8692beaf177f8a.camel@hadess.net>
Subject: Re: [PATCH v2] Bluetooth: Add SPDX id lines to some source files
From: Bastien Nocera <hadess@hadess.net>
To: Tim Bird <tim.bird@sony.com>, marcel@holtmann.org, luiz.dentz@gmail.com,
 	jannh@google.com, kuba@kernel.org, kiran.k@intel.com,
 chharry@chromium.org, 	gustavo@padovan.org, prameela.j04cs@gmail.com,
 salvatore.benedetto@intel.com, 	maxk@qualcomm.com
Cc: linux-bluetooth@vger.kernel.org, linux-spdx@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 04 Jun 2026 13:32:43 +0200
In-Reply-To: <20260604004125.715884-1-tim.bird@sony.com>
References: <20260604004125.715884-1-tim.bird@sony.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGFItsjBr1DpudwB+mW/X4sMnyITRepEaZQnjdCFVeOp1jvCB4G8rgicrfSwAHlnDLmO5WXXc0iFLvOExXimz9E/ApFUr/BEnXIj0pkczrMbbykVaO4d9fXohd+ApfmuBDgpH1N/YD7mCpoJ1psRD1VeaQcVziLEf5Rmqyy0XAp1mSKDjKoA9n+TjeKdaTStAKzxmIOPUU142CsKyWP+KUSACOLC8+j+U3iAupWFAuseFfD4qPpuU4U5h/5rC6vI+K68K+Sfdu9JM8QQPkx8N/kdlEf+UQorjleY9kQr/wkJ67DwAZYYh9AdpQfyAzttP9YwpCdgEJGO5/sAK+HNDnpNXEgX3cLkb+mcHxSe60RlZAmfNbsMW1XfCghdFV09ucWpw2qHKu0yx8m0j+h02dBEa4tY4eu5CSO7HtYOyvWrzKdnvS+n1rGuB5Ngu6zeNL2W6AXpp7xLjcJQpcsrlD2d/ipQeaURSwKYvZ7+u5XlZ+QyLNjCevhEZUykaaX+2fyMhc2A3NMQpqj+seVJyOcG/7yZUmANBPUR8MDIheVHOClzVya54JSLyza5abvpOs/Q+DF31Hah8dGmeb8yobPH/p1H4MOXhtYeXr8O96F514YTohl0BO7PBEHwUozuhm/0VUJfs7OyucAdrLleqOOF1mmKQ7HfdiQCIb7UVrydg

Hello Tim,

On Wed, 2026-06-03 at 18:41 -0600, Tim Bird wrote:
> Many bluetooth source files are missing SPDX-License-Identifier
> lines. Add appropriate IDs to these files, and remove other
> license lines from the headers.

I think it would be useful to separate the changes in drivers/bluetooth
and the ones in {include/,}net/bluetooth.

Why do some of the id lines use C-style comments and others C++-style
comments? (/* */ vs. //) ?

> Leave the warranty disclaimer in files where the license ID is
> GPL-2.0 but the wording of the disclaimer is slightly different
> from that of the GPL v2 disclaimer.
>=20
> It is not different enough to cause licensing conflicts, but is
> kept to honor the original contributors' legal intent.

Good job doing this, do you know if there's a plan to automate this
somehow? It would be great to be able to re-run a script on top of a
codebase to verify that no sources were missed, and that we got the
same license ID assigned for the same license verbiage in the source
headers.

Cheers

Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2180933064D
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 08:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778141589; cv=none; b=Px+kwGE6oRFJAYzhwSviBFIOHFBXvfWpUemx9xqQZ8LdbFfff5ImSafBV8yQ5ZWPBgArmvX8iUYCq/0AT71MlmMq3wXCJXZlLvQUV8jH8etmC1Togu7N90sJ7t/YC1RaMfu7giNXPIiVK8EoR4jKNYLX+GcER6eM8avGc7LESKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778141589; c=relaxed/simple;
	bh=c6E8lUDUoWUunenEENLBXRDXAZKhC1URYEQ4EDfWpkk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hsEJZFovpopUSC8dSeUyN9Am8sp93U5LlB7sIU9BJXsrx/ygvvMexWb6dA+osTmBiyQnyjQ9SX6Mf78Bwzwut74U8E4Qj4PU1C0vfOm2zWhh6WV5qS19Kyu0b96upED3hT5Vjq7AE+AwrEdg0z7f8Cv/DIDLp+Om3K7nerKgbzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 974943E9C6;
	Thu,  7 May 2026 08:13:04 +0000 (UTC)
Message-ID: <a506942c64fea3ff40abe16756de20ee4f426ee2.camel@hadess.net>
Subject: Re: [PATCH BlueZ] bap: Fix typo in QoS D-Bus dictionary entry names
From: Bastien Nocera <hadess@hadess.net>
To: Thomas Kirschner <thomaskirschner85@yahoo.de>, 
	linux-bluetooth@vger.kernel.org
Date: Thu, 07 May 2026 10:13:04 +0200
In-Reply-To: <20260506230051.27436-1-thomaskirschner85@yahoo.de>
References: <20260506230051.27436-1-thomaskirschner85.ref@yahoo.de>
	 <20260506230051.27436-1-thomaskirschner85@yahoo.de>
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
X-GND-Cause: dmFkZTEA4actgv/+BqguF4HbJo0xnpnlrCgZGQ8WBks6Sar1ecsg96nz1I35jHM9X3JFRqudJz67GQwy4WxAaAgseb0twQw0e7cJ3G4EO22C/2KJJkwHmAP6cqq+L8OyJ+gmaIxXRyz86Ogu20KW9k7vSQUXw6uWy9a3lse9TvKJhJ43/5Xb3qkkWqFlNZ/Jo4weT7e95NlJ4yzTDKQEQgLYJldsxQ/ZkXObvMDK9SAJ8nMn+tkJEcRKGWp+se5S0ZLZwJzRM0vssV3//AAkYoXTl0aA6uPIEhfeRmjjQKU42qQTyFfpvUMf4gp8nw0jqnNLGbnbsg0vyA5xyonEMvDLrfxLqLTZWWhrvvSvK7xeNzYtoalcZsnomsGOHWob8v12Tz/se2ji57xVH1RJHmXtEAJ+mE1ZDtTSuY/oTV52I4nLiWt1KN/eLpZMSGPR7EtfiONz2TbNckFZwxYC7owZfIIi6i6zp2Rrl7TAlb3nUWAc+Gxb7t1cZnWUCrs9qOOk8MGK6btxmkYHWdDfMJSMZc4suG12wOZpDvq+Sg0XmVRJrjlyiIHN2qUnhhuYlEfclpQhhNKx7Rlme8hVPpn58qgzyDVtGevu6fEvuIWy2fThFkwvIdh5pmEQMiewV82fO4C3pIr0T8kGWOyC/lYp5TotHDExl3ZODW9f9kyqe6P5Ow

LGTM

On Thu, 2026-05-07 at 01:00 +0200, Thomas Kirschner wrote:
> MinimumDelay and PreferredMinimumDelay had wrong spelling, causing
> them to be exposed incorrectly over D-Bus. Any client relying on
> the correct spelling would fail to find these entries, breaking
> LE Audio QoS negotiation.
> ---
> =C2=A0profiles/audio/bap.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index 5333267f7..b35542488 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -432,11 +432,11 @@ static gboolean get_qos(const
> GDBusPropertyTable *property,
> =C2=A0	dict_append_entry(&dict, "Retransmissions", DBUS_TYPE_BYTE,
> &qos->rtn);
> =C2=A0	dict_append_entry(&dict, "MaximumLatency", DBUS_TYPE_UINT16,
> =C2=A0					&qos->latency);
> -	dict_append_entry(&dict, "MimimumDelay", DBUS_TYPE_UINT32,
> +	dict_append_entry(&dict, "MinimumDelay", DBUS_TYPE_UINT32,
> =C2=A0					&qos->pd_min);
> =C2=A0	dict_append_entry(&dict, "MaximumDelay", DBUS_TYPE_UINT32,
> =C2=A0					&qos->pd_max);
> -	dict_append_entry(&dict, "PreferredMimimumDelay",
> DBUS_TYPE_UINT32,
> +	dict_append_entry(&dict, "PreferredMinimumDelay",
> DBUS_TYPE_UINT32,
> =C2=A0					&qos->ppd_min);
> =C2=A0	dict_append_entry(&dict, "PreferredMaximumDelay",
> DBUS_TYPE_UINT32,
> =C2=A0					&qos->ppd_max);

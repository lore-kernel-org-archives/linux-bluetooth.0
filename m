Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E52D10F2
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2026 09:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007610; cv=none; b=j3R8i/a/o+OjDcGOMnlTIEm20IqTLlVw87a4B/994iWFL9HUwqGeQI6TvG9bufNokWbil7NCVJ+EnQhKmPy1VM4sX4Nt8x84qp/jMe7UftAQI9DjL03/1kQBO1y5zd12ttcJEWnf9+mfOqTi3hvsO8YYJRsxH2u0RSlRzC/Ny+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007610; c=relaxed/simple;
	bh=BSHMgvarnar1oA6PCx/WIJKraDG8ri1MnMYA0eZTHiA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ube2iSLYnosYrNaeQqnLA5An3ihpgEmLYCX662XP0xpZy8INaYhrdDcmnvNcB83kZziA6lxc+BO0xnFv20Y05+sRkp5Tgp0FxHcyCNqWtnfFG1sczfP/+48iHsa6Mix30j0dejsXQLLL9RB2wBi4aM92G/YxxnSUTzjG6bDGqeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id C781A3EB9F;
	Thu,  6 Aug 2026 09:13:25 +0000 (UTC)
Message-ID: <9b1784ef02eb8e74b68fb382d3958152caf1b045.camel@hadess.net>
Subject: Re: [BlueZ, v2] unit: Add test for sdp_xml_parse_record()
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 06 Aug 2026 11:13:25 +0200
In-Reply-To: <CABBYNZKpGvzN4BUxEFKH6WDpC5tq7iih3uBWrxR9aLRn_RBxpQ@mail.gmail.com>
References: <20260805150327.2669078-1-hadess@hadess.net>
	 <CABBYNZKpGvzN4BUxEFKH6WDpC5tq7iih3uBWrxR9aLRn_RBxpQ@mail.gmail.com>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTEjvzx1hpcZpdXhPMQu5a6V3F4pajV6zXQ4rLzcIhsGe2k1An6B7bN1QS4oGxh9LM5NkuUoNCQZt0SBu2zB+I1SOgnyv6+xg1+P3wt9FGKGn/iZ6pfSHIM+Tmq2k/OlQCMiNdt7ukHxTbAnuU3PbhvvjTJIYFFNzEg6RuGy9r7olpeDwBlMu8Sywgm/K8KpB/v9q0FWTpnWDt84jySm+oOZoec+cn+fvAonxIcWQ4gGEmVfOpZMAS0fQvlvNWxUBBWe5YxZkZENpPY57kCz7RKUn01fjHIVeUvaji+24dxxgSyqMuwooj4R7irVvWmdiY6dylCGlFD6olILPKzzJ5yYh6BPCMFVPStiPtGWn12t81pVHWYSi1ogamWwADF049mPadANsdiAtBlHZWCnVWzprhM+yH9iiLpEmNu40kyGbMOcdJWsegojhwaWQ8GoGpkOeyRfnBiKhKOWXq7gfPCWrUGL9mBU27EKur5g5Jiuqn6E8qBpcOsVUhr1PjOl+p6xQWSIq+05/BDKNarS2UPh0udGgV+KcCXuaWcnVuR5YWj0k0aClL64zWLqzhMK7AW3ctNx0bb6+FYUA3LzirJXAg/wv48SnJXTqgZ3Ds7rwh9kuesf6n9x/sk7LxjciVWKgZwqxOenscq21eGd1ygsxYK0s1q+h1rTNY/+LH5Sfg

On Wed, 2026-08-05 at 12:37 -0400, Luiz Augusto von Dentz wrote:
> Hi Bastien,
>=20
> On Wed, Aug 5, 2026 at 11:07=E2=80=AFAM Bastien Nocera <hadess@hadess.net=
>
> wrote:
> >=20
> > This adds 2 example XML files from other repositories, under a fair
> > use
> > license exception.
> > ---
> > Changes since v1:
> > - Added an "expected result" field, so expected failures can also
> > pass
> > =C2=A0 tests.
> >=20
> > =C2=A0Makefile.am=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 10 ++
> > =C2=A0unit/sdp-xml/Bluetooth_HID-sdp_record.xml | 123
> > ++++++++++++++++++++++
> > =C2=A0unit/sdp-xml/qt-SerialPortSDPRecord.xml=C2=A0=C2=A0 |=C2=A0 57 ++=
++++++++
> > =C2=A0unit/test-sdp-xml.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 81 ++++++++++++++
> > =C2=A04 files changed, 271 insertions(+)
> > =C2=A0create mode 100644 unit/sdp-xml/Bluetooth_HID-sdp_record.xml
> > =C2=A0create mode 100644 unit/sdp-xml/qt-SerialPortSDPRecord.xml
> > =C2=A0create mode 100644 unit/test-sdp-xml.c
>=20
> Why no reuse test-sdp?

Because I did not want to add XML parsing tests to something that
didn't link against it, and separate test binaries can run in parallel
(at least they can in meson), making running loads of small tests
faster than running larger tests.

Note that this patch is just the scaffolding for many other tests I
have locally, so let me know quickly if folding this code into
unit/sdp-xml.c is a requirement to getting it merged.

Cheers

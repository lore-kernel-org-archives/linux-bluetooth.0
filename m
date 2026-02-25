Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B743E2DCF55
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 16:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772035309; cv=none; b=X1KcIbzrrVdBGXtzo31wxsWtDbts+cK3qiJ/KEKVt84szVpAeiPXffvqI4AxSGSaoJYOwPJR4+Z7NLTVzbqgN6oHN/xm1y/2wpDYOjFmB7PzGTm2+By7ONcmS9lWR5BIuoQbRZwB6bZ4rH5p9DVEXY1CFVaLDoFGR2/hSO/rfg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772035309; c=relaxed/simple;
	bh=2ewoFYgfjTPYL1wB3PQGQrloK4FoFsGkI3RVkRUIrgU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TWEUPnlOfjUqs+tdqwvw2NiJFuWh07xxPN9kWSBAhKecONJPNrpDev8WvAP6l+JrSADGWMN3MSIvVOlT+3cIloRx4LBJvnXCnfKRYX+zWjqqdnL5dZ5/DI7ZLbZoWktFrhxvFFNMWiLcQT9PW57+DK61UQXuaFMEP+iUv/dANGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id A2BD5432F2;
	Wed, 25 Feb 2026 16:01:38 +0000 (UTC)
Message-ID: <cc92dcae7bf3c7832643071df30eb5734097d2d1.camel@hadess.net>
Subject: Re: [PATCH BlueZ 2/2] shared/shell: gracefully recover from failed
 input initialization
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Ronan Pigott
 <ronan@rjp.ie>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 25 Feb 2026 17:01:38 +0100
In-Reply-To: <CABBYNZLgugMFofwxAV4qFFP=RCnXG22MbcTgdt88ydbkSEKO9Q@mail.gmail.com>
References: <20260218024605.70890-1-ronan@rjp.ie>
	 <20260218024605.70890-3-ronan@rjp.ie>
	 <CABBYNZJqjaDJmkEy0yvyqLXP6kFH-dVjnzcCVknAkpu39zspaA@mail.gmail.com>
	 <defdb4fb77123ebe7abea7e8f225720e4e72e6c5@rjp.ie>
	 <CABBYNZLgugMFofwxAV4qFFP=RCnXG22MbcTgdt88ydbkSEKO9Q@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-zdJAYxf5jdCn/Tm71mLI"
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeefhedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtfgggsehmtderredtreejnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpefhgfetvdeuueejveefgfehuddvjedvudfhgeeuieefhedtvefftdffteefgfefhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugeptedvueffheegfedvhfdvpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopehluhhiiiguvghnthiisehgmhgrihhlrdgtohhmpdhrtghpthhto
 heprhhonhgrnhesrhhjphdrihgvpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-State: clean

--=-zdJAYxf5jdCn/Tm71mLI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-02-18 at 13:45 -0500, Luiz Augusto von Dentz wrote:
> Hi Ronan,
>=20
> On Wed, Feb 18, 2026 at 12:45=E2=80=AFPM Ronan Pigott <ronan@rjp.ie> wrot=
e:
> >=20
> > February 18, 2026 at 7:58 AM, "Luiz Augusto von Dentz"
> > <luiz.dentz@gmail.com> wrote:
> >=20
> > > Yeah, the revert part doesn't really fly since
> > > e73bf582dae60356641a32fc27ae03d359ec4c47 does fixes a valid
> > > issue,
> > > that said we do have another proposal under discussion:
> > >=20
> > > https://patchwork.kernel.org/project/bluetooth/patch/20260217222954.4=
32676-1-larsch@belunktum.dk/
> >=20
> > Hi Luiz,
> >=20
> > I'm aware it fixes a valid issue. My hope with the patch is to fix
> > that same issue in another way.
> >=20
> > The problem adressed IIUC is that once the input is initialized, a
> > subsequent epoll_wait would hang
> > since the epoll_ctl call had failed to actually add the new event
> > source. The reverted patch had
> > fixed this by trying to avoid initializing stdin in all cases,
> > which inadvertently broke
> > bluetoothctl. My suggestion is to revert that change, and instead
> > check the return value of
> > io_set_read_handler so that we can avoid digging ourselves into a
> > deeper hole. Even if bt_shell_printf
> > is refactored so that it doesn't require the input fd, which sounds
> > prudent, I think it probably makes
> > sense to check the return values here, so I believe the reverted
> > patch would no longer be necessary.
> >=20
> > I have seen Lars's patch, and that is actually what prompted me to
> > submit this one. Unfortunately,
> > it isn't correct since it causes non-interactive bluetoothctl
> > invocations to also print several
> > extraneous lines relating to the interactive shell.
>=20
> Feel free to git a review to Lars's patch; hopefully, that will help
> us get this resolved quicker. We might as well create a unit test for
> shell to try to emulate different modes and environments. That way,
> we
> prevent introducing regressions like this in the future.

I wrote one, which I can integrate into meson.

This starts "btvirt" (so requires root), launches bluetoothd if there
isn't a daemon already running, and launches "bluetoothctl list".

You can run it manually with:
$ sudo top_builddir=3D/path/to/bluez/builddir/ ./integration-test.py

If "bluetoothctl list" doesn't output any text, the test errors out.
I've tested that pointing the bluetoothctl_path() output at an old
version of bluetoothctl worked.

This pattern of using Python to create test suites using python-
dbusmock is something I've already used in PolicyKit, upower, power-
profiles-daemon, gnome-bluetooth and many other places.

This test is pretty heavy-handed if we just want to test whether
bluetoothctl outputs things correctly, but it has the benefit of
testing the emulator as well as bluetoothd. We could start adding more
tests to the mix, such as creating more adapters, pairing them, etc.

Hopefully, this is a useful test to run on CIs, although I'm probably
missing spawning a system bus on top of everything else.

What do you think?

--=-zdJAYxf5jdCn/Tm71mLI
Content-Disposition: attachment; filename="bluez-btvirt-integration-test.py"
Content-Type: text/x-python3; name="bluez-btvirt-integration-test.py"; charset="UTF-8"
Content-Transfer-Encoding: base64

IyEvdXNyL2Jpbi9weXRob24zCgojIENvcHlyaWdodDogKEMpIDIwMjUgQmFzdGllbiBOb2NlcmEg
PGhhZGVzc0BoYWRlc3MubmV0PgojCiMgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlv
dSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKIyBpdCB1bmRlciB0aGUgdGVybXMg
b2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQojIHRoZSBG
cmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2Us
IG9yCiMgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KIwojIFRoaXMgcHJvZ3Jh
bSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLAojIGJ1
dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5
IG9mCiMgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NF
LiAgU2VlIHRoZQojIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMu
CgppbXBvcnQgb3MKaW1wb3J0IHN5cwppbXBvcnQgc3VicHJvY2VzcwppbXBvcnQgdW5pdHRlc3QK
aW1wb3J0IHRpbWUKCnRyeToKICAgIGltcG9ydCBnaQogICAgZnJvbSBnaS5yZXBvc2l0b3J5IGlt
cG9ydCBHTGliCmV4Y2VwdCBJbXBvcnRFcnJvciBhcyBlOgogICAgc3lzLnN0ZGVyci53cml0ZSgn
U2tpcHBpbmcgdGVzdHMsIFB5R29iamVjdCBub3QgYXZhaWxhYmxlIGZvciBQeXRob24gMywgb3Ig
bWlzc2luZyBHSSB0eXBlbGliczogJXNcbicgJSBzdHIoZSkpCiAgICBzeXMuZXhpdCg3NykKCmJ1
aWxkZGlyID0gb3MuZ2V0ZW52KCd0b3BfYnVpbGRkaXInLCAnLicpCgp0cnk6CiAgICBpbXBvcnQg
ZGJ1c21vY2sKZXhjZXB0IEltcG9ydEVycm9yOgogICAgc3lzLnN0ZGVyci53cml0ZSgnU2tpcHBp
bmcgdGVzdHMsIHB5dGhvbi1kYnVzbW9jayBub3QgYXZhaWxhYmxlIChodHRwOi8vcHlwaS5weXRo
b24ub3JnL3B5cGkvcHl0aG9uLWRidXNtb2NrKS5cbicpCiAgICBzeXMuZXhpdCg3NykKCmNsYXNz
IFRlc3RzKGRidXNtb2NrLkRCdXNUZXN0Q2FzZSk6CgogICAgQGNsYXNzbWV0aG9kCiAgICBkZWYg
c2V0VXBDbGFzcyhjbHMpOgogICAgICAgIHN1cGVyKCkuc2V0VXBDbGFzcygpCiAgICAgICAgY2xz
LnN0YXJ0X3N5c3RlbV9idXMoKQogICAgICAgIGNscy5kYnVzX2NvbiA9IGNscy5nZXRfZGJ1cyhU
cnVlKQoKICAgIEBjbGFzc21ldGhvZAogICAgZGVmIHRlYXJEb3duQ2xhc3MoY2xzKToKICAgICAg
ICBzdXBlcigpLnRlYXJEb3duQ2xhc3MoKQoKICAgIGRlZiBzZXRVcChzZWxmKToKICAgICAgICBz
dXBlcigpLnNldFVwKCkKICAgICAgICBzZWxmLmxvZyA9IE5vbmUKCiAgICBkZWYgc3RvcF92aXJ0
KHNlbGYpOgogICAgICAgIGlmIHNlbGYudmlydDoKICAgICAgICAgICAgdHJ5OgogICAgICAgICAg
ICAgICAgc2VsZi52aXJ0LnRlcm1pbmF0ZSgpCiAgICAgICAgICAgIGV4Y2VwdCBPU0Vycm9yOgog
ICAgICAgICAgICAgICAgcGFzcwogICAgICAgICAgICBzZWxmLmFzc2VydEVxdWFsKHNlbGYudmly
dC53YWl0KHRpbWVvdXQ9MzAwMCksIDApCgogICAgICAgIHNlbGYudmlydCA9IE5vbmUKCiAgICBk
ZWYgc3RhcnRfdmlydChzZWxmKToKICAgICAgICBzZWxmLnZpcnQgPSBzdWJwcm9jZXNzLlBvcGVu
KAogICAgICAgICAgICBbIHNlbGYuYnR2aXJ0X3BhdGgoKSwgJy1sMScgXSwgc3Rkb3V0PXNlbGYu
bG9nLCBzdGRlcnI9c3lzLnN0ZGVycgogICAgICAgICkKICAgICAgICBzZWxmLmFkZENsZWFudXAo
c2VsZi5zdG9wX3ZpcnQpCiAgICAgICAgIyB0aW1lLnNsZWVwKDEpCgogICAgZGVmIHN0b3BfZGFl
bW9uKHNlbGYpOgogICAgICAgIGlmIHNlbGYuZGFlbW9uOgogICAgICAgICAgICB0cnk6CiAgICAg
ICAgICAgICAgICBzZWxmLmRhZW1vbi50ZXJtaW5hdGUoKQogICAgICAgICAgICBleGNlcHQgT1NF
cnJvcjoKICAgICAgICAgICAgICAgIHBhc3MKICAgICAgICAgICAgc2VsZi5hc3NlcnRFcXVhbChz
ZWxmLmRhZW1vbi53YWl0KHRpbWVvdXQ9MzAwMCksIDApCgogICAgICAgIHNlbGYuZGFlbW9uID0g
Tm9uZQoKICAgIGRlZiBkYWVtb25fY2hlY2soc2VsZik6CiAgICAgICAgZGFlbW9uX2NoZWNrID0g
c3VicHJvY2Vzcy5ydW4oWydnZGJ1cycsICdpbnRyb3NwZWN0JywgJy0tc3lzdGVtJywgJy0tZGVz
dCcsICdvcmcuYmx1ZXonLCAnLS1vYmplY3QtcGF0aCcsICcvJyBdLAogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHN0ZG91dCA9IHN1YnByb2Nlc3MuREVWTlVMTCwKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjaGVjaz1GYWxzZSwKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBjYXB0dXJlX291dHB1dD1GYWxzZSkKICAgICAgICBy
ZXR1cm4gZGFlbW9uX2NoZWNrLnJldHVybmNvZGUgPT0gMAoKICAgIGRlZiBzdGFydF9kYWVtb24o
c2VsZik6CiAgICAgICAgIyBPbmx5IHN0YXJ0IGRhZW1vbiBpZiBvbmUgaXMgbm90IGFscmVhZHkg
YXZhaWxhYmxlCiAgICAgICAgaWYgbm90IHNlbGYuZGFlbW9uX2NoZWNrKCk6CiAgICAgICAgICAg
IHNlbGYuZGFlbW9uID0gc3VicHJvY2Vzcy5Qb3BlbigKICAgICAgICAgICAgICAgIFsgc2VsZi5i
bHVldG9vdGhkX3BhdGgoKSwgJy0tbm9kZXRhY2gnIF0sIHN0ZG91dD1zZWxmLmxvZywgc3RkZXJy
PXN5cy5zdGRlcnIKICAgICAgICAgICAgKQogICAgICAgICAgICBzZWxmLmFkZENsZWFudXAoc2Vs
Zi5zdG9wX2RhZW1vbikKCiAgICAgICAgICAgIHNlbGYuYXNzZXJ0X2V2ZW50dWFsbHkobGFtYmRh
OiBzZWxmLmRhZW1vbl9jaGVjaygpKQoKICAgIGRlZiBibHVldG9vdGhjdGxfcGF0aChzZWxmKToK
ICAgICAgICBidWlsZGRpciA9IG9zLmdldGVudigidG9wX2J1aWxkZGlyIiwgIi4iKQogICAgICAg
IHJldHVybiBvcy5wYXRoLmpvaW4oYnVpbGRkaXIsICJjbGllbnQiLCAiYmx1ZXRvb3RoY3RsIikK
CiAgICBkZWYgYnR2aXJ0X3BhdGgoc2VsZik6CiAgICAgICAgYnVpbGRkaXIgPSBvcy5nZXRlbnYo
InRvcF9idWlsZGRpciIsICIuIikKICAgICAgICByZXR1cm4gb3MucGF0aC5qb2luKGJ1aWxkZGly
LCAiZW11bGF0b3IiLCAiYnR2aXJ0IikKCiAgICBkZWYgYmx1ZXRvb3RoZF9wYXRoKHNlbGYpOgog
ICAgICAgIGJ1aWxkZGlyID0gb3MuZ2V0ZW52KCJ0b3BfYnVpbGRkaXIiLCAiLiIpCiAgICAgICAg
cmV0dXJuIG9zLnBhdGguam9pbihidWlsZGRpciwgInNyYyIsICJibHVldG9vdGhkIikKCiAgICBk
ZWYgYXNzZXJ0X2V2ZW50dWFsbHkoc2VsZiwgY29uZGl0aW9uLCBtZXNzYWdlPU5vbmUsIHRpbWVv
dXQ9NTAwMCwga2VlcF9jaGVja2luZz0wKToKICAgICAgICAiIiJBc3NlcnQgdGhhdCBjb25kaXRp
b24gZnVuY3Rpb24gZXZlbnR1YWxseSByZXR1cm5zIFRydWUuCgogICAgICAgIFRpbWVvdXQgaXMg
aW4gbWlsbGlzZWNvbmRzLCBkZWZhdWx0aW5nIHRvIDUwMDAgKDUgc2Vjb25kcykuIG1lc3NhZ2Ug
aXMKICAgICAgICBwcmludGVkIG9uIGZhaWx1cmUuCiAgICAgICAgIiIiCiAgICAgICAgaWYgbm90
IGtlZXBfY2hlY2tpbmc6CiAgICAgICAgICAgIGlmIGNvbmRpdGlvbigpOgogICAgICAgICAgICAg
ICAgcmV0dXJuCgogICAgICAgIGRvbmUgPSBGYWxzZQoKICAgICAgICBkZWYgb25fdGltZW91dF9y
ZWFjaGVkKCk6CiAgICAgICAgICAgIG5vbmxvY2FsIGRvbmUKICAgICAgICAgICAgZG9uZSA9IFRy
dWUKCiAgICAgICAgc291cmNlID0gR0xpYi50aW1lb3V0X2FkZCh0aW1lb3V0LCBvbl90aW1lb3V0
X3JlYWNoZWQpCiAgICAgICAgd2hpbGUgbm90IGRvbmU6CiAgICAgICAgICAgIGlmIGNvbmRpdGlv
bigpOgogICAgICAgICAgICAgICAgR0xpYi5zb3VyY2VfcmVtb3ZlKHNvdXJjZSkKICAgICAgICAg
ICAgICAgIGlmIGtlZXBfY2hlY2tpbmcgPiAwOgogICAgICAgICAgICAgICAgICAgIHNlbGYuYXNz
ZXJ0X2NvbmRpdGlvbl9wZXJzaXN0cygKICAgICAgICAgICAgICAgICAgICAgICAgY29uZGl0aW9u
LCBtZXNzYWdlLCB0aW1lb3V0PWtlZXBfY2hlY2tpbmcKICAgICAgICAgICAgICAgICAgICApCiAg
ICAgICAgICAgICAgICByZXR1cm4KICAgICAgICAgICAgR0xpYi5NYWluQ29udGV4dC5kZWZhdWx0
KCkuaXRlcmF0aW9uKEZhbHNlKQoKICAgICAgICBzZWxmLmZhaWwobWVzc2FnZSgpIGlmIG1lc3Nh
Z2UgZWxzZSBmInRpbWVkIG91dCB3YWl0aW5nIGZvciB7Y29uZGl0aW9ufSIpCgogICAgZGVmIHRl
c3RfYmx1ZXRvb3RoY3RsKHNlbGYpOgogICAgICAgIHNlbGYuc3RhcnRfdmlydCgpCiAgICAgICAg
c2VsZi5zdGFydF9kYWVtb24oKQoKICAgICAgICBjbWQgPSBzdWJwcm9jZXNzLnJ1bihbIHNlbGYu
Ymx1ZXRvb3RoY3RsX3BhdGgoKSwgJ2xpc3QnIF0sIGNoZWNrPUZhbHNlLCBjYXB0dXJlX291dHB1
dD1UcnVlKQogICAgICAgIHNlbGYuYXNzZXJ0UmVnZXgoY21kLnN0ZG91dC5kZWNvZGUoJ1VURi04
JyksICcuKlxcW2RlZmF1bHRcXF0nKQoKaWYgX19uYW1lX18gPT0gJ19fbWFpbl9fJzoKICAgIHVu
aXR0ZXN0Lm1haW4oKQo=


--=-zdJAYxf5jdCn/Tm71mLI--

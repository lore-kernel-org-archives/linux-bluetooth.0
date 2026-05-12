Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981913A872A
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 20:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778618416; cv=pass; b=fjD0Q2FCfwxDms2Pbbi+xrp2qflGAm7UhiopfPavazNxkv7JiGjQEGPB7mMbzPu3NzDXOxJHbkJWHDjfRLSkWjwc9NbxiO5T+XtW4MaXx0iHNo0fklMV+DWuKfLyMVJUZ1vKPWuUxZFmtW9b4ee+791dgM+wYLNZ9/56xOsJ3ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778618416; c=relaxed/simple;
	bh=+oLGEXp23WCE1JpmU7Pjt5RIkeYbGbsiymr3a0lxpXs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BX5Ch/04MKi9SWJnK9qVDjFP4fgWwKVMNQzLgcQDuNDlAOLfLDH+m5a9i4S+oeiRSzcKJ4a+kNPDIXOGRnyRVobtJBqq4MlppqomE9jKfatkf7CWFBjcAApzClErYn8taoKoKi2eYhagOBNcZ4uySWka6d50Y1jedVv/ojjACBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=HtiwrYEb; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="HtiwrYEb"
Received: from [192.168.1.195] (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4gFT416XTDz49PxH;
	Tue, 12 May 2026 23:40:01 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1778618402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ynMXgfWpZR6lW2yLF6KPSZyv5+omv0DD0kqYVEZiUXk=;
	b=HtiwrYEbaJDKBosIZlR/g1seXmkRBdN4c3bHWcqc1xMjO7jjp5M0VORG4if3Q4CHSpir18
	KNEBeZFMwZKKYxNFrjVPP/8FeJy3HInzvRqDHLVVORAoYpWw2RJ4XnzAEVgTAKq6lpKw7k
	MFDfyIqcjHrXFryh+Dbf14J3IERNQRFBryu8bYB1gJS2TkqxkIkRIDtw7voqEeeEn4zlm9
	v7VxDfPOHzh+5s2o0s9k2dvkvzArGdawWzYqiAjiG/qFjr+yDdzhnP/j3VDzWnZlpd0umN
	gT5pmMMhAWCwXYPjQJaU97FgsJ/2KjJPBSP+6Rwur9U92gqrTYrlhWwXkQjmNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1778618402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ynMXgfWpZR6lW2yLF6KPSZyv5+omv0DD0kqYVEZiUXk=;
	b=ClM3aXjgAoNkZuCAQjmik9C3j8TITM+dq8TL4CcgDfBWfampM2/bi5O2qjqWs/xf3kjDeL
	MvAql3jf2vY50dy9c6ZpcDE3otS9AtqU+pxRG7Dg1XhwVikdU75hGi3ZApyEWFEFsQbIz3
	1NBBDxGy4jk3wIvBUCbwhSB3zXglxr/sv62IiCsGLYB9aoYEEoZoOl3ohKyt0Gfh8H/60L
	eVppUfNlPu4lc1wFhj/VaCDuImAh1zT/KWHT7vPCTyCCFDuYqFlguuAH7/81DJE24POSWZ
	jTLQtzTsEOm7HN1RMBGbezz08UL2jQZhytCwx5zdYA17w7PdC38qkwhp4uDsGQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1778618402;
	b=W5YHBz6THSSwRFgqX1AeMYDPfPgtXncXHNaNCNqhaA4m2YOiGq8fL1Lzb/HTgQ9x4hrx/Y
	iY1kDNW3uAPp1KNLTbMctyqncn6l2BGesnVb86oI2wogxz6WIW9KxTeNMwBs2yz9VJQ0Nl
	VIJ/yff5jtV5+zWV531Yqgexqg1YnlgSefy3hw9rNm3k8jNrS/J/yulnjKXfMHBkmZ/Ivz
	qsIKxfvYtt7ObRx7hJJSoxlkx8VTaIXgiviNj9cof1DH57B/gNbZao3fPbgyzdRmOJyl4S
	h8zrTmiLCn6L2ocH6GicIzmEqMyFP/7TO9CyqdmwjoC30ZmyuXX/d3RnH1kAbA==
Message-ID: <fa6f77805bd81b200a0af16287fb81c3fc16e7b2.camel@iki.fi>
Subject: Re: [BlueZ v3 0/6] Add helper for "cleanup" variable attribute
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org
Date: Tue, 12 May 2026 23:40:01 +0300
In-Reply-To: <CABBYNZ+RZH25K0jhRsrTbYOZxQQeV9EvxYK907sgGW0Ot-mR3Q@mail.gmail.com>
References: <20260511132131.1283892-1-hadess@hadess.net>
	 <177861361154.3045511.1045324340041670862.git-patchwork-notify@kernel.org>
	 <CABBYNZ+RZH25K0jhRsrTbYOZxQQeV9EvxYK907sgGW0Ot-mR3Q@mail.gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

ti, 2026-05-12 kello 15:38 -0400, Luiz Augusto von Dentz kirjoitti:
> Hi Bastien,
>=20
> On Tue, May 12, 2026 at 3:21=E2=80=AFPM <patchwork-bot+bluetooth@kernel.o=
rg> wrote:
> >=20
> > Hello:
> >=20
> > This series was applied to bluetooth/bluez.git (master)
> > by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
> >=20
> > On Mon, 11 May 2026 15:18:03 +0200 you wrote:
> > > As discussed in:
> > > https://lore.kernel.org/linux-bluetooth/ed949f2550f79a4bef19bd482bf8b=
069ad5b7e0c.camel@hadess.net/
> > >=20
> > > Implement a cleanup helper.
> > >=20
> > > The MIN/MAX fix is here because it touches the same hunk in src/main.=
c
> > > as the other patches. Feel free to pick it up straight away while the
> > > rest is discussed.
> > >=20
> > > [...]
> >=20
> > Here is the summary with links:
> >   - [BlueZ,v3,1/6] all: Remove more unneeded MIN/MAX macro definition
> >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dca2b39b0c0=
8e
> >   - [BlueZ,v3,2/6] shared/util: Add helper for "cleanup" variable attri=
bute
> >     (no matching commit)
> >   - [BlueZ,v3,3/6] doc: Recommend using _cleanup_ and friends
> >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D9ba6c13df5=
fb
> >   - [BlueZ,v3,4/6] main: Use _cleanup_() to simplify configuration pars=
ing
> >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D140e356929=
5c
> >   - [BlueZ,v3,5/6] client: Use _cleanup_fd_ to simplify urandom access
> >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3De33f5027b8=
98
> >   - [BlueZ,v3,6/6] btattach: Use _cleanup_fd_ to simplify error paths
> >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D02aa9a8cfe=
6a
> >=20
> > You are awesome, thank you!
> > --
> > Deet-doot-dot, I am a bot.
> > https://korg.docs.kernel.org/patchwork/pwbot.html
>=20
> We will probably need to revert the cleanup changes, they are causing
> crashes and other problems when run under Valgrind.
>=20
> bluetoothd[941151]: src/main.c:parse_config() parsing src/main.conf
> =3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
> =3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
> =3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.=
0.8400.4)
> =3D=3D941151=3D=3D    by 0x4003098: parse_config_hex (main.c:961)
> =3D=3D941151=3D=3D    by 0x4003098: parse_general (main.c:1058)
> =3D=3D941151=3D=3D    by 0x4003098: parse_config (main.c:1341)
> =3D=3D941151=3D=3D    by 0x4003098: main (main.c:1616)
> =3D=3D941151=3D=3D  Address 0x1fff000100 is on thread 1's stack
> =3D=3D941151=3D=3D  in frame #2, created by main (main.c:1570)
> =3D=3D941151=3D=3D
> =3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
> =3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
> =3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.=
0.8400.4)
> =3D=3D941151=3D=3D    by 0x40F17EE: parse_config_int (main.c:467)
> =3D=3D941151=3D=3D    by 0x40F1ECD: parse_config_u32.constprop.0.isra.0 (=
main.c:848)
> =3D=3D941151=3D=3D    by 0x40030BD: parse_general (bluetooth.c:4925)
> =3D=3D941151=3D=3D    by 0x40030BD: parse_config (main.c:1341)
> =3D=3D941151=3D=3D    by 0x40030BD: main (main.c:1616)
> =3D=3D941151=3D=3D  Address 0x1fff000050 is on thread 1's stack
> =3D=3D941151=3D=3D  in frame #2, created by parse_config_int (main.c:465)
> =3D=3D941151=3D=3D
> =3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
> =3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
> =3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.=
0.8400.4)
> =3D=3D941151=3D=3D    by 0x4004C89: parse_device_id (main.c:974)
> =3D=3D941151=3D=3D    by 0x4004C89: parse_general (main.c:1067)
> =3D=3D941151=3D=3D    by 0x4004C89: parse_config (main.c:1341)
> =3D=3D941151=3D=3D    by 0x4004C89: main (main.c:1616)
> =3D=3D941151=3D=3D  Address 0x1fff000100 is on thread 1's stack
> =3D=3D941151=3D=3D  in frame #2, created by main (main.c:1570)
> =3D=3D941151=3D=3D
> bluetoothd[941151]: src/main.c:parse_config_string() General.ControllerMo=
de =3D le
> bluetoothd[941151]: GLib: g_error_free: assertion 'error !=3D NULL' faile=
d
> bluetoothd[941151]: ++++++++ backtrace ++++++++
> bluetoothd[941151]: #1  log_handler+0x4e (src/main.c:1418) [0x40f0ffe]
> bluetoothd[941151]: #2  g_logv+0x247
> (/usr/lib64/libglib-2.0.so.0.8400.4) [0x4cc5477]
> bluetoothd[941151]: #3  g_log+0x93
> (/usr/lib64/libglib-2.0.so.0.8400.4) [0x4cc5803]
> bluetoothd[941151]: #4  parse_config_string+0x60 (src/main.c:208) [0x40f1=
400]
> bluetoothd[941151]: #5  main+0x4a2 (src/main.c:988) [0x4003262]
> bluetoothd[941151]: #6  __libc_start_call_main+0x75
> (/usr/lib64/libc.so.6) [0x4f90575]
> bluetoothd[941151]: #7  __libc_start_main@@GLIBC_2.34+0x88
> (/usr/lib64/libc.so.6) [0x4f90628]
> bluetoothd[941151]: #8  _start+0x25
> (/home/vudentz/git/bluez/src/bluetoothd) [0x40054c5]
> bluetoothd[941151]: +++++++++++++++++++++++++++
> =3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
> =3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
> =3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.=
0.8400.4)
> =3D=3D941151=3D=3D    by 0x4003311: parse_ctrl_mode (bluetooth.c:5033)
> =3D=3D941151=3D=3D    by 0x4003311: parse_general (main.c:1074)
> =3D=3D941151=3D=3D    by 0x4003311: parse_config (main.c:1341)
> =3D=3D941151=3D=3D    by 0x4003311: main (main.c:1616)
> =3D=3D941151=3D=3D  Address 0x1fff000100 is on thread 1's stack
> =3D=3D941151=3D=3D  in frame #2, created by main (bluetooth.c:1570)
> =3D=3D941151=3D=3D
> =3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
> =3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
> =3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.=
0.8400.4)
> =3D=3D941151=3D=3D    by 0x40F17EE: parse_config_int (main.c:467)
> =3D=3D941151=3D=3D    by 0x40F20C2: parse_config_u16.isra.0 (main.c:863)
> =3D=3D941151=3D=3D    by 0x4003349: parse_general (bluetooth.c:2985)
> =3D=3D941151=3D=3D    by 0x4003349: parse_config (main.c:1341)
> =3D=3D941151=3D=3D    by 0x4003349: main (main.c:1616)
> =3D=3D941151=3D=3D  Address 0x1fff000050 is on thread 1's stack
> =3D=3D941151=3D=3D  in frame #2, created by parse_config_int (main.c:465)
> =3D=3D941151=3D=3D
> =3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
> =3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
> =3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.=
0.8400.4)
> =3D=3D941151=3D=3D    by 0x4004F55: parse_multi_profile (main.c:996)
> =3D=3D941151=3D=3D    by 0x4004F55: parse_general (main.c:1078)
> =3D=3D941151=3D=3D    by 0x4004F55: parse_config (main.c:1341)
> =3D=3D941151=3D=3D    by 0x4004F55: main (main.c:1616)
> =3D=3D941151=3D=3D  Address 0x1fff000100 is on thread 1's stack
> =3D=3D941151=3D=3D  in frame #2, created by main (main.c:1570)
> =3D=3D941151=3D=3D
> =3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
> =3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
> =3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.=
0.8400.4)
> =3D=3D941151=3D=3D    by 0x40F15D4: parse_privacy (main.c:910)
> =3D=3D941151=3D=3D    by 0x40033F9: parse_general (main.c:1081)
> =3D=3D941151=3D=3D    by 0x40033F9: parse_config (main.c:1341)
> =3D=3D941151=3D=3D    by 0x40033F9: main (main.c:1616)
> =3D=3D941151=3D=3D  Address 0x1fff000098 is on thread 1's stack
> =3D=3D941151=3D=3D  in frame #2, created by parse_privacy (main.c:909)
> =3D=3D941151=3D=3D
> =3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
> =3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
> =3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.=
0.8400.4)
> =3D=3D941151=3D=3D    by 0x40047B5: parse_repairing (main.c:947)
> =3D=3D941151=3D=3D    by 0x40047B5: parse_general (main.c:1082)
> =3D=3D941151=3D=3D    by 0x40047B5: parse_config (main.c:1341)
> =3D=3D941151=3D=3D    by 0x40047B5: main (main.c:1616)
> =3D=3D941151=3D=3D  Address 0x1fff000100 is on thread 1's stack
> =3D=3D941151=3D=3D  in frame #2, created by main (main.c:1570)
> =3D=3D941151=3D=3D
> =3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
> =3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
> =3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.=
0.8400.4)
> =3D=3D941151=3D=3D    by 0x40049FF: parse_secure_conns (bluetooth.c:1597)
> =3D=3D941151=3D=3D    by 0x40049FF: parse_general (main.c:1088)
> =3D=3D941151=3D=3D    by 0x40049FF: parse_config (main.c:1341)
> =3D=3D941151=3D=3D    by 0x40049FF: main (main.c:1616)
> =3D=3D941151=3D=3D  Address 0x1fff000100 is on thread 1's stack
> =3D=3D941151=3D=3D  in frame #2, created by main (bluetooth.c:1570)
> =3D=3D941151=3D=3D
> bluetoothd[941151]: src/main.c:parse_config_bool() General.Experimental =
=3D true
> bluetoothd[941151]: GLib: g_error_free: assertion 'error !=3D NULL' faile=
d
> bluetoothd[941151]: ++++++++ backtrace ++++++++
> bluetoothd[941151]: #1  log_handler+0x4e (src/main.c:1418) [0x40f0ffe]
> bluetoothd[941151]: #2  g_logv+0x247
> (/usr/lib64/libglib-2.0.so.0.8400.4) [0x4cc5477]
> bluetoothd[941151]: #3  g_log+0x93
> (/usr/lib64/libglib-2.0.so.0.8400.4) [0x4cc5803]
> bluetoothd[941151]: #4  parse_config_bool.isra.0+0x64 (src/main.c:208)
> [0x40f1f64]
> bluetoothd[941151]: #5  main+0x7c0 (src/main.c:1089) [0x4003580]
> bluetoothd[941151]: #6  __libc_start_call_main+0x75
> (/usr/lib64/libc.so.6) [0x4f90575]
> bluetoothd[941151]: #7  __libc_start_main@@GLIBC_2.34+0x88
> (/usr/lib64/libc.so.6) [0x4f90628]
> bluetoothd[941151]: #8  _start+0x25
> (/home/vudentz/git/bluez/src/bluetoothd) [0x40054c5]
> bluetoothd[941151]: +++++++++++++++++++++++++++
> bluetoothd[941151]: src/main.c:parse_config_string()
> General.KernelExperimental =3D 6fbaf188-05e0-496a-9885-d6ddfdb4e03e
> bluetoothd[941151]: GLib: g_error_free: assertion 'error !=3D NULL' faile=
d
> bluetoothd[941151]: ++++++++ backtrace ++++++++
> bluetoothd[941151]: #1  log_handler+0x4e (src/main.c:1418) [0x40f0ffe]
> bluetoothd[941151]: #2  g_logv+0x247
> (/usr/lib64/libglib-2.0.so.0.8400.4) [0x4cc5477]
> bluetoothd[941151]: #3  g_log+0x93
> (/usr/lib64/libglib-2.0.so.0.8400.4) [0x4cc5803]
> bluetoothd[941151]: #4  parse_config_string+0x60 (src/main.c:208) [0x40f1=
400]
> bluetoothd[941151]: #5  main+0x816 (src/main.c:1032) [0x40035d6]
> bluetoothd[941151]: #6  __libc_start_call_main+0x75
> (/usr/lib64/libc.so.6) [0x4f90575]
> bluetoothd[941151]: #7  __libc_start_main@@GLIBC_2.34+0x88
> (/usr/lib64/libc.so.6) [0x4f90628]
> bluetoothd[941151]: #8  _start+0x25
> (/home/vudentz/git/bluez/src/bluetoothd) [0x40054c5]
> bluetoothd[941151]: +++++++++++++++++++++++++++
> bluetoothd[941151]: src/main.c:btd_parse_kernel_experimental()
> 6fbaf188-05e0-496a-9885-d6ddfdb4e03e
> =3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
> =3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
> =3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.=
0.8400.4)
> =3D=3D941151=3D=3D    by 0x4003607: parse_kernel_exp (main.c:1030)
> =3D=3D941151=3D=3D    by 0x4003607: parse_general (main.c:1093)
> =3D=3D941151=3D=3D    by 0x4003607: parse_config (main.c:1341)
> =3D=3D941151=3D=3D    by 0x4003607: main (main.c:1616)
> =3D=3D941151=3D=3D  Address 0x1fff000100 is on thread 1's stack
> =3D=3D941151=3D=3D  in frame #2, created by main (main.c:1570)
> =3D=3D941151=3D=3D
> =3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
> =3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
> =3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.=
0.8400.4)
> =3D=3D941151=3D=3D    by 0x40F17EE: parse_config_int (main.c:467)
> =3D=3D941151=3D=3D    by 0x40F19B8: parse_mode_config (main.c:552)
> =3D=3D941151=3D=3D    by 0x40036D5: parse_le_config (bluetooth.c:2879)
> =3D=3D941151=3D=3D    by 0x40036D5: parse_config (main.c:1343)
> =3D=3D941151=3D=3D    by 0x40036D5: main (main.c:1616)
> =3D=3D941151=3D=3D  Address 0x1fff000020 is on thread 1's stack
> =3D=3D941151=3D=3D  in frame #2, created by parse_config_int (main.c:465)
> =3D=3D941151=3D=3D
> =3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
> =3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
> =3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.=
0.8400.4)
> =3D=3D941151=3D=3D    by 0x4004C4B: parse_gatt_cache (main.c:1103)
> =3D=3D941151=3D=3D    by 0x4004C4B: parse_gatt (main.c:1171)
> =3D=3D941151=3D=3D    by 0x4004C4B: parse_config (main.c:1344)
> =3D=3D941151=3D=3D    by 0x4004C4B: main (main.c:1616)
> =3D=3D941151=3D=3D  Address 0x1fff000100 is on thread 1's stack
> =3D=3D941151=3D=3D  in frame #2, created by main (main.c:1570)
> =3D=3D941151=3D=3D
> =3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
> =3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
> =3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.=
0.8400.4)
> =3D=3D941151=3D=3D    by 0x40F17EE: parse_config_int (main.c:467)
> =3D=3D941151=3D=3D    by 0x40F2072: parse_config_u8.isra.0 (main.c:878)
> =3D=3D941151=3D=3D    by 0x40037E5: parse_gatt (bluetooth.c:2847)
> =3D=3D941151=3D=3D    by 0x40037E5: parse_config (main.c:1344)
> =3D=3D941151=3D=3D    by 0x40037E5: main (main.c:1616)
> =3D=3D941151=3D=3D  Address 0x1fff000050 is on thread 1's stack
> =3D=3D941151=3D=3D  in frame #2, created by parse_config_int (main.c:465)
> =3D=3D941151=3D=3D
> bluetoothd[941151]: src/main.c:parse_config_string()
> GATT.ExportClaimedServices =3D read-write
> bluetoothd[941151]: GLib: g_error_free: assertion 'error !=3D NULL' faile=
d
> bluetoothd[941151]: ++++++++ backtrace ++++++++
> bluetoothd[941151]: #1  log_handler+0x4e (src/main.c:1418) [0x40f0ffe]
> bluetoothd[941151]: #2  g_logv+0x247
> (/usr/lib64/libglib-2.0.so.0.8400.4) [0x4cc5477]
> bluetoothd[941151]: #3  g_log+0x93
> (/usr/lib64/libglib-2.0.so.0.8400.4) [0x4cc5803]
> bluetoothd[941151]: #4  parse_config_string+0x60 (src/main.c:208) [0x40f1=
400]
> bluetoothd[941151]: #5  main+0xae3 (src/main.c:1132) [0x40038a3]
> bluetoothd[941151]: #6  __libc_start_call_main+0x75
> (/usr/lib64/libc.so.6) [0x4f90575]
> bluetoothd[941151]: #7  __libc_start_main@@GLIBC_2.34+0x88
> (/usr/lib64/libc.so.6) [0x4f90628]
> bluetoothd[941151]: #8  _start+0x25
> (/home/vudentz/git/bluez/src/bluetoothd) [0x40054c5]
> bluetoothd[941151]: +++++++++++++++++++++++++++
> =3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
> =3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
> =3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.=
0.8400.4)
> =3D=3D941151=3D=3D    by 0x400395E: parse_gatt_export (main.c:1129)
> =3D=3D941151=3D=3D    by 0x400395E: parse_gatt (main.c:1178)
> =3D=3D941151=3D=3D    by 0x400395E: parse_config (main.c:1344)
> =3D=3D941151=3D=3D    by 0x400395E: main (main.c:1616)
> =3D=3D941151=3D=3D  Address 0x1fff000100 is on thread 1's stack
> =3D=3D941151=3D=3D  in frame #2, created by main (main.c:1570)
> =3D=3D941151=3D=3D
> =3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
> =3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
> =3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.=
0.8400.4)
> =3D=3D941151=3D=3D    by 0x40040AD: parse_gatt_seclevel (main.c:1157)
> =3D=3D941151=3D=3D    by 0x40040AD: parse_gatt (main.c:1179)
> =3D=3D941151=3D=3D    by 0x40040AD: parse_config (main.c:1344)
> =3D=3D941151=3D=3D    by 0x40040AD: main (main.c:1616)
> =3D=3D941151=3D=3D  Address 0x1fff000100 is on thread 1's stack
> =3D=3D941151=3D=3D  in frame #2, created by main (main.c:1570)
> =3D=3D941151=3D=3D
> =3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
> =3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
> =3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.=
0.8400.4)
> =3D=3D941151=3D=3D    by 0x4004A1E: parse_csis_sirk (bluetooth.c:1593)
> =3D=3D941151=3D=3D    by 0x4004A1E: parse_csis (main.c:1197)
> =3D=3D941151=3D=3D    by 0x4004A1E: parse_config (main.c:1345)
> =3D=3D941151=3D=3D    by 0x4004A1E: main (main.c:1616)
> =3D=3D941151=3D=3D  Address 0x1fff000100 is on thread 1's stack
> =3D=3D941151=3D=3D  in frame #2, created by main (bluetooth.c:1570)
> =3D=3D941151=3D=3D
> =3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
> =3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
> =3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.=
0.8400.4)
> =3D=3D941151=3D=3D    by 0x4004A3D: parse_avdtp_session_mode (main.c:1276=
)
> =3D=3D941151=3D=3D    by 0x4004A3D: parse_avdtp (main.c:1310)
> =3D=3D941151=3D=3D    by 0x4004A3D: parse_config (main.c:1346)
> =3D=3D941151=3D=3D    by 0x4004A3D: main (main.c:1616)
> =3D=3D941151=3D=3D  Address 0x1fff000100 is on thread 1's stack
> =3D=3D941151=3D=3D  in frame #2, created by main (main.c:1570)
> =3D=3D941151=3D=3D
> =3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
> =3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
> =3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.=
0.8400.4)
> =3D=3D941151=3D=3D    by 0x4004A5C: parse_avdtp_stream_mode (main.c:1293)
> =3D=3D941151=3D=3D    by 0x4004A5C: parse_avdtp (main.c:1311)
> =3D=3D941151=3D=3D    by 0x4004A5C: parse_config (main.c:1346)
> =3D=3D941151=3D=3D    by 0x4004A5C: main (main.c:1616)
> =3D=3D941151=3D=3D  Address 0x1fff000100 is on thread 1's stack
> =3D=3D941151=3D=3D  in frame #2, created by main (main.c:1570)
> =3D=3D941151=3D=3D
> =3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
> =3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
> =3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.=
0.8400.4)
> =3D=3D941151=3D=3D    by 0x4004417: parse_cs_role (bluetooth.c:943)
> =3D=3D941151=3D=3D    by 0x4004417: parse_le_cs_config (main.c:1264)
> =3D=3D941151=3D=3D    by 0x4004417: parse_config (main.c:1348)
> =3D=3D941151=3D=3D    by 0x4004417: main (main.c:1616)
> =3D=3D941151=3D=3D  Address 0x1fff0000f8 is on thread 1's stack
> =3D=3D941151=3D=3D  in frame #2, created by main (bluetooth.c:1570)
> =3D=3D941151=3D=3D
> =3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
> =3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
> =3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.=
0.8400.4)
> =3D=3D941151=3D=3D    by 0x40044FB: parse_config_signed_int (main.c:501)
> =3D=3D941151=3D=3D    by 0x40044FB: parse_le_cs_config (main.c:1269)
> =3D=3D941151=3D=3D    by 0x40044FB: parse_config (main.c:1348)
> =3D=3D941151=3D=3D    by 0x40044FB: main (main.c:1616)
> =3D=3D941151=3D=3D  Address 0x1fff0000f8 is on thread 1's stack
> =3D=3D941151=3D=3D  in frame #2, created by main (main.c:1570)
> =3D=3D941151=3D=3D

I think it needed something like the below.

I think it would be better to have _steal_() and _steal_fd_() be macros
so that compiler can check the types so you can't mistake
_steal_(keyfile) and _steal_(&keyfile)

https://gitlab.freedesktop.org/pipewire/pipewire/-/blob/master/spa/include/=
spa/utils/cleanup.h

Not sure what can be done about the _cleanup_(g_free) char *str --- it
would be great if this generated compiler warning/error but it looks
like it didn't, so maybe this macro should be private so you're forced
to declare the CLEANUP_FREEFUNC always.


diff --git a/src/main.c b/src/main.c
index 9053e74aa..9d1074c11 100644
--- a/src/main.c
+++ b/src/main.c
@@ -205,8 +205,20 @@ static const struct group_table {
 	{ }
 };
=20
-CLEANUP_FREEFUNC(GError, g_error_free);
-CLEANUP_FREEFUNC(GKeyFile, g_key_file_free);
+static void cleanup_g_error(GError *err)
+{
+	if (err)
+		g_error_free(err);
+}
+
+static void cleanup_g_key_file(GKeyFile *keyfile)
+{
+	if (keyfile)
+		g_key_file_free(keyfile);
+}
+
+CLEANUP_FREEFUNC(GError, cleanup_g_error);
+CLEANUP_FREEFUNC(GKeyFile, cleanup_g_key_file);
=20
 static int8_t check_sirk_alpha_numeric(char *str)
 {
@@ -291,7 +303,7 @@ static GKeyFile *load_config(const char *name)
 		return NULL;
 	}
=20
-	return _steal_(keyfile);
+	return _steal_(&keyfile);
 }
=20
 static void parse_did(const char *did)
@@ -457,12 +469,19 @@ static bool parse_config_string(GKeyFile *config,
const char *group,
 	return true;
 }
=20
+static inline void cleanup_g_free(void *p)
+{
+	g_free(*(void **) p);
+}
+
+#define _cleanup_g_free_ _cleanup_(cleanup_g_free)
+
 static bool parse_config_int(GKeyFile *config, const char *group,
 					const char *key, int *val,
 					size_t min, size_t max)
 {
 	size_t tmp;
-	_cleanup_(g_free) char *str =3D NULL;
+	_cleanup_g_free_ char *str =3D NULL;
 	char *endptr =3D NULL;
=20
 	if (!parse_config_string(config, group, key, &str))

and so on for the rest of _cleanup_(g_free)

--=20
Pauli Virtanen

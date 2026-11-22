Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.185.170.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795364686;
	b=VzhZCq64lYEVEHw0rX2CmnM/9kdTideneRwMVS/XdqYzEpfWziHdW2kwFb8MOcdoau89
	 2/j+WN8WmqfbkFY39nABfyJ/95sjmHJVMN1RkPIBC95Z8mjC2QqXOqNQekPubEpoAjXq1
	 UmWGyxgb6PJNxzrI12F4C2tNlqSVlnBVV1uNTtS7gF4JlIuH7tAldR2O1MkVM4vMh1wXQ
	 JWv0hUfNdxFPAnvRiPywI9b7jZqZNLkmcNzocPz1uhULue4vuYDzCx4eBgc8Azol1FEZ2
	 pxOMcTTyMmtg04t/FAJYH6DcBRbJIHRaEoudDeqHqqxCcWZ2eb499CycwLo8C8VeQxQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795364686;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Date:
	 In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=0Jsh7FXCCxD+vFhLt2+/gOVPW24GVJ7ZqsfCSy1Mdz8=;
	b=sSstyBS+4azI9+6/G2vcDzlYF7xGgt6hSSusxtzuCbPhcWCwMV4kd1T9iZ7EgWCh6L+G
	 4TIXdOeM/JOE4bsLen+zNAWKPqmUGfX8DZEfBA9eybXZioRQW/Pz9ZyngnBQycM42Tnrl
	 IVkgYR3MRcwfx4g9s0izUWVgllgfhddiQVuM8NXPpW/EEbKXx167xeliE5o6tNipFqEO8
	 lt2KgyRO4LGutEiwwCDe5RwtUanR87VDpm8GWCHQjCbLpSEKOx3ulxx1J+sEl92HNHFkk
	 LkoqrcDpg/9sr9mOXEOMmBnsgCtrDOsve1pWse5RC9VH1g/Bq4gRYZd2aA0WWMrbGyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iki.fi;
	spf=pass smtp.mailfrom=iki.fi;
	dkim=pass header.d=iki.fi header.i=@iki.fi header.a=rsa-sha256 header.s=lahtoruutu header.b=B+ICLAUI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.185.170.37
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E4F606A320
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 16:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8E4F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iki.fi header.i=@iki.fi header.a=rsa-sha256 header.s=lahtoruutu header.b=B+ICLAUI
Received: from [192.168.1.195] (unknown [IPv6:2a02:6ea0:1508:7::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4jXZCm5qhDz49Psm
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 18:24:36 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1795364677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0Jsh7FXCCxD+vFhLt2+/gOVPW24GVJ7ZqsfCSy1Mdz8=;
	b=B+ICLAUIMnHMJWLsUD9t6DKhZJYC9ai5MaaOi1dsICgWiNykTjrmtQKHRanxTp/I+AOwFc
	15yv2gb0LN1+eRFJgTrSy5h105d+HUAEDyr3WJIA3ivzrPQ6CbWe6u13lXPBsCwTMVdqGY
	eQLTv9dOPhl9p9FZMG/Vgd18+CnchKMqvOnQC95GvC/szCsdH9yY1zr7f6Vu40WX0GFqwV
	hOS4Ym5mmMH/E1pTi/vWGObfMLMqTf38z3EXeWhZqdji+f3iQTUNi3L/p5fhd6ndfQ8SNo
	PgpR7YzhAG2FB4UTcXPLbkzeJgJyV0JTYNbI6tBGQrGimLkgx6XD69mfzI69CQ==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1795364677;
	b=P7jo0A6ve3oHYoDXmjtc4zJtGNGngfistGWuu5kaqZOxQMBJLpV0p5F8eth9hX8YYPYCDK
	PmRXte/ruvNz3g6fUM2pY1qrmvsLGZRcZEzDVKGOAcBjXN4kq6dx/iydleZsEoB0kPTQQV
	XXKp1e3RYRR+fdS+F8he4TQ9MsacL75t+L7jL/v9C6HVv3ZPrIkm3kwRbEuDIiAv6gyTZT
	lu95rUc5py+TBhoims3b38GOoAg2S/5bCZ5QGIBENZfGzn3FEkgRnkkBrgBpPASn1aJoFO
	GZKKolZUaFHOgfgO/IaSbpg1sST9WYi342qebie3NWKz6etG5rs3TS5VljpBog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1795364676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0Jsh7FXCCxD+vFhLt2+/gOVPW24GVJ7ZqsfCSy1Mdz8=;
	b=Uv4CH3YnNdiwX0EW5m5pPOuH23gisHTg43sgU5aY5wEfCSA13ZuWXZgJQRs3Wdx5c1Oxzj
	FY0WWSZvwD6+WvUfQWO9Cbxij//iEGcorB6+bBSBAgS0pbDyIlDezeYnPHCcT562ruByqC
	nu237YWf8Q54+8BGTT31mf2mc6vLdHvt2ivzMJMf4IcrqEQGtLzaXie/Lx8ZEgMNR7eIsp
	Ij7BbJvSKoNvWbBB499reGnIiBwCYKlHLL0ojFK66at/5+oVWYLNsqB2FM8YagTy7aDv8B
	VTnAThq9bKd5VZj5CxTL22TtJn1ohv8tc1mjLF/T3RdTuEFopC+BmCS3tCeqfw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <edb6288e11cf9eab058cada5151c0c071587eb3e.camel@iki.fi>
Subject: Re: [PATCH bluez 2/3] tools/test-runner: Support running on arm64
 hosts
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Date: Sun, 22 Nov 2026 18:24:35 +0200
In-Reply-To: <20261122-tr_arm64-v1-2-4eccf35daeca@oss.qualcomm.com>
References: <20261122-tr_arm64-v1-0-4eccf35daeca@oss.qualcomm.com>
	 <20261122-tr_arm64-v1-2-4eccf35daeca@oss.qualcomm.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=mQINBGX+qmEBEACt7O4iYRbX80B2OV+LbX06Mj1Wd67SVWwq2sAlI+6fK1YWbFu5jOWFy
 ShFCRGmwyzNvkVpK7cu/XOOhwt2URcy6DY3zhmd5gChz/t/NDHGBTezCh8rSO9DsIl1w9nNEbghUl
 cYmEvIhQjHH3vv2HCOKxSZES/6NXkskByXtkPVP8prHPNl1FHIO0JVVL7/psmWFP/eeB66eAcwIgd
 aUeWsA9+/AwcjqJV2pa1kblWjfZZw4TxrBgCB72dC7FAYs94ebUmNg3dyv8PQq63EnC8TAUTyph+M
 cnQiCPz6chp7XHVQdeaxSfcCEsOJaHlS+CtdUHiGYxN4mewPm5JwM1C7PW6QBPIpx6XFvtvMfG+Ny
 +AZ/jZtXxHmrGEJ5sz5YfqucDV8bMcNgnbFzFWxvVklafpP80O/4VkEZ8Og09kvDBdB6MAhr71b3O
 n+dE0S83rEiJs4v64/CG8FQ8B9K2p9HE55Iu3AyovR6jKajAi/iMKR/x4KoSq9Jgj9ZI3g86voWxM
 4735WC8h7vnhFSA8qKRhsbvlNlMplPjq0f9kVLg9cyNzRQBVrNcH6zGMhkMqbSvCTR5I1kY4SfU4f
 QqRF1Ai5f9Q9D8ExKb6fy7ct8aDUZ69Ms9N+XmqEL8C3+AAYod1XaXk9/hdTQ1Dhb51VPXAMWTICB
 dXi5z7be6KALQARAQABtCZQYXVsaSBWaXJ0YW5lbiA8cGF1bGkudmlydGFuZW5AaWtpLmZpPokCWg
 QTAQgARAIbAwUJEswDAAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBGrOSfUCZNEJOswAnOS
 aCbhLOrBPBQJl/qsDAhkBAAoJEOSaCbhLOrBPB/oP/1j6A7hlzheRhqcj+6sk+OgZZ+5eX7mBomyr
 76G+m/3RhPGlKbDxKTWtBZaIDKg2c0Q6yC1TegtxQ2EUD4kk7wKoHKj8dKbR29uS3OvURQR1guCo2
 /5kzQQVxQwhIoMdHJYF0aYNQgdA+ZJL09lDz+JC89xvup3spxbKYc9Iq6vxVLbVbjF9Uv/ncAC4Bs
 g1MQoMowhKsxwN5VlUdjqPZ6uGebZyC+gX6YWUHpPWcHQ1TxCD8TtqTbFU3Ltd3AYl7d8ygMNBEe3
 T7DV2GjBI06Xqdhydhz2G5bWPM0JSodNDE/m6MrmoKSEG0xTNkH2w3TWWD4o1snte9406az0YOwkk
 xDq9LxEVoeg6POceQG9UdcsKiiAJQXu/I0iUprkybRUkUj+3oTJQECcdfL1QtkuJBh+IParSF14/j
 Xojwnf7tE5rm7QvMWWSiSRewro1vaXjgGyhKNyJ+HCCgp5mw+ch7KaDHtg0fG48yJgKNpjkzGWfLQ
 BNXqtd8VYn1mCM3YM7qdtf9bsgjQqpvFiAh7jYGrhYr7geRjary1hTc8WwrxAxaxGvo4xZ1XYps3u
 ayy5dGHdiddk5KJ4iMTLSLH3Rucl19966COQeCwDvFMjkNZx5ExHshWCV5W7+xX/2nIkKUfwXRKfK
 dsVTL03FG0YvY/8A98EMbvlf4TnpyyaytBtQYXVsaSBWaXJ0YW5lbiA8cGF2QGlraS5maT6JAlcEE
 wEIAEEWIQRqzkn1AmTRCTrMAJzkmgm4SzqwTwUCZf6qYQIbAwUJEswDAAULCQgHAgIiAgYVCgkICw
 IEFgIDAQIeBwIXgAAKCRDkmgm4SzqwTxYZD/9hfC+CaihOESMcTKHoK9JLkO34YC0t8u3JAyetIz3
 Z9ek42FU8fpf58vbpKUIR6POdiANmKLjeBlT0D3mHW2ta90O1s711NlA1yaaoUw7s4RJb09W2Votb
 G02pDu2qhupD1GNpufArm3mOcYDJt0Rhh9DkTR2WQ9SzfnfzapjxmRQtMzkrH0GWX5OPv368IzfbJ
 S1fw79TXmRx/DqyHg+7/bvqeA3ZFCnuC/HQST72ncuQA9wFbrg3ZVOPAjqrjesEOFFL4RSaT0JasS
 XdcxCbAu9WNrHbtRZu2jo7n4UkQ7F133zKH4B0SD5IclLgK6Zc92gnHylGEPtOFpij/zCRdZw20VH
 xrPO4eI5Za4iRpnKhCbL85zHE0f8pDaBLD9L56UuTVdRvB6cKncL4T6JmTR6wbH+J+s4L3OLjsyx2
 LfEcVEh+xFsW87YQgVY7Mm1q+O94P2soUqjU3KslSxgbX5BghY2yDcDMNlfnZ3SdeRNbssgT28PAk
 5q9AmX/5YyNbexOCyYKZ9TLcAJJ1QLrHGoZaAIaR72K/kmVxy0oqdtAkvCQw4j2DCQDR0lQXsH2bl
 WTSfNIdSZd4pMxXHFF5iQbh+uReDc8rISNOFMAZcIMd+9jRNCbyGcoFiLa52yNGOLo7Im+CIlmZEt
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 (3.62.1-1.fc45) 
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi,

su, 2026-11-22 kello 02:34 -0800, Zijun Hu kirjoitti:
> Add arm64 support by:
> - Using qemu-system-aarch64 with the virt machine and the arm64 Image
> - Passing -cpu max or host, as the default virt CPU is 32-bit
> - Using earlycon and leaving out the x86-only options
> - Warning when /dev/kvm is not accessible, as QEMU then falls back
>   to TCG

Should it actually determine whether to run qemu x86 vs aarch based on
what the kernel image is, and not the host system this is compiled for?

> Assisted-by: Claude:claude-opus-5-5
> ---
>  doc/test-runner.rst |  5 ++++-
>  tools/test-runner.c | 49 ++++++++++++++++++++++++++++++++++++++++++-----=
--
>  2 files changed, 46 insertions(+), 8 deletions(-)
>=20
> diff --git a/doc/test-runner.rst b/doc/test-runner.rst
> index b5876e4f5108..4ff9d1b02c1b 100644
> --- a/doc/test-runner.rst
> +++ b/doc/test-runner.rst
> @@ -21,17 +21,20 @@ OPTIONS
>  :-m/--monitor: Start btmon
>  :-l/--emulator[=3Dnum]: Start btvirt
>  :-A/-audio[=3Dpath]: Start audio server
>  :-u/--unix[=3Dpath]: Provide serial device
>  :-U/--usb=3D<qemu_args>: Provide USB device
>  :-P/--pcie=3D<qemu_args>: Provide PCIe device
>  :-q/--qemu=3D<path>: QEMU binary
>  :-H/--qemu-host-cpu: Use host CPU (requires KVM support)
> -:-k/--kernel=3D<image>: Kernel image (bzImage) or User Mode Linux binary
> +:-k/--kernel=3D<image>: Kernel image or source tree path:
> +
> +    | x86: bzImage or User Mode Linux binary
> +    | arm64: Image
>  :-F/--virtiofs[=3D<path>]: Path to virtiofsd, or no to disable virtio-fs
>  :-T/--time-travel: Run a User Mode Linux kernel on simulated time, with
>      btvirt as time travel calendar (default if the kernel supports it)
>  :-R/--real-time: Run a User Mode Linux kernel on real time
>  :-o/--option=3D<opt>: Additional argument passed to QEMU, or kernel
>      parameter with User Mode Linux
>  :-h/--help: Show help options
> =20
> diff --git a/tools/test-runner.c b/tools/test-runner.c
> index 0bca31a46351..a2105977c1ee 100644
> --- a/tools/test-runner.c
> +++ b/tools/test-runner.c
> @@ -128,20 +128,25 @@ static void strv_cleanup(struct strv *s)
> =20
>  =09for (i =3D 0; i < s->i; ++i)
>  =09=09free(s->strv[i]);
> =20
>  =09memset(s, 0, sizeof(*s));
>  }
> =20
>  static const char *qemu_table[] =3D {
> +#if defined(__aarch64__)
> +=09"qemu-system-aarch64",
> +=09"/usr/bin/qemu-system-aarch64",
> +#else
>  =09"qemu-system-x86_64",
>  =09"qemu-system-i386",
>  =09"/usr/bin/qemu-system-x86_64",
>  =09"/usr/bin/qemu-system-i386",
> +#endif
>  =09NULL
>  };
> =20
>  static const char *find_qemu(void)
>  {
>  =09int i;
> =20
>  =09for (i =3D 0; qemu_table[i]; i++) {
> @@ -150,21 +155,26 @@ static const char *find_qemu(void)
>  =09=09if (!stat(qemu_table[i], &st))
>  =09=09=09return qemu_table[i];
>  =09}
> =20
>  =09return NULL;
>  }
> =20
>  static const char *kernel_table[] =3D {
> +#if defined(__aarch64__)
> +=09"Image",
> +=09"arch/arm64/boot/Image",
> +#else
>  =09"bzImage",
>  =09"arch/x86/boot/bzImage",
>  =09"vmlinux",
>  =09"arch/x86/boot/vmlinux",
>  =09"linux",
> +#endif
>  =09NULL
>  };
> =20
>  /* A User Mode Linux kernel is an executable with the .uml.setup.init
>   * section, through which it registers its command line options.
>   */
>  static bool is_uml_kernel(const char *path)
>  {
> @@ -420,16 +430,19 @@ static char *const qemu_envp[] =3D {
> =20
>  static void check_virtualization(void)
>  {
>  #ifdef HAVE_GET_CPUID
>  =09unsigned int eax, ebx, ecx, edx;
> =20
>  =09if (__get_cpuid(1, &eax, &ebx, &ecx, &edx) && (ecx & (1 << 5)))
>  =09=09printf("Found support for Virtual Machine eXtensions\n");
> +#elif defined(__aarch64__)
> +=09if (access("/dev/kvm", R_OK | W_OK) < 0)
> +=09=09fprintf(stderr, "No access to /dev/kvm, falling back to TCG\n");
>  #endif
>  }
> =20
>  #define PCI_DEVICES_PATH "/sys/bus/pci/devices"
> =20
>  static char pcie_bdf[16];
>  static char pcie_driver[64];
> =20
> @@ -894,16 +907,18 @@ static void qemu_signal(int sig)
>  =09if (qemu_pid > 0)
>  =09=09kill(qemu_pid, sig);
>  }
> =20
>  static int start_qemu(void)
>  {
>  =09char cwd[PATH_MAX/2], initcmd[PATH_MAX], testargs[PATH_MAX];
>  =09const char *fscmdline;
> +=09const char *earlycon;
> +=09const char *noacpi;
>  =09char cmdline[CMDLINE_MAX];
>  =09char *argv_strv[EXTRA_OPT_MAX + 64];
>  =09struct strv _cleanup_(strv_cleanup) argv =3D { argv_strv,
>  =09=09=09=09=09=09=09ARRAY_SIZE(argv_strv) };
>  =09struct rootfs _cleanup_(rootfs_cleanup) rootfs =3D {{0}};
>  =09int i, pos, status =3D 0;
>  =09pid_t pid;
> =20
> @@ -933,54 +948,71 @@ static int start_qemu(void)
>  =09}
> =20
>  =09if (!virtiofsd)
>  =09=09fscmdline =3D "rootfstype=3D9p "
>  =09=09=09=09"rootflags=3Dtrans=3Dvirtio,version=3D9p2000.u";
>  =09else
>  =09=09fscmdline =3D "rootfstype=3Dvirtiofs root=3D/dev/root";
> =20
> +#if defined(__aarch64__)
> +=09earlycon =3D "earlycon";
> +=09noacpi =3D "";
> +#else
> +=09earlycon =3D "earlyprintk=3Dserial";
> +=09/* PCIe passthrough requires ACPI and APIC for device enumeration
> +=09 * and MSI interrupts.
> +=09 */
> +=09noacpi =3D pcie_dev ? "" : "acpi=3Doff pci=3Dnoacpi noapic";
> +#endif
> +
>  =09snprintf(cmdline, sizeof(cmdline),
> -=09=09=09=09"console=3Dhvc0 earlyprintk=3Dserial "
> +=09=09=09=09"console=3Dhvc0 %s "
>  =09=09=09=09"no_hash_pointers=3D1 %s %s quiet ro init=3D%s "
>  =09=09=09=09"TESTHOME=3D%s TESTDBUS=3D%u TESTDAEMON=3D%u "
>  =09=09=09=09"TESTDBUSSESSION=3D%u XDG_RUNTIME_DIR=3D/run/user/0 "
>  =09=09=09=09"TESTMONITOR=3D%u TESTEMULATOR=3D%u TESTDEVS=3D%d "
>  =09=09=09=09"TESTAUTO=3D%u TESTAUDIO=3D'%s' TESTARGS=3D\'%s\'",
> +=09=09=09=09earlycon,
>  =09=09=09=09fscmdline,
> -=09=09=09=09/* PCIe passthrough requires ACPI and APIC for
> -=09=09=09=09 * device enumeration and MSI interrupts.
> -=09=09=09=09 */
> -=09=09=09=09pcie_dev ? "" : "acpi=3Doff pci=3Dnoacpi noapic",
> +=09=09=09=09noacpi,
>  =09=09=09=09initcmd, cwd, start_dbus, start_daemon,
>  =09=09=09=09start_dbus_session,
>  =09=09=09=09start_monitor, num_emulator, num_devs,
>  =09=09=09=09run_auto, audio_server ? audio_server : "",
>  =09=09=09=09testargs);
> =20
>  =09/* Make sure qemu_binary is not null */
>  =09if (!qemu_binary) {
>  =09=09fprintf(stderr, "No QEMU binary is set\n");
>  =09=09return EXIT_FAILURE;
>  =09}
> =20
>  =09strv_append(&argv, "%s", qemu_binary);
>  =09strv_concat(&argv, qemu_argv);
> =20
> +#if defined(__aarch64__)
> +=09strv_append(&argv, "-machine");
> +=09strv_append(&argv, "virt,gic-version=3Dmax,accel=3Dkvm:tcg");
> +
> +=09strv_append(&argv, "-cpu");
> +=09strv_append(&argv, qemu_host_cpu ? "host" : "max");
> +#else
>  =09/* Interrupt remapping is required to pass through a device using
>  =09 * MSI-X, which in turn needs the split irqchip.
>  =09 */
>  =09strv_append(&argv, "-machine");
>  =09strv_append(&argv, "type=3Dq35,accel=3Dkvm:tcg%s",
>  =09=09=09pcie_dev ? ",kernel-irqchip=3Dsplit" : "");
> =20
>  =09if (qemu_host_cpu) {
>  =09=09strv_append(&argv, "-cpu");
>  =09=09strv_append(&argv, "host");
>  =09}
> +#endif
> =20
>  =09strv_append(&argv, "-kernel");
>  =09strv_append(&argv, "%s", kernel_image);
>  =09strv_append(&argv, "-append");
>  =09strv_append(&argv, "%s", cmdline);
> =20
>  =09coverage_setup(&argv, cwd);
> =20
> @@ -994,18 +1026,20 @@ static int start_qemu(void)
>  =09if (usb_dev) {
>  =09=09strv_append(&argv, "-device");
>  =09=09strv_append(&argv, "qemu-xhci");
>  =09=09strv_append(&argv, "-device");
>  =09=09strv_append(&argv, "%s", usb_dev);
>  =09}
> =20
>  =09if (pcie_dev) {
> +#if !defined(__aarch64__)
>  =09=09strv_append(&argv, "-device");
>  =09=09strv_append(&argv, "intel-iommu,intremap=3Don");
> +#endif
>  =09=09strv_append(&argv, "-device");
>  =09=09strv_append(&argv, "%s", pcie_dev);
>  =09}
> =20
>  =09if (!rootfs_setup(&rootfs, &argv))
>  =09=09return EXIT_FAILURE;
> =20
>  =09for (i =3D 0; i < num_extra_opts; ++i)
> @@ -2193,18 +2227,19 @@ static void usage(void)
>  =09=09"\t-m, --monitor          Start btmon\n"
>  =09=09"\t-l, --emulator[=3Dnum]   Start btvirt\n"
>  =09=09"\t-A, --audio[=3Dpath]     Start audio server\n"
>  =09=09"\t-u, --unix[=3Dpath]      Provide serial device\n"
>  =09=09"\t-U, --usb <qemu_args>  Provide USB device\n"
>  =09=09"\t-P, --pcie <qemu_args> Provide PCIe device\n"
>  =09=09"\t-q, --qemu <path>      QEMU binary\n"
>  =09=09"\t-H, --qemu-host-cpu    Use host CPU (requires KVM support)\n"
> -=09=09"\t-k, --kernel <image>   Kernel bzImage, User Mode Linux\n"
> -=09=09"\t                       binary or source tree path\n"
> +=09=09"\t-k, --kernel <image>   Kernel image or source tree path,\n"
> +=09=09"\t                       x86: bzImage or User Mode Linux\n"
> +=09=09"\t                       arm64: Image\n"
>  =09=09"\t-F, --virtiofs[=3D<path>]  Virtiofsd path or 'no'\n"
>  =09=09"\t-T, --time-travel      Run User Mode Linux on simulated\n"
>  =09=09"\t                       time, with btvirt as calendar\n"
>  =09=09"\t                       (default if supported)\n"
>  =09=09"\t-R, --real-time        Run User Mode Linux on real time\n"
>  =09=09"\t-o, --option <opt>     Additional argument passed to QEMU,\n"
>  =09=09"\t                       or kernel parameter with User\n"
>  =09=09"\t                       Mode Linux\n"

--=20
Pauli Virtanen

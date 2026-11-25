Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.194
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597478;
	b=s/CCGHPy8g2SegR2JBU6PQf93vq9/ylLVHdToe144b6X5XwovU9RFxTuv9goLp+yH+Yr
	 p+k9IHJge+J7bxcfOZYwFeHolBO8ZEQptsqLnYlZsl+uDgn/CHlUodJU55PPNGMjQH6Gt
	 jAuM598O+QSgivZxwo2oUVlbT+M0EqlcBtKBmyi2I/nOLvDpoU5f0alBgqGwtxghzu0+m
	 nZHq1ZDjjox8ca+qfNCs43hA+vpOTNLGOie8lGPOJ4d/SHqdP1QBSuX7bgFEOVJTII9Sr
	 cPk34zHEY4Z/N8Si+VPWGrTu9oSMLu4mvoOwwQZwgQyW7PJmJc/AyrUPEpey2WZE2hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597478;
	h=DMARC-Filter:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version:X-GND-Sasl:X-GND-State:X-GND-Score:X-GND-Cause;
	bh=x/K++zkAAp+Y626LUwI0jz13LgEiNcI8hQ56caCb17c=;
	b=WOjt/1/bXxdOaBTDS0HmXANwdnzmmgzKUavT8aGXTPUr/dvhAQ2+4TpnSruI8d7FELoM
	 C86mR6d16BaenM0gtxiEjLCuprhf+zWn4/bNhSYnpzCgeoTq1C92771TkNO5tW3KUsWpx
	 Mvf8RJnDz2DHXtSBcXTQ9DcprGEFKmA+NXhXAu57uaWVKorGrA/EKywphr3JFrowkD5tj
	 +JCemq0QRuCKnuVw1MW3qOLVo///ziU3ZxxxREU2fwOd3gxan2pbbrKxU9KMeSTXbgdmP
	 jNSDFa24c+w1j1mwUw+unKGoZya3Y7CGDdDycrrknT3DME+BdtMmfX13MT+NSNWLcZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hadess.net;
	spf=pass smtp.mailfrom=hadess.net;
	arc=none smtp.remote-ip=217.70.183.194
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16AC606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 09:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B16AC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 694F841B7B;
	Wed, 25 Nov 2026 09:04:35 +0000 (UTC)
Message-ID: <80cec33b165dc54b1ed6ced34a6016a65ce7d6ad.camel@hadess.net>
Subject: Re: [PATCH bluez 2/3] tools/test-runner: Support running on arm64
 hosts
From: Bastien Nocera <hadess@hadess.net>
To: Zijun Hu <zijun.hu@oss.qualcomm.com>, Linux Bluetooth
	 <linux-bluetooth@vger.kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz
	 <luiz.dentz@gmail.com>, Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 25 Nov 2026 10:04:35 +0100
In-Reply-To: <20261122-tr_arm64-v1-2-4eccf35daeca@oss.qualcomm.com>
References: <20261122-tr_arm64-v1-0-4eccf35daeca@oss.qualcomm.com>
	 <20261122-tr_arm64-v1-2-4eccf35daeca@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGxPF5nBdAOG/NTDBKaRfC0EN5E46mRlVWt02dlYm9IFZLjEshOjxHz3Snfc4ljFtIpK/bPiLDQBpOwBtslTq5ZJ50otuSx2v00XC7ipug3FQGn3a+DQ2CR6R+oin4It9wxdouYd6VVIJUQ0kuXR1uW/vDP2muzCDmGH6wOp6saNEq1o6d/2if0FRSJ2E8IkM88V/SBcc1brKRBrd1LKCs+0RpfiasuGciRkTp36w+TIKh0FuwPo+S4LvKI+zV1nCNRuyuWNBh2Rb9bMObRk0Xy0/UchhuRIa0pEtQtupya1ykez+cdT4EW6KK7KheOCQcp1z9twHt+aWbPGxWWll94WuqwoEr9xXnv6ZCJRit7k3a0hxfMZw9YCzvd4SD9lVR7DsyKS4J0TU3TZvU1PV+sZDPfNaq9q08brnlavsIYSxNpxB3zdHP6Wzz6rK3iupIoVSMBiDOfLcYbKp1MBK+YRrwszcNcYPn7lEm70vxWfB61oN+TgPyRSg1OzpLdvJH0D4pcFit4AD+sQvxBuNSmS0rlS7sapu4G1IbbX0LpXYFnXZmnmi8A9vi2tF86kpv/eW7Kmd/2bn0VELhUqlxuXrcZNid0f0/rAiIHceQk8XmRk3myFAL666i6/DqkdopXztki56NNRCSLqnWZ+op8cWIF2Gx6o96UaHCeHZ3r6Q

On Sun, 2026-11-22 at 02:34 -0800, Zijun Hu wrote:
> Add arm64 support by:
> - Using qemu-system-aarch64 with the virt machine and the arm64 Image
> - Passing -cpu max or host, as the default virt CPU is 32-bit
> - Using earlycon and leaving out the x86-only options
> - Warning when /dev/kvm is not accessible, as QEMU then falls back
> =C2=A0 to TCG
>=20
> Assisted-by: Claude:claude-opus-5-5
> ---
> =C2=A0doc/test-runner.rst |=C2=A0 5 ++++-
> =C2=A0tools/test-runner.c | 49 ++++++++++++++++++++++++++++++++++++++++++=
-
> ------
> =C2=A02 files changed, 46 insertions(+), 8 deletions(-)
>=20
> diff --git a/doc/test-runner.rst b/doc/test-runner.rst
> index b5876e4f5108..4ff9d1b02c1b 100644
> --- a/doc/test-runner.rst
> +++ b/doc/test-runner.rst
> @@ -21,17 +21,20 @@ OPTIONS
> =C2=A0:-m/--monitor: Start btmon
> =C2=A0:-l/--emulator[=3Dnum]: Start btvirt
> =C2=A0:-A/-audio[=3Dpath]: Start audio server
> =C2=A0:-u/--unix[=3Dpath]: Provide serial device
> =C2=A0:-U/--usb=3D<qemu_args>: Provide USB device
> =C2=A0:-P/--pcie=3D<qemu_args>: Provide PCIe device
> =C2=A0:-q/--qemu=3D<path>: QEMU binary
> =C2=A0:-H/--qemu-host-cpu: Use host CPU (requires KVM support)
> -:-k/--kernel=3D<image>: Kernel image (bzImage) or User Mode Linux
> binary
> +:-k/--kernel=3D<image>: Kernel image or source tree path:
> +
> +=C2=A0=C2=A0=C2=A0 | x86: bzImage or User Mode Linux binary
> +=C2=A0=C2=A0=C2=A0 | arm64: Image

Is there anything actually stopping running User Mode Linux on aarch64
systems?

> =C2=A0:-F/--virtiofs[=3D<path>]: Path to virtiofsd, or no to disable virt=
io-
> fs
> =C2=A0:-T/--time-travel: Run a User Mode Linux kernel on simulated time,
> with
> =C2=A0=C2=A0=C2=A0=C2=A0 btvirt as time travel calendar (default if the k=
ernel supports
> it)
> =C2=A0:-R/--real-time: Run a User Mode Linux kernel on real time
> =C2=A0:-o/--option=3D<opt>: Additional argument passed to QEMU, or kernel
> =C2=A0=C2=A0=C2=A0=C2=A0 parameter with User Mode Linux
> =C2=A0:-h/--help: Show help options
> =C2=A0
> diff --git a/tools/test-runner.c b/tools/test-runner.c
> index 0bca31a46351..a2105977c1ee 100644
> --- a/tools/test-runner.c
> +++ b/tools/test-runner.c
> @@ -128,20 +128,25 @@ static void strv_cleanup(struct strv *s)
> =C2=A0
> =C2=A0	for (i =3D 0; i < s->i; ++i)
> =C2=A0		free(s->strv[i]);
> =C2=A0
> =C2=A0	memset(s, 0, sizeof(*s));
> =C2=A0}
> =C2=A0
> =C2=A0static const char *qemu_table[] =3D {
> +#if defined(__aarch64__)
> +	"qemu-system-aarch64",
> +	"/usr/bin/qemu-system-aarch64",
> +#else
> =C2=A0	"qemu-system-x86_64",
> =C2=A0	"qemu-system-i386",
> =C2=A0	"/usr/bin/qemu-system-x86_64",
> =C2=A0	"/usr/bin/qemu-system-i386",
> +#endif
> =C2=A0	NULL
> =C2=A0};
> =C2=A0
> =C2=A0static const char *find_qemu(void)
> =C2=A0{
> =C2=A0	int i;
> =C2=A0
> =C2=A0	for (i =3D 0; qemu_table[i]; i++) {
> @@ -150,21 +155,26 @@ static const char *find_qemu(void)
> =C2=A0		if (!stat(qemu_table[i], &st))
> =C2=A0			return qemu_table[i];
> =C2=A0	}
> =C2=A0
> =C2=A0	return NULL;
> =C2=A0}
> =C2=A0
> =C2=A0static const char *kernel_table[] =3D {
> +#if defined(__aarch64__)
> +	"Image",
> +	"arch/arm64/boot/Image",
> +#else
> =C2=A0	"bzImage",
> =C2=A0	"arch/x86/boot/bzImage",
> =C2=A0	"vmlinux",
> =C2=A0	"arch/x86/boot/vmlinux",
> =C2=A0	"linux",
> +#endif
> =C2=A0	NULL
> =C2=A0};
> =C2=A0
> =C2=A0/* A User Mode Linux kernel is an executable with the
> .uml.setup.init
> =C2=A0 * section, through which it registers its command line options.
> =C2=A0 */
> =C2=A0static bool is_uml_kernel(const char *path)
> =C2=A0{
> @@ -420,16 +430,19 @@ static char *const qemu_envp[] =3D {
> =C2=A0
> =C2=A0static void check_virtualization(void)
> =C2=A0{
> =C2=A0#ifdef HAVE_GET_CPUID
> =C2=A0	unsigned int eax, ebx, ecx, edx;
> =C2=A0
> =C2=A0	if (__get_cpuid(1, &eax, &ebx, &ecx, &edx) && (ecx & (1 <<
> 5)))
> =C2=A0		printf("Found support for Virtual Machine
> eXtensions\n");
> +#elif defined(__aarch64__)
> +	if (access("/dev/kvm", R_OK | W_OK) < 0)
> +		fprintf(stderr, "No access to /dev/kvm, falling back
> to TCG\n");
> =C2=A0#endif
> =C2=A0}
> =C2=A0
> =C2=A0#define PCI_DEVICES_PATH "/sys/bus/pci/devices"
> =C2=A0
> =C2=A0static char pcie_bdf[16];
> =C2=A0static char pcie_driver[64];
> =C2=A0
> @@ -894,16 +907,18 @@ static void qemu_signal(int sig)
> =C2=A0	if (qemu_pid > 0)
> =C2=A0		kill(qemu_pid, sig);
> =C2=A0}
> =C2=A0
> =C2=A0static int start_qemu(void)
> =C2=A0{
> =C2=A0	char cwd[PATH_MAX/2], initcmd[PATH_MAX], testargs[PATH_MAX];
> =C2=A0	const char *fscmdline;
> +	const char *earlycon;
> +	const char *noacpi;
> =C2=A0	char cmdline[CMDLINE_MAX];
> =C2=A0	char *argv_strv[EXTRA_OPT_MAX + 64];
> =C2=A0	struct strv _cleanup_(strv_cleanup) argv =3D { argv_strv,
> =C2=A0							ARRAY_SIZE(a
> rgv_strv) };
> =C2=A0	struct rootfs _cleanup_(rootfs_cleanup) rootfs =3D {{0}};
> =C2=A0	int i, pos, status =3D 0;
> =C2=A0	pid_t pid;
> =C2=A0
> @@ -933,54 +948,71 @@ static int start_qemu(void)
> =C2=A0	}
> =C2=A0
> =C2=A0	if (!virtiofsd)
> =C2=A0		fscmdline =3D "rootfstype=3D9p "
> =C2=A0				"rootflags=3Dtrans=3Dvirtio,version=3D9p20
> 00.u";
> =C2=A0	else
> =C2=A0		fscmdline =3D "rootfstype=3Dvirtiofs root=3D/dev/root";
> =C2=A0
> +#if defined(__aarch64__)
> +	earlycon =3D "earlycon";
> +	noacpi =3D "";
> +#else
> +	earlycon =3D "earlyprintk=3Dserial";
> +	/* PCIe passthrough requires ACPI and APIC for device
> enumeration
> +	 * and MSI interrupts.
> +	 */
> +	noacpi =3D pcie_dev ? "" : "acpi=3Doff pci=3Dnoacpi noapic";
> +#endif
> +
> =C2=A0	snprintf(cmdline, sizeof(cmdline),
> -				"console=3Dhvc0 earlyprintk=3Dserial "
> +				"console=3Dhvc0 %s "
> =C2=A0				"no_hash_pointers=3D1 %s %s quiet ro
> init=3D%s "
> =C2=A0				"TESTHOME=3D%s TESTDBUS=3D%u
> TESTDAEMON=3D%u "
> =C2=A0				"TESTDBUSSESSION=3D%u
> XDG_RUNTIME_DIR=3D/run/user/0 "
> =C2=A0				"TESTMONITOR=3D%u TESTEMULATOR=3D%u
> TESTDEVS=3D%d "
> =C2=A0				"TESTAUTO=3D%u TESTAUDIO=3D'%s'
> TESTARGS=3D\'%s\'",
> +				earlycon,
> =C2=A0				fscmdline,
> -				/* PCIe passthrough requires ACPI
> and APIC for
> -				 * device enumeration and MSI
> interrupts.
> -				 */
> -				pcie_dev ? "" : "acpi=3Doff pci=3Dnoacpi
> noapic",
> +				noacpi,
> =C2=A0				initcmd, cwd, start_dbus,
> start_daemon,
> =C2=A0				start_dbus_session,
> =C2=A0				start_monitor, num_emulator,
> num_devs,
> =C2=A0				run_auto, audio_server ?
> audio_server : "",
> =C2=A0				testargs);
> =C2=A0
> =C2=A0	/* Make sure qemu_binary is not null */
> =C2=A0	if (!qemu_binary) {
> =C2=A0		fprintf(stderr, "No QEMU binary is set\n");
> =C2=A0		return EXIT_FAILURE;
> =C2=A0	}
> =C2=A0
> =C2=A0	strv_append(&argv, "%s", qemu_binary);
> =C2=A0	strv_concat(&argv, qemu_argv);
> =C2=A0
> +#if defined(__aarch64__)
> +	strv_append(&argv, "-machine");
> +	strv_append(&argv, "virt,gic-version=3Dmax,accel=3Dkvm:tcg");
> +
> +	strv_append(&argv, "-cpu");
> +	strv_append(&argv, qemu_host_cpu ? "host" : "max");
> +#else
> =C2=A0	/* Interrupt remapping is required to pass through a device
> using
> =C2=A0	 * MSI-X, which in turn needs the split irqchip.
> =C2=A0	 */
> =C2=A0	strv_append(&argv, "-machine");
> =C2=A0	strv_append(&argv, "type=3Dq35,accel=3Dkvm:tcg%s",
> =C2=A0			pcie_dev ? ",kernel-irqchip=3Dsplit" : "");
> =C2=A0
> =C2=A0	if (qemu_host_cpu) {
> =C2=A0		strv_append(&argv, "-cpu");
> =C2=A0		strv_append(&argv, "host");
> =C2=A0	}
> +#endif
> =C2=A0
> =C2=A0	strv_append(&argv, "-kernel");
> =C2=A0	strv_append(&argv, "%s", kernel_image);
> =C2=A0	strv_append(&argv, "-append");
> =C2=A0	strv_append(&argv, "%s", cmdline);
> =C2=A0
> =C2=A0	coverage_setup(&argv, cwd);
> =C2=A0
> @@ -994,18 +1026,20 @@ static int start_qemu(void)
> =C2=A0	if (usb_dev) {
> =C2=A0		strv_append(&argv, "-device");
> =C2=A0		strv_append(&argv, "qemu-xhci");
> =C2=A0		strv_append(&argv, "-device");
> =C2=A0		strv_append(&argv, "%s", usb_dev);
> =C2=A0	}
> =C2=A0
> =C2=A0	if (pcie_dev) {
> +#if !defined(__aarch64__)
> =C2=A0		strv_append(&argv, "-device");
> =C2=A0		strv_append(&argv, "intel-iommu,intremap=3Don");
> +#endif
> =C2=A0		strv_append(&argv, "-device");
> =C2=A0		strv_append(&argv, "%s", pcie_dev);
> =C2=A0	}
> =C2=A0
> =C2=A0	if (!rootfs_setup(&rootfs, &argv))
> =C2=A0		return EXIT_FAILURE;
> =C2=A0
> =C2=A0	for (i =3D 0; i < num_extra_opts; ++i)
> @@ -2193,18 +2227,19 @@ static void usage(void)
> =C2=A0		"\t-m, --monitor=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 Start btmon\n"
> =C2=A0		"\t-l, --emulator[=3Dnum]=C2=A0=C2=A0 Start btvirt\n"
> =C2=A0		"\t-A, --audio[=3Dpath]=C2=A0=C2=A0=C2=A0=C2=A0 Start audio serve=
r\n"
> =C2=A0		"\t-u, --unix[=3Dpath]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Provide seri=
al device\n"
> =C2=A0		"\t-U, --usb <qemu_args>=C2=A0 Provide USB device\n"
> =C2=A0		"\t-P, --pcie <qemu_args> Provide PCIe device\n"
> =C2=A0		"\t-q, --qemu <path>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QEMU binary\n"
> =C2=A0		"\t-H, --qemu-host-cpu=C2=A0=C2=A0=C2=A0 Use host CPU (requires K=
VM
> support)\n"
> -		"\t-k, --kernel <image>=C2=A0=C2=A0 Kernel bzImage, User Mode
> Linux\n"
> -		"\t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 binary o=
r source tree
> path\n"
> +		"\t-k, --kernel <image>=C2=A0=C2=A0 Kernel image or source
> tree path,\n"
> +		"\t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x86: bzI=
mage or User Mode
> Linux\n"
> +		"\t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arm64: I=
mage\n"
> =C2=A0		"\t-F, --virtiofs[=3D<path>]=C2=A0 Virtiofsd path or
> 'no'\n"
> =C2=A0		"\t-T, --time-travel=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Run User Mode =
Linux on
> simulated\n"
> =C2=A0		"\t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ti=
me, with btvirt as
> calendar\n"
> =C2=A0		"\t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (d=
efault if supported)\n"
> =C2=A0		"\t-R, --real-time=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Run =
User Mode Linux on
> real time\n"
> =C2=A0		"\t-o, --option <opt>=C2=A0=C2=A0=C2=A0=C2=A0 Additional argument=
 passed
> to QEMU,\n"
> =C2=A0		"\t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or=
 kernel parameter with
> User\n"
> =C2=A0		"\t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Mo=
de Linux\n"

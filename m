Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795797202;
	b=xnL23M+FzKbMzcRS2xkUUWedrvCyL2NLAv8tQS6vI7oJEFotRO6RnhMvJEse4+PXozzA
	 4vXJBbFXrQqXoncG8xOHUVpHQVZ7QNez+qNzbm0VFBSLiwJ+iaEIe2UMvdvkhQ1jLBw9h
	 /D8S32QOuhxxWyuLOrXCQiXUZx+D+RbJQ4fXXLmAhV+sN9g1Ey4QGgGW6236dlcM4kTt+
	 pU1/Wwi8GGh0WsUSmjQVsVAcorY5UHHKmXu2B2LmWrCdeovHvu/cTgusB02dJYX5ncevs
	 sAA27FGHw0BiermTTmKzLgxm8u2DxSlHFokG+275zCdPd5L+HusYloz8CG9wA52cbdA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795797202;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=VduTzhhbsenmWhHwIAhamAyY1wJu/e5SD1E1xZmPNUc=;
	b=T467X8J1+ntR015lzeqFQiXzUc5UKxJsN9xl4CTQPdhHHgmPbesaAFQE25c/1/zMzuiq
	 UTkZ5rjeLqAtiglgvuPQUJR4x5LkjRp/SYqhO7hDQTflW4LTvO6ZDz7YNkmI+t1+QBAKX
	 PVQT4CSqhTwqU3casDEo8kTD3EEVLux0ZZtzlgoXkpEVy/vAx8NUNHnTSrPKeoX/nZrk9
	 lts4aaSr0moOIvqLprvACkEDSSY7vsiVzC9duu4S9//PjX2AkuO+V5qH8LyiN6ZDanBa0
	 2ykyiPhKtfd3qNAYrHkyeTFWbVXYl4b0ThX0ItU/n8mw7G0BjtM93ATG6nQmBLRJu5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A+h6JhG5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E17606A31E
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 16:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26E17606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A+h6JhG5
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-67c0bd676eeso5806118d50.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 08:33:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795797201; cv=none;
        d=google.com; s=arc-20260327;
        b=hvv3OHgtC62KjIGXfQ7ZqFmPuAvMCNOWE9SKOzRlkcm9E9xOh4MArpi1QJlIP8tFWj
         RSdZufmjoFutUAiXlM7+uhscYYD0/UWffr9OqXIo45hikX2YXrSDRkxaO8tPG6/M5PKM
         ky2MrVQFBgjWUqCvIqo+GL7qELAE9nubQpzL6nLSlA9wSyuGn58VFMUE3obQ2kw88AJq
         UxdcQux9vbZcRktDBigLHBbwa4XFMn6yliCEHRGr/lq9xPmK+V2y+0BbXGNy3QUPDy2C
         wLAyLzWDi7lnddvSurtK5Yz16FV+r+YAETSKgx+RFAipvLrqcFPOrVlGwRL+nZAQiYn+
         C/ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VduTzhhbsenmWhHwIAhamAyY1wJu/e5SD1E1xZmPNUc=;
        fh=HkewGmAbdbUo/zYrwa0iZawX3s/f9ikedKCHsNWJLts=;
        b=VzZOZSqS5/RXwJMTaHAvdvXLLTWYAJw9bumNWard9tscEUTa2pxbCgodbZivaly8l/
         VwotHR5auO+LLygUM2YexeAr/WfrvlfE6URCdxhXVa5rPC6FPBrHWOarKKs7nuH3lcEC
         XXPGgFNOTgX4m7a3z98T4wVwra2QEvDiCWtDK1ht8Gxk4opT4xU9y9WSizr/FmXBef0I
         qdgWK0cLK4YVQFbW+FcbSVuagI62tkKCuBGNl52fJtf9jaVlb+a2z1bAjgJnpmntrcnh
         DLDNg84UGGjcUR4lWl8QMpt09M+N7Yu3OE1usHQ49gaoirmEN+1jfBMZ7OqLAvTB4Zjf
         2JwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795797201; x=1796402001; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VduTzhhbsenmWhHwIAhamAyY1wJu/e5SD1E1xZmPNUc=;
        b=A+h6JhG51wFQlGAdcqQEAKqnjA87a2nPMexWh5dUbwB6J7aEccfIr/rPe7nQq+wEGk
         VKwv0tR4xVhVtvaf0uzfeLxeUkumGdlEhPp96DukTz96C5NfLIDZGoDrD3g2Cq5OddYT
         UmixesKYS00gOexLVwjygMFey+WLqV7oYBfFjXQXqNQQl7sVtiqnmhIRj///DRWiC6z/
         PTsCRY0Bn6gpFTMkVzw84fIWrQbwogrJIC5DY75qAl+p8FkHKtaB0M33dz7j8FgwTN+F
         Ifa22SaXivhT73xXKWYzWH0Q44a1L3+OcnVeYUdguHsKMsnPnhHU34tDPRgt1VvGX18t
         HMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795797201; x=1796402001;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VduTzhhbsenmWhHwIAhamAyY1wJu/e5SD1E1xZmPNUc=;
        b=CL/Tnr6YlUdutTplfB7qwJO91JVbDmn9F+qWJ+ZjqdilO7rMdci7WSu0jKSCVtTGaL
         9RxnntI/QrLa5MOc3SzeeL1WaPPQrMcLtmFuiLuqTnNN3N3R9zvZ4BLpV7YZ811APKXa
         JOUXDzpTx9x8KPYgO3p1IC6t1ayXZUDIvQwsomsSzqfbj2FpN6Ah2VvntTCI45iicGf+
         HwsGzzydKNbg+RiklDLt2TMFDUEdmjD4fu9Gi8M0Z8DWRowZtir+0hdyPP0v2J8WA9+n
         0Mf8mUaHxFCojZowgFIX12WBVivZ+4Q82n7D91XlQhEfcs2AWL1Jxhw7cAiJALNrFWH4
         pzNw==
X-Gm-Message-State: APuU4Z8wR91UUbbecasmhWpw8k2hASTFeOJBp2ZkC2KZZ0BcTVW5yAR0
	8kakShRHPxlPbbKu54JeJOzljkvCW+u98Xb7O1c4h1eMRPXcoDauXS6WZhcA92QrDIkqUPpg15H
	Vxj9rjCGF5AsEr3kXqtFlCxBap7wqCTM=
X-Gm-Gg: AZFdTZcvjrNxMQzYOfPZ0uffLKt9+tfmJpKPJ9MNbjBBG5P42YzVY+gNSQArRMfNgZh
	EtlvsBIPIzdKnmdTPIuZqkJ43D26EhBun5gwIsbsmmKboLo/surgQWZyFnRWvJHotoMZEgWg/X0
	1mH1jaxZUeET7hfyk0EfR/FEqBP306Q6oDhecTfyrkZJXNa6luthnJ54gFVb4exwkf7ujZIopYI
	rtjIuIGmugdfkhSHdsI7Ky9p4Dg/6FRwUdXa/G0eTTU5doWdnpxYKGNdGGWMs2xmGMiLda2e+O/
	rGeB9Rw5964OR6w7jlslVpo1iQiKC837cZSlG0DZy+cEaWmISHUNhZTpooOCKgBAOG5H5r5XFRK
	5ah1ef/DHjqfZOPgFlsj4RIVtV5Fl8noVT1jrhu8/Ldwt8mJb5vkDHdBgkidCPdlnDThL1Joxs9
	HCKHyOue9/V9I1XubGm/w89zhUAqtKc/88U/2NZHeeuedXTEydt7uemaob9w==
X-Received: by 2002:a05:690e:a4f:b0:672:964b:f071 with SMTP id
 956f58d0204a3-67df44b3ca6mr11048393d50.94.1795797201143; Fri, 27 Nov 2026
 08:33:21 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125-tr_arm64-v2-0-4f02989f17ba@oss.qualcomm.com> <20261125-tr_arm64-v2-5-4f02989f17ba@oss.qualcomm.com>
In-Reply-To: <20261125-tr_arm64-v2-5-4f02989f17ba@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 27 Nov 2026 11:33:07 -0500
X-Gm-Features: Aa3M54pJkwsHzmlZz8KaGei8E7ATFFO9kOsZRoOXHjPODkBlxGYKmUKrmrg2J9o
Message-ID: <CABBYNZ+oVaMvVEr8Kpg+tzuJSYXqUFwLXa8fdS33zqmowqb3zg@mail.gmail.com>
Subject: Re: [PATCH bluez v2 5/7] tools/test-runner: Allow suppressing noisy
 bluetoothd debug output
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Pauli Virtanen <pav@iki.fi>, Bastien Nocera <hadess@hadess.net>, Zijun Hu <zijun_hu@icloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zijun,

On Wed, Nov 25, 2026 at 9:45=E2=80=AFPM Zijun Hu <zijun.hu@oss.qualcomm.com=
> wrote:
>
> test-runner always starts bluetoothd with -d, which floods the console
> with debug output when only the test output is of interest.
>
> Add an optional bluetoothd run mode to -d, e.g. -d2:
> - 1: --nodetach -d [-f src/main.conf] (default)
> - 2: --nodetach [-f src/main.conf]

Let's not do that, the logging is actually important if there is an
error. Perhaps we can make `-d` take an optional path and write the
output there rather than omitting all bluetoothd traces.

> Also make supporting other run modes easier in the future.
>
> Existing usage in doc/test-runner.rst still works since -d without a
> mode behaves as before.
>
> Assisted-by: Claude:claude-opus-5-5
> ---
>  doc/test-runner.rst | 16 ++++++++++++-
>  tools/test-runner.c | 68 +++++++++++++++++++++++++++++++++++++++--------=
------
>  2 files changed, 65 insertions(+), 19 deletions(-)
>
> diff --git a/doc/test-runner.rst b/doc/test-runner.rst
> index 35dee021d8a0..f468a869e7ab 100644
> --- a/doc/test-runner.rst
> +++ b/doc/test-runner.rst
> @@ -12,17 +12,20 @@ it launches a virtual machine using qemu(1) with the =
host filesystem mounted
>  read-only inside the guest.
>
>  OPTIONS
>  =3D=3D=3D=3D=3D=3D=3D
>
>  :-a:--auto: Find tests and run them
>  :-b/--dbus: Start D-Bus system daemon
>  :-s/--dbus-session: Start D-Bus session daemon
> -:-d/--daemon: Start bluetoothd
> +:-d/--daemon[=3Dmode]: Start bluetoothd, mode (default 1):
> +
> +    | 1: --nodetach -d [-f src/main.conf]
> +    | 2: --nodetach [-f src/main.conf]
>  :-m/--monitor: Start btmon
>  :-l/--emulator[=3Dnum]: Start btvirt
>  :-A/-audio[=3Dpath]: Start audio server
>  :-u/--unix[=3Dpath]: Provide serial device
>  :-U/--usb=3D<qemu_args>: Provide USB device
>  :-P/--pcie=3D<qemu_args>: Provide PCIe device
>  :-q/--qemu=3D<path>: QEMU binary
>  :-H/--qemu-host-cpu: Use host CPU (requires KVM support)
> @@ -360,16 +363,27 @@ Running bluetoothctl with emulated controller and a=
udio support
>  Running shell with host controller using btproxy
>  ------------------------------------------------
>
>  .. code-block::
>
>         $ tools/btproxy -u [1]
>         $ tools/test-runner -u -d -k /pathto/bzImage -- /bin/bash [2]
>
> +Running bluetoothctl with host controller using btproxy for normal outpu=
t
> +------------------------------------------------------------------------=
--
> +
> +With -d2, bluetoothd is started without -d, so the bluetoothctl console
> +is not flooded with debug output:
> +
> +.. code-block::
> +
> +       $ tools/btproxy -u [1]
> +       $ tools/test-runner -u -d2 -k /pathto/bzImage -- client/bluetooth=
ctl [2]
> +
>  Running shell with host controller USB-passthrough
>  --------------------------------------------------
>
>  In addition the above kernel config option the following is required:
>
>  .. code-block::
>
>         CONFIG_USB=3Dy
> diff --git a/tools/test-runner.c b/tools/test-runner.c
> index 06573c5d3005..28cfa296e167 100644
> --- a/tools/test-runner.c
> +++ b/tools/test-runner.c
> @@ -50,25 +50,26 @@
>  #endif
>
>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
>
>  #define _cleanup_(f) __attribute__((cleanup(f)))
>
>  #define CMDLINE_MAX (2048 * 10)
>  #define EXTRA_OPT_MAX 64
> +#define DAEMON_MODE_MAX 3
>
>  static const char *own_binary;
>  static char **test_argv;
>  static int test_argc;
>
>  static bool run_auto =3D false;
>  static bool start_dbus =3D false;
>  static bool start_dbus_session;
> -static bool start_daemon =3D false;
> +static unsigned int start_daemon;
>  static bool start_monitor =3D false;
>  static bool qemu_host_cpu =3D false;
>  /* Simulated time with User Mode Linux: -1 if supported by the kernel */
>  static int time_travel =3D -1;
>  static int num_devs =3D 0;
>  static int num_emulator =3D 0;
>  static const char *device_path =3D "/tmp/bt-server-bredr";
>  static const char *qemu_binary =3D NULL;
> @@ -1578,17 +1579,17 @@ static const char *daemon_table[] =3D {
>         "/usr/sbin/bluetoothd",
>         "/usr/libexec/bluetooth/bluetoothd",
>         NULL
>  };
>
>  static pid_t start_bluetooth_daemon(const char *home)
>  {
>         const char *daemon =3D NULL;
> -       char *argv[6], *envp[2];
> +       char *argv[6] =3D { NULL }, *envp[2];
>         pid_t pid;
>         struct stat st;
>         int i;
>
>         if (chdir(home + 5) < 0) {
>                 perror("Failed to change home directory for daemon");
>                 return -1;
>         }
> @@ -1603,25 +1604,40 @@ static pid_t start_bluetooth_daemon(const char *h=
ome)
>
>         if (!daemon) {
>                 fprintf(stderr, "Failed to locate Bluetooth daemon binary=
\n");
>                 return -1;
>         }
>
>         printf("Using Bluetooth daemon %s\n", daemon);
>
> -       argv[0] =3D (char *) daemon;
> -       argv[1] =3D "--nodetach";
> -       argv[2] =3D "-d";
> -       argv[3] =3D NULL;
> +       i =3D 0;
> +       argv[i++] =3D (char *) daemon;
>
> -       if (!stat("src/main.conf", &st)) {
> -               argv[3] =3D "-f";
> -               argv[4] =3D "src/main.conf";
> -               argv[5] =3D NULL;
> +       switch (start_daemon) {
> +       case 1:
> +               argv[i++] =3D "--nodetach";
> +               argv[i++] =3D "-d";
> +
> +               if (!stat("src/main.conf", &st)) {
> +                       argv[i++] =3D "-f";
> +                       argv[i++] =3D "src/main.conf";
> +               }
> +               break;
> +       case 2:
> +               argv[i++] =3D "--nodetach";
> +
> +               if (!stat("src/main.conf", &st)) {
> +                       argv[i++] =3D "-f";
> +                       argv[i++] =3D "src/main.conf";
> +               }
> +               break;
> +       default:
> +               fprintf(stderr, "Invalid daemon mode %u\n", start_daemon)=
;
> +               return -1;
>         }
>
>         envp[0] =3D "DBUS_SYSTEM_BUS_ADDRESS=3Dunix:path=3D/run/dbus/syst=
em_bus_socket";
>         envp[1] =3D NULL;
>
>         printf("Starting Bluetooth daemon\n");
>
>         pid =3D fork();
> @@ -2165,20 +2181,21 @@ static void run_tests(void)
>         }
>
>         ptr =3D strstr(cmdline, "TESTDBUSSESSION=3D1");
>         if (ptr) {
>                 printf("D-Bus session daemon requested\n");
>                 start_dbus_session =3D true;
>         }
>
> -       ptr =3D strstr(cmdline, "TESTDAEMON=3D1");
> +       ptr =3D strstr(cmdline, "TESTDAEMON=3D");
>         if (ptr) {
> -               printf("bluetoothd requested\n");
> -               start_daemon =3D true;
> +               start_daemon =3D strtoul(ptr + 11, NULL, 0);
> +               if (start_daemon)
> +                       printf("bluetoothd mode %u requested\n", start_da=
emon);
>         }
>
>         ptr =3D strstr(cmdline, "TESTMONITOR=3D1");
>         if (ptr) {
>                 printf("Monitor requested\n");
>                 start_monitor =3D true;
>         }
>
> @@ -2218,17 +2235,19 @@ static void usage(void)
>  {
>         printf("test-runner - Automated test execution utility\n"
>                 "Usage:\n");
>         printf("\ttest-runner [options] [--] <command> [args]\n");
>         printf("Options:\n"
>                 "\t-a, --all,--auto       Find tests and run them\n"
>                 "\t-b, --dbus             Start D-Bus system daemon\n"
>                 "\t-s, --dbus-session     Start D-Bus session daemon\n"
> -               "\t-d, --daemon           Start bluetoothd\n"
> +               "\t-d, --daemon[=3Dmode]    Start bluetoothd, mode (defau=
lt 1):\n"
> +               "\t                       1: --nodetach -d [-f src/main.c=
onf]\n"
> +               "\t                       2: --nodetach [-f src/main.conf=
]\n"
>                 "\t-m, --monitor          Start btmon\n"
>                 "\t-l, --emulator[=3Dnum]   Start btvirt\n"
>                 "\t-A, --audio[=3Dpath]     Start audio server\n"
>                 "\t-u, --unix[=3Dpath]      Provide serial device\n"
>                 "\t-U, --usb <qemu_args>  Provide USB device\n"
>                 "\t-P, --pcie <qemu_args> Provide PCIe device\n"
>                 "\t-q, --qemu <path>      QEMU binary\n"
>                 "\t-H, --qemu-host-cpu    Use host CPU (requires KVM supp=
ort)\n"
> @@ -2247,17 +2266,17 @@ static void usage(void)
>  }
>
>  static const struct option main_options[] =3D {
>         { "all",     no_argument,       NULL, 'a' },
>         { "auto",    no_argument,       NULL, 'a' },
>         { "dbus",    no_argument,       NULL, 'b' },
>         { "dbus-session", no_argument,  NULL, 's' },
>         { "unix",    optional_argument, NULL, 'u' },
> -       { "daemon",  no_argument,       NULL, 'd' },
> +       { "daemon",  optional_argument, NULL, 'd' },
>         { "emulator", no_argument,      NULL, 'l' },
>         { "monitor", no_argument,       NULL, 'm' },
>         { "qemu",    required_argument, NULL, 'q' },
>         { "qemu-host-cpu", no_argument, NULL, 'H' },
>         { "kernel",  required_argument, NULL, 'k' },
>         { "audio",   optional_argument, NULL, 'A' },
>         { "usb",     required_argument, NULL, 'U' },
>         { "pcie",    required_argument, NULL, 'P' },
> @@ -2288,17 +2307,17 @@ int main(int argc, char *argv[])
>                         reboot(RB_AUTOBOOT);
>                 return EXIT_SUCCESS;
>         }
>
>         for (;;) {
>                 int opt;
>
>                 opt =3D getopt_long(argc, argv,
> -                               "au::bdsl::mq:Hk:A::U:P:o:F::TRvh",
> +                               "au::bd::sl::mq:Hk:A::U:P:o:F::TRvh",
>                                 main_options, NULL);
>                 if (opt < 0)
>                         break;
>
>                 switch (opt) {
>                 case 'a':
>                         run_auto =3D true;
>                         break;
> @@ -2309,18 +2328,31 @@ int main(int argc, char *argv[])
>                         break;
>                 case 'b':
>                         start_dbus =3D true;
>                         break;
>                 case 's':
>                         start_dbus_session =3D true;
>                         break;
>                 case 'd':
> -                       start_dbus =3D true;
> -                       start_daemon =3D true;
> +                       start_daemon =3D 1;
> +                       if (optarg) {
> +                               char *endptr;
> +
> +                               start_daemon =3D strtoul(optarg, &endptr,=
 0);
> +                               if (start_daemon >=3D DAEMON_MODE_MAX ||
> +                                                               *endptr) =
{
> +                                       fprintf(stderr,
> +                                               "Invalid daemon mode %s\n=
",
> +                                               optarg);
> +                                       return EXIT_FAILURE;
> +                               }
> +                       }
> +                       if (start_daemon)
> +                               start_dbus =3D true;
>                         break;
>                 case 'l':
>                         num_emulator =3D optarg ? atoi(optarg) : 1;
>                         break;
>                 case 'm':
>                         start_monitor =3D true;
>                         break;
>                 case 'q':
>
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz

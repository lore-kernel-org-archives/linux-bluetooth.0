Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF76C559C98
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060657; cv=pass; b=U3xVqYObO/Q79MY8eyQQlYOv+ihIlO0zjTJA/SPmAn9PWG4RK3Y5UH2UQAqMKu8aDJh+bm4TG2Pq5EsfaMVSvHXp3b9LIHETxgVPYAhZ0JVXSEDKz/PffwmKXJpHJfEz7rQEj88kfYKXTVvrmoWAIHornKv/A/w1wF5WERSIJFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060657; c=relaxed/simple;
	bh=ZcR+Y+9I1L2s6jXQdGxxdZUn5pzvKgM+IHhoQasmrfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pLEtACboHug2VSsoXVwKhtySlosUgUTSqt8JuyXFysdQI7vQjFhO6SYDjft9hCesX0SnWnYWxiDPqUZf78swENda9ALxILBt86yQ4/PfqwSmICijB7jnghgzg7Vc7L/tKOwrry4VGz2vsW4pChgRbVPS6kkUDbKKm1cfCm5724Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qIqV/0Fb; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIqV/0Fb"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66c9995ca60so721010d50.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 10:17:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789060622; cv=none;
        d=google.com; s=arc-20260327;
        b=QdBLMbxaW/OJfNpC+ZKNxBtFhBsdi7Edas66f+bkLs1uwC+aORaMfj1FFJn0anaYJu
         LB2+k/5CgIqT7D2JnOBNiqaxGwbNq1XW87Xqtszsb3VSPH1z/usq1LxD7Pvwg21DEkuc
         mb/asqXcatBwCP6UjiIs/pSEaQ389ytUZqabSinNDdV0OQQ9u+20aoEJSaLpHqyU29yi
         bke7EutCTaFZ0zIjhjimCSqTQmluqle3uKYibDnRj8LfjFBslv0HwMYhxyc17rmn759w
         QKI+1FXeko0RXHkCfBXXqnh/nmeE+rEH+aGMyLXOqHVFHE5XOw9K9kojwoiqMCHf/R6D
         rQMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UkDfwl5x50BkngPxN2dBng6TS8sjJnDWrkj6wYJqzaU=;
        fh=fAVvqa29TMCSLQ1BWo+IkeTh9vOt2h2EvlnFWIq0DOI=;
        b=DRVFgeB+KaInvVFWL8wu7H6D+H8ZOaWl1mImsPwB2WJgUllzHjgKX2xdalMClSIxET
         LBOuGiF3aQnQCdQRs9cSLf7dEJJSpJTJix0L/Y+nwAXwsh1fD+Dc2wjkwZ2paUgnsOxo
         21K33dSxpiOuTmrPVHOk8254E4pLzR9VW6iXr/KjlFW9HJDPPsavlbZd/jip4xZSC1D+
         mS3QyiI2RE2quovUB1lGew3EHRcpUTAB0TobatC40fnURpCj/vgJI3HPl4nngUsXf2q3
         bmTzh3qkmvIccYXlLV4ur+EteSAW9ri8gmzKbpCkWncyqxbyn/Xi8VU8UVmosazbHAcn
         8Mzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789060622; x=1789665422; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UkDfwl5x50BkngPxN2dBng6TS8sjJnDWrkj6wYJqzaU=;
        b=qIqV/0FbArxAFCZKX1UqSVz/4x6sfk4uS4kBnG7NCKqmnS92CMYPyR5Df4TsKULldH
         1kC1lPhEmm1O4lTD0/LNXDu12Ha2pTV34hbJfT2luRFbtJ1kuXJTdC7hgLYCem3t41I1
         ASLFLPpBPN++jniEdsDsneyXRC0W6WxnDZ63/6/AWttTpjrXIyPXc70eu1Q9GfEwgW9D
         cVow7G9qZ4RF5tauJo/KVbshXrbDK0+cXno/lWbH/BvUMICDuY3T+NgruCf/j6wIzlqU
         SC0SAqHRac1l4eKYvWXsBYr7hTHDAI/KhS5CzO84QtA9jhd65usTjGMBeDFL5xFfGiIf
         aptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789060622; x=1789665422;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UkDfwl5x50BkngPxN2dBng6TS8sjJnDWrkj6wYJqzaU=;
        b=U1A9651yTWbWN8yb565KQpkMb8IsXxG1TZN0P2Z/0ZBHfMfapJYq0g7XoLL3d6oj7M
         gB9K1kKjAkmMQnKm/t4eOZ1vvom7peaT13rYrfFIJ/U2BiIv2Ch0qH0cQ5FFXcXRwGHW
         sfeyBg/1ZNKU43R91HgmoLzP+5C3x/RPTEgS2UtddAUym9oUuj35J62SZk/zJL4JRu1M
         zUSbnS4bKQr7DhuHyl5Yh7LMITGstliReIl9OfYVHXpi7GC0/Xl3QJoKXcAFRLFm4U1T
         8IdBbjuTgsNWSdb/VNGCjn7EAgXkOlwEGsIQhRXYMNK68SIozpt4XlrGCkOysaahCVTS
         muhg==
X-Gm-Message-State: AFuF++m8TGdOpv7mznWqQB1ZFC75xXjUFQ1mlAE2kDaQwJ3K4TbK0Dzd
	3KSQjXsRSRuEhcc2qqWEiniwGf6/9Xs+qV7MSz6CzHMyEqB5FYmER2TC0Bg2nWpee/ZUKWTyn2z
	g2OrpY4ylzK3livvqQsmDxvIVP07P8fA=
X-Gm-Gg: AYBFou3rtb3JHEpCy23Q0jer3fr4334d7TminsI0xt07sOAQ7sO+9LWarnh1Nzvz6jI
	vhOTKOBP6j+Ahtc6yWhJFszZn+ZHs68RrrEF9xigcLNCPDzufnz6vRR2i3F4XRpbTx+Xrlc3dst
	E3cvAapDVXtEVTH0yayoP29oZt3av2cuEypPuIPsfH20C0uOCPIcqZAAmIQj0v58Pk1UizI0GKE
	8cAauGULazBzD2Njn+i+USvrk2vEup4nhIKSSLlFmT4XYq5BzgOptR5AdWuAOnXZ0HrfV3MQZsz
	bqrUi/c5bXk2IRuLfYeSkKoXBqbNiJXboKHopufpzAXYHyRMCRbBxo0S9UFq6cr8XQhZ4ppG2Lf
	QnO6LyUZS8kC+gX0m2IJVkiegFSeFessTcQLca2lJsg==
X-Received: by 2002:a05:690e:d47:b0:66f:c1bc:4058 with SMTP id
 956f58d0204a3-671138a07cdmr1506047d50.32.1789060617071; Thu, 10 Sep 2026
 10:16:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789058875.git.pav@iki.fi> <7644e092347c63f2777c86ac687eb2cb01c3c6c8.1789058875.git.pav@iki.fi>
In-Reply-To: <7644e092347c63f2777c86ac687eb2cb01c3c6c8.1789058875.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 10 Sep 2026 13:16:45 -0400
X-Gm-Features: AcwNN1WYj9kGK5n3a88LTxeN28ueOaZIvDJGSFY6yrT1HndeWoiC565AI24do7w
Message-ID: <CABBYNZJ3W4tybBhUfB8x+ucw_N=3ac77WTUUu9-OOojY=StZsQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] tools: test-runner: use virtiofsd for
 filesystem passthrough
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Thu, Sep 10, 2026 at 1:10=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> The 9p mount passthrough I/O is fairly CPU hungry and slow. This matters
> for e.g. running Python in test-runner, since it has to read some amount
> of files for startup.
>
> Add support for virtio-fs, which is significantly less CPU intensive.
>
> Enable it by default if /usr/libexec/virtiofsd is available, fall back
> to 9p if virtiofsd not usable.
>
> Before:
> $ time make check-functional
> real    2m9,736s
> user    1m29,570s
> sys     0m32,715s
>
> After:
> $ time make check-functional
> real    1m35,703s
> user    0m28,938s
> sys     0m7,453s
> ---
>  doc/test-runner.rst |   3 +
>  tools/test-runner.c | 210 +++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 199 insertions(+), 14 deletions(-)
>
> diff --git a/doc/test-runner.rst b/doc/test-runner.rst
> index 6787507c3..ac8f22c19 100644
> --- a/doc/test-runner.rst
> +++ b/doc/test-runner.rst
> @@ -26,6 +26,7 @@ OPTIONS
>  :-P/--pcie=3D<qemu_args>: Provide PCIe device
>  :-q/--qemu=3D<path>: QEMU binary
>  :-k/--kernel=3D<image>: Kernel image (bzImage)
> +:-F/--virtiofs=3D<virtiofsd / no>: Enable/disable use of virtio-fs.
>  :-h/--help: Show help options
>
>  Kernel
> @@ -47,6 +48,8 @@ option (like the Bluetooth subsystem) can be enabled on=
 top of this.
>         CONFIG_VIRTIO=3Dy
>         CONFIG_VIRTIO_PCI=3Dy
>         CONFIG_VIRTIO_CONSOLE=3Dy
> +       CONFIG_VIRTIO_FS=3Dy
> +       CONFIG_FUSE_FS=3Dy
>
>         CONFIG_NET=3Dy
>         CONFIG_INET=3Dy
> diff --git a/tools/test-runner.c b/tools/test-runner.c
> index 63fedece0..d6589f7a9 100644
> --- a/tools/test-runner.c
> +++ b/tools/test-runner.c
> @@ -64,6 +64,7 @@ static char *usb_dev;
>  static char *pcie_dev;
>  static char *extra_opts[EXTRA_OPT_MAX];
>  static int num_extra_opts;
> +static const char *virtiofsd =3D "/usr/libexec/virtiofsd";
>
>  static const char *qemu_table[] =3D {
>         "qemu-system-x86_64",
> @@ -235,9 +236,6 @@ static char *const qemu_argv[] =3D {
>         "-m", "256M",
>         "-net", "none",
>         "-no-reboot",
> -       "-fsdev", "local,id=3Dfsdev-root,path=3D/,readonly=3Don,security_=
model=3Dnone,"
> -       "multidevs=3Dremap",
> -       "-device", "virtio-9p-pci,fsdev=3Dfsdev-root,mount_tag=3D/dev/roo=
t",
>         "-chardev", "stdio,id=3Dcon,mux=3Don",
>         "-serial", "chardev:con",
>         "-device", "virtio-serial",
> @@ -495,6 +493,98 @@ static void pcie_unbind_vfio(void)
>         pcie_probe(pcie_bdf);
>  }
>
> +static bool check_virtiofsd(void)
> +{
> +       if (!virtiofsd)
> +               return false;
> +
> +       if (access(virtiofsd, X_OK)) {
> +               fprintf(stderr, "%s not available", virtiofsd);
> +               return false;
> +       }
> +
> +       return true;
> +}
> +
> +static pid_t start_virtiofsd(const char *tmpdir)
> +{
> +       pid_t pid;
> +       char path[PATH_MAX];
> +       struct stat st;
> +
> +       printf("Using virtiofsd %s\n", virtiofsd);
> +
> +       snprintf(path, sizeof(path), "%s/virtiofs", tmpdir);
> +
> +       pid =3D fork();
> +       if (pid < 0)
> +               return pid;
> +
> +       if (pid =3D=3D 0) {
> +               char *envp[1];
> +               const char *cmd[] =3D {
> +                       virtiofsd,
> +                       "--socket-path", path,
> +                       "--shared-dir", "/",
> +                       "--readonly",
> +                       "--tag", "/dev/root",
> +                       /* Drop unnecessary capabilities, if run as root =
*/
> +                       "--modcaps=3D-chown:-dac_override:-fowner:-fsetid=
:"
> +                                       "-setgid:-setuid:-mknod:-setfcap"=
,
> +                       /*
> +                        * Disabling namespace sandbox is needed to allow=
 the
> +                        * guest to mount other virtio/9p filesystems.
> +                        */
> +                       "--sandbox", "none",
> +                       NULL
> +               };
> +
> +               envp[0] =3D NULL;
> +               execve(cmd[0], (char **)cmd, envp);
> +               exit(EXIT_SUCCESS);
> +       }
> +
> +       while (1) {
> +               int status;
> +               pid_t ret;
> +
> +               if (!stat(path, &st))
> +                       break;
> +
> +               ret =3D waitpid(pid, &status, WNOHANG);
> +               if (ret < 0 && errno =3D=3D -EINTR)
> +                       continue;
> +               else if (ret)
> +                       return -EIO;
> +
> +               sleep(1);
> +       }
> +
> +       return pid;
> +}
> +
> +static void cleanup_virtiofsd(pid_t pid, const char *tmpdir)
> +{
> +       char path[PATH_MAX];
> +       int status;
> +
> +       if (pid > 0) {
> +               kill(pid, SIGTERM);
> +               while (waitpid(pid, &status, 0) < 0) {
> +                       if (errno !=3D EINTR)
> +                               break;
> +               }
> +       }
> +
> +       if (tmpdir[0]) {
> +               snprintf(path, sizeof(path), "%s/virtiofs", tmpdir);
> +               unlink(path);
> +               snprintf(path, sizeof(path), "%s/virtiofs.pid", tmpdir);
> +               unlink(path);
> +               rmdir(tmpdir);
> +       }
> +}
> +
>  static pid_t qemu_pid;
>
>  /* Forwards the signal to QEMU so it can shutdown, the host driver is th=
en
> @@ -509,10 +599,13 @@ static void qemu_signal(int sig)
>  static int start_qemu(void)
>  {
>         char cwd[PATH_MAX/2], initcmd[PATH_MAX], testargs[PATH_MAX];
> +       const char *fscmdline;
>         char cmdline[CMDLINE_MAX];
> +       char tmpdir[PATH_MAX] =3D {0};
>         char **argv;
>         int i, pos, status =3D 0;
>         pid_t pid;
> +       pid_t virtiofsd_pid =3D -1;
>
>         check_virtualization();
>
> @@ -539,15 +632,20 @@ static int start_qemu(void)
>                 pos +=3D n;
>         }
>
> +       if (!virtiofsd)
> +               fscmdline =3D "rootfstype=3D9p "
> +                               "rootflags=3Dtrans=3Dvirtio,version=3D9p2=
000.u";
> +       else
> +               fscmdline =3D "rootfstype=3Dvirtiofs root=3D/dev/root";
> +
>         snprintf(cmdline, sizeof(cmdline),
>                                 "console=3Dhvc0 earlyprintk=3Dserial "
> -                               "no_hash_pointers=3D1 rootfstype=3D9p "
> -                               "rootflags=3Dtrans=3Dvirtio,version=3D9p2=
000.u "
> -                               "%s quiet ro init=3D%s "
> +                               "no_hash_pointers=3D1 %s %s quiet ro init=
=3D%s "
>                                 "TESTHOME=3D%s TESTDBUS=3D%u TESTDAEMON=
=3D%u "
>                                 "TESTDBUSSESSION=3D%u XDG_RUNTIME_DIR=3D/=
run/user/0 "
>                                 "TESTMONITOR=3D%u TESTEMULATOR=3D%u TESTD=
EVS=3D%d "
>                                 "TESTAUTO=3D%u TESTAUDIO=3D'%s' TESTARGS=
=3D\'%s\'",
> +                               fscmdline,
>                                 /* PCIe passthrough requires ACPI and API=
C for
>                                  * device enumeration and MSI interrupts.
>                                  */
> @@ -559,6 +657,7 @@ static int start_qemu(void)
>                                 testargs);
>
>         argv =3D alloca(sizeof(qemu_argv) +
> +                       sizeof(char *) * 8 +
>                         (sizeof(char *) * (8 + (num_devs * 4))) +
>                         (sizeof(char *) * (usb_dev ? 4 : 0)) +
>                         (sizeof(char *) * (pcie_dev ? 2 : 0)) +
> @@ -567,6 +666,60 @@ static int start_qemu(void)
>
>         pos =3D (sizeof(qemu_argv) / sizeof(char *)) - 1;
>
> +       if (!virtiofsd) {
> +               argv[pos++] =3D "-fsdev";
> +               argv[pos++] =3D "local,id=3Dfsdev-root,path=3D/,readonly=
=3Don,"
> +                               "security_model=3Dnone,multidevs=3Dremap"=
;
> +               argv[pos++] =3D "-device";
> +               argv[pos++] =3D "virtio-9p-pci,fsdev=3Dfsdev-root,"
> +                               "mount_tag=3D/dev/root";
> +       } else {
> +               char *chrdev;
> +               const char *tmp_base;
> +               const char *mem =3D "256M";
> +               char *memdev;
> +
> +               tmp_base =3D getenv("TMPDIR");
> +               if (!tmp_base)
> +                       tmp_base =3D "/tmp";
> +
> +               snprintf(tmpdir, sizeof(tmpdir), "%s/bluez-test-runner.XX=
XXXX",
> +                                                               tmp_base)=
;
> +               if (!mkdtemp(tmpdir)) {
> +                       perror("mkdtemp failed");
> +                       return EXIT_FAILURE;
> +               }
> +
> +               chrdev =3D alloca(48 + strlen(tmpdir));
> +               sprintf(chrdev, "socket,id=3Dvirtiofs0,path=3D%s/virtiofs=
", tmpdir);
> +
> +               argv[pos++] =3D "-chardev";
> +               argv[pos++] =3D chrdev;
> +               argv[pos++] =3D "-device";
> +               argv[pos++] =3D "vhost-user-fs-pci,queue-size=3D1024,"
> +                                       "chardev=3Dvirtiofs0,tag=3D/dev/r=
oot";
> +
> +               /* Find out memory size */
> +               for (i =3D 0; i < pos; ++i) {
> +                       if (strcmp(argv[i], "-m") =3D=3D 0 && i + 1 < pos=
)
> +                               mem =3D argv[i+1];
> +               }
> +               for (i =3D 0; i < num_extra_opts; ++i) {
> +                       if (strcmp(extra_opts[i], "-m") =3D=3D 0 &&
> +                                                       i + 1 < num_extra=
_opts)
> +                               mem =3D extra_opts[i+1];
> +               }
> +
> +               memdev =3D alloca(48 + strlen(mem));
> +               sprintf(memdev, "memory-backend-memfd,id=3Dmem0,size=3D%s=
,share=3Don",
> +                                                                       m=
em);
> +
> +               argv[pos++] =3D "-object";
> +               argv[pos++] =3D memdev;
> +               argv[pos++] =3D "-numa";
> +               argv[pos++] =3D "node,memdev=3Dmem0";
> +       }

There quite a lot of code being added to this function, perhaps it
should be placed into a helper function that init the args for the
filesystem of choice.

>         /* Make sure qemu_binary is not null */
>         if (!qemu_binary) {
>                 fprintf(stderr, "No QEMU binary is set\n");
> @@ -616,21 +769,29 @@ static int start_qemu(void)
>
>         argv[pos] =3D NULL;
>
> -       if (!pcie_dev) {
> +       /* Exec directly if no setup/cleanup needed */
> +       if (!pcie_dev && !virtiofsd) {
>                 execve(argv[0], argv, qemu_envp);
>                 return EXIT_FAILURE;
>         }
>
> -       /* With a device passed through the host driver has to be restore=
d
> -        * once the guest is done with it, so QEMU cannot simply replace =
this
> -        * process here.
> -        */
> -       pcie_bind_vfio();
> +       if (virtiofsd) {
> +               virtiofsd_pid =3D start_virtiofsd(tmpdir);
> +               if (virtiofsd_pid < 0) {
> +                       perror("Failed to start virtiofsd");
> +                       cleanup_virtiofsd(virtiofsd_pid, tmpdir);
> +                       return EXIT_FAILURE;
> +               }
> +       }
> +
> +       if (pcie_dev)
> +               pcie_bind_vfio();
>
>         pid =3D fork();
>         if (pid < 0) {
>                 perror("Failed to fork new process");
>                 pcie_unbind_vfio();
> +               cleanup_virtiofsd(virtiofsd_pid, tmpdir);
>                 return EXIT_FAILURE;
>         }
>
> @@ -655,7 +816,11 @@ static int start_qemu(void)
>
>         qemu_pid =3D -1;
>
> -       pcie_unbind_vfio();
> +       if (pcie_dev)
> +               pcie_unbind_vfio();
> +
> +       if (virtiofsd)
> +               cleanup_virtiofsd(virtiofsd_pid, tmpdir);
>
>         return WIFEXITED(status) ? WEXITSTATUS(status) : EXIT_FAILURE;
>  }
> @@ -1524,6 +1689,7 @@ static void usage(void)
>                 "\t-q, --qemu <path>      QEMU binary\n"
>                 "\t-H, --qemu-host-cpu    Use host CPU (requires KVM supp=
ort)\n"
>                 "\t-k, --kernel <image>   Kernel bzImage or source tree p=
ath\n"
> +               "\t-F, --virtiofs[=3Dno / virtiofsd] Virtiofsd disable / =
path\n"
>                 "\t-o, --option <opt>     Additional argument passed to Q=
EMU\n"
>                 "\t-h, --help             Show help options\n");
>  }
> @@ -1544,6 +1710,7 @@ static const struct option main_options[] =3D {
>         { "usb",     required_argument, NULL, 'U' },
>         { "pcie",    required_argument, NULL, 'P' },
>         { "option",  required_argument, NULL, 'o' },
> +       { "virtiofs", optional_argument, NULL, 'F' },
>         { "version", no_argument,       NULL, 'v' },
>         { "help",    no_argument,       NULL, 'h' },
>         { }
> @@ -1552,6 +1719,7 @@ static const struct option main_options[] =3D {
>  int main(int argc, char *argv[])
>  {
>         char kernel_path[PATH_MAX];
> +       bool virtiofs_auto =3D true;
>
>         if (getpid() =3D=3D 1 && getppid() =3D=3D 0) {
>                 prepare_sandbox();
> @@ -1565,7 +1733,7 @@ int main(int argc, char *argv[])
>         for (;;) {
>                 int opt;
>
> -               opt =3D getopt_long(argc, argv, "au::bdsl::mq:Hk:A::U:P:o=
:vh",
> +               opt =3D getopt_long(argc, argv, "au::bdsl::mq:Hk:A::U:P:o=
:F::vh",
>                                                 main_options, NULL);
>                 if (opt < 0)
>                         break;
> @@ -1620,6 +1788,15 @@ int main(int argc, char *argv[])
>                         }
>                         extra_opts[num_extra_opts++] =3D optarg;
>                         break;
> +               case 'F':
> +                       virtiofs_auto =3D false;
> +                       if (optarg) {
> +                               if (strcmp(optarg, "no") =3D=3D 0)
> +                                       virtiofsd =3D NULL;
> +                               else
> +                                       virtiofsd =3D optarg;
> +                       }
> +                       break;
>                 case 'v':
>                         printf("%s\n", VERSION);
>                         return EXIT_SUCCESS;
> @@ -1631,6 +1808,11 @@ int main(int argc, char *argv[])
>                 }
>         }
>
> +       if (virtiofs_auto && !check_virtiofsd()) {
> +               fprintf(stderr, ": virtiofs disabled\n");
> +               virtiofsd =3D NULL;
> +       }
> +
>         if (run_auto) {
>                 if (argc - optind > 0) {
>                         fprintf(stderr, "Invalid command line parameters\=
n");
> --
> 2.55.0
>
>


--=20
Luiz Augusto von Dentz

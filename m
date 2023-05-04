Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804C2C7EE21
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 May 2023 19:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjEDTLN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 May 2023 15:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjEDTKx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 May 2023 15:10:53 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7509ECC
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 May 2023 12:10:27 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2ac7f53ae44so10303791fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 May 2023 12:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683227368; x=1685819368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGzjRcSHniXPWgoBx2+lAk6Ano53VaWINvyow2Vqv7A=;
        b=K8AJ4rl8xPQQo8jAqgwscY+IiK5s0mNxT1hlbhJSOfUyPYO5p8vQDF9zv0ZkCX1MP2
         T3IWXBNHuS6xTQstMFtnsEDq7/XJ/zhKBwl2hGo84VvEmYCLZmvv82MEt8K+L1Hlwd4g
         wy9ja5LXLybXh5MoBwGZn6Wf7K7BTRsIfivKK/NGRE4etXI9TXydSS1c+fFO6WUhK+0h
         PhVCn+0rr7+BRrttsz6o/d5eXOQ9eX0lRP9Vk5fPJP2fEx9HdxVNH8hucl3i1vFujX91
         ffFfEMk6VeDx68WLkImbzN1YVk1k746ZgdsE2XurUqcmbuHTU9R08mXmg6pCM+QNH7si
         ikog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683227368; x=1685819368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGzjRcSHniXPWgoBx2+lAk6Ano53VaWINvyow2Vqv7A=;
        b=FN29KehA2/qbtnb5S/TnhHOarW3de+2O0L2H/bPpszqKH+9x+gg4M0qGQIaJH64C4K
         hCDyGusBrmcmwlWk5e4BCauh6sMADDMP9KwUKWG9WvhyiztRcnlg0fE32zaE99HKfatF
         Zz+INIowOANhAoXdzVj2H36vpqcoPp9UXewdgrtNs/FLlCRvuGW7NHDRcaeufY5aalau
         hWPDkcXUJXOfvTmpvtavEkbiorpJdnAbUCLTjwMBfjTqCD1Huyr7SPjRB3UAZsuDgzS4
         DCe2CF4vCb69bU2FL4wdj8fQNCGqCze8S4UQibTDjWexYq7cnTgY9lYQSgf/4rxqKI37
         6LaA==
X-Gm-Message-State: AC+VfDx8UOyBUBouFFpKugiS3xujvUCObBZW04A+Vi7+oYRJLwM/1FUn
        jgpW8PSrg6x9X6BLLK3Xp68My1FtQzOg1NJiQimAZCpL
X-Google-Smtp-Source: ACHHUZ64yE9UrJ4g8mjUFMFChV/K5PG+pJrSpNQ6vw50VmuGNeU5VbNcTjRuTF4Lwoss1PR91Dk3422o76hj4vAUVM8=
X-Received: by 2002:a2e:8054:0:b0:2ab:5bee:affc with SMTP id
 p20-20020a2e8054000000b002ab5beeaffcmr1264482ljg.21.1683227368334; Thu, 04
 May 2023 12:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <48701651ef435518ac8432d80dfdc2dfe80f3703.1681569400.git.pav@iki.fi>
 <CABBYNZL9C1cF7vTLobVhZ3_HxhDv7zsobB5NcWonPOwz_Rz+jw@mail.gmail.com> <1bc7d31d989fbdfb0d14897b6ca14a31310546f5.camel@iki.fi>
In-Reply-To: <1bc7d31d989fbdfb0d14897b6ca14a31310546f5.camel@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 4 May 2023 12:09:14 -0700
Message-ID: <CABBYNZLDR=LBRFXmHU98nd88Q_fUZXfneNyVbge0JAcTP8G8Rw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] tools/test-runner: add option to start Pipewire
 inside the VM
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Sat, Apr 22, 2023 at 5:12=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> to, 2023-04-20 kello 12:49 -0700, Luiz Augusto von Dentz kirjoitti:
> > Hi Pauli,
> >
> > On Sat, Apr 15, 2023 at 7:44=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wro=
te:
> > >
> > > Add option for launching Pipewire inside the VM to serve Bluetooth
> > > endpoints, which can be used in tests.
> > >
> > > If daemon and emulator were also started, wait for the endpoints to
> > > appear.
> > > ---
> > >
> > > Notes:
> > >     An example how you can launch Pipewire to serve Bluetooth endpoin=
ts.
> > >
> > >  tools/test-runner.c | 247 ++++++++++++++++++++++++++++++++++++++++++=
+-
> > >  1 file changed, 242 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/tools/test-runner.c b/tools/test-runner.c
> > > index 6660ea8de..d416f80ed 100644
> > > --- a/tools/test-runner.c
> > > +++ b/tools/test-runner.c
> > > @@ -51,6 +51,7 @@ static bool start_dbus_session;
> > >  static bool start_daemon =3D false;
> > >  static bool start_emulator =3D false;
> > >  static bool start_monitor =3D false;
> > > +static bool start_pipewire;
> > >  static int num_devs =3D 0;
> > >  static const char *qemu_binary =3D NULL;
> > >  static const char *kernel_image =3D NULL;
> > > @@ -252,13 +253,13 @@ static void start_qemu(void)
> > >                                 "acpi=3Doff pci=3Dnoacpi noapic quiet=
 ro init=3D%s "
> > >                                 "TESTHOME=3D%s TESTDBUS=3D%u TESTDAEM=
ON=3D%u "
> > >                                 "TESTDBUSSESSION=3D%u XDG_RUNTIME_DIR=
=3D/run/user/0 "
> > > -                               "TESTAUDIO=3D%u "
> > > +                               "TESTAUDIO=3D%u TESTPIPEWIRE=3D%u "
> >
> > I'd just reuse TESTAUDIO instead of introducing yet another
> > environment variable, that should probably check if it shall run
> > pulseaudio or pipewire depending on what is available in the system.
>
> TESTAUDIO also adds a virtual soundcard to the VM. Is this needed for
> something, if tests and the audio daemon runs inside the VM they should
> not need such access to soundcards outside the VM?
>
> The tester.config doesn't enable ALSA, so it won't do anything in that
> configuration. The VM also fails to boot for me with -A enabled for
> that kernel.
>
> IIUC, this and running udevd are not currently used for something, and
> if so I'll remove those.

Yep, please remove/replace with something that doesn't depend on ALSA.

> >
> > >                                 "TESTMONITOR=3D%u TESTEMULATOR=3D%u T=
ESTDEVS=3D%d "
> > >                                 "TESTAUTO=3D%u TESTARGS=3D\'%s\'",
> > >                                 initcmd, cwd, start_dbus, start_daemo=
n,
> > >                                 start_dbus_session, audio_support,
> > > -                               start_monitor, start_emulator, num_de=
vs,
> > > -                               run_auto, testargs);
> > > +                               start_pipewire, start_monitor, start_=
emulator,
> > > +                               num_devs, run_auto, testargs);
> > >
> > >         argv =3D alloca(sizeof(qemu_argv) +
> > >                                 (audio_support ? 4 : 0) +
> > > @@ -606,6 +607,207 @@ static pid_t start_bluetooth_daemon(const char =
*home)
> > >         return pid;
> > >  }
> > >
> > > +static char *get_command_stdout(char *command, size_t *size)
> > > +{
> > > +       char *buf =3D NULL;
> > > +       ssize_t nread =3D 0;
> > > +       size_t allocated =3D 0;
> > > +       int ret;
> > > +       FILE *f;
> > > +
> > > +       f =3D popen(command, "re");
> > > +       if (!f)
> > > +               return NULL;
> > > +
> > > +       while (1) {
> > > +               size_t res;
> > > +               void *p;
> > > +
> > > +               if (nread + 256 > allocated) {
> > > +                       allocated +=3D allocated + 256;
> > > +                       p =3D realloc(buf, allocated);
> > > +                       if (!p) {
> > > +                               nread =3D -1;
> > > +                               break;
> > > +                       }
> > > +                       buf =3D p;
> > > +               }
> > > +
> > > +               res =3D fread(buf + nread, 1, allocated - nread - 1, =
f);
> > > +               if (!res)
> > > +                       break;
> > > +               nread +=3D res;
> > > +       }
> > > +
> > > +       ret =3D pclose(f);
> > > +       if (ret < 0 || !WIFEXITED(ret) || WEXITSTATUS(ret) !=3D 0) {
> > > +               printf("%s failed\n", command);
> > > +               nread =3D -1;
> > > +       }
> > > +
> > > +       if (nread >=3D 0) {
> > > +               buf[nread] =3D 0;
> > > +               if (size)
> > > +                       *size =3D nread;
> > > +       } else {
> > > +               free(buf);
> > > +               buf =3D NULL;
> > > +       }
> > > +
> > > +       return buf;
> > > +}
> > > +
> > > +static void start_pipewire_daemons(pid_t *pipewire_pid, pid_t *wirep=
lumber_pid)
> > > +{
> > > +       static const char *const daemons[2] =3D {
> > > +               "/usr/bin/pipewire",
> > > +               "/usr/bin/wireplumber"
> > > +       };
> > > +       static const char *const dirs[] =3D {
> > > +               "/run/pw",
> > > +               "/run/pw/state",
> > > +               "/run/pw/wireplumber",
> > > +               "/run/pw/wireplumber/bluetooth.lua.d",
> > > +               "/run/pw/wireplumber/main.lua.d",
> > > +               NULL
> > > +       };
> > > +       FILE *f;
> > > +       pid_t *pids[2] =3D {pipewire_pid, wireplumber_pid};
> > > +       char *envp[5];
> > > +       int i;
> > > +
> > > +       for (i =3D 0; dirs[i]; ++i) {
> > > +               if (mkdir(dirs[i], 0755) < 0) {
> > > +                       perror("Failed to create directory");
> > > +                       return;
> > > +               }
> > > +       }
> > > +
> > > +       /* Enable only Bluetooth part, disable whatever requires user=
 DBus */
> > > +       f =3D fopen("/run/pw/wireplumber/main.lua.d/51-custom.lua", "=
w");
> > > +       if (!f) {
> > > +               perror("Failed to create Pipewire main config");
> > > +               return;
> > > +       }
> > > +       fprintf(f, "alsa_monitor.enabled =3D false\n"
> > > +               "v4l2_monitor.enabled =3D false\n"
> > > +               "libcamera_monitor.enabled =3D false\n"
> > > +               "default_access.properties[\"enable-flatpak-portal\"]=
"
> > > +               " =3D false\n");
> > > +       fclose(f);
> >
> > I'd put this into its own function to make it clear that this is
> > setting up the configuration e.g.:
> >
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/test-runn=
er.c#n450
> >
> > > +       f =3D fopen("/run/pw/wireplumber/bluetooth.lua.d/51-custom.lu=
a", "w");
> > > +       if (!f) {
> > > +               perror("Failed to create Pipewire bluetooth config");
> > > +               return;
> > > +       }
> > > +       fprintf(f, "bluez_monitor.properties[\"with-logind\"] =3D fal=
se\n"
> > > +               "bluez_midi_monitor.enabled =3D false\n");
> > > +       fclose(f);
> > > +
> > > +       /* Launch daemons */
> > > +       for (i =3D 0; i < 2; ++i)
> > > +               *pids[i] =3D -1;
> > > +
> > > +       envp[0] =3D "DBUS_SYSTEM_BUS_ADDRESS=3Dunix:"
> > > +                 "path=3D/run/dbus/system_bus_socket";
> > > +       envp[1] =3D "XDG_STATE_HOME=3D/run/pw/state";
> > > +       envp[2] =3D "XDG_CONFIG_HOME=3D/run/pw";
> > > +       envp[3] =3D "XDG_RUNTIME_DIR=3D/run/pw";
> > > +       envp[4] =3D NULL;
> > > +
> > > +       for (i =3D 0; i < 2; ++i) {
> > > +               const char *daemon =3D daemons[i];
> > > +               char *argv[2];
> > > +               pid_t pid;
> > > +
> > > +               printf("Starting Pipewire daemon %s\n", daemon);
> > > +
> > > +               argv[0] =3D (char *) daemon;
> > > +               argv[1] =3D NULL;
> > > +
> > > +               pid =3D fork();
> > > +               if (pid < 0) {
> > > +                       perror("Failed to fork new process");
> > > +                       return;
> > > +               }
> > > +
> > > +               if (pid =3D=3D 0) {
> > > +                       execve(argv[0], argv, envp);
> > > +                       exit(EXIT_SUCCESS);
> > > +               }
> > > +
> > > +               *pids[i] =3D pid;
> > > +
> > > +               printf("Pipewire daemon process %d created\n", pid);
> > > +       }
> > > +
> > > +       /* Tell pipewire clients where the socket is */
> > > +       setenv("PIPEWIRE_RUNTIME_DIR", "/run/pw", 1);
> > > +
> > > +       /* Wait until daemons completely started */
> > > +       for (i =3D 0; i < 6; ++i) {
> > > +               char *buf;
> > > +
> > > +               if (i > 0) {
> > > +                       printf("Wait for Pipewire ready...\n");
> > > +                       usleep(500000);
> > > +               }
> > > +
> > > +               buf =3D get_command_stdout("/usr/bin/pw-dump", NULL);
> > > +               if (!buf)
> > > +                       continue;
> >
> > Don't we have a file or something similar to
> > /run/dbus/system_bus_socket that indicates pw is running? Checking
> > dump file seems a little overkill to me.
>
> You can stat for /run/pipewire-0
>
> The daemon running doesn't mean you have a sound devices yet, though,
> so if tests need them they need to wait for them themselves.

We could perhaps wait to see if Pipewire name popup on D-Bus, but I'd
leave that for a later stage when we actually have some tests that
depend on Pipewire directly.

> >
> > > +
> > > +               if (strstr(buf, "WirePlumber")) {
> > > +                       printf("Pipewire ready\n");
> > > +                       free(buf);
> > > +                       break;
> > > +               }
> > > +
> > > +               free(buf);
> > > +       }
> > > +       if (i =3D=3D 6)
> > > +               goto fail;
> > > +
> > > +       if (!start_emulator || !start_daemon)
> > > +               return;
> > > +
> > > +       /* Wait for Bluetooth endpoints */
> > > +       for (i =3D 0; i < 6; ++i) {
> > > +               char *buf;
> > > +
> > > +               if (i > 0) {
> > > +                       printf("Wait for endpoints...\n");
> > > +                       usleep(500000);
> > > +               }
> > > +
> > > +               buf =3D get_command_stdout("/usr/bin/bluetoothctl sho=
w", NULL);
> > > +               if (!buf)
> > > +                       continue;
> > > +
> > > +               if (strstr(buf, "0000110b-0000-1000-8000-00805f9b34fb=
") ||
> > > +                   strstr(buf, "00001850-0000-1000-8000-00805f9b34fb=
")) {
> > > +                       printf("Pipewire endpoints ready\n");
> > > +                       free(buf);
> > > +                       break;
> > > +               }
> > > +
> > > +               free(buf);
> > > +       }
> > > +       if (i =3D=3D 6)
> > > +               goto fail;
> >
> > Id skip this part, the endpoints registration depends on how
> > bluetoothd:main.conf  is configured so we shouldn't really expect
> > certain UUIDs like above.
>
> Ok, in principle the tests that need endpoints can wait for them.

Let me know if you need more feedback on anything, also what is the
status of coordinated set setup? Did you get it working or there are
still some blockers?

> >
> > > +       return;
> > > +
> > > +fail:
> > > +       for (i =3D 0; i < 2; ++i)
> > > +               if (*pids[i] > 0)
> > > +                       kill(*pids[i], SIGTERM);
> > > +
> > > +       printf("Pipewire daemons not running properly\n");
> > > +       return;
> > > +}
> > > +
> > >  static const char *test_table[] =3D {
> > >         "mgmt-tester",
> > >         "smp-tester",
> > > @@ -807,7 +1009,7 @@ static void run_command(char *cmdname, char *hom=
e)
> > >         int pos =3D 0, idx =3D 0;
> > >         int serial_fd;
> > >         pid_t pid, dbus_pid, daemon_pid, monitor_pid, emulator_pid,
> > > -             dbus_session_pid, udevd_pid;
> > > +             dbus_session_pid, udevd_pid, pw_pid, wp_pid;
> > >
> > >         if (!home) {
> > >                 perror("Invalid parameter: TESTHOME");
> > > @@ -860,6 +1062,13 @@ static void run_command(char *cmdname, char *ho=
me)
> > >         else
> > >                 emulator_pid =3D -1;
> > >
> > > +       if (start_pipewire) {
> > > +               start_pipewire_daemons(&pw_pid, &wp_pid);
> > > +       } else {
> > > +               pw_pid =3D -1;
> > > +               wp_pid =3D -1;
> > > +       }
> > > +
> > >  start_next:
> > >         if (run_auto) {
> > >                 if (chdir(home + 5) < 0) {
> > > @@ -966,6 +1175,16 @@ start_next:
> > >                         udevd_pid =3D -1;
> > >                 }
> > >
> > > +               if (corpse =3D=3D pw_pid) {
> > > +                       printf("pipewire terminated\n");
> > > +                       pw_pid =3D -1;
> > > +               }
> > > +
> > > +               if (corpse =3D=3D wp_pid) {
> > > +                       printf("wireplumber terminated\n");
> > > +                       wp_pid =3D -1;
> > > +               }
> > > +
> > >                 if (corpse =3D=3D pid)
> > >                         break;
> > >         }
> > > @@ -975,6 +1194,12 @@ start_next:
> > >                 goto start_next;
> > >         }
> > >
> > > +       if (wp_pid > 0)
> > > +               kill(wp_pid, SIGTERM);
> > > +
> > > +       if (pw_pid > 0)
> > > +               kill(pw_pid, SIGTERM);
> > > +
> > >         if (daemon_pid > 0)
> > >                 kill(daemon_pid, SIGTERM);
> > >
> > > @@ -1079,6 +1304,12 @@ static void run_tests(void)
> > >                 audio_support =3D true;
> > >         }
> > >
> > > +       ptr =3D strstr(cmdline, "TESTPIPEWIRE=3D1");
> > > +       if (ptr) {
> > > +               printf("Pipewire requested\n");
> > > +               start_pipewire =3D true;
> > > +       }
> > > +
> > >         ptr =3D strstr(cmdline, "TESTHOME=3D");
> > >         if (ptr) {
> > >                 home =3D ptr + 4;
> > > @@ -1106,6 +1337,7 @@ static void usage(void)
> > >                 "\t-q, --qemu <path>      QEMU binary\n"
> > >                 "\t-k, --kernel <image>   Kernel image (bzImage)\n"
> > >                 "\t-A, --audio            Add audio support\n"
> > > +               "\t-P, --pipewire         Start pipewire\n"
> > >                 "\t-h, --help             Show help options\n");
> > >  }
> > >
> > > @@ -1121,6 +1353,7 @@ static const struct option main_options[] =3D {
> > >         { "qemu",    required_argument, NULL, 'q' },
> > >         { "kernel",  required_argument, NULL, 'k' },
> > >         { "audio",   no_argument,       NULL, 'A' },
> > > +       { "pipewire", no_argument,      NULL, 'P' },
> > >         { "version", no_argument,       NULL, 'v' },
> > >         { "help",    no_argument,       NULL, 'h' },
> > >         { }
> > > @@ -1140,7 +1373,7 @@ int main(int argc, char *argv[])
> > >         for (;;) {
> > >                 int opt;
> > >
> > > -               opt =3D getopt_long(argc, argv, "aubdslmq:k:Avh", mai=
n_options,
> > > +               opt =3D getopt_long(argc, argv, "aubdslmq:k:APvh", ma=
in_options,
> > >                                                                 NULL)=
;
> > >                 if (opt < 0)
> > >                         break;
> > > @@ -1177,6 +1410,10 @@ int main(int argc, char *argv[])
> > >                 case 'A':
> > >                         audio_support =3D true;
> > >                         break;
> > > +               case 'P':
> > > +                       start_dbus =3D true;
> > > +                       start_pipewire =3D true;
> > > +                       break;
> > >                 case 'v':
> > >                         printf("%s\n", VERSION);
> > >                         return EXIT_SUCCESS;
> > > --
> > > 2.39.2
> > >
> >
> >
>


--=20
Luiz Augusto von Dentz

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38ADCC77B73
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Apr 2023 19:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjDTTt5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Apr 2023 15:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbjDTTtx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Apr 2023 15:49:53 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7554C26
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Apr 2023 12:49:51 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4ec8399e963so814135e87.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Apr 2023 12:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682020190; x=1684612190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VKIiQSQRWx0gqrLMikcJGQfvJG0CSHFCiJP7btctwc=;
        b=Hrjfd4p7+e0uRQmxtHbYOHdTmlwVJiGnMt/cXz11cHxowi9vJJoYI0VI8tl+1KToGt
         Vkg0B+QJ22wJv1NNL5Y6nBX1em1jrd08PURlWChoymJ1e+50mMFYpX4bGTFgkTQhUHd5
         wtaTK+ujBN52ZYqUQtkqVMcWpCxjU0eKl7VgcotkwqqwlIj3yAN/ICey0/yI1WjM2fYn
         7Rck/Yzsmc2SyMU2wZBOif8zw9x1WBEYbXQRFmO/vCJzr+bs3ie9r5eJGyRsc73j0FC/
         dzvAh9T7DdaM+IZkFzIr0pYQH9pu63Tk5Sd/VVldIaJjxaAaLwNPFXvizXEB7OERBNJe
         RZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682020190; x=1684612190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0VKIiQSQRWx0gqrLMikcJGQfvJG0CSHFCiJP7btctwc=;
        b=W+SdZHbHs18b5yJtDOqwM/DDEIGHM0rSm9wn0YL3R+uwiCZWw05BPzLkV+Y/G692gU
         CAxgN610VydKpiO/m8TD1zuRa8HuGbnSkXT4gcu/M5xsxBMxVweddUGC7ru3FaIvOkPo
         6EJNXnHPp7rruzV4hsc3Xmc+hyzDoQUTwPgZueXkLEc0X6IfDgTGUl7vi0C3bcEKx0uL
         FBm+ZpvYD7rHycVtQNZXJXk+Dmyb5yv+bL3QAXsTf+lOKcVHcQFVqn2KAc0vVsRn/Q50
         a/nhM6Pxx9rbpMWsM03SfJypfA9Z4CbY/s4WKAsFChy46W9FPH3/HpBnT77G+tjvLEVs
         S/ZA==
X-Gm-Message-State: AAQBX9eK2QjaZxkxpgyivMQGnh0woYu0aGUuSJ7foZqsMnA1cvdYMaVp
        1D5gSxFzZZERZGguwDFz9kP8oYTBHviCL820MckoVrWatl0=
X-Google-Smtp-Source: AKy350Z2+cQgpgQ25MXX9dribjAWhF3xU2k3htTf8qfWU5UD0VB5yDhRX0pQHtOEa+jHlgXOtpS/o/VUBjwpU6VMKr4=
X-Received: by 2002:ac2:51c4:0:b0:4eb:312f:8126 with SMTP id
 u4-20020ac251c4000000b004eb312f8126mr704972lfm.13.1682020189476; Thu, 20 Apr
 2023 12:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <48701651ef435518ac8432d80dfdc2dfe80f3703.1681569400.git.pav@iki.fi>
In-Reply-To: <48701651ef435518ac8432d80dfdc2dfe80f3703.1681569400.git.pav@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 20 Apr 2023 12:49:37 -0700
Message-ID: <CABBYNZL9C1cF7vTLobVhZ3_HxhDv7zsobB5NcWonPOwz_Rz+jw@mail.gmail.com>
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

On Sat, Apr 15, 2023 at 7:44=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Add option for launching Pipewire inside the VM to serve Bluetooth
> endpoints, which can be used in tests.
>
> If daemon and emulator were also started, wait for the endpoints to
> appear.
> ---
>
> Notes:
>     An example how you can launch Pipewire to serve Bluetooth endpoints.
>
>  tools/test-runner.c | 247 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 242 insertions(+), 5 deletions(-)
>
> diff --git a/tools/test-runner.c b/tools/test-runner.c
> index 6660ea8de..d416f80ed 100644
> --- a/tools/test-runner.c
> +++ b/tools/test-runner.c
> @@ -51,6 +51,7 @@ static bool start_dbus_session;
>  static bool start_daemon =3D false;
>  static bool start_emulator =3D false;
>  static bool start_monitor =3D false;
> +static bool start_pipewire;
>  static int num_devs =3D 0;
>  static const char *qemu_binary =3D NULL;
>  static const char *kernel_image =3D NULL;
> @@ -252,13 +253,13 @@ static void start_qemu(void)
>                                 "acpi=3Doff pci=3Dnoacpi noapic quiet ro =
init=3D%s "
>                                 "TESTHOME=3D%s TESTDBUS=3D%u TESTDAEMON=
=3D%u "
>                                 "TESTDBUSSESSION=3D%u XDG_RUNTIME_DIR=3D/=
run/user/0 "
> -                               "TESTAUDIO=3D%u "
> +                               "TESTAUDIO=3D%u TESTPIPEWIRE=3D%u "

I'd just reuse TESTAUDIO instead of introducing yet another
environment variable, that should probably check if it shall run
pulseaudio or pipewire depending on what is available in the system.

>                                 "TESTMONITOR=3D%u TESTEMULATOR=3D%u TESTD=
EVS=3D%d "
>                                 "TESTAUTO=3D%u TESTARGS=3D\'%s\'",
>                                 initcmd, cwd, start_dbus, start_daemon,
>                                 start_dbus_session, audio_support,
> -                               start_monitor, start_emulator, num_devs,
> -                               run_auto, testargs);
> +                               start_pipewire, start_monitor, start_emul=
ator,
> +                               num_devs, run_auto, testargs);
>
>         argv =3D alloca(sizeof(qemu_argv) +
>                                 (audio_support ? 4 : 0) +
> @@ -606,6 +607,207 @@ static pid_t start_bluetooth_daemon(const char *hom=
e)
>         return pid;
>  }
>
> +static char *get_command_stdout(char *command, size_t *size)
> +{
> +       char *buf =3D NULL;
> +       ssize_t nread =3D 0;
> +       size_t allocated =3D 0;
> +       int ret;
> +       FILE *f;
> +
> +       f =3D popen(command, "re");
> +       if (!f)
> +               return NULL;
> +
> +       while (1) {
> +               size_t res;
> +               void *p;
> +
> +               if (nread + 256 > allocated) {
> +                       allocated +=3D allocated + 256;
> +                       p =3D realloc(buf, allocated);
> +                       if (!p) {
> +                               nread =3D -1;
> +                               break;
> +                       }
> +                       buf =3D p;
> +               }
> +
> +               res =3D fread(buf + nread, 1, allocated - nread - 1, f);
> +               if (!res)
> +                       break;
> +               nread +=3D res;
> +       }
> +
> +       ret =3D pclose(f);
> +       if (ret < 0 || !WIFEXITED(ret) || WEXITSTATUS(ret) !=3D 0) {
> +               printf("%s failed\n", command);
> +               nread =3D -1;
> +       }
> +
> +       if (nread >=3D 0) {
> +               buf[nread] =3D 0;
> +               if (size)
> +                       *size =3D nread;
> +       } else {
> +               free(buf);
> +               buf =3D NULL;
> +       }
> +
> +       return buf;
> +}
> +
> +static void start_pipewire_daemons(pid_t *pipewire_pid, pid_t *wireplumb=
er_pid)
> +{
> +       static const char *const daemons[2] =3D {
> +               "/usr/bin/pipewire",
> +               "/usr/bin/wireplumber"
> +       };
> +       static const char *const dirs[] =3D {
> +               "/run/pw",
> +               "/run/pw/state",
> +               "/run/pw/wireplumber",
> +               "/run/pw/wireplumber/bluetooth.lua.d",
> +               "/run/pw/wireplumber/main.lua.d",
> +               NULL
> +       };
> +       FILE *f;
> +       pid_t *pids[2] =3D {pipewire_pid, wireplumber_pid};
> +       char *envp[5];
> +       int i;
> +
> +       for (i =3D 0; dirs[i]; ++i) {
> +               if (mkdir(dirs[i], 0755) < 0) {
> +                       perror("Failed to create directory");
> +                       return;
> +               }
> +       }
> +
> +       /* Enable only Bluetooth part, disable whatever requires user DBu=
s */
> +       f =3D fopen("/run/pw/wireplumber/main.lua.d/51-custom.lua", "w");
> +       if (!f) {
> +               perror("Failed to create Pipewire main config");
> +               return;
> +       }
> +       fprintf(f, "alsa_monitor.enabled =3D false\n"
> +               "v4l2_monitor.enabled =3D false\n"
> +               "libcamera_monitor.enabled =3D false\n"
> +               "default_access.properties[\"enable-flatpak-portal\"]"
> +               " =3D false\n");
> +       fclose(f);

I'd put this into its own function to make it clear that this is
setting up the configuration e.g.:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/test-runner.c=
#n450

> +       f =3D fopen("/run/pw/wireplumber/bluetooth.lua.d/51-custom.lua", =
"w");
> +       if (!f) {
> +               perror("Failed to create Pipewire bluetooth config");
> +               return;
> +       }
> +       fprintf(f, "bluez_monitor.properties[\"with-logind\"] =3D false\n=
"
> +               "bluez_midi_monitor.enabled =3D false\n");
> +       fclose(f);
> +
> +       /* Launch daemons */
> +       for (i =3D 0; i < 2; ++i)
> +               *pids[i] =3D -1;
> +
> +       envp[0] =3D "DBUS_SYSTEM_BUS_ADDRESS=3Dunix:"
> +                 "path=3D/run/dbus/system_bus_socket";
> +       envp[1] =3D "XDG_STATE_HOME=3D/run/pw/state";
> +       envp[2] =3D "XDG_CONFIG_HOME=3D/run/pw";
> +       envp[3] =3D "XDG_RUNTIME_DIR=3D/run/pw";
> +       envp[4] =3D NULL;
> +
> +       for (i =3D 0; i < 2; ++i) {
> +               const char *daemon =3D daemons[i];
> +               char *argv[2];
> +               pid_t pid;
> +
> +               printf("Starting Pipewire daemon %s\n", daemon);
> +
> +               argv[0] =3D (char *) daemon;
> +               argv[1] =3D NULL;
> +
> +               pid =3D fork();
> +               if (pid < 0) {
> +                       perror("Failed to fork new process");
> +                       return;
> +               }
> +
> +               if (pid =3D=3D 0) {
> +                       execve(argv[0], argv, envp);
> +                       exit(EXIT_SUCCESS);
> +               }
> +
> +               *pids[i] =3D pid;
> +
> +               printf("Pipewire daemon process %d created\n", pid);
> +       }
> +
> +       /* Tell pipewire clients where the socket is */
> +       setenv("PIPEWIRE_RUNTIME_DIR", "/run/pw", 1);
> +
> +       /* Wait until daemons completely started */
> +       for (i =3D 0; i < 6; ++i) {
> +               char *buf;
> +
> +               if (i > 0) {
> +                       printf("Wait for Pipewire ready...\n");
> +                       usleep(500000);
> +               }
> +
> +               buf =3D get_command_stdout("/usr/bin/pw-dump", NULL);
> +               if (!buf)
> +                       continue;

Don't we have a file or something similar to
/run/dbus/system_bus_socket that indicates pw is running? Checking
dump file seems a little overkill to me.

> +
> +               if (strstr(buf, "WirePlumber")) {
> +                       printf("Pipewire ready\n");
> +                       free(buf);
> +                       break;
> +               }
> +
> +               free(buf);
> +       }
> +       if (i =3D=3D 6)
> +               goto fail;
> +
> +       if (!start_emulator || !start_daemon)
> +               return;
> +
> +       /* Wait for Bluetooth endpoints */
> +       for (i =3D 0; i < 6; ++i) {
> +               char *buf;
> +
> +               if (i > 0) {
> +                       printf("Wait for endpoints...\n");
> +                       usleep(500000);
> +               }
> +
> +               buf =3D get_command_stdout("/usr/bin/bluetoothctl show", =
NULL);
> +               if (!buf)
> +                       continue;
> +
> +               if (strstr(buf, "0000110b-0000-1000-8000-00805f9b34fb") |=
|
> +                   strstr(buf, "00001850-0000-1000-8000-00805f9b34fb")) =
{
> +                       printf("Pipewire endpoints ready\n");
> +                       free(buf);
> +                       break;
> +               }
> +
> +               free(buf);
> +       }
> +       if (i =3D=3D 6)
> +               goto fail;

Id skip this part, the endpoints registration depends on how
bluetoothd:main.conf  is configured so we shouldn't really expect
certain UUIDs like above.

> +       return;
> +
> +fail:
> +       for (i =3D 0; i < 2; ++i)
> +               if (*pids[i] > 0)
> +                       kill(*pids[i], SIGTERM);
> +
> +       printf("Pipewire daemons not running properly\n");
> +       return;
> +}
> +
>  static const char *test_table[] =3D {
>         "mgmt-tester",
>         "smp-tester",
> @@ -807,7 +1009,7 @@ static void run_command(char *cmdname, char *home)
>         int pos =3D 0, idx =3D 0;
>         int serial_fd;
>         pid_t pid, dbus_pid, daemon_pid, monitor_pid, emulator_pid,
> -             dbus_session_pid, udevd_pid;
> +             dbus_session_pid, udevd_pid, pw_pid, wp_pid;
>
>         if (!home) {
>                 perror("Invalid parameter: TESTHOME");
> @@ -860,6 +1062,13 @@ static void run_command(char *cmdname, char *home)
>         else
>                 emulator_pid =3D -1;
>
> +       if (start_pipewire) {
> +               start_pipewire_daemons(&pw_pid, &wp_pid);
> +       } else {
> +               pw_pid =3D -1;
> +               wp_pid =3D -1;
> +       }
> +
>  start_next:
>         if (run_auto) {
>                 if (chdir(home + 5) < 0) {
> @@ -966,6 +1175,16 @@ start_next:
>                         udevd_pid =3D -1;
>                 }
>
> +               if (corpse =3D=3D pw_pid) {
> +                       printf("pipewire terminated\n");
> +                       pw_pid =3D -1;
> +               }
> +
> +               if (corpse =3D=3D wp_pid) {
> +                       printf("wireplumber terminated\n");
> +                       wp_pid =3D -1;
> +               }
> +
>                 if (corpse =3D=3D pid)
>                         break;
>         }
> @@ -975,6 +1194,12 @@ start_next:
>                 goto start_next;
>         }
>
> +       if (wp_pid > 0)
> +               kill(wp_pid, SIGTERM);
> +
> +       if (pw_pid > 0)
> +               kill(pw_pid, SIGTERM);
> +
>         if (daemon_pid > 0)
>                 kill(daemon_pid, SIGTERM);
>
> @@ -1079,6 +1304,12 @@ static void run_tests(void)
>                 audio_support =3D true;
>         }
>
> +       ptr =3D strstr(cmdline, "TESTPIPEWIRE=3D1");
> +       if (ptr) {
> +               printf("Pipewire requested\n");
> +               start_pipewire =3D true;
> +       }
> +
>         ptr =3D strstr(cmdline, "TESTHOME=3D");
>         if (ptr) {
>                 home =3D ptr + 4;
> @@ -1106,6 +1337,7 @@ static void usage(void)
>                 "\t-q, --qemu <path>      QEMU binary\n"
>                 "\t-k, --kernel <image>   Kernel image (bzImage)\n"
>                 "\t-A, --audio            Add audio support\n"
> +               "\t-P, --pipewire         Start pipewire\n"
>                 "\t-h, --help             Show help options\n");
>  }
>
> @@ -1121,6 +1353,7 @@ static const struct option main_options[] =3D {
>         { "qemu",    required_argument, NULL, 'q' },
>         { "kernel",  required_argument, NULL, 'k' },
>         { "audio",   no_argument,       NULL, 'A' },
> +       { "pipewire", no_argument,      NULL, 'P' },
>         { "version", no_argument,       NULL, 'v' },
>         { "help",    no_argument,       NULL, 'h' },
>         { }
> @@ -1140,7 +1373,7 @@ int main(int argc, char *argv[])
>         for (;;) {
>                 int opt;
>
> -               opt =3D getopt_long(argc, argv, "aubdslmq:k:Avh", main_op=
tions,
> +               opt =3D getopt_long(argc, argv, "aubdslmq:k:APvh", main_o=
ptions,
>                                                                 NULL);
>                 if (opt < 0)
>                         break;
> @@ -1177,6 +1410,10 @@ int main(int argc, char *argv[])
>                 case 'A':
>                         audio_support =3D true;
>                         break;
> +               case 'P':
> +                       start_dbus =3D true;
> +                       start_pipewire =3D true;
> +                       break;
>                 case 'v':
>                         printf("%s\n", VERSION);
>                         return EXIT_SUCCESS;
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D79C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jun 2022 15:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243783AbiFJPuW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jun 2022 11:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243695AbiFJPuU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jun 2022 11:50:20 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CE122D
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 08:50:18 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id e4so14112751ljl.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 08:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j50JBxG59cW80mzIXuciATBqAAtO0kYYog9Jp1fSTrc=;
        b=bkhsuT2DuXeU5F0upW8ob7biEPQOau192UutHHecVCIpHDDnYdw8cchTa5oXTgxw3Y
         IkJlM9H1hL+3vX5oyvhvgXpyKz4JyX/Q23Qr7rFZp3Ky/sIcuhJCENlcB2DyMeGh/FOw
         y4Ft5AAKOymkhVliHehaLSho+1N66YGtm5m+wkfEwsCjURxHQ2ZdizXpTl+sLQd46yS0
         FeYXLJ2XEXqmOo/lnhzBZhzoTR+fHWY37sK6Z/xErXR0slFdAqdbLliWXUhSXcnWEv3u
         P08FdfaAiRuePmDUtL5iayI3xE4S9GpKhD2LhIemFq9mwzi/OeK7PswHy/9pkJUiTu6d
         nndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j50JBxG59cW80mzIXuciATBqAAtO0kYYog9Jp1fSTrc=;
        b=E932joLUf4JsN/KrjeJItPunp05IoRNM9ct92hXP9WjuEuIjBdYN4yBGZ5U1m+Uvzr
         j4P22yEUct15dBh5+UqW1WFPJSeuOP49zqpSkjaA5HT2LRuzRRA+ejWK770KsdMLlvpS
         oUNsSbfRryd9u1NJryy/Y8itJYNFLcDzF7h76VC1wFZG/buF/3HrMqKYoIruul+x0/7m
         Ol2mSP7CXLOxKHxe9HktPWyHiqwLR0ymUTFNEjEJH09ABogiGRT+xYtSqVagczeEmP5k
         JZUlG/hWcg1sPxSnpHTmB37THDQjJ8cvfVVqqM83Q9I2MLzKyjDyZUQztipXkspOjI4C
         2t5g==
X-Gm-Message-State: AOAM533umjuBr23c5bf12jukvigEYSCWNygRrLFbGJ8ELLXXkTNzI0Bu
        LnP+/oR4SmfTUF2cS2DSogGRySRhYk0Vpb4LzacbolsS
X-Google-Smtp-Source: ABdhPJxCoswgpVoJM+W/yDW8lrAGlbFGU9zoLAbbC72HobNbycLqIMP4wNsqiR0A3x0FBll4luonrYz3UWSOhGjiBas=
X-Received: by 2002:a05:651c:102b:b0:255:5ca3:8983 with SMTP id
 w11-20020a05651c102b00b002555ca38983mr29633611ljm.423.1654876216409; Fri, 10
 Jun 2022 08:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220610072850.16593-1-frederic.danis@collabora.com> <20220610072850.16593-4-frederic.danis@collabora.com>
In-Reply-To: <20220610072850.16593-4-frederic.danis@collabora.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 10 Jun 2022 08:50:03 -0700
Message-ID: <CABBYNZJxPrVwusCtPojhu5kiPRpiJ_0ZHzunzMAATDii44+R4Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 3/3] test-runner: Add udevd and trigger events
To:     =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Fr=C3=A9d=C3=A9ric,

On Fri, Jun 10, 2022 at 12:30 AM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> Kernel events should have been managed so the audio card is accessible
> from PipeWire
> ---
>  tools/test-runner.c | 83 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 80 insertions(+), 3 deletions(-)
>
> diff --git a/tools/test-runner.c b/tools/test-runner.c
> index bbbca5b5d..e79e3b6e9 100644
> --- a/tools/test-runner.c
> +++ b/tools/test-runner.c
> @@ -251,13 +251,14 @@ static void start_qemu(void)
>                                 "rootfstype=3D9p "
>                                 "rootflags=3Dtrans=3Dvirtio,version=3D9p2=
000.L "
>                                 "acpi=3Doff pci=3Dnoacpi noapic quiet ro =
init=3D%s "
> -                               "bluetooth.enable_ecred=3D1"
> +                               "bluetooth.enable_ecred=3D1 "
>                                 "TESTHOME=3D%s TESTDBUS=3D%u TESTDAEMON=
=3D%u "
>                                 "TESTDBUSSESSION=3D%u XDG_RUNTIME_DIR=3D/=
run/user/0 "
> +                               "AUDIO_SUPPORT=3D%u "

Lets name these TESTAUDIO instead of AUDIO_SUPPORT so it is consistent
with the other parameters like it.

>                                 "TESTMONITOR=3D%u TESTEMULATOR=3D%u TESTD=
EVS=3D%d "
>                                 "TESTAUTO=3D%u TESTARGS=3D\'%s\'",
>                                 initcmd, cwd, start_dbus, start_daemon,
> -                               start_dbus_session,
> +                               start_dbus_session, audio_support,
>                                 start_monitor, start_emulator, num_devs,
>                                 run_auto, testargs);
>
> @@ -724,13 +725,70 @@ static pid_t start_btvirt(const char *home)
>         return pid;
>  }
>
> +static void trigger_udev(void)
> +{
> +       char *argv[3], *envp[1];
> +       pid_t pid;
> +
> +       argv[0] =3D "/bin/udevadm";
> +       argv[1] =3D "trigger";
> +       argv[2] =3D NULL;
> +
> +       envp[0] =3D NULL;
> +
> +       printf("Triggering udev events\n");
> +
> +       pid =3D fork();
> +       if (pid < 0) {
> +               perror("Failed to fork new process");
> +               return;
> +       }
> +
> +       if (pid =3D=3D 0) {
> +               execve(argv[0], argv, envp);
> +               exit(EXIT_SUCCESS);
> +       }
> +
> +       printf("udev trigger process %d created\n", pid);
> +}
> +
> +static pid_t start_udevd(void)
> +{
> +       char *argv[2], *envp[1];
> +       pid_t pid;
> +
> +       argv[0] =3D "/lib/systemd/systemd-udevd";
> +       argv[1] =3D NULL;
> +
> +       envp[0] =3D NULL;
> +
> +       printf("Starting udevd daemon\n");
> +
> +       pid =3D fork();
> +       if (pid < 0) {
> +               perror("Failed to fork new process");
> +               return -1;
> +       }
> +
> +       if (pid =3D=3D 0) {
> +               execve(argv[0], argv, envp);
> +               exit(EXIT_SUCCESS);
> +       }
> +
> +       printf("udevd daemon process %d created\n", pid);
> +
> +       trigger_udev();
> +
> +       return pid;
> +}
> +
>  static void run_command(char *cmdname, char *home)
>  {
>         char *argv[9], *envp[3];
>         int pos =3D 0, idx =3D 0;
>         int serial_fd;
>         pid_t pid, dbus_pid, daemon_pid, monitor_pid, emulator_pid,
> -             dbus_session_pid;
> +             dbus_session_pid, udevd_pid;
>
>         if (num_devs) {
>                 const char *node =3D "/dev/ttyS1";
> @@ -746,6 +804,11 @@ static void run_command(char *cmdname, char *home)
>         } else
>                 serial_fd =3D -1;
>
> +       if (audio_support)
> +               udevd_pid =3D start_udevd();
> +       else
> +               udevd_pid =3D -1;
> +
>         if (start_dbus) {
>                 create_dbus_system_conf();
>                 dbus_pid =3D start_dbus_daemon(false);
> @@ -874,6 +937,11 @@ start_next:
>                         monitor_pid =3D -1;
>                 }
>
> +               if (corpse =3D=3D udevd_pid) {
> +                       printf("udevd terminated\n");
> +                       udevd_pid =3D -1;
> +               }
> +
>                 if (corpse =3D=3D pid)
>                         break;
>         }
> @@ -898,6 +966,9 @@ start_next:
>         if (monitor_pid > 0)
>                 kill(monitor_pid, SIGTERM);
>
> +       if (udevd_pid > 0)
> +               kill(udevd_pid, SIGTERM);
> +
>         if (serial_fd >=3D 0) {
>                 close(serial_fd);
>                 serial_fd =3D -1;
> @@ -980,6 +1051,12 @@ static void run_tests(void)
>                 start_emulator =3D true;
>         }
>
> +       ptr =3D strstr(cmdline, "AUDIO_SUPPORT=3D1");
> +       if (ptr) {
> +               printf("Audio support requested\n");
> +               audio_support =3D true;
> +       }
> +
>         ptr =3D strstr(cmdline, "TESTHOME=3D");
>         if (ptr) {
>                 home =3D ptr + 4;
> --
> 2.25.1
>


--=20
Luiz Augusto von Dentz

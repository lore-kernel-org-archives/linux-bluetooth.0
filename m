Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDD7C678D4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Mar 2023 00:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjCCA5O (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Mar 2023 19:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjCCA5N (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Mar 2023 19:57:13 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39E155057
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Mar 2023 16:57:07 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id m6so1607410lfq.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Mar 2023 16:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLZIvRlght/PVbbonorqWUiVhcpnqsdsr7jxIpW89d4=;
        b=cu6ui9iWzjffJKdSUZnNpD0MglyHkmZsA9bAlPxMVlUZlq1YldDlaQlNtYMGGJo13a
         U/Y+3C8DlwEbib7k2QsqxbqgoJWCxo5EC/Qo0ijLnL9M/CcGP1w2HIDOyGASQLE3ebt7
         VyY1F4Y7jmOTzp2ZdiRBhZ1jgg6IFQyFzpd6hSHltP29/Eed+5IjfpWkpuLJAgGhCCoF
         FKlsPCgz2Ic1y7lxcF084rYSimZTSctixtC4VHRfLqfFwVm8SSvDN0dkaemdOLEgh8r4
         lfR8CCIsCJsBOrouTp6+GI8DbPztHRgyeDkDikRy+3S4TNb1UXvcqMAkGkKrKHKRaFfJ
         7j9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLZIvRlght/PVbbonorqWUiVhcpnqsdsr7jxIpW89d4=;
        b=tpp4JIpgBp3Fy2pgcXVK2nGfm98DohtyOwRVtUB5fpwzPDT7X4tu8pgYH4wdmEK89P
         p0W4pcvhqdWJhn5WiyrhO6C3NP/LJetlslxcfMYAeOH8LkBDalHeN7bb5oIFlKHud3XK
         tXiyTzBdFhcGJPoUclqn4hD22abCBSZygcXopBC4Qp1WXNno/Jmdq4bhFHGA4E+/QFZV
         uiY6jz4lhkcSNevHpDGQqKE1Gw9Tfu/CCoUuJEADdmXU0hCmlYxD9ZhgPRj43xh8iZ/W
         tdqqNJ+xRi4lpN2orzZoNcVzEG/ThPKNeLgfFPnlyxYXxYEb3qxE82d6N/9GGHdMHyHp
         aOJw==
X-Gm-Message-State: AO0yUKWrMVSNNymVHwmhRCF2IJaiohFGm6nFCdZYdPUi1gZuxh+EoqW/
        AOeHyOV6BnfC9D1ec8ET1XXpiAkjIDsSwqxUTug=
X-Google-Smtp-Source: AK7set8O7MkG70wsokOuh7dl1SS9QkP35amoYh4/V8bBbzr4bS8KeGQICsqHZFeQZVaY1vGJWG5XFBZiMS45ZYkKw3k=
X-Received: by 2002:ac2:4c13:0:b0:4dd:a4c5:2b42 with SMTP id
 t19-20020ac24c13000000b004dda4c52b42mr55946lfq.8.1677805025678; Thu, 02 Mar
 2023 16:57:05 -0800 (PST)
MIME-Version: 1.0
References: <20230302151621.BlueZ.v1.1.I21ac5a143b0e42eef4ff71ef04ef0e53a294932a@changeid>
In-Reply-To: <20230302151621.BlueZ.v1.1.I21ac5a143b0e42eef4ff71ef04ef0e53a294932a@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 2 Mar 2023 16:56:54 -0800
Message-ID: <CABBYNZ+3iFjAXi96AS8yr1VpnVmQzr3=pSnVS3v2OY5boxw0Rg@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1] mgmt-tester: Add devcoredump test
To:     Manish Mandlik <mmandlik@google.com>
Cc:     marcel@holtmann.org, chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Manish,

On Thu, Mar 2, 2023 at 3:17=E2=80=AFPM Manish Mandlik <mmandlik@google.com>=
 wrote:
>
> Add mgmt-tester test for hci devcoredump.
>
> ---
>
>  emulator/vhci.c     | 42 ++++++++++++++++++++++++
>  emulator/vhci.h     |  2 ++
>  tools/mgmt-tester.c | 78 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 122 insertions(+)
>
> diff --git a/emulator/vhci.c b/emulator/vhci.c
> index a12b11e0f..048ea08c6 100644
> --- a/emulator/vhci.c
> +++ b/emulator/vhci.c
> @@ -22,6 +22,7 @@
>  #include <sys/uio.h>
>  #include <fcntl.h>
>  #include <unistd.h>
> +#include <dirent.h>
>
>  #include "lib/bluetooth.h"
>  #include "lib/hci.h"
> @@ -32,6 +33,7 @@
>  #include "vhci.h"
>
>  #define DEBUGFS_PATH "/sys/kernel/debug/bluetooth"
> +#define DEVCORE_PATH "/sys/class/devcoredump"
>
>  struct vhci {
>         enum btdev_type type;
> @@ -267,3 +269,43 @@ int vhci_set_force_static_address(struct vhci *vhci,=
 bool enable)
>         return vhci_debugfs_write(vhci, "force_static_address", &val,
>                                                         sizeof(val));
>  }
> +
> +int vhci_force_devcoredump(struct vhci *vhci, void *data, size_t len)
> +{
> +       return vhci_debugfs_write(vhci, "force_devcoredump", data, len);
> +}
> +
> +int vhci_read_devcoredump(struct vhci *vhci, void *buf, size_t size)
> +{
> +       DIR *dir;
> +       struct dirent *entry;
> +       char filename[PATH_MAX];
> +       int fd;
> +       int count;
> +
> +       dir =3D opendir(DEVCORE_PATH);
> +       if (dir =3D=3D NULL)
> +               return -errno;
> +
> +       while ((entry =3D readdir(dir)) !=3D NULL) {
> +               if (strstr(entry->d_name, "devcd"))

Hmm, I think I like the term devcd better then devcoredump, it is more
a cosmetic thing but it seem much better to read vhci_read_devcd than
vhci_read_devcoredump, etc.

> +                       break;
> +       }
> +
> +       if (entry =3D=3D NULL) {
> +               closedir(dir);
> +               return -ENOENT;
> +       }
> +
> +       sprintf(filename, DEVCORE_PATH "/%s/data", entry->d_name);
> +       fd  =3D open(filename, O_RDONLY);
> +       if (fd < 0) {
> +               closedir(dir);
> +               return -errno;
> +       }
> +
> +       count =3D read(fd, buf, size);
> +       close(fd);
> +
> +       return count;
> +}
> diff --git a/emulator/vhci.h b/emulator/vhci.h
> index 6da56cb58..cb969911c 100644
> --- a/emulator/vhci.h
> +++ b/emulator/vhci.h
> @@ -29,3 +29,5 @@ int vhci_set_msft_opcode(struct vhci *vhci, uint16_t op=
code);
>  int vhci_set_aosp_capable(struct vhci *vhci, bool enable);
>  int vhci_set_emu_opcode(struct vhci *vhci, uint16_t opcode);
>  int vhci_set_force_static_address(struct vhci *vhci, bool enable);
> +int vhci_force_devcoredump(struct vhci *vhci, void *data, size_t len);
> +int vhci_read_devcoredump(struct vhci *vhci, void *buf, size_t size);
> diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
> index a56c38173..70b425547 100644
> --- a/tools/mgmt-tester.c
> +++ b/tools/mgmt-tester.c
> @@ -12511,6 +12511,77 @@ static void test_suspend_resume_success_10(const=
 void *test_data)
>         tester_wait(2, trigger_force_resume, NULL);
>  }
>
> +#define MAX_COREDUMP_BUF_LEN   512
> +#define MAX_COREDUMP_LINE_LEN  40
> +
> +static void test_hci_devcoredump(const void *test_data)
> +{
> +       struct test_data *data =3D tester_get_data();
> +       struct vhci *vhci =3D hciemu_get_vhci(data->hciemu);
> +       char buf[MAX_COREDUMP_BUF_LEN] =3D {0};
> +       char delim[] =3D "\n";
> +       char *line;
> +       char *saveptr;
> +       int i =3D 0;
> +
> +       char dump_data[] =3D "test data";
> +       char expected[][MAX_COREDUMP_LINE_LEN] =3D {
> +               "Bluetooth devcoredump",
> +               "State: 2",
> +               "Controller Name: vhci_ctrl",
> +               "Firmware Version: vhci_fw",
> +               "Driver: vhci_drv",
> +               "Vendor: vhci",
> +               "--- Start dump ---",
> +       };
> +
> +       /* Triggers the devcoredump */
> +       if (vhci_force_devcoredump(vhci, dump_data, sizeof(dump_data))) {
> +               tester_warn("Unable to set force_devcoredump");
> +               tester_test_failed();
> +               return;
> +       }
> +
> +       /* Read the generated devcoredump file */
> +       if (vhci_read_devcoredump(vhci, buf, sizeof(buf)) <=3D 0) {
> +               tester_warn("Unable to read devcoredump");
> +               tester_test_failed();
> +               return;
> +       }
> +
> +       /* Verify if all devcoredump header fields are present */
> +       line =3D strtok_r(buf, delim, &saveptr);
> +       while (i < ARRAY_SIZE(expected)) {
> +               if (!line || strcmp(line, expected[i])) {
> +                       tester_warn("Incorrect coredump data: %s (expecte=
d %s)",
> +                                   line, expected[i]);
> +                       tester_test_failed();
> +                       return;
> +               }
> +
> +               if (!strcmp(line, "State: 2")) {
> +                       /* After updating the devcoredump state, the HCI
> +                        * devcoredump API adds a `\0` at the end. Skip i=
t
> +                        * before reading the next line.
> +                        */
> +                       saveptr++;
> +               }
> +
> +               line =3D strtok_r(NULL, delim, &saveptr);
> +               i++;
> +       }
> +
> +       /* Verify the devcoredump data */
> +       if (!line || strcmp(line, dump_data)) {
> +               tester_warn("Incorrect coredump data: %s (expected %s)", =
line,
> +                           dump_data);
> +               tester_test_failed();
> +               return;
> +       }
> +
> +       tester_test_passed();
> +}
> +
>  int main(int argc, char *argv[])
>  {
>         tester_init(&argc, &argv);
> @@ -14651,5 +14722,12 @@ int main(int argc, char *argv[])
>                                 setup_ll_privacy_add_device,
>                                 test_command_generic);
>
> +       /* HCI devcoredump
> +        * Setup : Power on
> +        * Run: Trigger devcoredump via force_devcoredump
> +        * Expect: Devcoredump is generated with correct data
> +        */
> +       test_bredrle("HCI devcoredump", NULL, NULL, test_hci_devcoredump)=
;
> +

Great work, thanks for creating the test for it, lets just split the
vhci changes for the test itself then add the expected output in the
patch descriptions.

>         return tester_run();
>  }
> --
> 2.40.0.rc0.216.gc4246ad0f0-goog
>


--=20
Luiz Augusto von Dentz

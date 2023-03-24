Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39ED8C6FD20
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Mar 2023 17:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjCXRe6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Mar 2023 13:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjCXRe5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Mar 2023 13:34:57 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F02C659
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Mar 2023 10:34:55 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id q16so3175503lfe.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Mar 2023 10:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679679294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lURG49t78H8UHb9XvsEOFxTMWIOuS27J8bFLa+7YRa4=;
        b=c944WTQawOAEtxmqx6o3Bi+Iy/2NoSfFG2OFFGU/xDT2w1dT6kT9IQ0IXIre0t4ZbV
         Ri/1KNCwTShAVmPtLuBg+m0ruXYxbc+VGjey3Wji3y7DZbXuBseNVYZsGlB1cKAtRFul
         pNNhZr3enP73B66nZMtG9zGSw2A3HrAR5T28OedUR/rkeV777PqJZRafhyWypC95rNzo
         CsrGsjWJuuxQkmf8UbznjA1pOqKECUTZXXmsu6ZEi+mgKQ9+B+g60dmnSE3RuXKpbseB
         mQdcq8vITyPVe2ehus/DPBHKpwawVqf8Ud3DxCZHZhvVPogILh+c82LzTZjZcY0TZD3u
         BszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679679294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lURG49t78H8UHb9XvsEOFxTMWIOuS27J8bFLa+7YRa4=;
        b=XV2vwMs2MUQOECYacwpd0FpxZJqY1fdfPWlef41JCWgmrFAfJ9RSCo7GHWp8nxPfqy
         LumkhVgm8iXvxe3en1mnre44KKOvF1sU+bAwMTExraVUgBFOWNSQ06KqeHG2qTs437xR
         4R9NsVW6iF2TgP8KhXW8UHnAFnYnDw3Qzy57mN9bMAJ9Y8ojVWBqvSNXpAwW5w0qk/bK
         Tc23+04uJFCCVK6uTZa8o+GAvnnN+l1wrDUgj0bDPzMkBD4nyNXF/C0Dn/qAejmLcf4J
         Srf+BpGUPpqGreDpaSIOsPMaNRsUN+XLJJzjP2LLLx+Q9YmixHFwKAg8eu2w2u0e9VrO
         NVkw==
X-Gm-Message-State: AAQBX9fz3AMkqbJEwBn6j7CxBtphXdp3i+JOPBl7rCcIazt1au2eoGTY
        EhcCQTbleVKi6c3vaETtkLJYvsNRPEwqpk2wTGFcQqoo
X-Google-Smtp-Source: AKy350ZwJ7fdf61Rk8ENaFP9f1KteHoPLIhpADQ94voXRaM3oyrtKAbWBAWS7qepcBMh0KHN4/kU8O01UfhKEpMEpZc=
X-Received: by 2002:ac2:55a2:0:b0:4ea:f9d4:93a1 with SMTP id
 y2-20020ac255a2000000b004eaf9d493a1mr948032lfg.10.1679679293684; Fri, 24 Mar
 2023 10:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230324102227.BlueZ.v3.1.I21ac5a143b0e42eef4ff71ef04ef0e53a294932a@changeid>
In-Reply-To: <20230324102227.BlueZ.v3.1.I21ac5a143b0e42eef4ff71ef04ef0e53a294932a@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 24 Mar 2023 10:34:42 -0700
Message-ID: <CABBYNZLC-gP2Wc_xjsSsozOYhpTjz_moq1m2NSWdtiG_Q9CvtA@mail.gmail.com>
Subject: Re: [BlueZ PATCH v3] mgmt-tester: Add devcoredump test
To:     Manish Mandlik <mmandlik@google.com>
Cc:     marcel@holtmann.org, chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Manish,

On Fri, Mar 24, 2023 at 10:22=E2=80=AFAM Manish Mandlik <mmandlik@google.co=
m> wrote:
>
> Add mgmt-tester test for hci devcoredump. This test triggers the
> devcoredump with a test data and verifies the generated devcoredump
> file for the test data and correct devcoredump header fields.
>
> Signed-off-by: Manish Mandlik <mmandlik@google.com>
> ---
>
> Changes in v3:
> - Fix compiler warning for signed comparision in test_hci_devcd()
>
> Changes in v2:
> - Rename function names to *_devcd
>
>  emulator/vhci.c     | 42 ++++++++++++++++++++++++
>  emulator/vhci.h     |  2 ++
>  tools/mgmt-tester.c | 78 +++++++++++++++++++++++++++++++++++++++++++++

Looks like you forgot to split the vhci changes.

>  3 files changed, 122 insertions(+)
>
> diff --git a/emulator/vhci.c b/emulator/vhci.c
> index a12b11e0f..1676f1697 100644
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
> +int vhci_force_devcd(struct vhci *vhci, void *data, size_t len)
> +{
> +       return vhci_debugfs_write(vhci, "force_devcoredump", data, len);
> +}
> +
> +int vhci_read_devcd(struct vhci *vhci, void *buf, size_t size)
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
> index 6da56cb58..5dd28b627 100644
> --- a/emulator/vhci.h
> +++ b/emulator/vhci.h
> @@ -29,3 +29,5 @@ int vhci_set_msft_opcode(struct vhci *vhci, uint16_t op=
code);
>  int vhci_set_aosp_capable(struct vhci *vhci, bool enable);
>  int vhci_set_emu_opcode(struct vhci *vhci, uint16_t opcode);
>  int vhci_set_force_static_address(struct vhci *vhci, bool enable);
> +int vhci_force_devcd(struct vhci *vhci, void *data, size_t len);
> +int vhci_read_devcd(struct vhci *vhci, void *buf, size_t size);
> diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
> index a56c38173..838ae5d2b 100644
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
> +static void test_hci_devcd(const void *test_data)
> +{
> +       struct test_data *data =3D tester_get_data();
> +       struct vhci *vhci =3D hciemu_get_vhci(data->hciemu);
> +       char buf[MAX_COREDUMP_BUF_LEN] =3D {0};
> +       char delim[] =3D "\n";
> +       char *line;
> +       char *saveptr;
> +       unsigned int i =3D 0;
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
> +       if (vhci_force_devcd(vhci, dump_data, sizeof(dump_data))) {
> +               tester_warn("Unable to set force_devcoredump");
> +               tester_test_failed();
> +               return;
> +       }
> +
> +       /* Read the generated devcoredump file */
> +       if (vhci_read_devcd(vhci, buf, sizeof(buf)) <=3D 0) {
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
> +       test_bredrle("HCI devcoredump", NULL, NULL, test_hci_devcd);
> +
>         return tester_run();
>  }
> --
> 2.40.0.348.gf938b09366-goog
>


--=20
Luiz Augusto von Dentz

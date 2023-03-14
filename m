Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC901C6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Mar 2023 20:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjCNUAS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Mar 2023 16:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjCNUAQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Mar 2023 16:00:16 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B321B2E5
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 13:00:07 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id s22so21526480lfi.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 13:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678824006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVewKLPWXZt3yaSq0Oy6L9PAzkmvuDo6zygAGAo65ZQ=;
        b=PpTV0qfYFoYlHy3BvBYB6O604TEEE5En4KqcpCZhQDbENWVptwofNZfNOo3GzPXFK1
         1xnIErcXqYDF2g5+H+pBpa625PQWpnk6LcwW3oHaKiIN4zBE/hvprAbZT7PevOm9rjoT
         jqmMbuGaIINHmmsW92lN45NTsDO/fuiIe8X56ci6l2iL72+TxIQai59r34IbYyj2OTUq
         db4He1bCWgQKg0XlWFoDCh2Cgs7LRg4BB51NKfQydwHEcGCvtAKtBEmhqybNywvGyEwC
         H4aWhf9Qjs3LbiYIuZ/04wLAVCIJ0UWRmeyHnXIRdvT9Xn72XYHlCUojxa3o4wMFjwyT
         7j/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678824006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVewKLPWXZt3yaSq0Oy6L9PAzkmvuDo6zygAGAo65ZQ=;
        b=pRyW04zsI6RzYz9dIHEGI4135fO2ojWaT6Lx363MWdlUrfh4LMjkjE69DOADpxvh7r
         cIa1Hiw6Is8fL6e6mj+reZY8erwDyt7S6SBFgERW0VxPxnZWHpB3nvbT0od70c5tV+D4
         pVMuAC+O6ZGVKgg0kJRqJjfduD6s8+tDRx56FoGVBoSIAR/w2EJcE/xZNL6taFhammXi
         d/JhEPWa8wTV+xKN6yySSskUSsK2mYsvokpLxIOdJSw7oJFDc+gwCcuBZNOarVYyV+oq
         5CBfhGgsEz6UdG70LoZ6X03Gcnq9+bdw+aCN1IghkrpwCKJeH3UNucV8Em4hXjnBTWi5
         LLOg==
X-Gm-Message-State: AO0yUKXTI/+3FnzRVf3mfwwWISLv17b8JC7fNoLTsBW6yYBE5TM3+vPy
        1oM1x+82nOSKElAZQynx/x8/UMTdbxTzPLxJuj0=
X-Google-Smtp-Source: AK7set+K01169ZcRpwso4Um8ZrWXYyeso1eEamXDO6qihnN7qxtexIXWK3A0bt113jsm75ZPk1KFUDrvRg7Y4OCsMiU=
X-Received: by 2002:a19:7604:0:b0:4d5:ca32:7bc3 with SMTP id
 c4-20020a197604000000b004d5ca327bc3mr1147414lff.10.1678824005667; Tue, 14 Mar
 2023 13:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230302151621.BlueZ.v1.1.I21ac5a143b0e42eef4ff71ef04ef0e53a294932a@changeid>
 <CABBYNZ+3iFjAXi96AS8yr1VpnVmQzr3=pSnVS3v2OY5boxw0Rg@mail.gmail.com>
In-Reply-To: <CABBYNZ+3iFjAXi96AS8yr1VpnVmQzr3=pSnVS3v2OY5boxw0Rg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 14 Mar 2023 12:59:54 -0700
Message-ID: <CABBYNZ+dzMjBzYm5R9hhq90guPBjZRmExRfZBwLvpnOgH+O8QA@mail.gmail.com>
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

On Thu, Mar 2, 2023 at 4:56=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Manish,
>
> On Thu, Mar 2, 2023 at 3:17=E2=80=AFPM Manish Mandlik <mmandlik@google.co=
m> wrote:
> >
> > Add mgmt-tester test for hci devcoredump.
> >
> > ---
> >
> >  emulator/vhci.c     | 42 ++++++++++++++++++++++++
> >  emulator/vhci.h     |  2 ++
> >  tools/mgmt-tester.c | 78 +++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 122 insertions(+)
> >
> > diff --git a/emulator/vhci.c b/emulator/vhci.c
> > index a12b11e0f..048ea08c6 100644
> > --- a/emulator/vhci.c
> > +++ b/emulator/vhci.c
> > @@ -22,6 +22,7 @@
> >  #include <sys/uio.h>
> >  #include <fcntl.h>
> >  #include <unistd.h>
> > +#include <dirent.h>
> >
> >  #include "lib/bluetooth.h"
> >  #include "lib/hci.h"
> > @@ -32,6 +33,7 @@
> >  #include "vhci.h"
> >
> >  #define DEBUGFS_PATH "/sys/kernel/debug/bluetooth"
> > +#define DEVCORE_PATH "/sys/class/devcoredump"
> >
> >  struct vhci {
> >         enum btdev_type type;
> > @@ -267,3 +269,43 @@ int vhci_set_force_static_address(struct vhci *vhc=
i, bool enable)
> >         return vhci_debugfs_write(vhci, "force_static_address", &val,
> >                                                         sizeof(val));
> >  }
> > +
> > +int vhci_force_devcoredump(struct vhci *vhci, void *data, size_t len)
> > +{
> > +       return vhci_debugfs_write(vhci, "force_devcoredump", data, len)=
;
> > +}
> > +
> > +int vhci_read_devcoredump(struct vhci *vhci, void *buf, size_t size)
> > +{
> > +       DIR *dir;
> > +       struct dirent *entry;
> > +       char filename[PATH_MAX];
> > +       int fd;
> > +       int count;
> > +
> > +       dir =3D opendir(DEVCORE_PATH);
> > +       if (dir =3D=3D NULL)
> > +               return -errno;
> > +
> > +       while ((entry =3D readdir(dir)) !=3D NULL) {
> > +               if (strstr(entry->d_name, "devcd"))
>
> Hmm, I think I like the term devcd better then devcoredump, it is more
> a cosmetic thing but it seem much better to read vhci_read_devcd than
> vhci_read_devcoredump, etc.
>
> > +                       break;
> > +       }
> > +
> > +       if (entry =3D=3D NULL) {
> > +               closedir(dir);
> > +               return -ENOENT;
> > +       }
> > +
> > +       sprintf(filename, DEVCORE_PATH "/%s/data", entry->d_name);
> > +       fd  =3D open(filename, O_RDONLY);
> > +       if (fd < 0) {
> > +               closedir(dir);
> > +               return -errno;
> > +       }
> > +
> > +       count =3D read(fd, buf, size);
> > +       close(fd);
> > +
> > +       return count;
> > +}
> > diff --git a/emulator/vhci.h b/emulator/vhci.h
> > index 6da56cb58..cb969911c 100644
> > --- a/emulator/vhci.h
> > +++ b/emulator/vhci.h
> > @@ -29,3 +29,5 @@ int vhci_set_msft_opcode(struct vhci *vhci, uint16_t =
opcode);
> >  int vhci_set_aosp_capable(struct vhci *vhci, bool enable);
> >  int vhci_set_emu_opcode(struct vhci *vhci, uint16_t opcode);
> >  int vhci_set_force_static_address(struct vhci *vhci, bool enable);
> > +int vhci_force_devcoredump(struct vhci *vhci, void *data, size_t len);
> > +int vhci_read_devcoredump(struct vhci *vhci, void *buf, size_t size);
> > diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
> > index a56c38173..70b425547 100644
> > --- a/tools/mgmt-tester.c
> > +++ b/tools/mgmt-tester.c
> > @@ -12511,6 +12511,77 @@ static void test_suspend_resume_success_10(con=
st void *test_data)
> >         tester_wait(2, trigger_force_resume, NULL);
> >  }
> >
> > +#define MAX_COREDUMP_BUF_LEN   512
> > +#define MAX_COREDUMP_LINE_LEN  40
> > +
> > +static void test_hci_devcoredump(const void *test_data)
> > +{
> > +       struct test_data *data =3D tester_get_data();
> > +       struct vhci *vhci =3D hciemu_get_vhci(data->hciemu);
> > +       char buf[MAX_COREDUMP_BUF_LEN] =3D {0};
> > +       char delim[] =3D "\n";
> > +       char *line;
> > +       char *saveptr;
> > +       int i =3D 0;
> > +
> > +       char dump_data[] =3D "test data";
> > +       char expected[][MAX_COREDUMP_LINE_LEN] =3D {
> > +               "Bluetooth devcoredump",
> > +               "State: 2",
> > +               "Controller Name: vhci_ctrl",
> > +               "Firmware Version: vhci_fw",
> > +               "Driver: vhci_drv",
> > +               "Vendor: vhci",
> > +               "--- Start dump ---",
> > +       };
> > +
> > +       /* Triggers the devcoredump */
> > +       if (vhci_force_devcoredump(vhci, dump_data, sizeof(dump_data)))=
 {
> > +               tester_warn("Unable to set force_devcoredump");
> > +               tester_test_failed();
> > +               return;
> > +       }
> > +
> > +       /* Read the generated devcoredump file */
> > +       if (vhci_read_devcoredump(vhci, buf, sizeof(buf)) <=3D 0) {
> > +               tester_warn("Unable to read devcoredump");
> > +               tester_test_failed();
> > +               return;
> > +       }
> > +
> > +       /* Verify if all devcoredump header fields are present */
> > +       line =3D strtok_r(buf, delim, &saveptr);
> > +       while (i < ARRAY_SIZE(expected)) {
> > +               if (!line || strcmp(line, expected[i])) {
> > +                       tester_warn("Incorrect coredump data: %s (expec=
ted %s)",
> > +                                   line, expected[i]);
> > +                       tester_test_failed();
> > +                       return;
> > +               }
> > +
> > +               if (!strcmp(line, "State: 2")) {
> > +                       /* After updating the devcoredump state, the HC=
I
> > +                        * devcoredump API adds a `\0` at the end. Skip=
 it
> > +                        * before reading the next line.
> > +                        */
> > +                       saveptr++;
> > +               }
> > +
> > +               line =3D strtok_r(NULL, delim, &saveptr);
> > +               i++;
> > +       }
> > +
> > +       /* Verify the devcoredump data */
> > +       if (!line || strcmp(line, dump_data)) {
> > +               tester_warn("Incorrect coredump data: %s (expected %s)"=
, line,
> > +                           dump_data);
> > +               tester_test_failed();
> > +               return;
> > +       }
> > +
> > +       tester_test_passed();
> > +}
> > +
> >  int main(int argc, char *argv[])
> >  {
> >         tester_init(&argc, &argv);
> > @@ -14651,5 +14722,12 @@ int main(int argc, char *argv[])
> >                                 setup_ll_privacy_add_device,
> >                                 test_command_generic);
> >
> > +       /* HCI devcoredump
> > +        * Setup : Power on
> > +        * Run: Trigger devcoredump via force_devcoredump
> > +        * Expect: Devcoredump is generated with correct data
> > +        */
> > +       test_bredrle("HCI devcoredump", NULL, NULL, test_hci_devcoredum=
p);
> > +
>
> Great work, thanks for creating the test for it, lets just split the
> vhci changes for the test itself then add the expected output in the
> patch descriptions.

Do you need any feedback on this? You might want a v2 before 30 days
otherwise the pw series is removed due to inactivity.

> >         return tester_run();
> >  }
> > --
> > 2.40.0.rc0.216.gc4246ad0f0-goog
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E2BC6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 23:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjCWXel (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 19:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjCWXek (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 19:34:40 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA0A24127
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 16:34:39 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 20so93433lju.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 16:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679614477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0V1CdkQVvc+ZB3zMbx9RygjjNHOD2Nv+vp6ncNFcYwE=;
        b=jmuzXKZclCDL5RYzdhdip95dxmvKV9l67MvXi5ywL8n9oK070fZ9YJcNGzQ6CfyQTo
         NeQgYyd8gfHo1da2uIvGZa+bACFdy3Vt133R3YBgKbthxmSy8rd+ScjTsVve9pz/JY98
         xqh0qx+dMCISNy6EPyWrfJZ3giZ9Q2scZe20V6D0vw8sUF9Q9W921kWamTM9ITqDGi69
         /y1JhJuYeB6ehXIU/O51FmmzU5TTZzAoEUiHshIh77ywaNMp8qoFGQHmhxyI58V5MqX7
         Jxv3lLxo7qgklKPllgYXQDc6ah8xXrTI3xzGQ7rj+4SH6YtWB5Z33Wso7lmXupEkd/tu
         RGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679614477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0V1CdkQVvc+ZB3zMbx9RygjjNHOD2Nv+vp6ncNFcYwE=;
        b=UrbiyhZ+PcLNNu8d2dZ8bLyw/IM9Ve+Xoh4SE7fTTHfhWedh5mWp/a8qz9iD/K/v78
         R3jMnO3XcONk5LyeSjMtDF9d+vrkMFmvTDbPDYVPZaPSuOAf6MhSkwHpVqkvFdDPgQ/w
         GWl7iZgoq3G+xzzyiJViMBAPrkVGzZ81+stkI4H++LDaNtuhuWD6RXM2weFry/neSpfs
         nCNEUewPxe7143jErBEMLJov25DEJMpDrVBYxVQSwIHCKs/Q8Q8yBzMA1wpshsYY13Ke
         pWnKH7D+kzu4s2Oz3PeRuids18jINHERhWPy32oE1QJBdkZ2Ccox39nQAToURS3BXyub
         2QWw==
X-Gm-Message-State: AAQBX9fgqJra6mEoEdHbXt7e2rv/JgABzJIb8juhpYDU3QYM1PXuS59/
        j0zkcconffBGspoKDV4OEWde51zhlW4CDpoyd14=
X-Google-Smtp-Source: AKy350ZUTkxU3DbQeU4IxHTCsDh31bPuDezQookdgAzYutzMPDV4G2JkNknjvPhGrCpsF6syJAzOZGd9mU2GOWYGU6Y=
X-Received: by 2002:a2e:9c83:0:b0:295:897c:6f7a with SMTP id
 x3-20020a2e9c83000000b00295897c6f7amr297327lji.0.1679614477175; Thu, 23 Mar
 2023 16:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230302151621.BlueZ.v1.1.I21ac5a143b0e42eef4ff71ef04ef0e53a294932a@changeid>
 <CABBYNZ+3iFjAXi96AS8yr1VpnVmQzr3=pSnVS3v2OY5boxw0Rg@mail.gmail.com>
 <CABBYNZ+dzMjBzYm5R9hhq90guPBjZRmExRfZBwLvpnOgH+O8QA@mail.gmail.com>
 <CAGPPCLDpyHRN7Zjq6wATnr2J8b_p+wL3=0+jMEFUKqkCyFaY3g@mail.gmail.com> <CAGPPCLCBgiUC1PqueFNbzpJizM6w9Y-UGSJEe_8RsE1iisCHVw@mail.gmail.com>
In-Reply-To: <CAGPPCLCBgiUC1PqueFNbzpJizM6w9Y-UGSJEe_8RsE1iisCHVw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 23 Mar 2023 16:34:25 -0700
Message-ID: <CABBYNZK+5LXVD2jPrKt6h_7nXA9iB-S0AoXKEgDujmuaEMxErg@mail.gmail.com>
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

On Thu, Mar 23, 2023 at 2:22=E2=80=AFPM Manish Mandlik <mmandlik@google.com=
> wrote:
>
> Hi Luiz,
>
>
> On Tue, Mar 14, 2023 at 1:22=E2=80=AFPM Manish Mandlik <mmandlik@google.c=
om> wrote:
>>
>> Hi Luiz,
>>
>> On Tue, Mar 14, 2023 at 1:00=E2=80=AFPM Luiz Augusto von Dentz <luiz.den=
tz@gmail.com> wrote:
>>>
>>> Hi Manish,
>>>
>>> On Thu, Mar 2, 2023 at 4:56=E2=80=AFPM Luiz Augusto von Dentz
>>> <luiz.dentz@gmail.com> wrote:
>>> >
>>> > Hi Manish,
>>> >
>>> > On Thu, Mar 2, 2023 at 3:17=E2=80=AFPM Manish Mandlik <mmandlik@googl=
e.com> wrote:
>>> > >
>>> > > Add mgmt-tester test for hci devcoredump.
>>> > >
>>> > > ---
>>> > >
>>> > >  emulator/vhci.c     | 42 ++++++++++++++++++++++++
>>> > >  emulator/vhci.h     |  2 ++
>>> > >  tools/mgmt-tester.c | 78 +++++++++++++++++++++++++++++++++++++++++=
++++
>>> > >  3 files changed, 122 insertions(+)
>>> > >
>>> > > diff --git a/emulator/vhci.c b/emulator/vhci.c
>>> > > index a12b11e0f..048ea08c6 100644
>>> > > --- a/emulator/vhci.c
>>> > > +++ b/emulator/vhci.c
>>> > > @@ -22,6 +22,7 @@
>>> > >  #include <sys/uio.h>
>>> > >  #include <fcntl.h>
>>> > >  #include <unistd.h>
>>> > > +#include <dirent.h>
>>> > >
>>> > >  #include "lib/bluetooth.h"
>>> > >  #include "lib/hci.h"
>>> > > @@ -32,6 +33,7 @@
>>> > >  #include "vhci.h"
>>> > >
>>> > >  #define DEBUGFS_PATH "/sys/kernel/debug/bluetooth"
>>> > > +#define DEVCORE_PATH "/sys/class/devcoredump"
>>> > >
>>> > >  struct vhci {
>>> > >         enum btdev_type type;
>>> > > @@ -267,3 +269,43 @@ int vhci_set_force_static_address(struct vhci =
*vhci, bool enable)
>>> > >         return vhci_debugfs_write(vhci, "force_static_address", &va=
l,
>>> > >                                                         sizeof(val)=
);
>>> > >  }
>>> > > +
>>> > > +int vhci_force_devcoredump(struct vhci *vhci, void *data, size_t l=
en)
>>> > > +{
>>> > > +       return vhci_debugfs_write(vhci, "force_devcoredump", data, =
len);
>>> > > +}
>>> > > +
>>> > > +int vhci_read_devcoredump(struct vhci *vhci, void *buf, size_t siz=
e)
>>> > > +{
>>> > > +       DIR *dir;
>>> > > +       struct dirent *entry;
>>> > > +       char filename[PATH_MAX];
>>> > > +       int fd;
>>> > > +       int count;
>>> > > +
>>> > > +       dir =3D opendir(DEVCORE_PATH);
>>> > > +       if (dir =3D=3D NULL)
>>> > > +               return -errno;
>>> > > +
>>> > > +       while ((entry =3D readdir(dir)) !=3D NULL) {
>>> > > +               if (strstr(entry->d_name, "devcd"))
>>> >
>>> > Hmm, I think I like the term devcd better then devcoredump, it is mor=
e
>>> > a cosmetic thing but it seem much better to read vhci_read_devcd than
>>> > vhci_read_devcoredump, etc.
>
> Ack. Will include in the next patch.
>
>>>
>>> >
>>> > > +                       break;
>>> > > +       }
>>> > > +
>>> > > +       if (entry =3D=3D NULL) {
>>> > > +               closedir(dir);
>>> > > +               return -ENOENT;
>>> > > +       }
>>> > > +
>>> > > +       sprintf(filename, DEVCORE_PATH "/%s/data", entry->d_name);
>>> > > +       fd  =3D open(filename, O_RDONLY);
>>> > > +       if (fd < 0) {
>>> > > +               closedir(dir);
>>> > > +               return -errno;
>>> > > +       }
>>> > > +
>>> > > +       count =3D read(fd, buf, size);
>>> > > +       close(fd);
>>> > > +
>>> > > +       return count;
>>> > > +}
>>> > > diff --git a/emulator/vhci.h b/emulator/vhci.h
>>> > > index 6da56cb58..cb969911c 100644
>>> > > --- a/emulator/vhci.h
>>> > > +++ b/emulator/vhci.h
>>> > > @@ -29,3 +29,5 @@ int vhci_set_msft_opcode(struct vhci *vhci, uint1=
6_t opcode);
>>> > >  int vhci_set_aosp_capable(struct vhci *vhci, bool enable);
>>> > >  int vhci_set_emu_opcode(struct vhci *vhci, uint16_t opcode);
>>> > >  int vhci_set_force_static_address(struct vhci *vhci, bool enable);
>>> > > +int vhci_force_devcoredump(struct vhci *vhci, void *data, size_t l=
en);
>>> > > +int vhci_read_devcoredump(struct vhci *vhci, void *buf, size_t siz=
e);
>>> > > diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
>>> > > index a56c38173..70b425547 100644
>>> > > --- a/tools/mgmt-tester.c
>>> > > +++ b/tools/mgmt-tester.c
>>> > > @@ -12511,6 +12511,77 @@ static void test_suspend_resume_success_10=
(const void *test_data)
>>> > >         tester_wait(2, trigger_force_resume, NULL);
>>> > >  }
>>> > >
>>> > > +#define MAX_COREDUMP_BUF_LEN   512
>>> > > +#define MAX_COREDUMP_LINE_LEN  40
>>> > > +
>>> > > +static void test_hci_devcoredump(const void *test_data)
>>> > > +{
>>> > > +       struct test_data *data =3D tester_get_data();
>>> > > +       struct vhci *vhci =3D hciemu_get_vhci(data->hciemu);
>>> > > +       char buf[MAX_COREDUMP_BUF_LEN] =3D {0};
>>> > > +       char delim[] =3D "\n";
>>> > > +       char *line;
>>> > > +       char *saveptr;
>>> > > +       int i =3D 0;
>>> > > +
>>> > > +       char dump_data[] =3D "test data";
>>> > > +       char expected[][MAX_COREDUMP_LINE_LEN] =3D {
>>> > > +               "Bluetooth devcoredump",
>>> > > +               "State: 2",
>>> > > +               "Controller Name: vhci_ctrl",
>>> > > +               "Firmware Version: vhci_fw",
>>> > > +               "Driver: vhci_drv",
>>> > > +               "Vendor: vhci",
>>> > > +               "--- Start dump ---",
>>> > > +       };
>>> > > +
>>> > > +       /* Triggers the devcoredump */
>>> > > +       if (vhci_force_devcoredump(vhci, dump_data, sizeof(dump_dat=
a))) {
>>> > > +               tester_warn("Unable to set force_devcoredump");
>>> > > +               tester_test_failed();
>>> > > +               return;
>>> > > +       }
>>> > > +
>>> > > +       /* Read the generated devcoredump file */
>>> > > +       if (vhci_read_devcoredump(vhci, buf, sizeof(buf)) <=3D 0) {
>>> > > +               tester_warn("Unable to read devcoredump");
>>> > > +               tester_test_failed();
>>> > > +               return;
>>> > > +       }
>>> > > +
>>> > > +       /* Verify if all devcoredump header fields are present */
>>> > > +       line =3D strtok_r(buf, delim, &saveptr);
>>> > > +       while (i < ARRAY_SIZE(expected)) {
>>> > > +               if (!line || strcmp(line, expected[i])) {
>>> > > +                       tester_warn("Incorrect coredump data: %s (e=
xpected %s)",
>>> > > +                                   line, expected[i]);
>>> > > +                       tester_test_failed();
>>> > > +                       return;
>>> > > +               }
>>> > > +
>>> > > +               if (!strcmp(line, "State: 2")) {
>>> > > +                       /* After updating the devcoredump state, th=
e HCI
>>> > > +                        * devcoredump API adds a `\0` at the end. =
Skip it
>>> > > +                        * before reading the next line.
>>> > > +                        */
>>> > > +                       saveptr++;
>>> > > +               }
>>> > > +
>>> > > +               line =3D strtok_r(NULL, delim, &saveptr);
>>> > > +               i++;
>>> > > +       }
>>> > > +
>>> > > +       /* Verify the devcoredump data */
>>> > > +       if (!line || strcmp(line, dump_data)) {
>>> > > +               tester_warn("Incorrect coredump data: %s (expected =
%s)", line,
>>> > > +                           dump_data);
>>> > > +               tester_test_failed();
>>> > > +               return;
>>> > > +       }
>>> > > +
>>> > > +       tester_test_passed();
>>> > > +}
>>> > > +
>>> > >  int main(int argc, char *argv[])
>>> > >  {
>>> > >         tester_init(&argc, &argv);
>>> > > @@ -14651,5 +14722,12 @@ int main(int argc, char *argv[])
>>> > >                                 setup_ll_privacy_add_device,
>>> > >                                 test_command_generic);
>>> > >
>>> > > +       /* HCI devcoredump
>>> > > +        * Setup : Power on
>>> > > +        * Run: Trigger devcoredump via force_devcoredump
>>> > > +        * Expect: Devcoredump is generated with correct data
>>> > > +        */
>>> > > +       test_bredrle("HCI devcoredump", NULL, NULL, test_hci_devcor=
edump);
>>> > > +
>>> >
>>> > Great work, thanks for creating the test for it, lets just split the
>>> > vhci changes for the test itself then add the expected output in the
>>> > patch descriptions.
>
> Do you suggest I split this patch into two? One for vhci changes and anot=
her for test changes? And for the expected output, should I include the exp=
ected contents of the output devcoredump file OR just the output from the t=
est run like this:
> HCI devcoredump - init
>   Read Version callback
>     Status: Success (0x00)
>     Version 1.22
>   Read Commands callback
>     Status: Success (0x00)
>   Read Index List callback
>     Status: Success (0x00)
>   Index Added callback
>     Index: 0x0000
>   Enable management Mesh interface
>   Enabling Mesh feature
>   Read Info callback
>     Status: Success (0x00)
>     Address: 00:AA:01:00:00:00
>     Version: 0x09
>     Manufacturer: 0x05f1
>     Supported settings: 0x0001bfff
>     Current settings: 0x00000080
>     Class: 0x000000
>     Name:
>     Short name:
>   Mesh feature is enabled
> HCI devcoredump - setup
> HCI devcoredump - setup complete
> HCI devcoredump - run
> HCI devcoredump - test passed
> HCI devcoredump - teardown
>   Index Removed callback
>     Index: 0x0000
> HCI devcoredump - teardown complete
> HCI devcoredump - done

Have just the summary of the new tests you are adding but remove the
timing portion since it doesn't matter in this context.

>>>
>>> Do you need any feedback on this? You might want a v2 before 30 days
>>> otherwise the pw series is removed due to inactivity.
>>
>> I'm in the middle of addressing kernel side code changes, and got caught=
 up in other work. I'll send a new series as soon as possible. Thanks for t=
he 30 day inactivity heads up!
>>
>>>
>>> > >         return tester_run();
>>> > >  }
>>> > > --
>>> > > 2.40.0.rc0.216.gc4246ad0f0-goog
>>> > >
>>> >
>>> >
>>> > --
>>> > Luiz Augusto von Dentz
>>>
>>>
>>>
>>> --
>>> Luiz Augusto von Dentz
>>
>> Regards,
>> Manish.
>>
>>
>
>
> Regards,
> Manish.



--=20
Luiz Augusto von Dentz

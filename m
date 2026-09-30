Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0623A4E3229
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790772856; cv=pass; b=AeeCZtVJ/DSM9W7FE8doolrNNQMjSC6aGulsSLKbMNkZEUZEHBfNS0PZ3xwg14VPWOXz2zX8Xiig8KEwrNPE8X9We7pHVfNF4EPdASwDz0FS10dOg2O/2WtfJwARfZIhd9WbBZTYykV7C+EZusDcFimflMGTXXarIlrDPILtIHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790772856; c=relaxed/simple;
	bh=J3BUSjpk7WrrwvGDwlP2XO18pw7uMtCeDySqVSKfg9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GePvq/Ih5CmRd64KYhPKRSGpt5/IBk7Q3o/JCFgbTzvHZyj1plY2mzR1Q+1V+zEHbEJ2i9LWMpFxtgb7Vv1MyPM/6+idzBJ+Mr7Jqd4ggLbt3J381PWMAj5ylEBQ5d7vzH4UykA5WkdmR3Bij4ASkWMVJR92wz+NlJ8LxtyjLe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOvvM5br; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOvvM5br"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-895fd505824so46055237b3.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 05:53:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790772834; cv=none;
        d=google.com; s=arc-20260327;
        b=Tqlg8lMtPUWoqSHxWsHfQDz/T9kqFuWBrML1RU4Udj+AbbyrfYLLRh1m5ulxHkNnfe
         kS7H0LiFrQIAwo+PWDBbCN+OA8tLfRlY/RBfLLQo0WkhpsDUIOlkaTUY5HckdWt+98OD
         lIdE9CaqbOQK6tt2m4ejqnsJS1Xf8nMyqdeHwt1QBuMxuCGKA6e/x4j+8XS0L38buTRQ
         CS+LbbgGK+qsGSppm5UgunaYq5sFFBUYyumtxiCulRewxcJhpq+9RHpQwraseTax6JSO
         n3NZS7WLlfMaOWCxuoqxFINl4yjs9YxfHsgSncVcfF6nChosztL5DrcbaqHxMV/ElM3G
         Ae8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cQNtbQt0Mgn3/zmOLjMi3Fmlo/i8r565mkFUJ4m1lnk=;
        fh=XYDkU1TTZTlQiedNyhQBOXJRcm2xFOG4rWZzy7Q8TSk=;
        b=oCdbcTixQjahsJyLA664bNOMyiWNMhys8cU/6ejsoVyn5qHq3n0GNinR1rmagWmKZx
         VhPI0Ncl24Aii+dKwTB4LwjRRu7sbJplVgEPX9M3/pdgycvlChSk0D+F/f+Y6tDN79dM
         nD24rdz5SEYqvIocfQ6RFPIX760/Q/SpmTSU3h9zLH8dMagvn+hNR3HSbH5YK6aa7T0e
         g8UILm91OWRHWggD+5+FBklXFsNQ3rm671RRK3yzXqINCY/M7tHXMSEAf38+CGqy+hRA
         25AZCrS2XvdhZdP8Qwu1NpvvqPK37AWsVxsRYKYQWNWyIQZUMdHl+SYmHagaeOzNtZRA
         xOuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790772834; x=1791377634; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cQNtbQt0Mgn3/zmOLjMi3Fmlo/i8r565mkFUJ4m1lnk=;
        b=iOvvM5brFIwIPXuASWiGiU6m36x2L6ghdyT6/Ga0lDbq6CMHqrMduac6+ZHCVG2afg
         jQsPcX6gD+Guz1Ghw2ueg+qWVCSp/WF4qbgty7znzcMfRe1+2MKQCXVt/5qM7QGcErqS
         9PYiVZMCiP69g76NyoDdpeS/lAeqKw5Bhf1WGqJdkQfVAoiSjR0r85F3R8bj8AyRF5iM
         I9FT5HofJb6Z2WnT48e0QPk8kdqb47H9sEcdUkp2TZddpIIo7bATLpsfmqR33lLxgUMh
         mN5mhMi13RDeknQw8wxcgJ/PMOdr0XZiEXcYNJkKu7uaUVGu8OjF9+V58eJoi04RGfHx
         5OrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790772834; x=1791377634;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cQNtbQt0Mgn3/zmOLjMi3Fmlo/i8r565mkFUJ4m1lnk=;
        b=x1DaBtUQgCZWOOE4sPuQxZ086TcDsH4MK68R9B+AQLKffxXOEENhBcXgjK+YvPykGE
         BLiQeptSJqLzj4Tck9PjPoC0MCZDoxbPLYA3JsSafr54BMbeEugnF4Jw+DFRFquMmsG9
         lfHN/dMEt52QtEzvfbD7j08PMzNz7hFu17mxt+G7kiirkbYSJn4Yr+JrvcAnDgeGLWCd
         fWD/Jr52mmPOgkYXwNw4qE92BG16obQnJEGYV7o5HKyq5sxL2irmmtSyPfAOLZEQ3LBk
         eD9euvoXiNnyrUk5PvaL1fRFi1kix/Prx9G6RkbBbLvj3LDTgGECz7c8P4zTVk7btHjE
         c2kQ==
X-Gm-Message-State: AFq9FYLx72SssugIasBtdNaDjqN/suw1zvfKIU9a/NFj9vz5HvSeXwwn
	8oxdouw3xlRy9MUXp1zIQNutmxXu90XwI0moKDg7i3Pltj9eN1SR1FbxKYFj8A76u/Vb77VWQUv
	G4+qP7KLKNoT8iEawe1wdjVlU9ai+LGf/+BqDrbM=
X-Gm-Gg: AYBFou3jFCmGB0fu4lOfg5d8wftxHK0aYm4TzOWE+fGOy5ji+kjYA3275SnhrXCb0xY
	Mr8h5v8MSj+dxcl0kN4O+nPYOQ6nVHJm6v1Bn4tZrADaU8uMpfrfERvOEwoUNY4UbZH+T3KZ9QV
	wgItBfjySJ6LtNUPrPiGdv90PjRb8t0xj0LRtzl/m7wl4JY25a/wODXiPscwVtOdX5Tjl4nB02Q
	xPn+RtYPeyjMvdAegMTZMB1vm8u7f0DLrjqlYeE5okgLbHemYRF3hu/8KqiO3pZF8wPHdkCzXZb
	uERG3HiGIvkH1HtytC3meTzhNe1h9ZhEq6MPHdRFx7V8uu50oesIJ6oJZ5iKT0OcM2GhKMNq3lD
	2xczWaPKXaRJmUzD2HukNTVddLnojcKpk1Vq0VCA=
X-Received: by 2002:a05:690c:c625:b0:8a8:8f62:e8f with SMTP id
 00721157ae682-8ac92286b30mr3057227b3.22.1790772834013; Wed, 30 Sep 2026
 05:53:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790752800.git.aluvala.sai.teja@intel.com> <66971d6f85d714f2728b29fada7136d5a2fbb3c2.1790752800.git.aluvala.sai.teja@intel.com>
In-Reply-To: <66971d6f85d714f2728b29fada7136d5a2fbb3c2.1790752800.git.aluvala.sai.teja@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 30 Sep 2026 08:53:42 -0400
X-Gm-Features: AclHuK9oqgz27dxzpjkC-bMnlK4U1wMRN-3pnb3eWzMvZNyS4bRS3xsi9NjgW58
Message-ID: <CABBYNZ+_ZMd9fh2K8ESe5V9NKuZjBcbBsqsnLVuXkTZ4YXm6-g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] emulator: add generic HW rfkill test tool
To: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Cc: linux-bluetooth@vger.kernel.org, kiran.k@intel.com, 
	chethan.tumkur.narayan@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sai,

On Wed, Sep 30, 2026 at 3:53=E2=80=AFAM Sai Teja Aluvala
<aluvala.sai.teja@intel.com> wrote:
>
> Add emulator/hci_rfkill, a standalone tool that drives the
> force_hw_rfkill debugfs hook for an hciN device and verifies the
> reported hardware-block state against /sys/class/rfkill. The hook
> exercises the generic net/bluetooth rfkill path for any HCI transport;
> it does not test the driver's hardware interrupt or register handling.
>
> Support assert-only, deassert-only, and toggle modes. Validate the
> hciN argument before using it in filesystem paths. In toggle mode,
> if asserting the block was written successfully but subsequent
> verification fails, still attempt a verified unblock while preserving
> the failure result. Do not attempt an unblock when the assert write
> itself fails.
>
> The optional -r/--restore mode snapshots the adapter's up/down state
> via HCIGETDEVINFO and restores it via HCIDEVUP/HCIDEVDOWN, following
> the raw HCI control-socket approach used by tools/hciconfig.c.
>
> Usage: hci_rfkill [-e|-d|-t] [-r] hciN

I have a hard time understanding why we can't just use the `rfkill`
tool for this purpose, or does it not support hardware-block? It seems
it does:

rfkill --help

Usage:
 rfkill [options] command [identifier ...]

Tool for enabling and disabling wireless devices.

Options:
 -J, --json             use JSON output format
 -n, --noheadings       don't print headings
 -o, --output <list>    define which output columns to use
     --output-all       output all columns
 -r, --raw              use the raw output format

 -h, --help             display this help
 -V, --version          display version

Available output columns:
 DEVICE      kernel device name
 ID          device identifier value
 TYPE        device type name that can be used as identifier
 TYPE-DESC   device type description
 SOFT        status of software block
-> HARD        status of hardware block

>
> Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
> ---
>  Makefile.tools        |   3 +
>  emulator/hci_rfkill.c | 478 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 481 insertions(+)
>  create mode 100644 emulator/hci_rfkill.c
>
> diff --git a/Makefile.tools b/Makefile.tools
> index 2914bf1c0..4e5d0d976 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -85,6 +85,7 @@ endif
>
>  if TESTING
>  noinst_PROGRAMS +=3D emulator/btvirt emulator/b1ee emulator/hfp \
> +                                       emulator/hci_rfkill \
>                                         peripheral/btsensor tools/3dsp \
>                                         tools/mgmt-tester tools/gap-teste=
r \
>                                         tools/l2cap-tester tools/sco-test=
er \
> @@ -111,6 +112,8 @@ emulator_b1ee_LDADD =3D src/libshared-mainloop.la
>  emulator_hfp_SOURCES =3D emulator/hfp.c
>  emulator_hfp_LDADD =3D src/libshared-mainloop.la
>
> +emulator_hci_rfkill_SOURCES =3D emulator/hci_rfkill.c
> +
>  peripheral_btsensor_SOURCES =3D peripheral/main.c \
>                                 peripheral/efivars.h peripheral/efivars.c=
 \
>                                 peripheral/attach.h peripheral/attach.c \
> diff --git a/emulator/hci_rfkill.c b/emulator/hci_rfkill.c
> new file mode 100644
> index 000000000..f5ef5e3bb
> --- /dev/null
> +++ b/emulator/hci_rfkill.c
> @@ -0,0 +1,478 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2026  Intel Corporation
> + *
> + */
> +
> +/*
> + * hci_rfkill - generic HW rfkill stack test driver.
> + *
> + * Applies to any hci_dev with rfkill registered, regardless of vendor o=
r
> + * transport (USB, UART, PCIe, virtual, etc.). Many transport drivers (e=
.g.
> + * btintel_pcie) are bound to real hardware and have no userspace-attach=
able
> + * transport to emulate the way emulator/vhci.c does for /dev/vhci. Inst=
ead,
> + * net/bluetooth's hci_debugfs.c exposes a generic debugfs test hook
> + * ("force_hw_rfkill" under /sys/kernel/debug/bluetooth/hciN/) that call=
s
> + * hci_rfkill_set_hw_state() directly. That is the exact same entry poin=
t
> + * any driver's real HW rfkill interrupt path (e.g. btintel_pcie's
> + * MSIX/doorbell flow, or another vendor's equivalent) calls into, so
> + * writing this hook exercises the full net/bluetooth rfkill core
> + * notification chain (hci_rfkill_set_block() -> HCI_RFKILLED flag ->
> + * device power on/off) without needing the driver to assert its real HW
> + * rfkill line. This tool writes that hook to simulate the HW rfkill lin=
e
> + * toggling and reads back both the debugfs state and the corresponding
> + * /sys/class/rfkill hard-block state to confirm the hci_dev (and rfkill
> + * core) picked up the change.
> + *
> + * Note: this only covers the net/bluetooth stack side of the flow. The
> + * driver-side interrupt/doorbell/register-read logic that decides when =
to
> + * call hci_rfkill_set_hw_state() in the first place is vendor/transport
> + * specific and is not exercised by this tool; that still requires real
> + * hardware or a transport-level (e.g. PCIe) emulation to test.
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <stdio.h>
> +#include <stdbool.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <ctype.h>
> +#include <getopt.h>
> +#include <dirent.h>
> +#include <limits.h>
> +#include <stdarg.h>
> +#include <sys/socket.h>
> +#include <sys/ioctl.h>
> +
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +
> +#define DEBUGFS_PATH "/sys/kernel/debug/bluetooth"
> +#define RFKILL_CLASS_PATH "/sys/class/rfkill"
> +
> +static bool verbose;
> +
> +static void print_verbose(const char *format, ...)
> +{
> +       va_list ap;
> +
> +       if (!verbose)
> +               return;
> +
> +       va_start(ap, format);
> +       vprintf(format, ap);
> +       va_end(ap);
> +}
> +
> +static int debugfs_hw_rfkill_write(const char *hci_name, bool enable)
> +{
> +       char path[128];
> +       int fd, err;
> +       char val =3D enable ? 'Y' : 'N';
> +
> +       snprintf(path, sizeof(path), DEBUGFS_PATH "/%s/force_hw_rfkill",
> +                                                       hci_name);
> +
> +       fd =3D open(path, O_WRONLY);
> +       if (fd < 0) {
> +               err =3D -errno;
> +               fprintf(stderr, "Failed to open %s: %s\n", path,
> +                                                       strerror(errno));
> +               return err;
> +       }
> +
> +       if (write(fd, &val, sizeof(val)) !=3D sizeof(val)) {
> +               err =3D -errno;
> +               fprintf(stderr, "Failed to write %s: %s\n", path,
> +                                                       strerror(errno));
> +               close(fd);
> +               return err;
> +       }
> +
> +       close(fd);
> +
> +       return 0;
> +}
> +
> +static int debugfs_hw_rfkill_read(const char *hci_name, bool *enable)
> +{
> +       char path[128];
> +       char buf[8];
> +       int fd, err;
> +       ssize_t len;
> +
> +       snprintf(path, sizeof(path), DEBUGFS_PATH "/%s/force_hw_rfkill",
> +                                                       hci_name);
> +
> +       fd =3D open(path, O_RDONLY);
> +       if (fd < 0) {
> +               err =3D -errno;
> +               fprintf(stderr, "Failed to open %s: %s\n", path,
> +                                                       strerror(errno));
> +               return err;
> +       }
> +
> +       memset(buf, 0, sizeof(buf));
> +       len =3D read(fd, buf, sizeof(buf) - 1);
> +       close(fd);
> +
> +       if (len < 1)
> +               return -EIO;
> +
> +       *enable =3D (buf[0] =3D=3D 'Y');
> +
> +       return 0;
> +}
> +
> +/* Locate the /sys/class/rfkill/rfkillN entry whose "name" matches the g=
iven
> + * hci device name (e.g. "hci0") and read back its hard-block state.
> + */
> +static int rfkill_class_hard_read(const char *hci_name, bool *blocked)
> +{
> +       DIR *dir;
> +       struct dirent *entry;
> +       int ret =3D -ENOENT;
> +       int val;
> +
> +       dir =3D opendir(RFKILL_CLASS_PATH);
> +       if (!dir)
> +               return -errno;
> +
> +       while ((entry =3D readdir(dir)) !=3D NULL) {
> +               char path[PATH_MAX];
> +               char name[64];
> +               FILE *f;
> +
> +               if (strncmp(entry->d_name, "rfkill", 6))
> +                       continue;
> +
> +               snprintf(path, sizeof(path), RFKILL_CLASS_PATH "/%s/name"=
,
> +                                                       entry->d_name);
> +
> +               f =3D fopen(path, "r");
> +               if (!f)
> +                       continue;
> +
> +               memset(name, 0, sizeof(name));
> +               if (!fgets(name, sizeof(name), f)) {
> +                       fclose(f);
> +                       continue;
> +               }
> +               fclose(f);
> +
> +               name[strcspn(name, "\n")] =3D '\0';
> +
> +               if (strcmp(name, hci_name))
> +                       continue;
> +
> +               snprintf(path, sizeof(path), RFKILL_CLASS_PATH "/%s/hard"=
,
> +                                                       entry->d_name);
> +
> +               f =3D fopen(path, "r");
> +               if (!f) {
> +                       ret =3D -errno;
> +                       break;
> +               }
> +
> +               if (fscanf(f, "%d", &val) =3D=3D 1) {
> +                       *blocked =3D (val !=3D 0);
> +                       ret =3D 0;
> +               } else {
> +                       ret =3D -EIO;
> +               }
> +               fclose(f);
> +               break;
> +       }
> +
> +       closedir(dir);
> +
> +       return ret;
> +}
> +
> +/* Parse the numeric device id out of an "hciN" name without requiring t=
he
> + * device to be up (unlike lib/bluetooth's hci_devid(), which internally
> + * calls hci_devba() and fails with ENETDOWN on a down/blocked device --
> + * exactly the state this tool may have just put the adapter into).
> + */
> +static int hci_name_to_id(const char *hci_name)
> +{
> +       const char *p;
> +       char *end;
> +       unsigned long id;
> +
> +       if (strncmp(hci_name, "hci", 3))
> +               return -1;
> +
> +       p =3D hci_name + 3;
> +       if (!*p)
> +               return -1;
> +
> +       while (*p) {
> +               if (!isdigit((unsigned char)*p))
> +                       return -1;
> +               p++;
> +       }
> +
> +       errno =3D 0;
> +       id =3D strtoul(hci_name + 3, &end, 10);
> +       if (errno =3D=3D ERANGE || *end || id > USHRT_MAX)
> +               return -1;
> +
> +       return id;
> +}
> +
> +/* Query whether the given hci device currently has HCI_UP set, using th=
e
> + * same raw HCI control socket + ioctl approach as tools/hciconfig.c.
> + */
> +static int hci_dev_is_up(int hdev_id, bool *up)
> +{
> +       struct hci_dev_info di;
> +       int ctl, err;
> +
> +       ctl =3D socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
> +       if (ctl < 0)
> +               return -errno;
> +
> +       memset(&di, 0, sizeof(di));
> +       di.dev_id =3D hdev_id;
> +
> +       if (ioctl(ctl, HCIGETDEVINFO, (void *) &di) < 0) {
> +               err =3D -errno;
> +               close(ctl);
> +               return err;
> +       }
> +
> +       close(ctl);
> +
> +       *up =3D !!(di.flags & (1U << HCI_UP));
> +
> +       return 0;
> +}
> +
> +/* Bring the given hci device up or down via HCIDEVUP/HCIDEVDOWN, mirror=
ing
> + * tools/hciconfig.c's cmd_up()/cmd_down(). Used to restore the adapter =
to
> + * its pre-test state, since unblocking HW rfkill does not automatically
> + * reopen the device (that is normally done by bluetoothd reacting to th=
e
> + * rfkill unblock event via mgmt).
> + */
> +static int hci_dev_set_up(int hdev_id, bool up)
> +{
> +       int ctl, err;
> +
> +       ctl =3D socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
> +       if (ctl < 0)
> +               return -errno;
> +
> +       if (ioctl(ctl, up ? HCIDEVUP : HCIDEVDOWN, hdev_id) < 0) {
> +               err =3D -errno;
> +               close(ctl);
> +               /* HCIDEVUP returns EALREADY if the device is already up
> +                * (mirrors tools/hciconfig.c's cmd_up()); HCIDEVDOWN has
> +                * no such case.
> +                */
> +               return (up && err =3D=3D -EALREADY) ? 0 : err;
> +       }
> +
> +       close(ctl);
> +
> +       return 0;
> +}
> +
> +static int run_test(const char *hci_name, bool enable, bool *write_succe=
eded)
> +{
> +       bool val;
> +       int err;
> +
> +       *write_succeeded =3D false;
> +       printf("Setting HW rfkill %s on %s\n", enable ? "ON" : "OFF",
> +                                                               hci_name)=
;
> +
> +       err =3D debugfs_hw_rfkill_write(hci_name, enable);
> +       if (err)
> +               return err;
> +       *write_succeeded =3D true;
> +
> +       err =3D debugfs_hw_rfkill_read(hci_name, &val);
> +       if (err) {
> +               fprintf(stderr, "Failed to read back debugfs state: %s\n"=
,
> +                                                       strerror(-err));
> +               return err;
> +       }
> +
> +       if (val !=3D enable) {
> +               fprintf(stderr, "debugfs force_hw_rfkill mismatch: wrote =
%d, "
> +                                       "read %d\n", enable, val);
> +               return -EIO;
> +       }
> +
> +       print_verbose("debugfs force_hw_rfkill now reports: %s\n",
> +                                               val ? "Y" : "N");
> +
> +       err =3D rfkill_class_hard_read(hci_name, &val);
> +       if (err) {
> +               fprintf(stderr, "Failed to read rfkill class state for %s=
: "
> +                                       "%s\n", hci_name, strerror(-err))=
;
> +               return err;
> +       }
> +
> +       print_verbose("rfkill class hard-block state: %s\n",
> +                                               val ? "blocked" : "unbloc=
ked");
> +
> +       if (val !=3D enable) {
> +               fprintf(stderr, "rfkill class state mismatch: expected "
> +                                       "%s, got %s\n",
> +                                       enable ? "blocked" : "unblocked",
> +                                       val ? "blocked" : "unblocked");
> +               return -EIO;
> +       }
> +
> +       printf("OK: hci_dev and rfkill class agree HW rfkill is %s\n",
> +                                               enable ? "ON" : "OFF");
> +
> +       return 0;
> +}
> +
> +static void usage(void)
> +{
> +       printf("hci_rfkill - generic HW rfkill stack test driver\n"
> +               "Usage:\n");
> +       printf("\thci_rfkill [options] <hciN>\n");
> +       printf("options:\n"
> +               "\t-t, --toggle       Toggle HW rfkill on then off "
> +                                                       "(default)\n"
> +               "\t-e, --enable       Only assert HW rfkill (block)\n"
> +               "\t-d, --disable      Only de-assert HW rfkill (unblock)\=
n"
> +               "\t-r, --restore      Restore the adapter to its pre-test=
\n"
> +               "\t                   up/down state afterwards (unblockin=
g\n"
> +               "\t                   HW rfkill does not reopen the devic=
e\n"
> +               "\t                   on its own; that is normally done b=
y\n"
> +               "\t                   bluetoothd reacting to the rfkill\n=
"
> +               "\t                   event via mgmt). Note: combined wit=
h\n"
> +               "\t                   -e, restoring an adapter that was u=
p\n"
> +               "\t                   will fail with ERFKILL, since it is=
\n"
> +               "\t                   left HW-blocked on purpose\n"
> +               "\t-v, --verbose      Show verbose output\n"
> +               "\t-h, --help         Show help options\n");
> +}
> +
> +static const struct option main_options[] =3D {
> +       { "toggle",     no_argument,    NULL, 't' },
> +       { "enable",     no_argument,    NULL, 'e' },
> +       { "disable",    no_argument,    NULL, 'd' },
> +       { "restore",    no_argument,    NULL, 'r' },
> +       { "verbose",    no_argument,    NULL, 'v' },
> +       { "help",       no_argument,    NULL, 'h' },
> +       { }
> +};
> +
> +int main(int argc, char *argv[])
> +{
> +       const char *hci_name;
> +       int mode =3D 't';
> +       bool restore =3D false;
> +       int opt;
> +       int hdev_id =3D -1;
> +       bool was_up =3D false;
> +       bool have_pre_state =3D false;
> +       bool write_succeeded;
> +       int ret =3D EXIT_SUCCESS;
> +       int err;
> +
> +       while ((opt =3D getopt_long(argc, argv, "tedrvh",
> +                                               main_options, NULL)) !=3D=
 -1) {
> +               switch (opt) {
> +               case 't':
> +               case 'e':
> +               case 'd':
> +                       mode =3D opt;
> +                       break;
> +               case 'r':
> +                       restore =3D true;
> +                       break;
> +               case 'v':
> +                       verbose =3D true;
> +                       break;
> +               case 'h':
> +                       usage();
> +                       return EXIT_SUCCESS;
> +               default:
> +                       usage();
> +                       return EXIT_FAILURE;
> +               }
> +       }
> +
> +       argc -=3D optind;
> +       argv +=3D optind;
> +
> +       if (argc < 1) {
> +               usage();
> +               return EXIT_FAILURE;
> +       }
> +
> +       hci_name =3D argv[0];
> +
> +       hdev_id =3D hci_name_to_id(hci_name);
> +       if (hdev_id < 0) {
> +               fprintf(stderr, "Invalid hci device name %s\n", hci_name)=
;
> +               return EXIT_FAILURE;
> +       }
> +
> +       if (restore) {
> +               err =3D hci_dev_is_up(hdev_id, &was_up);
> +               if (err) {
> +                       fprintf(stderr, "Failed to query %s up state: %s\=
n",
> +                                               hci_name, strerror(-err))=
;
> +                       return EXIT_FAILURE;
> +               }
> +
> +               have_pre_state =3D true;
> +               print_verbose("%s pre-test state: %s\n", hci_name,
> +                                               was_up ? "up" : "down");
> +       }
> +
> +       switch (mode) {
> +       case 'e':
> +               if (run_test(hci_name, true, &write_succeeded))
> +                       ret =3D EXIT_FAILURE;
> +               break;
> +       case 'd':
> +               if (run_test(hci_name, false, &write_succeeded))
> +                       ret =3D EXIT_FAILURE;
> +               break;
> +       case 't':
> +       default:
> +               err =3D run_test(hci_name, true, &write_succeeded);
> +               if (err)
> +                       ret =3D EXIT_FAILURE;
> +               if (write_succeeded) {
> +                       if (run_test(hci_name, false, &write_succeeded))
> +                               ret =3D EXIT_FAILURE;
> +               }
> +               break;
> +       }
> +
> +       if (restore && have_pre_state) {
> +               err =3D hci_dev_set_up(hdev_id, was_up);
> +               if (err) {
> +                       fprintf(stderr, "Failed to restore %s to its "
> +                                       "pre-test %s state: %s\n", hci_na=
me,
> +                                       was_up ? "up" : "down",
> +                                       strerror(-err));
> +                       ret =3D EXIT_FAILURE;
> +               } else {
> +                       print_verbose("%s restored to pre-test state: %s\=
n",
> +                                       hci_name, was_up ? "up" : "down")=
;
> +               }
> +       }
> +
> +       return ret;
> +}
> --
> 2.53.0
>
>


--=20
Luiz Augusto von Dentz

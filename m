Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com [74.125.224.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931B6492E27
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773013; cv=pass; b=SKSoWZzxZBct6Qrf0pVBZwOd4OLBCbp8jyjPbCy6X3F5j2Ce7xvr6Ax/w7Ki2jwSc02wlCQ/XiNYuI8vQOKvT+BL0nU0U0rlMWLCxrgfgbwnhHrJLpfQzMf5IHCE/N/YwJCWZ1oDHLiaOd+6k+udUAUxCOpCdHESzULQEc1KpYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773013; c=relaxed/simple;
	bh=aaVUs8rNGF9g/7HACM4BILlw57mnbDgh2PoYU1tdxUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ahxs5XRf+Htpwvm4/pgVNIAAdXOrMEsLePwWHuiSBSKKiYcJ5++eRQk5P0cg7ekW2Os/vJCN+M8ZRLGpzi4u7sHr9lqBWF7AEronp+ziHsRxk/wcwH6AQpy2azr/OZOks+1SQycW+QNmcKqTZvbYTU1Mk8BF+jL8gdMbBVfcmxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A60RKepi; arc=pass smtp.client-ip=74.125.224.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A60RKepi"
Received: by mail-yx2-f38.google.com with SMTP id 00721157ae682-8ab408a38bdso7884507b3.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 05:56:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790773008; cv=none;
        d=google.com; s=arc-20260327;
        b=dE+gowFUnRTjafK4jk6KIjNTVMtVgMFYCB95DkGpMc5Nn8Ol7HLgX4z3nUZHmIkZYx
         Mf5XGvCdPsrwipiZ5cDNLm39S1tKUhUurzYQw06pj5V5zUc2jU/j9loy1l3SpzbR8kU6
         Y1jAXZjKWTXXRcowegDtyyZ9QNq4dugk8UBWHb3fEfyh1l9bZgpKqj7VDM27Tg2SFQFJ
         vQtCwwybm9WQPHF/4NIvHWU3pjlhEzITaNjwVOAaAmx5CxD7liR5YujANndodCthP6xR
         qG7QVaCFNV6Dh2sr20XNE7ExopM6b3cyRGmfeRHiNR1+AlA9iwq/vZzC6Su472ApMBT3
         /LTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ev1zkCD6HNNPXhBPhO6KNE8pSyaKNyAcEndriqkNUH8=;
        fh=XYDkU1TTZTlQiedNyhQBOXJRcm2xFOG4rWZzy7Q8TSk=;
        b=WZ6xP417FPOfhHu0UO8hqVAEepUa8rpxIBV/zn51vpIVvVgwjQ2VoU+YTy9+e8JLlP
         0lQIUCQvBFQzoGRxlJTZVc9otRRi5WkAQF9mJ1ZR66X3YX5HNeTI6HO7QxT21a6Ldbd9
         vvXXtMMQf3rdSRVksqd8QzCyJwtgJJk1IchTh3O6Y/gziDuuwG5Ywv7gtfDJFF9RHOwC
         pm51GRWie/5fbn1TswY36DfR+yN1r/nnIWfVilYGjOyeJLRvSQwh7dcVdMOin8h+J4nv
         6GXHf6wpl3rgmNnH6ia0D/4/VDGOY4U0OAkpLAEEVr6yHbSDlo4pBdvX4WNccpHn7m17
         uhCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790773008; x=1791377808; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ev1zkCD6HNNPXhBPhO6KNE8pSyaKNyAcEndriqkNUH8=;
        b=A60RKepizrcjEYVLDpQzMN1I6Khhy1oHpq3ruZ+vLmH73ssRZS1VWadISK4IUx9+YE
         dFAzjMisKa9XDiWyYBKed9qMJNZMgkTBXeT7YAW80ITX/nrSJRTWhB8+Vi3mhnr4v9lt
         UzcbeVsKSFvISaCX9qM5oVBB2K50z/gNeAx40m5wHgOqcqKGSUdy5t9VjI0my2EHkYwF
         tToPRliLAO6RF3ZdBuRBLPIxlLMRXsXSIRASZ3ZhqgWVpmRXgJ26kaaSe58sxigPLWbH
         rCMkhql3Gq/pw6EBa9YoZi0CVH7RF+EWyfrdYZgyI8n6UkKzhdEMLMqsCsnoT6rxVrbA
         i6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790773008; x=1791377808;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ev1zkCD6HNNPXhBPhO6KNE8pSyaKNyAcEndriqkNUH8=;
        b=YrMgqGVuAjHkQr/KIcHMuH6wxghgOWURWrI5n2g8cK/C33vFKSfZjtBaf4S0j3+a6N
         Et3HvOZb98ZMAjVsriviZ5DM/tGb15mQamRplkj1CR7h7bGd34rsD5iPs98kQi+Qy6nA
         Z3wJW865nGXCasRUoUBoG8DuG1YWTFb4MXAF9bP37lhxyWX6+mGOUVkT9r0KHvPGB2Hk
         TZsEiIlHBezab+88gQN8t4kPwloTs4oinjlPag5QnpNcYHhT+Z2PAe4GEw366AyEb9IH
         cLH4KtM14XWhG3+BnSd8cAnb5PjhpUJD25d+licC1Q2Aj3ao+/FdspPmtASvqgqeoWo4
         51/g==
X-Gm-Message-State: AFq9FYJfHAQUGTOrmZyqX5Z2SRwdtSFJMAceX+NJIH1AN9pTY+ojUglG
	9WEASsdQW/lWOLu1EeCL5rjxWGKmrRCTjsa1E6srWau8Fri/x0FnfR3cYIAnF1yPfR5hZKX+keM
	z44O47LAWoN7wwNmOjckwFhSOAjrFdwk=
X-Gm-Gg: AYBFou1aaLQ7yDgyonB88q13IUu3Mesvbxt1XQBdcItF9cJq5JQNzmtzKFIISQNyDo1
	fl+Yxuv+AbsxTmOaLH+259kFMGsysCaF6fnXh1BHViFpPIHJ0NoXO0+U15ZvMaMPC+jysZM29N2
	HYGSwHAsjsdXMfS2rnFuTNeUO9Skyq/wRPBljV21WoyQ+PGJrSjGDkbr/xIDzp8BhPPsisHbSII
	KUrLSAHPjW7TWkekUqP0Zz7WdZWD+hKCUgQBWezSv0hkjIs58TaSJG0axPGUzQtimZ11rkr016R
	ulZoQfBbKcII9rzDxW1VI2vF6eFAEvHHIK4z0cf5sXkb/aHIAUIPbkAaye8yYAmVqYr61SbYA3I
	LwZTO8ex9pihCuD7Hxo2U3ijIwJ+e4uJE17n0noo=
X-Received: by 2002:a05:690c:4f01:b0:86c:295c:8d1c with SMTP id
 00721157ae682-8ac94db79b0mr3011597b3.4.1790773008483; Wed, 30 Sep 2026
 05:56:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790752799.git.aluvala.sai.teja@intel.com> <af7525184b7c910d8f5bc313805ac31293711c19.1790752799.git.aluvala.sai.teja@intel.com>
In-Reply-To: <af7525184b7c910d8f5bc313805ac31293711c19.1790752799.git.aluvala.sai.teja@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 30 Sep 2026 08:56:36 -0400
X-Gm-Features: AclHuK-iahTkiAUnrjWorfya2F-paD8rBDewaeVB13yc8xTOsSwZAuuE7qjijFU
Message-ID: <CABBYNZ+a8w5Xyeb_n3wKkhi2Fa=o4oo_X6rtYia=Z_7SJVSXzg@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] Bluetooth: hci_debugfs: add force_hw_rfkill test hook
To: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Cc: linux-bluetooth@vger.kernel.org, kiran.k@intel.com, 
	chethan.tumkur.narayan@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sai,

On Wed, Sep 30, 2026 at 3:50=E2=80=AFAM Sai Teja Aluvala
<aluvala.sai.teja@intel.com> wrote:
>
> Add a force_hw_rfkill entry under /sys/kernel/debug/bluetooth/hciN/ for
> HCI devices with a registered rfkill handle. Writing Y/N sets the
> hardware block state through hci_rfkill_set_hw_state(), which exercises
> the generic Bluetooth HW rfkill handling without requiring a transport
> driver to assert its physical rfkill line. Reading returns the hardware
> block state from rfkill_hard_blocked(), independently of any software
> block. Writing the current state returns -EALREADY.

I guess the first thing we need to ask ourselves is why we need a
dedicated entry for rfkill?

> The read and write handlers check HCI_UNREGISTER and hdev->rfkill under
> hdev->unregister_lock, so they fail with -ENODEV rather than use an
> rfkill handle that is being destroyed. The entry uses custom open and
> release operations that pin the debugfs file with debugfs_file_get() and
> debugfs_file_put(), so hdev cannot be released while a descriptor is
> open. After a successful write, the handler drops unregister_lock and
> flushes hdev->rfkill_block, so the caller observes the settled
> HCI_RFKILLED state without blocking the work, which may itself need that
> lock.
>
> The hook does not exercise driver-specific interrupt, doorbell or
> register logic that detects the hardware event; that still requires
> real hardware or transport-level emulation.
>
> Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
> ---
>  net/bluetooth/hci_debugfs.c | 107 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
>
> diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
> index 2559fb6324d6..a14d2ae8cab5 100644
> --- a/net/bluetooth/hci_debugfs.c
> +++ b/net/bluetooth/hci_debugfs.c
> @@ -20,6 +20,7 @@
>
>  #include <linux/debugfs.h>
>  #include <linux/kstrtox.h>
> +#include <linux/rfkill.h>
>
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
> @@ -306,6 +307,108 @@ static const struct file_operations sc_only_mode_fo=
ps =3D {
>         .llseek         =3D default_llseek,
>  };
>
> +static int force_hw_rfkill_open(struct inode *inode, struct file *file)
> +{
> +       int err;
> +
> +       err =3D debugfs_file_get(file->f_path.dentry);
> +       if (err)
> +               return err;
> +
> +       err =3D simple_open(inode, file);
> +       if (err)
> +               debugfs_file_put(file->f_path.dentry);
> +
> +       return err;
> +}
> +
> +static int force_hw_rfkill_release(struct inode *inode, struct file *fil=
e)
> +{
> +       debugfs_file_put(file->f_path.dentry);
> +
> +       return 0;
> +}
> +
> +/* Test-only hook to simulate a HW rfkill event without needing the
> + * underlying transport driver to assert its real rfkill line. It drives
> + * hci_rfkill_set_hw_state() directly, exercising the same rfkill core
> + * notification (hci_rfkill_set_block()) and power on/off handling that =
a
> + * genuine HW rfkill interrupt from any driver would trigger.
> + */
> +static ssize_t force_hw_rfkill_read(struct file *file, char __user *user=
_buf,
> +                                    size_t count, loff_t *ppos)
> +{
> +       struct hci_dev *hdev =3D file->private_data;
> +       char buf[3];
> +       bool blocked;
> +
> +       mutex_lock(&hdev->unregister_lock);
> +       if (hci_dev_test_flag(hdev, HCI_UNREGISTER) ||
> +           IS_ERR_OR_NULL(hdev->rfkill)) {
> +               mutex_unlock(&hdev->unregister_lock);
> +               return -ENODEV;
> +       }
> +       blocked =3D rfkill_hard_blocked(hdev->rfkill);
> +       mutex_unlock(&hdev->unregister_lock);
> +
> +       buf[0] =3D blocked ? 'Y' : 'N';
> +       buf[1] =3D '\n';
> +       buf[2] =3D '\0';
> +       return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
> +}
> +
> +static ssize_t force_hw_rfkill_write(struct file *file,
> +                                     const char __user *user_buf,
> +                                     size_t count, loff_t *ppos)
> +{
> +       struct hci_dev *hdev =3D file->private_data;
> +       bool enable;
> +       int err;
> +
> +       err =3D kstrtobool_from_user(user_buf, count, &enable);
> +       if (err)
> +               return err;
> +
> +       mutex_lock(&hdev->unregister_lock);
> +       if (hci_dev_test_flag(hdev, HCI_UNREGISTER) ||
> +           IS_ERR_OR_NULL(hdev->rfkill)) {
> +               err =3D -ENODEV;
> +               goto unlock;
> +       }
> +
> +       if (enable =3D=3D rfkill_hard_blocked(hdev->rfkill)) {
> +               err =3D -EALREADY;
> +               goto unlock_flush;
> +       }
> +
> +       hci_rfkill_set_hw_state(hdev, enable);
> +       err =3D count;
> +
> +unlock_flush:
> +       mutex_unlock(&hdev->unregister_lock);
> +
> +       /* hci_rfkill_set_hw_state() updates the rfkill core state
> +        * synchronously, but applies the HCI_RFKILLED flag and resulting
> +        * power handling asynchronously via hdev->rfkill_block. Flush af=
ter
> +        * dropping unregister_lock because the work may submit a sync co=
mmand
> +        * that also takes this lock.
> +        */
> +       flush_work(&hdev->rfkill_block);
> +       return err;
> +
> +unlock:
> +       mutex_unlock(&hdev->unregister_lock);
> +       return err;
> +}
> +
> +static const struct file_operations force_hw_rfkill_fops =3D {
> +       .open           =3D force_hw_rfkill_open,
> +       .read           =3D force_hw_rfkill_read,
> +       .write          =3D force_hw_rfkill_write,
> +       .llseek         =3D default_llseek,
> +       .release        =3D force_hw_rfkill_release,
> +};
> +
>  DEFINE_INFO_ATTRIBUTE(hardware_info, hw_info);
>  DEFINE_INFO_ATTRIBUTE(firmware_info, fw_info);
>
> @@ -352,6 +455,10 @@ void hci_debugfs_create_common(struct hci_dev *hdev)
>         if (hdev->fw_info)
>                 debugfs_create_file("firmware_info", 0444, hdev->debugfs,
>                                     hdev, &firmware_info_fops);
> +
> +       if (!IS_ERR_OR_NULL(hdev->rfkill))
> +               debugfs_create_file("force_hw_rfkill", 0644, hdev->debugf=
s,
> +                                   hdev, &force_hw_rfkill_fops);
>  }
>
>  static int inquiry_cache_show(struct seq_file *f, void *p)
> --
> 2.53.0
>


--=20
Luiz Augusto von Dentz

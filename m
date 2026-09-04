Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18F532470E
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 00:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788483353; cv=pass; b=j+BjQMNd5/tb6z24AYNcytpxc/DeZP36EYu4U5R2iORqOE2ULy2kxwBMrZspGUX3jSDbDfEbVyZtVpiAwb2btnLija0+7Wbc2C9KRRHRd+4ULo+29D9gLMrfSPKreQMKdY2E/U8ZyhPkvJqnOkoZEekNRZyqQmVPVI71layItKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788483353; c=relaxed/simple;
	bh=0lpYs+0SMd/t3rfQna2KQK7enevRVV/qjLJ50LWU4xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nEbb9KJvKkIkWPUAixG1cRmzWg2mWp6itCJOZ5W63VgBZ9x2/xoXVKxVJNXct/4ajHvhoAdkE3XyCmLT+8inwcapLDzKGlqd+Za+fq7sEE1mvgyZzcPa4zgeswFW4Ml5F2i07a8Hd1MdT+JREQDGItgpbLDbo55a/xRxWyTQLNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdKYKksf; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdKYKksf"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e9ecb1e13cso449900a34.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 17:55:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788483350; cv=none;
        d=google.com; s=arc-20260327;
        b=avBBdWeshV2+MjXbqnjx500X8DnMWDm8CUpcVgHIF0jNx3UnQ07dVaj/YAxtBcFL2E
         FNBOEMFx6B4WVNbECSzsw796k43N1Tw+Ui4GiEsKEmuQhfni7Bxcz9jXozYwkNy7s2ZA
         2xVUDML1VfIK+S3VPkrUNnBsxvrz8v+BCzZwe4ZD1wMJS6706T+Xfz7b3va2I+ATZ2BT
         WVNfc5qLd0MfwudwKl6l0zIegkg+pcAlo6p50ImS0Q/V0TS9sCbEqB2Qn+LT19IyjPm4
         ixFMajygP6StiNzyUH57OlqJAwlIDFhf5uDTdZI5ryjlsBuQH6sSkvHBdFzRAjlWlhKS
         AzlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=b2FWJKV2IGmtFNZcy7f2OIRNyu0QStHoGtkGvfLTgac=;
        fh=lanPNtKzmg+jnu/jaxayKzzdm100I5RCGb3wyhib1TU=;
        b=hFV6HR0QpKmSZqfYELtmxJFJZvvsgQqSN/yXs1OIMYRN77aXwK20z4+v0OmatOLEj0
         fKehIT7mHmEXLrwzCGvU64bnXX96V45IXcB7Nbfpfstxrb+HLWIGPOCEKQlHOg211fzP
         Sxg5Wivib3o5AOTQaerJ6pqoLATRTCnNng4IHBjkdKx8njYd3NIWoWDAcHPRxI2FthxF
         NXP0TYM8nkRWjdPyOvfXZQrUqE57TxobxC9Vl07fhQD9qZQPdfY3OD5UcmY7/UtwY/iK
         4wektZQfwU+uNGo0xRmGLhf1Rm0v0RiPGCiNbdO7HSUgMjDlqijArq/WyhNRfn9almxt
         O9KA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788483350; x=1789088150; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b2FWJKV2IGmtFNZcy7f2OIRNyu0QStHoGtkGvfLTgac=;
        b=ZdKYKksfGPsxluG10GxS+51S6PCzcL6rSHJCKljYU0n8OtyhIbKXzlvbp5r4OhHoD7
         Oq7wE2zzZYxN3l5WA954WnElyHQhNsS6HpEUMde+R9nqWNcriY4kZANTWMSawUDF8dJU
         qrul8FPhDRRA9UE9MTmXO3H+Zh7FLjvFcJXwPGQv7Zry+5dgTZRcriRA3gEBDkoE8tB6
         egz044Fi/XeKvowMpJQ4OXwO9E+kGTjWBsxNnMdXexBlKZvOTX8hkUaKd9/eKRGVJ7lp
         bTMJmbGdpjeCQLscy3AUon/tNhp8QtbOTrVeNMlRT6Ria5M3dgtl9U89zpmWKII++WYC
         U1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788483350; x=1789088150;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b2FWJKV2IGmtFNZcy7f2OIRNyu0QStHoGtkGvfLTgac=;
        b=s7cQ6+wCSt+hS4btuOmOvaBeS5MeYEZdtOXw57NME7xpaZno6P6AUo76GuBdvmP95t
         JpCENRDIn5ug+LwPY/8APRVz7l/vJzfKJfRHdRLFUXXTByx0Jwb9fSAwdcM36wqyJHxS
         TPmyDQ060xzSpfZQBxIBgroLtiq/GZ5zEa7wTiAnrh9muejGs6y8RTcA1Au2LS5AIIUc
         m3o8oNLoxCWOLlfXtqg7faXzQ9WGMwZYcowCzpsgnqYAxxzwFLtt/9BRzs03YGHGWvcV
         94TPdnZymWkd2wLWLIfNNo4W2nIsJvW1hndRzacpHKxp8Lm+l07kkgUHkVb2SFwfRsql
         MRKw==
X-Forwarded-Encrypted: i=1; AKwUvBx6ey5+CYi2mi/QJONyspDU5Jv0VJ+yffOktWwLve0Odi7jM+brS9uerhBnLFI6p7PbWbFI9SxOYjN/8jOY5Wo=@vger.kernel.org
X-Gm-Message-State: AFuF++nVAe27lzc9xx8w1FbsqbzeoDC8LegXgNy88Q6rmFQwyupns8Y9
	Q+Pp3oJqp24BS8mcKe2hrWN3ApxTXWRR1oq/0JjCcNxBhzo/yxlzEZebmr7frZjqaW5PDzmXG1C
	Wo8WdEPqCgEuXgWqzZfbOAFfQN6/9YGI=
X-Gm-Gg: AYBFou12uknMyjRuv3VPV1fMhXV24zproSzYrLAKd7o5oiHPC9f6eFtemW18u5Rb5aK
	un+CBGRLGcVDUfqhDUoyGzxG13/jCGNrvJNbHOA7LNMU4F4xt5jQ8rhuMFEoH2MMgrOskOOlARO
	Zl2BkXJwYQla/OV+XjXttj6mYqjYx8xOdCJLkT04ZavbgdEGrigdjVreenUG9nKe0hVUUJYw+Cw
	6qvqR66NdrREx3GHuv77uTB7xdrYmpMSZdaLOMC+xkirq/93mJWzINreze/IqKFXrbclocKivVe
	DVfwWYM3gSF+4AsnO16gZUG0es+Hunm6TmBFPXGceCQfjsG0lHlZmUDE2sx3k09nJ5soGV/wIDI
	HDwr/PGUr+OHFqfDmCGQjAAGNEW1HTXEJGoHLh/7WaOg=
X-Received: by 2002:a05:6830:838a:b0:7fa:5c49:524f with SMTP id
 46e09a7af769-7fa5c495490mr620783a34.22.1788483350487; Thu, 03 Sep 2026
 17:55:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902235132.453044-1-mikhail.v.gavrilov@gmail.com> <947b663be7dded8a00aad6a277bb82eb8a9069be.camel@iki.fi>
In-Reply-To: <947b663be7dded8a00aad6a277bb82eb8a9069be.camel@iki.fi>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Fri, 4 Sep 2026 05:55:38 +0500
X-Gm-Features: AcwNN1Xi_wVYD0L91JvsounBFuKRljXsI-H3wpipPx0WFetbJvnCDU3JzHFgzCU
Message-ID: <CABXGCsMuYKVXyDN5avoxJTGf5-VPud7EctuZn7Z4p4wCbJq=JQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: RFCOMM: defer security confirmation to krfcommd
To: Pauli Virtanen <pav@iki.fi>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, nicoyip.dev@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+74071deb72339c215b2e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Pauli,
thanks for the review.

> Sashiko review comment that security_cfm() cleanup should be run in
> rfcomm_init() after hci_unregister_cb(), appears correct.

Correct, and rfcomm_init() is exactly where it matters: the error path
runs kthread_stop() at the stop: label and hci_unregister_cb() only at
unregister:, so a confirmation queued in between would have outlived the
thread that frees it.  v2 has rfcomm_flush_security_cfm(), which just
drops the queued entries, called after hci_unregister_cb() in
rfcomm_init() and after kthread_stop() in rfcomm_exit().  The drain at
the end of rfcomm_run() is gone.

> However, rfcomm_session_get() could return a different session if
> processing is delayed. Is this a concern? ABA issue?

It is.  Nothing keeps a session alive while the confirmation waits:
__rfcomm_dlc_close() can drop the last DLC and rfcomm_dlc_open() can
create a new session to the same peer, both from a syscall, without
krfcommd running in between.  The lookup is by (src, dst), so the new
session matches and a stale RFCOMM_AUTH_ACCEPT can be set on a DLC that
asked for BT_SECURITY_HIGH while the current link is weaker.

v2 compares the session's hci_conn with the one the confirmation was
reported for and skips the session if they differ.  Comparing pointers
is safe because the entry holds a reference on the connection, so the
object cannot be freed and reused while it is queued.

> This patch introduces data race in read of conn->cfm->sec_level,
> probably benign, but these are not marked with READ_ONCE/WRITE_ONCE.
>
> I'd maybe take hdev_lock in rfcomm_process_security_cfm instead.

Done that way in v2: the entry pins the controller with hci_dev_hold()
and krfcommd takes hdev->lock around applying the confirmation, so
conn->sec_level is read in the same context as before the change and
nothing needs new READ_ONCE()/WRITE_ONCE() annotations.  rfcomm_mutex ->
hdev->lock is the order rfcomm_dlc_open() already uses, so this does not
bring the cycle back.

> Context analysis annotations would be useful here:

Added __guarded_by(&security_cfm_lock) on security_cfm_list and
__must_hold(&rfcomm_mutex) on __rfcomm_security_cfm().

I left the list_head member of struct rfcomm_sec_cfm unannotated:
rfcomm_process_security_cfm() moves the whole queue to a local list with
list_splice_init() and from then on the entries are private to that
thread, so the list_del() and the free happen without the spinlock and
__guarded_by(&security_cfm_lock) on the member would flag correct code.

I could not build with LLVM here - no clang 23 - so the annotations are
by inspection only, gcc W=1 and checkpatch --strict are clean.  If you
have the checker at hand a run on net/bluetooth/rfcomm/ would be
welcome.

-- 
Thanks,
Mikhail

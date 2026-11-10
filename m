Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794288173;
	b=vi0l5P8pXupo3t16gNd4cJLWFtmNIKSkgQ26y+DUyRL4MCuClZ7MPcLZUmDXmQYUlK8D
	 mvIeLr9Wr94XQGHmlLnjUFTtoSgTmpflIKqK8HQrSIkwHlBD8pTKPpXKw8iQtIVsjIoYb
	 V6qOBZTOu4KX0G4waFfVWBGGdt826T1zABHgtBKhcWUU+AxLMXcOC/CqRveXKGDiUwy+9
	 KKHgcgkKH3QqS9fF654K+Gfqy4/P3/xUdECxEx05fkbQDQ32d26fXiwAL7y/GkWa3Zup+
	 bNzFLJsAW+QsnDeIn9BA924TAiuucksstM4qLZT4Rgu9Hx609IWYoXxi7VDnuv1SR+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794288173;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=DKPIMO35GoHu4ymy+ZudrzxsVuwPuFu3tcLtjbWbxy0=;
	b=w/PE1eVyvTbQOc/KdSl8p2mWBTq3ZPMYLzYoCw02scC4w9glNVhWbF6x1A6kMsKguUUY
	 wyDEvmi6p8RWkACu/ZNmzq0XsaeF/70iI+UMMEqCfJjJbVyx++eWJUZZ9D82VtYToqJc1
	 KXck5RkdYmT6wT1FWOWyF/8RQUDnyoKVXPddpo6ah1UGCVhvORSqJoDdI6fWo6QtmZyzM
	 mEJYjukrjAa+KXNFobTkDrSM4drZNYEN5Eay+RAnjSrnchowRj5eatJvGLTO2EnGCWYHo
	 OnSOJFWCfx+9FRf/peFFwYXMg9Sc7eA/OtTC2QEl0fW8yxOaJsxJWhBJi9zUVbI1Gfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=pass smtp.mailfrom=iiitd.ac.in;
	dkim=pass header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=bUO2zcOi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A6D606A325
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 05:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25A6D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=bUO2zcOi
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4d473cfff6so228302766b.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 21:22:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794288159; cv=none;
        d=google.com; s=arc-20260327;
        b=JNfbtbyajArJxh0ASp1ueroiulcI0nj4zyw6bx6C7cfOHXYChN2u8On34Vym8hsh+7
         mUsKTm0fdmiNnqJxpnJuv/KIRHGzNqxTPomxiDhJXHBb6FAx704vOE9suAOfGlVSAQA1
         Pnwf+vRzuuuHLyEFCn9+p+vPbW6k6wS2oTxyH8c0JIkL8GHEoGYzhpjSgiaQTz9ySp50
         sjftSPE7C+nE3QcNfnZrmCmzfdBMqkNnGIXz0WtCHVmzcXo/olPDnkVegrQJOn7tPcze
         QxsEjMiKIvu/GaE+lHEOz5hLUrW2GY+B0CC4Uq0RhfJp7Pl9V2txqsubGONM+OrwFlfx
         3u2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=DKPIMO35GoHu4ymy+ZudrzxsVuwPuFu3tcLtjbWbxy0=;
        fh=RZlyosji/hqI4aw85Yh9R4J9YjmF55lY6+77IsrG2GI=;
        b=POZTEUo+TvyFAwAH8+uAWvh6S1mx9fbAMdSwvRvZn1yEYOD1KB1liM92OpAtCN1bQa
         If8AlXzO6CpE4AmZkcyudqfwanm3SHcCi8K+55OOh6jFF588SB+ZUGmAeO9pX7o9oV7N
         QdoONe8Cp8AVe3lZcpkr0nrnYAk+J20z/TrrLH1CIqUtBNPNGLn5BKMH5c+pKX+d3IyX
         rASYNsER4K9efk/AKUKTafGrU3OGcl2UyyuglzKEmH44GskpDOd5nhoS0szT6qAjlnkX
         73pQwCPSlDqSkDTSHZJmFEpanFzEawG7RNPfH+SIn3jl6UtI1CzMsIaOWU6g+Z/Pa8a2
         5Y/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1794288159; x=1794892959; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DKPIMO35GoHu4ymy+ZudrzxsVuwPuFu3tcLtjbWbxy0=;
        b=bUO2zcOidPvUoLljN8bCrmkXUiBi2AjoVzP/UZ792g97NtNPIKQP0xBteNDKVIbLra
         9K+1su1Mw5tTgfoKr1bphZIgvf90wMQiiuaXGvh/B4TJOJd0uRNYB58mqynoiTb6XxI7
         F7ghzPWob0jMHa8WBbX+dvMQXPAMKQXtjkN88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794288159; x=1794892959;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DKPIMO35GoHu4ymy+ZudrzxsVuwPuFu3tcLtjbWbxy0=;
        b=HXhUwMDU65bRzg9e5MxJmkKW4+Wt/J3wwtuGdoOWMkSrYcp5vmRi9YcGLQD0L0AZ25
         QoQ7QHHm9sziggx92faBe6efkutu9eIa3UTSlfMeXYCACr9OPy1VrK/aQDrFdo5wZcLG
         Adw96Y4UJAOx2Y/w8txZdlbUy+HoSg2viUZjfwoSl3waNollkfEdhGxRyw2D/AnW2idW
         7GR9xbJgD/8Ry5kCgFlX0Vf7Xj8ihJ6P3ECL/cAM8n4KDPLOkrrGUoPI2ZqqgIgaSaNa
         SC5+Sqz5MywLOhJbkZ4aUzrnOQ6VtWOxmBTZRAz7cJP8iTqOLxBQ5PxcHVTRl6KkSoCo
         btSg==
X-Gm-Message-State: APuU4Z/JE+wG0rolxpNTy6DP17xiCCDOlAQY7BHGlJPawfmt0FSn9uzI
	SrpZMXMHrcge0znksQNeK6ybf5yIKqbebXYKaPwu8Ja5uwejK53VY/J/l49jGD/dDKjaAtZ3OLp
	doq2JkozepW5u7glEUafu4DTc2y/SVTCt9Vw0B3clEdbarXFGy0eZdsxnXg==
X-Gm-Gg: AYBFou3KaO/l+5GMOynlJqUE1HUnCbkI+rpDhEdeIp8Ge7p+hVAZxy1CSAhS4hyZhUs
	2IvrWzexXGcX2BhqNTGpENu+NKtDcUTR/YYGEEABIj8ZYEWc/+MH4C4i/yjmdmIrUHFJ59Ks3FO
	ZNvKsrwzcNKpOxHvGOeFastV7AWZHawEP2TNXh+Ql/Eq4ZIQjBjXXBe7ou3laWIvd4dK0QV4Ees
	hcIjVfmuFbNCRAHHbohCD7RSBlGnxPCqh1/PzyoU0kq4+ukxpgf7B8RHU28/GaEcB8as6L579WV
	xadQXGieTJXRTA6ysmsBFD/DaW46d2JqtFk5ET/bwOCPUNCCvElS52AN5HgF/wtBPcj9PyWis4g
	mNXG6eJrqf+OtRqNSjgDba8ZzVqPOJBiJ1LZzdBPSQ04jG3+q71Im5XRKq4DEF+J4Be/v/n93gQ
	n79cHYr/hwY5kyawSS/sCroHE1IpCHTRCiH5PEQH0f2cugcoSxurrvoRWEMaRXL+yMV+3tcCeA2
	LThDQ==
X-Received: by 2002:a17:907:daa:b0:c40:eb1a:4c8b with SMTP id
 a640c23a62f3a-c50495d6b0fmr113091466b.29.1794288159171; Mon, 09 Nov 2026
 21:22:39 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Piyus Kedia <piyus@iiitd.ac.in>
Date: Tue, 10 Nov 2026 10:52:25 +0530
X-Gm-Features: AclHuK--p4SpvrGtwpJDoZChxfL4eKDKzMm4ygHb6CCrXoM60Eg5uYldOFLJ7Po
Message-ID: <CADq=QSx3zruNoQ41d7iza=WcTikx9uxkrXQ50cXWugrYeVMb2Q@mail.gmail.com>
Subject: [BUG] Bluetooth: stack out-of-bounds write in eir_create_adv_data()
 and eir_create_scan_rsp() when a controller stops reporting LE Extended
 Advertising (seen on 7.3.1)
To: marcel@holtmann.org, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kapil Vaswani <kapil@presceralabs.ai>
Content-Type: multipart/mixed; boundary="0000000000005a7ca0065fe544cb"

--0000000000005a7ca0065fe544cb
Content-Type: text/plain; charset="UTF-8"

Hi Marcel and Luiz,

We would like to report two KASAN stack-out-of-bounds writes in
net/bluetooth/eir.c.
Both writes share the same root cause. Both are reached from the
HCIDEVUP ioctl, on the kernel's automatic restart of a stored
advertising instance.
Please find a reproducer in section 5 and a suggested fix in section 6.

  BUG: KASAN: stack-out-of-bounds in eir_create_adv_data+0x2ab/0x440
       net/bluetooth/eir.c:303
  BUG: KASAN: stack-out-of-bounds in eir_create_scan_rsp+0x119/0x1a0
       net/bluetooth/eir.c:360

In both cases a 220-byte memcpy() writes to a 31-byte buffer that is part of
a 32-byte struct on the caller's stack, overrunning it by 189 bytes.

Attached:

  eir-oob.c                      reproducer; one program, either bug
  eir-fix.diff                   the patch in section 6, as a file
  kasan-eir_create_adv_data.txt  full KASAN report for eir.c:303
  kasan-eir_create_scan_rsp.txt  full KASAN report for eir.c:360


1. Root cause
=============

An advertising instance keeps its data in adv_info, which is sized for
extended advertising:

  /* include/net/bluetooth/hci_core.h */
  struct adv_info {
          ...
          __u16   adv_data_len;
          __u8    adv_data[HCI_MAX_EXT_AD_LENGTH];     /* 251 */
          ...
          __u16   scan_rsp_len;
          __u8    scan_rsp_data[HCI_MAX_EXT_AD_LENGTH];
  };

Those two lengths are validated once in userspace by
tlv_data_is_valid() -> tlv_data_max_len() -> max_adv_len():

  /* include/net/bluetooth/hci_core.h */
  #define ext_adv_capable(dev) (((dev)->le_features[1] & HCI_LE_EXT_ADV))

  #define max_adv_len(dev) \
          (ext_adv_capable(dev) ? HCI_MAX_EXT_AD_LENGTH : HCI_MAX_AD_LENGTH)

So with a controller that reports LE Extended Advertising, up to 251 bytes
are accepted and stored. The data is then packaged for the controller
down one of two paths, chosen by ext_adv_capable() *as it is at that moment*:

  /* net/bluetooth/hci_sync.c */
  int hci_update_adv_data_sync(struct hci_dev *hdev, u8 instance)
  {
          if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
                  return 0;

          if (ext_adv_capable(hdev))
                  return hci_set_ext_adv_data_sync(hdev, instance);

          return hci_set_adv_data_sync(hdev, instance);
  }

The extended path renders into a 251-byte DEFINE_FLEX buffer and is fine.
The legacy path renders into a 32-byte struct on the stack:

  /* net/bluetooth/hci_sync.c */
  static int hci_set_adv_data_sync(struct hci_dev *hdev, u8 instance)
  {
          struct hci_cp_le_set_adv_data cp;           /* { u8 length;    */
          u8 len;                                     /*   u8 data[31] } */

          memset(&cp, 0, sizeof(cp));

          len = eir_create_adv_data(hdev, instance, cp.data, sizeof(cp.data));

and eir_create_adv_data() takes that size but does not apply it to the
following copy:

  /* net/bluetooth/eir.c */
  u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr, u8 size)
  {
          ...
                  /* Only add the "Flags" if it fits together with the
                   * instance advertising data; drop it rather than
                   * overflow the buffer.
                   */
                  if (flags &&
                      (ad_len + eir_precalc_len(1) +
                       (adv ? adv->adv_data_len : 0) <= size)) {
          ...
  skip_flags:
          if (adv) {
                  memcpy(ptr, adv->adv_data, adv->adv_data_len);   /* :303 */
                  ad_len += adv->adv_data_len;
                  ptr += adv->adv_data_len;
          }

The only test against `size` decides whether the optional three-byte FLAGS
field fits.  It does not gate the copy on line 303, which writes
adv->adv_data_len bytes unconditionally.

eir_create_scan_rsp() is the same bug, with the difference that it has no size
parameter at all:

  /* net/bluetooth/eir.c */
  u8 eir_create_scan_rsp(struct hci_dev *hdev, u8 instance, u8 *ptr)
  {
          ...
          memcpy(&ptr[scan_rsp_len], adv->scan_rsp_data,
                 adv->scan_rsp_len);                              /* :360 */

and its legacy caller passes the same 31-byte field:

  /* net/bluetooth/hci_sync.c, __hci_set_scan_rsp_data_sync() */
          struct hci_cp_le_set_scan_rsp_data cp;
          ...
          len = eir_create_scan_rsp(hdev, instance, cp.data);


2. Why the one-time validation does not hold
============================================

As far as we understand, the following invariants must hold for memory safety.

  1. ext_adv_capable() reads hdev->le_features[1], which is memcpy'd
     straight out of the controller's LE Read Local Supported Features
     reply (net/bluetooth/hci_event.c:1241) and re-read on every bring-up.
     Currently, this is not cleared or validated when it changes.

  2. The adv_info instances are not dropped across HCIDEVDOWN/HCIDEVUP.
     hci_adv_instances_clear() is called from exactly one place,
     hci_release_dev() (net/bluetooth/hci_core.c:2739), i.e. when the
     device goes away for good. hci_dev_close_sync() only cancels each
     instance's rpa_expired_cb work; the list and the lengths survive.

  3. There are no checks that compare stored instance against the current
     max_adv_len(hdev).  hci_powered_update_adv_sync() simply reads
     every instance it finds:

       /* net/bluetooth/hci_sync.c, hci_powered_update_adv_sync() */
       /* Call for each tracked instance to be scheduled */
       list_for_each_entry_safe(adv, tmp, &hdev->adv_instances, list)
               hci_schedule_adv_instance_sync(hdev, adv->instance, true);

As a result 220 bytes are accepted while the controller claims extended
advertising, and are later written even when it does not.  The write happens
inside the HCIDEVUP ioctl itself, from the kernel's own restart path - no
further userspace call is needed once the instance is registered.

For what it is worth, eir_create_per_adv_data() looks like a third instance
of this but is not: per_adv_data and its only caller's buffer are both
HCI_MAX_PER_AD_LENGTH, so the sizes agree.


3. KASAN reports
================

Both from Linux 7.3.1 (base commit 41f174fd422b) with CONFIG_KASAN=y,
CONFIG_KASAN_OUTLINE=y, CONFIG_KASAN_STACK=y on x86_64.  The two
traces below are cut down to the
critical frames; the full reports are attached as
kasan-eir_create_adv_data.txt and kasan-eir_create_scan_rsp.txt.  The task
name is the fuzzer process that first hit this; section 7 has the
same two reports as the attached reproducer produces them.

The banner says "-dirty" and the traces have no [inline] frames in
net/bluetooth, so to be explicit about what is local: no .c or .h file under
net/bluetooth or include/net/bluetooth is modified.  The only change in the
subsystem is a line of compiler flags appended to net/bluetooth/Makefile by
our coverage harness -

  subdir-ccflags-y += -fno-inline -fno-inline-functions \
                      -finstrument-functions-after-inlining ...

  ==================================================================
  BUG: KASAN: stack-out-of-bounds in eir_create_adv_data+0x2ab/0x440
                                     net/bluetooth/eir.c:303
  Write of size 220 at addr ffffc900043cf9c1 by task syz-executor/14158

  CPU: 1 UID: 0 PID: 14158 Comm: syz-executor Not tainted
        7.3.1-g41f174fd422b-dirty #8 PREEMPT(full)
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
  Call Trace:
   <TASK>
   kasan_report+0xd2/0x110 mm/kasan/report.c:595
   __asan_memcpy+0x40/0x70 mm/kasan/shadow.c:106
   eir_create_adv_data+0x2ab/0x440 net/bluetooth/eir.c:303
   hci_set_adv_data_sync+0xb0/0x220 net/bluetooth/hci_sync.c:1359
   hci_update_adv_data_sync+0xa9/0xf0 net/bluetooth/hci_sync.c:1383
   hci_start_adv_sync+0x5e/0xe0 net/bluetooth/hci_sync.c:1922
   hci_schedule_adv_instance_sync+0x2ef/0x330 net/bluetooth/hci_sync.c:2119
   hci_powered_update_adv_sync+0x27d/0x2d0 net/bluetooth/hci_sync.c:3526
   hci_powered_update_sync+0xf0/0x370 net/bluetooth/hci_sync.c:3694
   hci_dev_open_sync+0x72e/0x7d0 net/bluetooth/hci_sync.c:5459
   hci_dev_do_open+0x46/0xe0 net/bluetooth/hci_core.c:431
   hci_dev_open+0x1d6/0x210 net/bluetooth/hci_core.c:487
   hci_sock_ioctl+0x536/0x680 net/bluetooth/hci_sock.c:1139
   sock_do_ioctl net/socket.c:1325 [inline]
   sock_ioctl+0x581/0x830 net/socket.c:1446
   __se_sys_ioctl+0xce/0x140 fs/ioctl.c:583
   do_syscall_64+0x170/0x540 arch/x86/entry/syscall_64.c:84
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

  The buggy address belongs to stack of task syz-executor/14158
   and is located at offset 33 in frame:
   hci_set_adv_data_sync+0x0/0x220

  This frame has 1 object:
   [32, 64) 'cp'
  ==================================================================

  ==================================================================
  BUG: KASAN: stack-out-of-bounds in eir_create_scan_rsp+0x119/0x1a0
                                     net/bluetooth/eir.c:360
  Write of size 220 at addr ffffc9000a9ff9c1 by task syz-executor/9585

  Call Trace:
   <TASK>
   kasan_report+0xd2/0x110 mm/kasan/report.c:595
   __asan_memcpy+0x40/0x70 mm/kasan/shadow.c:106
   eir_create_scan_rsp+0x119/0x1a0 net/bluetooth/eir.c:360
   __hci_set_scan_rsp_data_sync+0xd2/0x270 net/bluetooth/hci_sync.c:1612
   hci_update_scan_rsp_data_sync+0xa9/0xf0 net/bluetooth/hci_sync.c:1638
   hci_start_adv_sync+0xb9/0xe0 net/bluetooth/hci_sync.c:1926
   hci_schedule_adv_instance_sync+0x2ef/0x330 net/bluetooth/hci_sync.c:2119
   hci_powered_update_adv_sync+0x27d/0x2d0 net/bluetooth/hci_sync.c:3526
   hci_powered_update_sync+0xf0/0x370 net/bluetooth/hci_sync.c:3694
   hci_dev_open_sync+0x72e/0x7d0 net/bluetooth/hci_sync.c:5459
   hci_dev_do_open+0x46/0xe0 net/bluetooth/hci_core.c:431
   hci_dev_open+0x1d6/0x210 net/bluetooth/hci_core.c:487
   hci_sock_ioctl+0x536/0x680 net/bluetooth/hci_sock.c:1139
   ...
   </TASK>

  The buggy address belongs to stack of task syz-executor/9585
   and is located at offset 33 in frame:
   __hci_set_scan_rsp_data_sync+0x0/0x270

  This frame has 1 object:
   [32, 64) 'cp'
  ==================================================================

KASAN reports and lets execution continue, so the 220-byte write completes.
Whether the frame's canary is among what gets clobbered varies from run to run.
The runs here mostly carried on past the report, and one ended as

  Kernel panic - not syncing: stack-protector: Kernel stack is corrupted
  in: hci_set_adv_data_sync+0x200/0x220
  ...
   __stack_chk_fail+0x1e/0x20

On a kernel built without KASAN there is no report at all and the stack
protector may be the only defense that detects the out of bound write.

4. Impact
=========

This is privileged-to-privileged escalation, since /dev/vhci plus
the HCIDEVUP/HCIDEVDOWN ioctls and an HCI_CHANNEL_CONTROL socket all want
root / CAP_NET_ADMIN. vhci is only the cheap way to control two successive
feature replies.

However, this may be more critical due to the source of inputs.
le_features is whatever the controller said, and the window opens whenever
a controller answers LE Read Local Supported Features differently across
two resets - buggy firmware, a controller whose capability is suppressed on
the second bring-up, or anyone in a position to tamper with the HCI
transport (a hostile USB dongle, a UART/SDIO path an attacker can reach).
The oversized data does not have to be set by the attacker either: on a
normal desktop an application registers it through bluetoothd's
org.bluez.LEAdvertisingManager1, which is how an advertisement with up to
251 bytes of data gets stored in the first place.

The overwrite is 189 bytes of attacker-chosen data past a 32-byte stack
object, in a frame that is about to return - so it is a stack-frame
overwrite with controlled contents, not just a crash.

I am reporting this on the public list because the path I can demonstrate
needs CAP_NET_ADMIN.  If you consider the hostile-controller path above to
be in scope, say so and I will take it to security@kernel.org instead.


5. Reproducer
=============

One program, eir-oob.c, reaches either sink depending on its argument.
Build and run it as root in a VM with /dev/vhci and a KASAN kernel:

    gcc -O2 -o eir-oob eir-oob.c
    ./eir-oob             # eir_create_adv_data(),  eir.c:303
    ./eir-oob scan_rsp    # eir_create_scan_rsp(),  eir.c:360

It creates a virtual controller, answers its init sequence from a forked
child, registers a 220-byte advertising instance while answering LE Read
Local Supported Features with HCI_LE_EXT_ADV set, and then takes the device
down and back up answering the same command without it.  KASAN fires inside
the second HCIDEVUP.

Expect "Bluetooth: hci0: unexpected cc 0x.... length: 250 > N" warnings on
the console: the responder answers every command it does not special-case
with a maximum-length Command Complete, since a reply shorter than the
opcode's hci_cc entry expects is a hard error while a longer one is only a
warning.


6. Suggested fix
================

The minimal fix is to make both functions respect the destination size,
which also gives eir_create_scan_rsp() the parameter it is missing.  Patch
below (against 7.3.1; applies with no fuzz).

Returning 0 rather than truncating is deliberate: a truncated AD structure
would not be parseable by a peer anyway, and both callers already treat 0
as "nothing to send".

There is a second-order question we have not addressed because it is a policy
call rather than a memory-safety one: with this patch an instance that was
registered while the controller supported extended advertising is silently
not advertised after it stops.  Dropping such instances (or clamping them)
in hci_powered_update_adv_sync() may be the better behaviour, but that is
your call to make.

diff --git a/net/bluetooth/eir.c b/net/bluetooth/eir.c
--- a/net/bluetooth/eir.c
+++ b/net/bluetooth/eir.c
@@ -300,6 +300,16 @@ u8 eir_create_adv_data(struct hci_dev *hdev, u8
instance, u8 *ptr, u8 size)

 skip_flags:
  if (adv) {
+ /* The instance's length was validated against max_adv_len()
+ * when it was set, and max_adv_len() depends on a controller
+ * capability that is re-read on every bring-up - so by now it
+ * can be larger than the caller's buffer. Refuse rather than
+ * overflow; a truncated AD structure would not be parseable
+ * by a peer anyway.
+ */
+ if (ad_len + adv->adv_data_len > size)
+ return 0;
+
  memcpy(ptr, adv->adv_data, adv->adv_data_len);
  ad_len += adv->adv_data_len;
  ptr += adv->adv_data_len;
@@ -342,7 +352,7 @@ static u8 create_default_scan_rsp(struct hci_dev
*hdev, u8 *ptr)
  return eir_append_local_name(hdev, ptr, scan_rsp_len);
 }

-u8 eir_create_scan_rsp(struct hci_dev *hdev, u8 instance, u8 *ptr)
+u8 eir_create_scan_rsp(struct hci_dev *hdev, u8 instance, u8 *ptr, u8 size)
 {
  struct adv_info *adv;
  u8 scan_rsp_len = 0;
@@ -357,6 +367,10 @@ u8 eir_create_scan_rsp(struct hci_dev *hdev, u8
instance, u8 *ptr)
  if ((adv->flags & MGMT_ADV_FLAG_APPEARANCE) && hdev->appearance)
  scan_rsp_len = eir_append_appearance(hdev, ptr, scan_rsp_len);

+ /* See the matching check in eir_create_adv_data(). */
+ if (scan_rsp_len + adv->scan_rsp_len > size)
+ return 0;
+
  memcpy(&ptr[scan_rsp_len], adv->scan_rsp_data, adv->scan_rsp_len);

  scan_rsp_len += adv->scan_rsp_len;
diff --git a/net/bluetooth/eir.h b/net/bluetooth/eir.h
--- a/net/bluetooth/eir.h
+++ b/net/bluetooth/eir.h
@@ -10,7 +10,7 @@
 void eir_create(struct hci_dev *hdev, u8 *data);

 u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr, u8 size);
-u8 eir_create_scan_rsp(struct hci_dev *hdev, u8 instance, u8 *ptr);
+u8 eir_create_scan_rsp(struct hci_dev *hdev, u8 instance, u8 *ptr, u8 size);
 u8 eir_create_per_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr);

 u8 eir_append_local_name(struct hci_dev *hdev, u8 *eir, u8 ad_len);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1563,7 +1563,8 @@ static int hci_set_ext_scan_rsp_data_sync(struct
hci_dev *hdev, u8 instance)
  }
  }

- len = eir_create_scan_rsp(hdev, instance, pdu->data);
+ len = eir_create_scan_rsp(hdev, instance, pdu->data,
+  HCI_MAX_EXT_AD_LENGTH);

  pdu->handle = adv ? adv->handle : instance;
  pdu->length = len;
@@ -1609,7 +1610,7 @@ static int __hci_set_scan_rsp_data_sync(struct
hci_dev *hdev, u8 instance)
  if (instance)
  hci_dev_lock(hdev);

- len = eir_create_scan_rsp(hdev, instance, cp.data);
+ len = eir_create_scan_rsp(hdev, instance, cp.data, sizeof(cp.data));

  if (instance)
  hci_dev_unlock(hdev);

7. What was and was not checked
===============================

Verified here: the code paths above as shipped in 7.3.1, and that the
attached eir-oob.c reproduces both on an otherwise untainted kernel -

  BUG: KASAN: stack-out-of-bounds in eir_create_adv_data+0x2ab/0x440
  Write of size 220 at addr ffffc9000651f9c1 by task eir-oob/9505
  CPU: 0 UID: 0 PID: 9505 Comm: eir-oob Not tainted
        7.3.1-g41f174fd422b-dirty #10 PREEMPT(full)
   and is located at offset 33 in frame:
  This frame has 1 object:
   [32, 64) 'cp'

  BUG: KASAN: stack-out-of-bounds in eir_create_scan_rsp+0x119/0x1a0
  Write of size 220 at addr ffffc90012f379c1 by task eir-oob/9500
  CPU: 0 UID: 0 PID: 9500 Comm: eir-oob Not tainted
        7.3.1-g41f174fd422b-dirty #10 PREEMPT(full)
   and is located at offset 33 in frame:
  This frame has 1 object:
   [32, 64) 'cp'

- at the same instruction offsets as the two reports in section 3.

Not checked: how far back this goes, and whether something in
bluetooth-next already addresses it. We have no upstream history available
for this tree, so please treat the version above as "where it was seen",
not as "where it starts".  The shape of the code suggests every version
that has both eir_create_adv_data()'s unbounded copy and the
ext_adv_capable()-keyed dispatch in hci_update_adv_data_sync() is affected.

Please let us know if you need any further information.

Thanks and regards,
Piyus Kedia
Kapil Vaswani

--0000000000005a7ca0065fe544cb
Content-Type: text/plain; charset="US-ASCII"; name="kasan-eir_create_adv_data.txt"
Content-Disposition: attachment; filename="kasan-eir_create_adv_data.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mwa8tqhu2>
X-Attachment-Id: f_mwa8tqhu2

PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09CkJVRzogS0FTQU46IHN0YWNrLW91dC1vZi1ib3VuZHMgaW4gZWlyX2NyZWF0ZV9h
ZHZfZGF0YSsweDJhYi8weDQ0MCBuZXQvYmx1ZXRvb3RoL2Vpci5jOjMwMwpXcml0ZSBvZiBzaXpl
IDIyMCBhdCBhZGRyIGZmZmZjOTAwMDQzY2Y5YzEgYnkgdGFzayBzeXotZXhlY3V0b3IvMTQxNTgK
CkNQVTogMSBVSUQ6IDAgUElEOiAxNDE1OCBDb21tOiBzeXotZXhlY3V0b3IgTm90IHRhaW50ZWQg
Ny4zLjEtZzQxZjE3NGZkNDIyYi1kaXJ0eSAjOCBQUkVFTVBUKGZ1bGwpIApIYXJkd2FyZSBuYW1l
OiBRRU1VIFN0YW5kYXJkIFBDIChpNDQwRlggKyBQSUlYLCAxOTk2KSwgQklPUyAxLjE2LjMtZGVi
aWFuLTEuMTYuMy0yIDA0LzAxLzIwMTQKQ2FsbCBUcmFjZToKIDxUQVNLPgogX19kdW1wX3N0YWNr
IGxpYi9kdW1wX3N0YWNrLmM6OTQgW2lubGluZV0KIGR1bXBfc3RhY2tfbHZsKzB4MTBlLzB4MTkw
IGxpYi9kdW1wX3N0YWNrLmM6MTIwCiBwcmludF9hZGRyZXNzX2Rlc2NyaXB0aW9uIG1tL2thc2Fu
L3JlcG9ydC5jOjM3OCBbaW5saW5lXQogcHJpbnRfcmVwb3J0KzB4MTUzLzB4NzEwIG1tL2thc2Fu
L3JlcG9ydC5jOjQ4Mgoga2FzYW5fcmVwb3J0KzB4ZDIvMHgxMTAgbW0va2FzYW4vcmVwb3J0LmM6
NTk1CiBjaGVja19yZWdpb25faW5saW5lIG1tL2thc2FuL2dlbmVyaWMuYzotMSBbaW5saW5lXQog
a2FzYW5fY2hlY2tfcmFuZ2UrMHgyZDIvMHgyZTAgbW0va2FzYW4vZ2VuZXJpYy5jOjU5NAogX19h
c2FuX21lbWNweSsweDQwLzB4NzAgbW0va2FzYW4vc2hhZG93LmM6MTA2CiBlaXJfY3JlYXRlX2Fk
dl9kYXRhKzB4MmFiLzB4NDQwIG5ldC9ibHVldG9vdGgvZWlyLmM6MzAzCiBoY2lfc2V0X2Fkdl9k
YXRhX3N5bmMrMHhiMC8weDIyMCBuZXQvYmx1ZXRvb3RoL2hjaV9zeW5jLmM6MTM1OQogaGNpX3Vw
ZGF0ZV9hZHZfZGF0YV9zeW5jKzB4YTkvMHhmMCBuZXQvYmx1ZXRvb3RoL2hjaV9zeW5jLmM6MTM4
MwogaGNpX3N0YXJ0X2Fkdl9zeW5jKzB4NWUvMHhlMCBuZXQvYmx1ZXRvb3RoL2hjaV9zeW5jLmM6
MTkyMgogaGNpX3NjaGVkdWxlX2Fkdl9pbnN0YW5jZV9zeW5jKzB4MmVmLzB4MzMwIG5ldC9ibHVl
dG9vdGgvaGNpX3N5bmMuYzoyMTE5CiBoY2lfcG93ZXJlZF91cGRhdGVfYWR2X3N5bmMrMHgyN2Qv
MHgyZDAgbmV0L2JsdWV0b290aC9oY2lfc3luYy5jOjM1MjYKIGhjaV9wb3dlcmVkX3VwZGF0ZV9z
eW5jKzB4ZjAvMHgzNzAgbmV0L2JsdWV0b290aC9oY2lfc3luYy5jOjM2OTQKIGhjaV9kZXZfb3Bl
bl9zeW5jKzB4NzJlLzB4N2QwIG5ldC9ibHVldG9vdGgvaGNpX3N5bmMuYzo1NDU5CiBoY2lfZGV2
X2RvX29wZW4rMHg0Ni8weGUwIG5ldC9ibHVldG9vdGgvaGNpX2NvcmUuYzo0MzEKIGhjaV9kZXZf
b3BlbisweDFkNi8weDIxMCBuZXQvYmx1ZXRvb3RoL2hjaV9jb3JlLmM6NDg3CiBoY2lfc29ja19p
b2N0bCsweDUzNi8weDY4MCBuZXQvYmx1ZXRvb3RoL2hjaV9zb2NrLmM6MTEzOQogc29ja19kb19p
b2N0bCBuZXQvc29ja2V0LmM6MTMyNSBbaW5saW5lXQogc29ja19pb2N0bCsweDU4MS8weDgzMCBu
ZXQvc29ja2V0LmM6MTQ0NgogdmZzX2lvY3RsIGZzL2lvY3RsLmM6NTEgW2lubGluZV0KIF9fZG9f
c3lzX2lvY3RsIGZzL2lvY3RsLmM6NTk3IFtpbmxpbmVdCiBfX3NlX3N5c19pb2N0bCsweGNlLzB4
MTQwIGZzL2lvY3RsLmM6NTgzCiBkb19zeXNjYWxsX3g2NCBhcmNoL3g4Ni9lbnRyeS9zeXNjYWxs
XzY0LmM6NjEgW2lubGluZV0KIGRvX3N5c2NhbGxfNjQrMHgxNzAvMHg1NDAgYXJjaC94ODYvZW50
cnkvc3lzY2FsbF82NC5jOjg0CiBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg3Ny8w
eDdmClJJUDogMDAzMzoweDQyNzM4YgpDb2RlOiAwMCA0OCA4OSA0NCAyNCAxOCAzMSBjMCA0OCA4
ZCA0NCAyNCA2MCBjNyAwNCAyNCAxMCAwMCAwMCAwMCA0OCA4OSA0NCAyNCAwOCA0OCA4ZCA0NCAy
NCAyMCA0OCA4OSA0NCAyNCAxMCBiOCAxMCAwMCAwMCAwMCAwZiAwNSA8ODk+IGMyIDNkIDAwIGYw
IGZmIGZmIDc3IDFjIDQ4IDhiIDQ0IDI0IDE4IDY0IDQ4IDJiIDA0IDI1IDI4IDAwIDAwClJTUDog
MDAyYjowMDAwN2ZmZTdlZDBiYzYwIEVGTEFHUzogMDAwMDAyNDYgT1JJR19SQVg6IDAwMDAwMDAw
MDAwMDAwMTAKUkFYOiBmZmZmZmZmZmZmZmZmZmRhIFJCWDogMDAwMDAwMDAwMDAwMDAwOCBSQ1g6
IDAwMDAwMDAwMDA0MjczOGIKUkRYOiAwMDAwMDAwMDAwMDAwMDAwIFJTSTogMDAwMDAwMDA0MDA0
NDhjOSBSREk6IDAwMDAwMDAwMDAwMDAwMDgKUkJQOiAwMDAwMDAwMDAwMDAwMDAwIFIwODogMDAw
MDAwMDAwMDAwMDAwMCBSMDk6IDAwMDAwMDAwMDAwMDAwMDAKUjEwOiAwMDAwMDAwMDAwMDAwMDAw
IFIxMTogMDAwMDAwMDAwMDAwMDI0NiBSMTI6IDAwMDAwMDAwMDAwMDAwMDAKUjEzOiAwMDAwMDAw
MDBkYzQwM2E4IFIxNDogMDAwMDdmZmU3ZWQwYmRmZiBSMTU6IDAwMDAwMDAwMDAwMDAwMDIKIDwv
VEFTSz4KClRoZSBidWdneSBhZGRyZXNzIGJlbG9uZ3MgdG8gc3RhY2sgb2YgdGFzayBzeXotZXhl
Y3V0b3IvMTQxNTgKIGFuZCBpcyBsb2NhdGVkIGF0IG9mZnNldCAzMyBpbiBmcmFtZToKIGhjaV9z
ZXRfYWR2X2RhdGFfc3luYysweDAvMHgyMjAgaW5jbHVkZS9saW51eC9mb3J0aWZ5LXN0cmluZy5o
OjU0OQoKVGhpcyBmcmFtZSBoYXMgMSBvYmplY3Q6CiBbMzIsIDY0KSAnY3AnCgpUaGUgYnVnZ3kg
YWRkcmVzcyBiZWxvbmdzIHRvIGEgdm1hbGxvYyB2aXJ0dWFsIG1hcHBpbmcKVGhlIGJ1Z2d5IGFk
ZHJlc3MgYmVsb25ncyB0byB0aGUgcGh5c2ljYWwgcGFnZToKcGFnZTogcmVmY291bnQ6MSBtYXBj
b3VudDowIG1hcHBpbmc6MDAwMDAwMDAwMDAwMDAwMCBpbmRleDoweDAgcGZuOjB4NDQ1MTcKbWVt
Y2c6ZmZmZjg4ODAxZWJmYmYwMgpmbGFnczogMHg0ZmZmMDAwMDAwMDAwMDAobm9kZT0xfHpvbmU9
MXxsYXN0Y3B1cGlkPTB4N2ZmKQpyYXc6IDA0ZmZmMDAwMDAwMDAwMDAgMDAwMDAwMDAwMDAwMDAw
MCBmZmZmZWEwMDAxMTE0NWM4IDAwMDAwMDAwMDAwMDAwMDAKcmF3OiAwMDAwMDAwMDAwMDAwMDAw
IDAwMDAwMDAwMDAwMDAwMDAgMDAwMDAwMDFmZmZmZmZmZiBmZmZmODg4MDFlYmZiZjAyCnBhZ2Ug
ZHVtcGVkIGJlY2F1c2U6IGthc2FuOiBiYWQgYWNjZXNzIGRldGVjdGVkCnBhZ2Vfb3duZXIgdHJh
Y2tzIHRoZSBwYWdlIGFzIGFsbG9jYXRlZApwYWdlIGxhc3QgYWxsb2NhdGVkIHZpYSBvcmRlciAw
LCBtaWdyYXRldHlwZSBVbm1vdmFibGUsIGdmcF9tYXNrIDB4MjljMihHRlBfTk9XQUlUfF9fR0ZQ
X0hJR0hNRU18X19HRlBfSU98X19HRlBfRlN8X19HRlBfWkVSTyksIHBpZCAxNDE1NywgdGdpZCAx
NDE1NyAoc3l6LWV4ZWN1dG9yKSwgdHMgMTMxNjc2ODgzMDk2NzYKIHNldF9wYWdlX293bmVyIGlu
Y2x1ZGUvbGludXgvcGFnZV9vd25lci5oOjMzIFtpbmxpbmVdCiBwb3N0X2FsbG9jX2hvb2srMHgx
YjYvMHgyMTAgbW0vcGFnZV9hbGxvYy5jOjE4NzEKIHByZXBfbmV3X3BhZ2UgbW0vcGFnZV9hbGxv
Yy5jOjE4NzkgW2lubGluZV0KIGdldF9wYWdlX2Zyb21fZnJlZWxpc3QrMHgxN2MzLzB4MTgyMCBt
bS9wYWdlX2FsbG9jLmM6Mzk0MwogX19hbGxvY19mcm96ZW5fcGFnZXNfbm9wcm9mKzB4MWRmLzB4
NGYwIG1tL3BhZ2VfYWxsb2MuYzo1NDM2CiBhbGxvY19wYWdlc19tcG9sKzB4MjA4LzB4NDEwIG1t
L21lbXBvbGljeS5jOjI0ODYKIGFsbG9jX2Zyb3plbl9wYWdlc19ub3Byb2YgbW0vbWVtcG9saWN5
LmM6MjU1NyBbaW5saW5lXQogYWxsb2NfcGFnZXNfbm9wcm9mKzB4OTkvMHgyMDAgbW0vbWVtcG9s
aWN5LmM6MjU3Nwogdm1fYXJlYV9hbGxvY19wYWdlcyBtbS92bWFsbG9jLmM6MzY4OSBbaW5saW5l
XQogX192bWFsbG9jX2FyZWFfbm9kZSBtbS92bWFsbG9jLmM6MzkxNCBbaW5saW5lXQogX192bWFs
bG9jX25vZGVfcmFuZ2Vfbm9wcm9mKzB4NWQxLzB4MTE2MCBtbS92bWFsbG9jLmM6NDEwNAogX192
bWFsbG9jX25vZGVfbm9wcm9mKzB4ODkvMHhjMCBtbS92bWFsbG9jLmM6NDE2NQogYWxsb2NfdGhy
ZWFkX3N0YWNrX25vZGUga2VybmVsL2ZvcmsuYzozNTkgW2lubGluZV0KIGR1cF90YXNrX3N0cnVj
dCsweDI0ZC8weDZkMCBrZXJuZWwvZm9yay5jOjkzMAogY29weV9wcm9jZXNzKzB4NjUzLzB4Mjhj
MCBrZXJuZWwvZm9yay5jOjIxNDMKIGtlcm5lbF9jbG9uZSsweDIyMS8weDc2MCBrZXJuZWwvZm9y
ay5jOjI3ODQKIF9fZG9fc3lzX2Nsb25lIGtlcm5lbC9mb3JrLmM6MjkyNiBbaW5saW5lXQogX19z
ZV9zeXNfY2xvbmUga2VybmVsL2ZvcmsuYzoyOTEwIFtpbmxpbmVdCiBfX3g2NF9zeXNfY2xvbmUr
MHgxMzkvMHgxYTAga2VybmVsL2ZvcmsuYzoyOTEwCiBkb19zeXNjYWxsX3g2NCBhcmNoL3g4Ni9l
bnRyeS9zeXNjYWxsXzY0LmM6NjEgW2lubGluZV0KIGRvX3N5c2NhbGxfNjQrMHgxNzAvMHg1NDAg
YXJjaC94ODYvZW50cnkvc3lzY2FsbF82NC5jOjg0CiBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3
ZnJhbWUrMHg3Ny8weDdmCnBhZ2UgbGFzdCBmcmVlIHBpZCAxMzc2MyB0Z2lkIDEzNzYzIHRzIDEz
MTE3MjE4MDQzNzAzIHN0YWNrIHRyYWNlOgogcmVzZXRfcGFnZV9vd25lciBpbmNsdWRlL2xpbnV4
L3BhZ2Vfb3duZXIuaDoyNiBbaW5saW5lXQogX19mcmVlX3BhZ2VzX3ByZXBhcmUgbW0vcGFnZV9h
bGxvYy5jOjE0MTggW2lubGluZV0KIGZyZWVfcGFnZXNfcHJlcGFyZSsweDY3ZS8weDcxMCBtbS9w
YWdlX2FsbG9jLmM6MTQ2MwogX19mcmVlX2NvbnRpZ19yYW5nZV9jb21tb24rMHgxMWMvMHgyYTAg
bW0vcGFnZV9hbGxvYy5jOjcwNzIKIF9fZnJlZV9jb250aWdfcmFuZ2UgbW0vcGFnZV9hbGxvYy5j
OjcxMTcgW2lubGluZV0KIGZyZWVfcGFnZXNfYnVsaysweDQ3LzB4YzAgbW0vcGFnZV9hbGxvYy5j
OjUzMjIKIHZtX2FyZWFfZnJlZV9wYWdlcyBtbS92bWFsbG9jLmM6MzQ2MSBbaW5saW5lXQogdmZy
ZWUrMHgxYTcvMHgzMzAgbW0vdm1hbGxvYy5jOjM1MTAKIGRlbGF5ZWRfdmZyZWVfd29yaysweDNm
LzB4NjAgbW0vdm1hbGxvYy5jOjM0MTQKIHByb2Nlc3Nfb25lX3dvcmsga2VybmVsL3dvcmtxdWV1
ZS5jOjMzOTYgW2lubGluZV0KIHByb2Nlc3Nfc2NoZWR1bGVkX3dvcmtzKzB4OGUyLzB4MTBkMCBr
ZXJuZWwvd29ya3F1ZXVlLmM6MzQ3OQogd29ya2VyX3RocmVhZCsweDUwMS8weDc1MCBrZXJuZWwv
d29ya3F1ZXVlLmM6MzU2MAoga3RocmVhZCsweDI2YS8weDJjMCBrZXJuZWwva3RocmVhZC5jOjQz
NgogcmV0X2Zyb21fZm9yaysweDQ3NS8weDhjMCBhcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzcy5jOjE1
OAogcmV0X2Zyb21fZm9ya19hc20rMHgxYS8weDMwIGFyY2gveDg2L2VudHJ5L2VudHJ5XzY0LlM6
MjQ1CgpNZW1vcnkgc3RhdGUgYXJvdW5kIHRoZSBidWdneSBhZGRyZXNzOgogZmZmZmM5MDAwNDNj
Zjg4MDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAKIGZm
ZmZjOTAwMDQzY2Y5MDA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwCj5mZmZmYzkwMDA0M2NmOTgwOiAwMCAwMCAwMCAwMCBmMSBmMSBmMSBmMSAwMCAwMCAw
MCAwMCBmMyBmMyBmMyBmMwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgXgogZmZmZmM5MDAwNDNjZmEwMDogMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAKIGZmZmZjOTAwMDQzY2ZhODA6IDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwCj09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQoKPDw8PDw8PDw8
PDw8PDw8IHRhaWwgcmVwb3J0ID4+Pj4+Pj4+Pj4+Pj4+PgoKU1laRkFJTDogZmFpbGVkIHRvIHJl
Y3YgcnBjCmZkPTMgd2FudD00IHJlY3Y9MCBuPTAgKGVycm5vIDIyOiBJbnZhbGlkIGFyZ3VtZW50
KQoKPDw8PDw8PDw8PDw8PDw8IHRhaWwgcmVwb3J0ID4+Pj4+Pj4+Pj4+Pj4+PgoK
--0000000000005a7ca0065fe544cb
Content-Type: text/x-patch; charset="US-ASCII"; name="eir-fix.diff"
Content-Disposition: attachment; filename="eir-fix.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mwa8tqfs0>
X-Attachment-Id: f_mwa8tqfs0

ZGlmZiAtLWdpdCBhL25ldC9ibHVldG9vdGgvZWlyLmMgYi9uZXQvYmx1ZXRvb3RoL2Vpci5jCi0t
LSBhL25ldC9ibHVldG9vdGgvZWlyLmMKKysrIGIvbmV0L2JsdWV0b290aC9laXIuYwpAQCAtMzAw
LDYgKzMwMCwxNiBAQCB1OCBlaXJfY3JlYXRlX2Fkdl9kYXRhKHN0cnVjdCBoY2lfZGV2ICpoZGV2
LCB1OCBpbnN0YW5jZSwgdTggKnB0ciwgdTggc2l6ZSkKIAogc2tpcF9mbGFnczoKIAlpZiAoYWR2
KSB7CisJCS8qIFRoZSBpbnN0YW5jZSdzIGxlbmd0aCB3YXMgdmFsaWRhdGVkIGFnYWluc3QgbWF4
X2Fkdl9sZW4oKQorCQkgKiB3aGVuIGl0IHdhcyBzZXQsIGFuZCBtYXhfYWR2X2xlbigpIGRlcGVu
ZHMgb24gYSBjb250cm9sbGVyCisJCSAqIGNhcGFiaWxpdHkgdGhhdCBpcyByZS1yZWFkIG9uIGV2
ZXJ5IGJyaW5nLXVwIC0gc28gYnkgbm93IGl0CisJCSAqIGNhbiBiZSBsYXJnZXIgdGhhbiB0aGUg
Y2FsbGVyJ3MgYnVmZmVyLiBSZWZ1c2UgcmF0aGVyIHRoYW4KKwkJICogb3ZlcmZsb3c7IGEgdHJ1
bmNhdGVkIEFEIHN0cnVjdHVyZSB3b3VsZCBub3QgYmUgcGFyc2VhYmxlCisJCSAqIGJ5IGEgcGVl
ciBhbnl3YXkuCisJCSAqLworCQlpZiAoYWRfbGVuICsgYWR2LT5hZHZfZGF0YV9sZW4gPiBzaXpl
KQorCQkJcmV0dXJuIDA7CisKIAkJbWVtY3B5KHB0ciwgYWR2LT5hZHZfZGF0YSwgYWR2LT5hZHZf
ZGF0YV9sZW4pOwogCQlhZF9sZW4gKz0gYWR2LT5hZHZfZGF0YV9sZW47CiAJCXB0ciArPSBhZHYt
PmFkdl9kYXRhX2xlbjsKQEAgLTM0Miw3ICszNTIsNyBAQCBzdGF0aWMgdTggY3JlYXRlX2RlZmF1
bHRfc2Nhbl9yc3Aoc3RydWN0IGhjaV9kZXYgKmhkZXYsIHU4ICpwdHIpCiAJcmV0dXJuIGVpcl9h
cHBlbmRfbG9jYWxfbmFtZShoZGV2LCBwdHIsIHNjYW5fcnNwX2xlbik7CiB9CiAKLXU4IGVpcl9j
cmVhdGVfc2Nhbl9yc3Aoc3RydWN0IGhjaV9kZXYgKmhkZXYsIHU4IGluc3RhbmNlLCB1OCAqcHRy
KQordTggZWlyX2NyZWF0ZV9zY2FuX3JzcChzdHJ1Y3QgaGNpX2RldiAqaGRldiwgdTggaW5zdGFu
Y2UsIHU4ICpwdHIsIHU4IHNpemUpCiB7CiAJc3RydWN0IGFkdl9pbmZvICphZHY7CiAJdTggc2Nh
bl9yc3BfbGVuID0gMDsKQEAgLTM1Nyw2ICszNjcsMTAgQEAgdTggZWlyX2NyZWF0ZV9zY2FuX3Jz
cChzdHJ1Y3QgaGNpX2RldiAqaGRldiwgdTggaW5zdGFuY2UsIHU4ICpwdHIpCiAJaWYgKChhZHYt
PmZsYWdzICYgTUdNVF9BRFZfRkxBR19BUFBFQVJBTkNFKSAmJiBoZGV2LT5hcHBlYXJhbmNlKQog
CQlzY2FuX3JzcF9sZW4gPSBlaXJfYXBwZW5kX2FwcGVhcmFuY2UoaGRldiwgcHRyLCBzY2FuX3Jz
cF9sZW4pOwogCisJLyogU2VlIHRoZSBtYXRjaGluZyBjaGVjayBpbiBlaXJfY3JlYXRlX2Fkdl9k
YXRhKCkuICovCisJaWYgKHNjYW5fcnNwX2xlbiArIGFkdi0+c2Nhbl9yc3BfbGVuID4gc2l6ZSkK
KwkJcmV0dXJuIDA7CisKIAltZW1jcHkoJnB0cltzY2FuX3JzcF9sZW5dLCBhZHYtPnNjYW5fcnNw
X2RhdGEsIGFkdi0+c2Nhbl9yc3BfbGVuKTsKIAogCXNjYW5fcnNwX2xlbiArPSBhZHYtPnNjYW5f
cnNwX2xlbjsKZGlmZiAtLWdpdCBhL25ldC9ibHVldG9vdGgvZWlyLmggYi9uZXQvYmx1ZXRvb3Ro
L2Vpci5oCi0tLSBhL25ldC9ibHVldG9vdGgvZWlyLmgKKysrIGIvbmV0L2JsdWV0b290aC9laXIu
aApAQCAtMTAsNyArMTAsNyBAQAogdm9pZCBlaXJfY3JlYXRlKHN0cnVjdCBoY2lfZGV2ICpoZGV2
LCB1OCAqZGF0YSk7CiAKIHU4IGVpcl9jcmVhdGVfYWR2X2RhdGEoc3RydWN0IGhjaV9kZXYgKmhk
ZXYsIHU4IGluc3RhbmNlLCB1OCAqcHRyLCB1OCBzaXplKTsKLXU4IGVpcl9jcmVhdGVfc2Nhbl9y
c3Aoc3RydWN0IGhjaV9kZXYgKmhkZXYsIHU4IGluc3RhbmNlLCB1OCAqcHRyKTsKK3U4IGVpcl9j
cmVhdGVfc2Nhbl9yc3Aoc3RydWN0IGhjaV9kZXYgKmhkZXYsIHU4IGluc3RhbmNlLCB1OCAqcHRy
LCB1OCBzaXplKTsKIHU4IGVpcl9jcmVhdGVfcGVyX2Fkdl9kYXRhKHN0cnVjdCBoY2lfZGV2ICpo
ZGV2LCB1OCBpbnN0YW5jZSwgdTggKnB0cik7CiAKIHU4IGVpcl9hcHBlbmRfbG9jYWxfbmFtZShz
dHJ1Y3QgaGNpX2RldiAqaGRldiwgdTggKmVpciwgdTggYWRfbGVuKTsKZGlmZiAtLWdpdCBhL25l
dC9ibHVldG9vdGgvaGNpX3N5bmMuYyBiL25ldC9ibHVldG9vdGgvaGNpX3N5bmMuYwotLS0gYS9u
ZXQvYmx1ZXRvb3RoL2hjaV9zeW5jLmMKKysrIGIvbmV0L2JsdWV0b290aC9oY2lfc3luYy5jCkBA
IC0xNTYzLDcgKzE1NjMsOCBAQCBzdGF0aWMgaW50IGhjaV9zZXRfZXh0X3NjYW5fcnNwX2RhdGFf
c3luYyhzdHJ1Y3QgaGNpX2RldiAqaGRldiwgdTggaW5zdGFuY2UpCiAJCX0KIAl9CiAKLQlsZW4g
PSBlaXJfY3JlYXRlX3NjYW5fcnNwKGhkZXYsIGluc3RhbmNlLCBwZHUtPmRhdGEpOworCWxlbiA9
IGVpcl9jcmVhdGVfc2Nhbl9yc3AoaGRldiwgaW5zdGFuY2UsIHBkdS0+ZGF0YSwKKwkJCQkgIEhD
SV9NQVhfRVhUX0FEX0xFTkdUSCk7CiAKIAlwZHUtPmhhbmRsZSA9IGFkdiA/IGFkdi0+aGFuZGxl
IDogaW5zdGFuY2U7CiAJcGR1LT5sZW5ndGggPSBsZW47CkBAIC0xNjA5LDcgKzE2MTAsNyBAQCBz
dGF0aWMgaW50IF9faGNpX3NldF9zY2FuX3JzcF9kYXRhX3N5bmMoc3RydWN0IGhjaV9kZXYgKmhk
ZXYsIHU4IGluc3RhbmNlKQogCWlmIChpbnN0YW5jZSkKIAkJaGNpX2Rldl9sb2NrKGhkZXYpOwog
Ci0JbGVuID0gZWlyX2NyZWF0ZV9zY2FuX3JzcChoZGV2LCBpbnN0YW5jZSwgY3AuZGF0YSk7CisJ
bGVuID0gZWlyX2NyZWF0ZV9zY2FuX3JzcChoZGV2LCBpbnN0YW5jZSwgY3AuZGF0YSwgc2l6ZW9m
KGNwLmRhdGEpKTsKIAogCWlmIChpbnN0YW5jZSkKIAkJaGNpX2Rldl91bmxvY2soaGRldik7Cg==
--0000000000005a7ca0065fe544cb
Content-Type: text/x-csrc; charset="US-ASCII"; name="eir-oob.c"
Content-Disposition: attachment; filename="eir-oob.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mwa8tqhc1>
X-Attachment-Id: f_mwa8tqhc1

Ly8gQmx1ZXRvb3RoOiBzdGFjayBvdXQtb2YtYm91bmRzIHdyaXRlIGluIGVpcl9jcmVhdGVfYWR2
X2RhdGEoKSAvIGVpcl9jcmVhdGVfc2Nhbl9yc3AoKQovLwovLyAgIGdjYyAtTzIgLW8gZWlyLW9v
YiBlaXItb29iLmMKLy8gICAuL2Vpci1vb2IgICAgICAgICAgICAgIyBlaXJfY3JlYXRlX2Fkdl9k
YXRhKCksICBuZXQvYmx1ZXRvb3RoL2Vpci5jOjMwMwovLyAgIC4vZWlyLW9vYiBzY2FuX3JzcCAg
ICAjIGVpcl9jcmVhdGVfc2Nhbl9yc3AoKSwgIG5ldC9ibHVldG9vdGgvZWlyLmM6MzYwCi8vCi8v
IE5lZWRzIHJvb3QgKC9kZXYvdmhjaSBhbmQgdGhlIEhDSURFVlVQL0hDSURFVkRPV04gaW9jdGxz
KSBhbmQgYSBDT05GSUdfS0FTQU4ga2VybmVsLgovLwovLyBBbiBhZHZlcnRpc2luZyBpbnN0YW5j
ZSdzIGRhdGEgbGVuZ3RoIGlzIHZhbGlkYXRlZCBvbmNlLCB3aGVuIGl0IGlzIHNldCwgYWdhaW5z
dAovLyBtYXhfYWR2X2xlbihoZGV2KSA9PSBleHRfYWR2X2NhcGFibGUoaGRldikgPyAyNTEgOiAz
MS4gIFRoZSBpbnN0YW5jZSB0aGVuIG91dGxpdmVzIHRoZQovLyBicmluZy11cCB0aGF0IHZhbGlk
YXRlZCBpdCwgd2hpbGUgZXh0X2Fkdl9jYXBhYmxlKCkgLSB3aGljaCByZWFkcyBoZGV2LT5sZV9m
ZWF0dXJlc1sxXSwKLy8gcmUtcmVhZCBmcm9tIHRoZSBjb250cm9sbGVyIG9uIGV2ZXJ5IGJyaW5n
LXVwIC0gZG9lcyBub3QuICBTbzogcmVnaXN0ZXIgMjIwIGJ5dGVzIHdoaWxlCi8vIHRoZSBjb250
cm9sbGVyIHJlcG9ydHMgTEUgRXh0ZW5kZWQgQWR2ZXJ0aXNpbmcsIHRoZW4gYnJpbmcgdGhlIHNh
bWUgY29udHJvbGxlciBiYWNrIHVwCi8vIHdpdGhvdXQgaXQuICBoY2lfcG93ZXJlZF91cGRhdGVf
YWR2X3N5bmMoKSByZS1hcm1zIHRoZSBzdG9yZWQgaW5zdGFuY2UgZG93biB0aGUgbGVnYWN5Ci8v
IHBhdGgsIHdoaWNoIG1lbWNweSgpcyB0aG9zZSAyMjAgYnl0ZXMgaW50byBhIDMxLWJ5dGUgYnVm
ZmVyIG9uIHRoZSBzdGFjay4KCiNpbmNsdWRlIDxlcnJuby5oPgojaW5jbHVkZSA8ZmNudGwuaD4K
I2luY2x1ZGUgPHNpZ25hbC5oPgojaW5jbHVkZSA8c3RkYXJnLmg+CiNpbmNsdWRlIDxzdGRpbnQu
aD4KI2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPHN5cy9p
b2N0bC5oPgojaW5jbHVkZSA8c3lzL21tYW4uaD4KI2luY2x1ZGUgPHN5cy9wcmN0bC5oPgojaW5j
bHVkZSA8c3lzL3NvY2tldC5oPgojaW5jbHVkZSA8dW5pc3RkLmg+CgojaWZuZGVmIEFGX0JMVUVU
T09USAojZGVmaW5lIEFGX0JMVUVUT09USAkJMzEKI2VuZGlmCiNkZWZpbmUgQlRQUk9UT19IQ0kJ
CTEKI2RlZmluZSBIQ0lfREVWX05PTkUJCTB4ZmZmZgojZGVmaW5lIEhDSV9DSEFOTkVMX0NPTlRS
T0wJMwoKI2RlZmluZSBIQ0lERVZVUAkJMHg0MDA0NDhjOQojZGVmaW5lIEhDSURFVkRPV04JCTB4
NDAwNDQ4Y2EKCiNkZWZpbmUgSENJX0NPTU1BTkRfUEtUCQkweDAxCiNkZWZpbmUgSENJX0VWRU5U
X1BLVAkJMHgwNAojZGVmaW5lIEhDSV9FVl9DTURfQ09NUExFVEUJMHgwZQoKI2RlZmluZSBNR01U
X09QX1NFVF9QT1dFUkVECTB4MDAwNQojZGVmaW5lIE1HTVRfT1BfU0VUX0xFCQkweDAwMGQKI2Rl
ZmluZSBNR01UX09QX0FERF9BRFZFUlRJU0lORwkweDAwM2UKCi8qID4gSENJX01BWF9BRF9MRU5H
VEggKDMxKSwgPD0gSENJX01BWF9FWFRfQURfTEVOR1RIICgyNTEpICovCiNkZWZpbmUgQURfTEVO
CQkJMjIwCgpzdGF0aWMgaW50IHZoY2k7CQkgIC8qIC9kZXYvdmhjaSAqLwpzdGF0aWMgdm9sYXRp
bGUgaW50ICpleHRfYWR2OwkgIC8qIHNoYXJlZCB3aXRoIHRoZSByZXNwb25kZXIgY2hpbGQgKi8K
Ci8qIEEgY3Jhc2ggdGFrZXMgc3Rkb3V0IHdpdGggaXQsIHNvIHNheSBldmVyeXRoaW5nIG9uIHRo
ZSBjb25zb2xlIHRvby4gKi8Kc3RhdGljIHZvaWQgc2F5KGNvbnN0IGNoYXIgKmZtdCwgLi4uKQp7
CgljaGFyIGxpbmVbMjU2XTsKCXZhX2xpc3QgYXA7CglpbnQgbiwgZmQ7CgoJdmFfc3RhcnQoYXAs
IGZtdCk7CgluID0gdnNucHJpbnRmKGxpbmUsIHNpemVvZihsaW5lKSwgZm10LCBhcCk7Cgl2YV9l
bmQoYXApOwoJd3JpdGUoMSwgbGluZSwgbik7CglmZCA9IG9wZW4oIi9kZXYva21zZyIsIE9fV1JP
TkxZKTsKCWlmIChmZCA+PSAwKSB7CgkJd3JpdGUoZmQsIGxpbmUsIG4pOwoJCWNsb3NlKGZkKTsK
CX0KfQoKLyogLS0tLSB0aGUgY29udHJvbGxlcjogYW5zd2VyIGV2ZXJ5IEhDSSBjb21tYW5kIHRo
ZSBob3N0IHNlbmRzIC0tLS0tLS0tLS0tLS0tLS0tLS0tLSAqLwoKc3RhdGljIHZvaWQgcmVwbHko
dWludDE2X3Qgb3Bjb2RlLCBjb25zdCB1aW50OF90ICpyZXQsIHVpbnQ4X3QgbGVuKQp7Cgl1aW50
OF90IHBrdFs2ICsgMjU1XTsKCglwa3RbMF0gPSBIQ0lfRVZFTlRfUEtUOwoJcGt0WzFdID0gSENJ
X0VWX0NNRF9DT01QTEVURTsKCXBrdFsyXSA9IDMgKyBsZW47CQkvKiBwYXJhbWV0ZXIgdG90YWwg
bGVuZ3RoICovCglwa3RbM10gPSAxOwkJCS8qIE51bV9IQ0lfQ29tbWFuZF9QYWNrZXRzICovCglw
a3RbNF0gPSBvcGNvZGUgJiAweGZmOwoJcGt0WzVdID0gb3Bjb2RlID4+IDg7CgltZW1jcHkocGt0
ICsgNiwgcmV0LCBsZW4pOwoJd3JpdGUodmhjaSwgcGt0LCA2ICsgbGVuKTsKfQoKc3RhdGljIHZv
aWQgcmVzcG9uZGVyKHZvaWQpCnsKCXVpbnQ4X3QgYnVmWzQwOTZdLCByZXRbMjU1XTsKCglmb3Ig
KDs7KSB7CgkJc3NpemVfdCBuID0gcmVhZCh2aGNpLCBidWYsIHNpemVvZihidWYpKTsKCQl1aW50
MTZfdCBvcGNvZGU7CgoJCWlmIChuIDwgNCB8fCBidWZbMF0gIT0gSENJX0NPTU1BTkRfUEtUKQoJ
CQljb250aW51ZTsKCQlvcGNvZGUgPSBidWZbMV0gfCAoYnVmWzJdIDw8IDgpOwoJCW1lbXNldChy
ZXQsIDAsIHNpemVvZihyZXQpKTsKCgkJc3dpdGNoIChvcGNvZGUpIHsKCQljYXNlIDB4MTAwMzoJ
LyogUmVhZCBMb2NhbCBTdXBwb3J0ZWQgRmVhdHVyZXMgKi8KCQkJcmV0WzEgKyA0XSA9IDB4NDA7
CQkvKiBMTVBfTEUgKi8KCQkJcmVwbHkob3Bjb2RlLCByZXQsIDkpOwoJCQlicmVhazsKCQljYXNl
IDB4MjAwMzoJLyogTEUgUmVhZCBMb2NhbCBTdXBwb3J0ZWQgRmVhdHVyZXMgKi8KCQkJaWYgKCpl
eHRfYWR2KQoJCQkJcmV0WzEgKyAxXSA9IDB4MTA7CS8qIEhDSV9MRV9FWFRfQURWICovCgkJCXJl
cGx5KG9wY29kZSwgcmV0LCA5KTsKCQkJYnJlYWs7CgkJY2FzZSAweDEwMDU6CS8qIFJlYWQgQnVm
ZmVyIFNpemUgLSBoY2lfY2NfcmVhZF9idWZmZXJfc2l6ZSgpCgkJCQkgKiBmYWlscyBpbml0IG91
dHJpZ2h0IG9uIGEgemVybyBBQ0wgTVRVIG9yCgkJCQkgKiBwYWNrZXQgY291bnQgKi8KCQkJcmV0
WzFdID0gMHhmZjsJCS8qIGFjbF9tdHUgICA9IDEwMjMgKi8KCQkJcmV0WzJdID0gMHgwMzsKCQkJ
cmV0WzRdID0gNDsJCS8qIGFjbF9tYXhfcGt0ID0gNCAqLwoJCQlyZXBseShvcGNvZGUsIHJldCwg
OCk7CgkJCWJyZWFrOwoJCWNhc2UgMHgxMDA5OgkvKiBSZWFkIEJEX0FERFIgLSBhIHplcm8gYWRk
cmVzcyBtYWtlcwoJCQkJICogaGNpX3Bvd2VyX29uKCkgY2xvc2UgdGhlIGRldmljZSBhZ2FpbiAq
LwoJCQltZW1zZXQocmV0ICsgMSwgMHhhMSwgNik7CgkJCXJlcGx5KG9wY29kZSwgcmV0LCA3KTsK
CQkJYnJlYWs7CgkJY2FzZSAweDIwM2I6CS8qIExFIFJlYWQgTnVtYmVyIG9mIFN1cHBvcnRlZCBB
ZHZlcnRpc2luZyBTZXRzCgkJCQkgKiAtIHplcm8gb2YgdGhlbSBhbmQgQWRkIEFkdmVydGlzaW5n
IGJlbG93IGlzCgkJCQkgKiByZWplY3RlZCB3aXRoIEludmFsaWQgUGFyYW1zICovCgkJCXJldFsx
XSA9IDU7CgkJCXJlcGx5KG9wY29kZSwgcmV0LCAyKTsKCQkJYnJlYWs7CgkJY2FzZSAweDIwMzY6
CS8qIExFIFNldCBFeHRlbmRlZCBBZHZlcnRpc2luZyBQYXJhbWV0ZXJzIC0KCQkJCSAqIHN0YXR1
cyArIFRYIHBvd2VyLCBhbmQgdGhpcyBvbmUncyBsZW5ndGggSVMKCQkJCSAqIGNoZWNrZWQgc3Ry
aWN0bHk7IGdldHRpbmcgaXQgd3JvbmcgZmFpbHMKCQkJCSAqIGhjaV9zdGFydF9leHRfYWR2X3N5
bmMoKSwgd2hvc2UgZXJyb3IgcGF0aAoJCQkJICogcmVtb3ZlcyB0aGUgaW5zdGFuY2Ugd2UgYXJl
IHRyeWluZyB0byBzdG9yZSAqLwoJCQlyZXBseShvcGNvZGUsIHJldCwgMik7CgkJCWJyZWFrOwoJ
CWRlZmF1bHQ6CS8qIFN1Y2Nlc3MgZm9yIGV2ZXJ5dGhpbmcgZWxzZS4gMjUwIGlzIHRoZQoJCQkJ
ICogbGFyZ2VzdCByZXBseSBhbnkgb3Bjb2RlJ3MgaGNpX2NjIGVudHJ5CgkJCQkgKiBleHBlY3Rz
LCBhbmQgYSByZXBseSBTSE9SVEVSIHRoYW4gZXhwZWN0ZWQKCQkJCSAqIGlzIGEgaGFyZCBlcnJv
ciB3aGlsZSBhIGxvbmdlciBvbmUgaXMgb25seQoJCQkJICogYSAidW5leHBlY3RlZCBjYyAweC4u
LiBsZW5ndGg6IDI1MCA+IE4iCgkJCQkgKiB3YXJuaW5nIC0gc28gb25lIGxlbmd0aCBmaXRzIGFs
bCwgYXQgdGhlCgkJCQkgKiBjb3N0IG9mIHRob3NlIHdhcm5pbmdzIG9uIHRoZSBjb25zb2xlLiAq
LwoJCQlyZXBseShvcGNvZGUsIHJldCwgMjUwKTsKCQkJYnJlYWs7CgkJfQoJfQp9CgovKiAtLS0t
IHRoZSBob3N0OiBtYW5hZ2VtZW50IGNvbW1hbmRzIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tICovCgpzdGF0aWMgaW50IG1nbXQoaW50IGZkLCB1aW50MTZf
dCBvcCwgdWludDE2X3QgaW5kZXgsIGNvbnN0IHZvaWQgKmRhdGEsIHVpbnQxNl90IGxlbikKewoJ
dWludDhfdCBjbWRbNiArIDExICsgQURfTEVOXSwgZXZbNTEyXTsKCWludCBpOwoKCWNtZFswXSA9
IG9wICYgMHhmZjsKCWNtZFsxXSA9IG9wID4+IDg7CgljbWRbMl0gPSBpbmRleCAmIDB4ZmY7Cglj
bWRbM10gPSBpbmRleCA+PiA4OwoJY21kWzRdID0gbGVuICYgMHhmZjsKCWNtZFs1XSA9IGxlbiA+
PiA4OwoJbWVtY3B5KGNtZCArIDYsIGRhdGEsIGxlbik7CglpZiAod3JpdGUoZmQsIGNtZCwgNiAr
IGxlbikgPCAwKQoJCXJldHVybiAtZXJybm87CgoJLyogU2tpcCB0aGUgdW5zb2xpY2l0ZWQgZXZl
bnRzIGFuZCByZXBvcnQgdGhpcyBjb21tYW5kJ3Mgb3duIHN0YXR1cy4gKi8KCWZvciAoaSA9IDA7
IGkgPCAxNjsgaSsrKSB7CgkJc3NpemVfdCBuID0gcmVhZChmZCwgZXYsIHNpemVvZihldikpOwoJ
CXVpbnQxNl90IGV2dDsKCgkJaWYgKG4gPCA5KQoJCQlyZXR1cm4gLTE7CgkJZXZ0ID0gZXZbMF0g
fCAoZXZbMV0gPDwgOCk7CgkJaWYgKChldnQgPT0gMHgwMDAxIHx8IGV2dCA9PSAweDAwMDIpICYm
CgkJICAgIChldls2XSB8IChldls3XSA8PCA4KSkgPT0gb3ApCgkJCXJldHVybiBldls4XTsKCX0K
CXJldHVybiAtMTsKfQoKaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQp7CglpbnQgc2Nh
bl9yc3AgPSBhcmdjID4gMSAmJiAhc3RyY21wKGFyZ3ZbMV0sICJzY2FuX3JzcCIpOwoJdWludDhf
dCBjcFsxMSArIEFEX0xFTl0sIGFja1s0XSwgb24gPSAxOwoJdWludDE2X3QgYWRkclszXTsKCWlu
dCBpbmRleCwgbWZkLCBoZmQ7CglwaWRfdCBjaGlsZDsKCglleHRfYWR2ID0gbW1hcChOVUxMLCBz
aXplb2YoaW50KSwgUFJPVF9SRUFEIHwgUFJPVF9XUklURSwKCQkgICAgICAgTUFQX1NIQVJFRCB8
IE1BUF9BTk9OWU1PVVMsIC0xLCAwKTsKCSpleHRfYWR2ID0gMTsKCgl2aGNpID0gb3BlbigiL2Rl
di92aGNpIiwgT19SRFdSKTsKCWlmICh2aGNpIDwgMCkgewoJCXNheSgib3BlbiAvZGV2L3ZoY2k6
ICVtXG4iKTsKCQlyZXR1cm4gMTsKCX0KCS8qIENyZWF0ZSBhIHZpcnR1YWwgY29udHJvbGxlcjog
SENJX1ZFTkRPUl9QS1QsIEhDSV9QUklNQVJZLiAqLwoJd3JpdGUodmhjaSwgIlx4ZmZceDAwIiwg
Mik7CglpZiAocmVhZCh2aGNpLCBhY2ssIHNpemVvZihhY2spKSA8IDQpIHsKCQlzYXkoIm5vIGRl
dmljZS1jcmVhdGVkIHBhY2tldCBiYWNrIGZyb20gL2Rldi92aGNpXG4iKTsKCQlyZXR1cm4gMTsK
CX0KCWluZGV4ID0gYWNrWzJdIHwgKGFja1szXSA8PCA4KTsKCXNheSgiaGNpJWQgY3JlYXRlZCwg
c2luaz0lc1xuIiwgaW5kZXgsIHNjYW5fcnNwID8gInNjYW5fcnNwIiA6ICJhZHZfZGF0YSIpOwoK
CWNoaWxkID0gZm9yaygpOwoJaWYgKGNoaWxkID09IDApIHsKCQkvKiBUaGUgcmVzcG9uZGVyIGxv
b3BzIGZvcmV2ZXI7IG1ha2Ugc3VyZSBpdCBjYW5ub3Qgb3V0bGl2ZQoJCSAqIHRoaXMgcHJvZ3Jh
bSBhbmQgc2l0IG9uIC9kZXYvdmhjaS4gKi8KCQlwcmN0bChQUl9TRVRfUERFQVRIU0lHLCBTSUdL
SUxMKTsKCQlyZXNwb25kZXIoKTsKCQlfZXhpdCgwKTsKCX0KCS8qIGhjaV9yZWdpc3Rlcl9kZXYo
KSBxdWV1ZXMgaGNpX3Bvd2VyX29uKCksIHdoaWNoIHJ1bnMgdGhlIHdob2xlIGluaXQKCSAqIHNl
cXVlbmNlIGJ5IGl0c2VsZiAtIHRoZSBjaGlsZCBhYm92ZSBhbnN3ZXJzIGl0IHdpdGggRVhUX0FE
ViBzZXQuICovCglzbGVlcCgyKTsKCgltZmQgPSBzb2NrZXQoQUZfQkxVRVRPT1RILCBTT0NLX1JB
VywgQlRQUk9UT19IQ0kpOwoJYWRkclswXSA9IEFGX0JMVUVUT09USDsKCWFkZHJbMV0gPSBIQ0lf
REVWX05PTkU7CglhZGRyWzJdID0gSENJX0NIQU5ORUxfQ09OVFJPTDsKCWlmIChiaW5kKG1mZCwg
KHN0cnVjdCBzb2NrYWRkciAqKWFkZHIsIHNpemVvZihhZGRyKSkgPCAwKSB7CgkJc2F5KCJiaW5k
KEhDSV9DSEFOTkVMX0NPTlRST0wpOiAlbVxuIik7CgkJcmV0dXJuIDE7Cgl9CgoJc2F5KCJzZXQg
cG93ZXJlZDogJWRcbiIsIG1nbXQobWZkLCBNR01UX09QX1NFVF9QT1dFUkVELCBpbmRleCwgJm9u
LCAxKSk7CglzYXkoInNldCBsZTogJWRcbiIsIG1nbXQobWZkLCBNR01UX09QX1NFVF9MRSwgaW5k
ZXgsICZvbiwgMSkpOwoKCS8qIGluc3RhbmNlKDEpIGZsYWdzKDQpIGR1cmF0aW9uKDIpIHRpbWVv
dXQoMikgYWR2X2RhdGFfbGVuKDEpCgkgKiBzY2FuX3JzcF9sZW4oMSkgZGF0YVtdLiAgZmxhZ3Mg
PSAwOiBub3RoaW5nIHRoZSBrZXJuZWwgbWFuYWdlcywgc28KCSAqIHRsdl9kYXRhX21heF9sZW4o
KSBpcyBwbGFpbiBtYXhfYWR2X2xlbihoZGV2KSA9PSAyNTEgaGVyZS4gKi8KCW1lbXNldChjcCwg
MCwgc2l6ZW9mKGNwKSk7CgljcFswXSA9IDE7CQkJCS8qIGluc3RhbmNlICovCgljcFs5XSA9IHNj
YW5fcnNwID8gMCA6IEFEX0xFTjsJCS8qIGFkdl9kYXRhX2xlbiAqLwoJY3BbMTBdID0gc2Nhbl9y
c3AgPyBBRF9MRU4gOiAwOwkJLyogc2Nhbl9yc3BfbGVuICovCgljcFsxMV0gPSBBRF9MRU4gLSAx
OwkJCS8qIG9uZSBBRCBzdHJ1Y3R1cmUsIGFsbCBvZiBpdCAqLwoJY3BbMTJdID0gMHhmZjsJCQkJ
LyogTWFudWZhY3R1cmVyIFNwZWNpZmljIERhdGEgKi8KCW1lbXNldChjcCArIDEzLCAnQScsIEFE
X0xFTiAtIDIpOwoJc2F5KCJhZGQgYWR2ZXJ0aXNpbmcgJWQgYnl0ZXM6ICVkXG4iLCBBRF9MRU4s
CgkgICAgbWdtdChtZmQsIE1HTVRfT1BfQUREX0FEVkVSVElTSU5HLCBpbmRleCwgY3AsIHNpemVv
ZihjcCkpKTsKCgkvKiBUaGUgc2FtZSBjb250cm9sbGVyLCBub3cgd2l0aG91dCBMRSBFeHRlbmRl
ZCBBZHZlcnRpc2luZy4gKi8KCSpleHRfYWR2ID0gMDsKCgloZmQgPSBzb2NrZXQoQUZfQkxVRVRP
T1RILCBTT0NLX1JBVywgQlRQUk9UT19IQ0kpOwoJc2F5KCJIQ0lERVZET1dOOiAlZFxuIiwgaW9j
dGwoaGZkLCBIQ0lERVZET1dOLCBpbmRleCkpOwoJc2xlZXAoMSk7CglzYXkoIkhDSURFVlVQIC0g
dGhlIG92ZXJmbG93IGhhcHBlbnMgaW5zaWRlIHRoaXMgaW9jdGxcbiIpOwoJc2F5KCJIQ0lERVZV
UDogJWRcbiIsIGlvY3RsKGhmZCwgSENJREVWVVAsIGluZGV4KSk7CgoJc2xlZXAoMSk7CglzYXko
InN0aWxsIGFsaXZlIC0gbm8gb3ZlcmZsb3cgdGhpcyB0aW1lXG4iKTsKCWtpbGwoY2hpbGQsIFNJ
R0tJTEwpOwoJcmV0dXJuIDA7Cn0K
--0000000000005a7ca0065fe544cb
Content-Type: text/plain; charset="US-ASCII"; name="kasan-eir_create_scan_rsp.txt"
Content-Disposition: attachment; filename="kasan-eir_create_scan_rsp.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mwa8tqib3>
X-Attachment-Id: f_mwa8tqib3

PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09CkJVRzogS0FTQU46IHN0YWNrLW91dC1vZi1ib3VuZHMgaW4gZWlyX2NyZWF0ZV9z
Y2FuX3JzcCsweDExOS8weDFhMCBuZXQvYmx1ZXRvb3RoL2Vpci5jOjM2MApXcml0ZSBvZiBzaXpl
IDIyMCBhdCBhZGRyIGZmZmZjOTAwMGE5ZmY5YzEgYnkgdGFzayBzeXotZXhlY3V0b3IvOTU4NQoK
Q1BVOiAzIFVJRDogMCBQSUQ6IDk1ODUgQ29tbTogc3l6LWV4ZWN1dG9yIE5vdCB0YWludGVkIDcu
My4xLWc0MWYxNzRmZDQyMmItZGlydHkgIzggUFJFRU1QVChmdWxsKSAKSGFyZHdhcmUgbmFtZTog
UUVNVSBTdGFuZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5NiksIEJJT1MgMS4xNi4zLWRlYmlh
bi0xLjE2LjMtMiAwNC8wMS8yMDE0CkNhbGwgVHJhY2U6CiA8VEFTSz4KIF9fZHVtcF9zdGFjayBs
aWIvZHVtcF9zdGFjay5jOjk0IFtpbmxpbmVdCiBkdW1wX3N0YWNrX2x2bCsweDEwZS8weDE5MCBs
aWIvZHVtcF9zdGFjay5jOjEyMAogcHJpbnRfYWRkcmVzc19kZXNjcmlwdGlvbiBtbS9rYXNhbi9y
ZXBvcnQuYzozNzggW2lubGluZV0KIHByaW50X3JlcG9ydCsweDE1My8weDcxMCBtbS9rYXNhbi9y
ZXBvcnQuYzo0ODIKIGthc2FuX3JlcG9ydCsweGQyLzB4MTEwIG1tL2thc2FuL3JlcG9ydC5jOjU5
NQogY2hlY2tfcmVnaW9uX2lubGluZSBtbS9rYXNhbi9nZW5lcmljLmM6LTEgW2lubGluZV0KIGth
c2FuX2NoZWNrX3JhbmdlKzB4MmQyLzB4MmUwIG1tL2thc2FuL2dlbmVyaWMuYzo1OTQKIF9fYXNh
bl9tZW1jcHkrMHg0MC8weDcwIG1tL2thc2FuL3NoYWRvdy5jOjEwNgogZWlyX2NyZWF0ZV9zY2Fu
X3JzcCsweDExOS8weDFhMCBuZXQvYmx1ZXRvb3RoL2Vpci5jOjM2MAogX19oY2lfc2V0X3NjYW5f
cnNwX2RhdGFfc3luYysweGQyLzB4MjcwIG5ldC9ibHVldG9vdGgvaGNpX3N5bmMuYzoxNjEyCiBo
Y2lfdXBkYXRlX3NjYW5fcnNwX2RhdGFfc3luYysweGE5LzB4ZjAgbmV0L2JsdWV0b290aC9oY2lf
c3luYy5jOjE2MzgKIGhjaV9zdGFydF9hZHZfc3luYysweGI5LzB4ZTAgbmV0L2JsdWV0b290aC9o
Y2lfc3luYy5jOjE5MjYKIGhjaV9zY2hlZHVsZV9hZHZfaW5zdGFuY2Vfc3luYysweDJlZi8weDMz
MCBuZXQvYmx1ZXRvb3RoL2hjaV9zeW5jLmM6MjExOQogaGNpX3Bvd2VyZWRfdXBkYXRlX2Fkdl9z
eW5jKzB4MjdkLzB4MmQwIG5ldC9ibHVldG9vdGgvaGNpX3N5bmMuYzozNTI2CiBoY2lfcG93ZXJl
ZF91cGRhdGVfc3luYysweGYwLzB4MzcwIG5ldC9ibHVldG9vdGgvaGNpX3N5bmMuYzozNjk0CiBo
Y2lfZGV2X29wZW5fc3luYysweDcyZS8weDdkMCBuZXQvYmx1ZXRvb3RoL2hjaV9zeW5jLmM6NTQ1
OQogaGNpX2Rldl9kb19vcGVuKzB4NDYvMHhlMCBuZXQvYmx1ZXRvb3RoL2hjaV9jb3JlLmM6NDMx
CiBoY2lfZGV2X29wZW4rMHgxZDYvMHgyMTAgbmV0L2JsdWV0b290aC9oY2lfY29yZS5jOjQ4Nwog
aGNpX3NvY2tfaW9jdGwrMHg1MzYvMHg2ODAgbmV0L2JsdWV0b290aC9oY2lfc29jay5jOjExMzkK
IHNvY2tfZG9faW9jdGwgbmV0L3NvY2tldC5jOjEzMjUgW2lubGluZV0KIHNvY2tfaW9jdGwrMHg1
ODEvMHg4MzAgbmV0L3NvY2tldC5jOjE0NDYKIHZmc19pb2N0bCBmcy9pb2N0bC5jOjUxIFtpbmxp
bmVdCiBfX2RvX3N5c19pb2N0bCBmcy9pb2N0bC5jOjU5NyBbaW5saW5lXQogX19zZV9zeXNfaW9j
dGwrMHhjZS8weDE0MCBmcy9pb2N0bC5jOjU4MwogZG9fc3lzY2FsbF94NjQgYXJjaC94ODYvZW50
cnkvc3lzY2FsbF82NC5jOjYxIFtpbmxpbmVdCiBkb19zeXNjYWxsXzY0KzB4MTcwLzB4NTQwIGFy
Y2gveDg2L2VudHJ5L3N5c2NhbGxfNjQuYzo4NAogZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2Zy
YW1lKzB4NzcvMHg3ZgpSSVA6IDAwMzM6MHg0MjczOGIKQ29kZTogMDAgNDggODkgNDQgMjQgMTgg
MzEgYzAgNDggOGQgNDQgMjQgNjAgYzcgMDQgMjQgMTAgMDAgMDAgMDAgNDggODkgNDQgMjQgMDgg
NDggOGQgNDQgMjQgMjAgNDggODkgNDQgMjQgMTAgYjggMTAgMDAgMDAgMDAgMGYgMDUgPDg5PiBj
MiAzZCAwMCBmMCBmZiBmZiA3NyAxYyA0OCA4YiA0NCAyNCAxOCA2NCA0OCAyYiAwNCAyNSAyOCAw
MCAwMApSU1A6IDAwMmI6MDAwMDdmZmYyOTg0NDQ3MCBFRkxBR1M6IDAwMDAwMjQ2IE9SSUdfUkFY
OiAwMDAwMDAwMDAwMDAwMDEwClJBWDogZmZmZmZmZmZmZmZmZmZkYSBSQlg6IDAwMDAwMDAwMDAw
MDAwMDggUkNYOiAwMDAwMDAwMDAwNDI3MzhiClJEWDogMDAwMDAwMDAwMDAwMDAwMCBSU0k6IDAw
MDAwMDAwNDAwNDQ4YzkgUkRJOiAwMDAwMDAwMDAwMDAwMDA4ClJCUDogMDAwMDAwMDAwMDAwMDAw
MCBSMDg6IDAwMDAwMDAwMDAwMDAwMDAgUjA5OiAwMDAwMDAwMDAwMDAwMDAwClIxMDogMDAwMDAw
MDAwMDAwMDAwMCBSMTE6IDAwMDAwMDAwMDAwMDAyNDYgUjEyOiAwMDAwMDAwMDAwMDAwMDAwClIx
MzogMDAwMDAwMDAyMzUxMzNhOCBSMTQ6IDAwMDA3ZmZmMjk4NDQ2MGYgUjE1OiAwMDAwMDAwMDAw
MDAwMDAyCiA8L1RBU0s+CgpUaGUgYnVnZ3kgYWRkcmVzcyBiZWxvbmdzIHRvIHN0YWNrIG9mIHRh
c2sgc3l6LWV4ZWN1dG9yLzk1ODUKIGFuZCBpcyBsb2NhdGVkIGF0IG9mZnNldCAzMyBpbiBmcmFt
ZToKIF9faGNpX3NldF9zY2FuX3JzcF9kYXRhX3N5bmMrMHgwLzB4MjcwIGluY2x1ZGUvbGludXgv
Zm9ydGlmeS1zdHJpbmcuaDo1NDkKClRoaXMgZnJhbWUgaGFzIDEgb2JqZWN0OgogWzMyLCA2NCkg
J2NwJwoKVGhlIGJ1Z2d5IGFkZHJlc3MgYmVsb25ncyB0byBhIHZtYWxsb2MgdmlydHVhbCBtYXBw
aW5nClRoZSBidWdneSBhZGRyZXNzIGJlbG9uZ3MgdG8gdGhlIHBoeXNpY2FsIHBhZ2U6CnBhZ2U6
IHJlZmNvdW50OjEgbWFwY291bnQ6MCBtYXBwaW5nOjAwMDAwMDAwMDAwMDAwMDAgaW5kZXg6MHg3
ZjkzYmZhMmQgcGZuOjB4NWI1Y2YKbWVtY2c6ZmZmZjg4ODA0YzEwMWYwMgpmbGFnczogMHg0ZmZm
MDAwMDAwMDAwMDAobm9kZT0xfHpvbmU9MXxsYXN0Y3B1cGlkPTB4N2ZmKQpyYXc6IDA0ZmZmMDAw
MDAwMDAwMDAgMDAwMDAwMDAwMDAwMDAwMCBkZWFkMDAwMDAwMDAwMTIyIDAwMDAwMDAwMDAwMDAw
MDAKcmF3OiAwMDAwMDAwN2Y5M2JmYTJkIDAwMDAwMDAwMDAwMDAwMDAgMDAwMDAwMDFmZmZmZmZm
ZiBmZmZmODg4MDRjMTAxZjAyCnBhZ2UgZHVtcGVkIGJlY2F1c2U6IGthc2FuOiBiYWQgYWNjZXNz
IGRldGVjdGVkCnBhZ2Vfb3duZXIgdHJhY2tzIHRoZSBwYWdlIGFzIGFsbG9jYXRlZApwYWdlIGxh
c3QgYWxsb2NhdGVkIHZpYSBvcmRlciAwLCBtaWdyYXRldHlwZSBVbm1vdmFibGUsIGdmcF9tYXNr
IDB4MjljMihHRlBfTk9XQUlUfF9fR0ZQX0hJR0hNRU18X19HRlBfSU98X19HRlBfRlN8X19HRlBf
WkVSTyksIHBpZCA5NTg0LCB0Z2lkIDk1ODQgKHN5ei1leGVjdXRvciksIHRzIDIwOTEyNDk1ODY2
NQogc2V0X3BhZ2Vfb3duZXIgaW5jbHVkZS9saW51eC9wYWdlX293bmVyLmg6MzMgW2lubGluZV0K
IHBvc3RfYWxsb2NfaG9vaysweDFiNi8weDIxMCBtbS9wYWdlX2FsbG9jLmM6MTg3MQogcHJlcF9u
ZXdfcGFnZSBtbS9wYWdlX2FsbG9jLmM6MTg3OSBbaW5saW5lXQogZ2V0X3BhZ2VfZnJvbV9mcmVl
bGlzdCsweDE3YzMvMHgxODIwIG1tL3BhZ2VfYWxsb2MuYzozOTQzCiBfX2FsbG9jX2Zyb3plbl9w
YWdlc19ub3Byb2YrMHgxZGYvMHg0ZjAgbW0vcGFnZV9hbGxvYy5jOjU0MzYKIGFsbG9jX3BhZ2Vz
X21wb2wrMHgyMDgvMHg0MTAgbW0vbWVtcG9saWN5LmM6MjQ4NgogYWxsb2NfZnJvemVuX3BhZ2Vz
X25vcHJvZiBtbS9tZW1wb2xpY3kuYzoyNTU3IFtpbmxpbmVdCiBhbGxvY19wYWdlc19ub3Byb2Yr
MHg5OS8weDIwMCBtbS9tZW1wb2xpY3kuYzoyNTc3CiB2bV9hcmVhX2FsbG9jX3BhZ2VzIG1tL3Zt
YWxsb2MuYzozNjg5IFtpbmxpbmVdCiBfX3ZtYWxsb2NfYXJlYV9ub2RlIG1tL3ZtYWxsb2MuYzoz
OTE0IFtpbmxpbmVdCiBfX3ZtYWxsb2Nfbm9kZV9yYW5nZV9ub3Byb2YrMHg1ZDEvMHgxMTYwIG1t
L3ZtYWxsb2MuYzo0MTA0CiBfX3ZtYWxsb2Nfbm9kZV9ub3Byb2YrMHg4OS8weGMwIG1tL3ZtYWxs
b2MuYzo0MTY1CiBhbGxvY190aHJlYWRfc3RhY2tfbm9kZSBrZXJuZWwvZm9yay5jOjM1OSBbaW5s
aW5lXQogZHVwX3Rhc2tfc3RydWN0KzB4MjRkLzB4NmQwIGtlcm5lbC9mb3JrLmM6OTMwCiBjb3B5
X3Byb2Nlc3MrMHg2NTMvMHgyOGMwIGtlcm5lbC9mb3JrLmM6MjE0Mwoga2VybmVsX2Nsb25lKzB4
MjIxLzB4NzYwIGtlcm5lbC9mb3JrLmM6Mjc4NAogX19kb19zeXNfY2xvbmUga2VybmVsL2Zvcmsu
YzoyOTI2IFtpbmxpbmVdCiBfX3NlX3N5c19jbG9uZSBrZXJuZWwvZm9yay5jOjI5MTAgW2lubGlu
ZV0KIF9feDY0X3N5c19jbG9uZSsweDEzOS8weDFhMCBrZXJuZWwvZm9yay5jOjI5MTAKIGRvX3N5
c2NhbGxfeDY0IGFyY2gveDg2L2VudHJ5L3N5c2NhbGxfNjQuYzo2MSBbaW5saW5lXQogZG9fc3lz
Y2FsbF82NCsweDE3MC8weDU0MCBhcmNoL3g4Ni9lbnRyeS9zeXNjYWxsXzY0LmM6ODQKIGVudHJ5
X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDc3LzB4N2YKcGFnZSBsYXN0IGZyZWUgcGlkIDEw
IHRnaWQgMTAgdHMgMTk5NTM0MTAxODkyIHN0YWNrIHRyYWNlOgogcmVzZXRfcGFnZV9vd25lciBp
bmNsdWRlL2xpbnV4L3BhZ2Vfb3duZXIuaDoyNiBbaW5saW5lXQogX19mcmVlX3BhZ2VzX3ByZXBh
cmUgbW0vcGFnZV9hbGxvYy5jOjE0MTggW2lubGluZV0KIF9fZnJlZV9mcm96ZW5fcGFnZXMrMHg4
YTkvMHg5MzAgbW0vcGFnZV9hbGxvYy5jOjI5NjIKIF9fc2xhYl9mcmVlKzB4MjdiLzB4MmQwIG1t
L3NsdWIuYzo1ODI5CiBxbGlua19mcmVlIG1tL2thc2FuL3F1YXJhbnRpbmUuYzoxNjMgW2lubGlu
ZV0KIHFsaXN0X2ZyZWVfYWxsKzB4OTkvMHgxMDAgbW0va2FzYW4vcXVhcmFudGluZS5jOjE3OQog
a2FzYW5fcXVhcmFudGluZV9yZWR1Y2UrMHgxNDgvMHgxNjAgbW0va2FzYW4vcXVhcmFudGluZS5j
OjI4NgogX19rYXNhbl9zbGFiX2FsbG9jKzB4MjIvMHg4MCBtbS9rYXNhbi9jb21tb24uYzozOTcK
IGthc2FuX3NsYWJfYWxsb2MgaW5jbHVkZS9saW51eC9rYXNhbi5oOjI2MCBbaW5saW5lXQogc2xh
Yl9wb3N0X2FsbG9jX2hvb2sgbW0vc2x1Yi5jOjQ2ODkgW2lubGluZV0KIHNsYWJfYWxsb2Nfbm9k
ZSBtbS9zbHViLmM6NTAwMiBbaW5saW5lXQogX19rbWFsbG9jX2NhY2hlX25vcHJvZisweDJhMy8w
eDYyMCBtbS9zbHViLmM6NTU2NQogX2ttYWxsb2Nfbm9wcm9mIGluY2x1ZGUvbGludXgvc2xhYi5o
Ojk5MSBbaW5saW5lXQogX2t6YWxsb2Nfbm9wcm9mIGluY2x1ZGUvbGludXgvc2xhYi5oOjEzMTIg
W2lubGluZV0KIGRybV9hdG9taWNfY29tbWl0X2FsbG9jKzB4NmMvMHhjMCBkcml2ZXJzL2dwdS9k
cm0vZHJtX2F0b21pYy5jOjI1OAogZHJtX2F0b21pY19oZWxwZXJfZGlydHlmYisweGM5LzB4Nzcw
IGRyaXZlcnMvZ3B1L2RybS9kcm1fZGFtYWdlX2hlbHBlci5jOjEyOAogZHJtX2ZiZGV2X3NobWVt
X2hlbHBlcl9mYl9kaXJ0eSsweGNjLzB4MWMwIGRyaXZlcnMvZ3B1L2RybS9kcm1fZmJkZXZfc2ht
ZW0uYzoxMTcKIGRybV9mYl9oZWxwZXJfZmJfZGlydHkgZHJpdmVycy9ncHUvZHJtL2RybV9mYl9o
ZWxwZXIuYzozMzkgW2lubGluZV0KIGRybV9mYl9oZWxwZXJfZGFtYWdlX3dvcmsrMHg2MDkvMHg4
NDAgZHJpdmVycy9ncHUvZHJtL2RybV9mYl9oZWxwZXIuYzozNjUKIHByb2Nlc3Nfb25lX3dvcmsg
a2VybmVsL3dvcmtxdWV1ZS5jOjMzOTYgW2lubGluZV0KIHByb2Nlc3Nfc2NoZWR1bGVkX3dvcmtz
KzB4OGUyLzB4MTBkMCBrZXJuZWwvd29ya3F1ZXVlLmM6MzQ3OQogd29ya2VyX3RocmVhZCsweDUw
MS8weDc1MCBrZXJuZWwvd29ya3F1ZXVlLmM6MzU2MAoga3RocmVhZCsweDI2YS8weDJjMCBrZXJu
ZWwva3RocmVhZC5jOjQzNgogcmV0X2Zyb21fZm9yaysweDQ3NS8weDhjMCBhcmNoL3g4Ni9rZXJu
ZWwvcHJvY2Vzcy5jOjE1OAogcmV0X2Zyb21fZm9ya19hc20rMHgxYS8weDMwIGFyY2gveDg2L2Vu
dHJ5L2VudHJ5XzY0LlM6MjQ1CgpNZW1vcnkgc3RhdGUgYXJvdW5kIHRoZSBidWdneSBhZGRyZXNz
OgogZmZmZmM5MDAwYTlmZjg4MDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAKIGZmZmZjOTAwMGE5ZmY5MDA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwCj5mZmZmYzkwMDBhOWZmOTgwOiAwMCAwMCAwMCAwMCBmMSBm
MSBmMSBmMSAwMCAwMCAwMCAwMCBmMyBmMyBmMyBmMwogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgogZmZmZmM5MDAwYTlmZmEwMDogMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAKIGZmZmZjOTAwMGE5ZmZh
ODA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwCj09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQoKPDw8PDw8PDw8PDw8PDw8IHRhaWwgcmVwb3J0ID4+Pj4+Pj4+Pj4+Pj4+PgoKU1laRkFJ
TDogZmFpbGVkIHRvIHJlY3YgcnBjCmZkPTMgd2FudD00IHJlY3Y9MCBuPTAgKGVycm5vIDIyOiBJ
bnZhbGlkIGFyZ3VtZW50KQoKPDw8PDw8PDw8PDw8PDw8IHRhaWwgcmVwb3J0ID4+Pj4+Pj4+Pj4+
Pj4+PgoK
--0000000000005a7ca0065fe544cb--

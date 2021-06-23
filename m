Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D36C2B9F4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 01:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 223AB61374
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 01:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhFWBsg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Jun 2021 21:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhFWBsf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Jun 2021 21:48:35 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7CFC061574;
        Tue, 22 Jun 2021 18:46:18 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id o6so1248385qkh.4;
        Tue, 22 Jun 2021 18:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=FyEjjg/7XIlLCs8aEiTSPfLA3fQ4x+ggliR08InUZxs=;
        b=agV/PdIwVxecfQMcNkj400s2308o2AiGdGyRppONVvaiC62DEf+8ssdyG+JDl1rGSR
         e99s902hiUTNosmcns7pGe3UgYOfkqpXd+LasIiIJf7ytruUBmhYNh7qOCMLC+VRwcgz
         L0gyoproWv1rGPE/omXwqXqzO+ZJ0OZkszMyZRT6fkdSBusNjXrEw9dBQPqSzXJ+AQr+
         syHs/aKrIVFoo61GD5N57KjVPbMkT+RxB/zMqFe1pZOu5OTgDXGk1XsZZnC14Y8HMKVF
         /CKTxO1w0UovJw4J9UVQ0j/kWz6wns0/qcUHj3NbIY0FY6gXQmtFE5L+gFTA+/vB3Tqm
         MZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=FyEjjg/7XIlLCs8aEiTSPfLA3fQ4x+ggliR08InUZxs=;
        b=ep6FRVEJVKdm96K/FYrLG8Hdm7p4zi4zgm5Jba2qCMWjTgOGEU1sChdURL07vWMCxi
         jxGZTzKhKm2aVRNkweWMByGyU6crA+iB7IZNTn9z7MBpe3XeG0EGmIrXzZSAIsbGiZM/
         aqnOMTGHJN0jgrEn04g7XO2UziVOWZlMbwtZJDINRi9ptOzbomk6gkuKz2ZhCPZvbYuW
         q5dPZYzUdGF2O/aHVlQB9GVpm1HX5351ljGl3KmRXn/OcxDgDuClf6JZaR7eSDtUdoVQ
         XEZmWQqD2Ei5AHAp7pjCYbkNR9yEQmih7PwKZntLaExkBn5ZAN0O15S9+NYtHrGQWI7f
         1Pgg==
X-Gm-Message-State: AOAM533kxWPV98d+55YbdZZzmuSj5I1F9slE+qDxlT/ryNZXW8R0IVW5
        2MKVF8sQX5YInOyJQp3SlDWZ3UU2DlI8GteU7HE=
X-Google-Smtp-Source: ABdhPJzwIvGYCdZIB6V/DRilEEtGe+x0X0Soo6Xl7bVIrk/4jwdQmM8jnbQvONgA1bwItEwscB4LqnmB+UYNBk06bcw=
X-Received: by 2002:a25:40cc:: with SMTP id n195mr2230563yba.242.1624412775536;
 Tue, 22 Jun 2021 18:46:15 -0700 (PDT)
MIME-Version: 1.0
From:   Lin Horse <kylin.formalin@gmail.com>
Date:   Wed, 23 Jun 2021 09:46:04 +0800
Message-ID: <CAJjojJsj9pzF4j2MVvsM-hCpvyR7OkZn232yt3MdOGnLxOiRRg@mail.gmail.com>
Subject: Another patch for CVE-2021-3573 without introducing lock bugs
To:     Marcel Holtmann <marcel@holtmann.org>, ohan.hedberg@gmail.com,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     amistry@google.com, Greg KH <greg@kroah.com>
Content-Type: multipart/mixed; boundary="0000000000007475b705c5651252"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--0000000000007475b705c5651252
Content-Type: text/plain; charset="UTF-8"

Hello there

I need to say sorry about the erroneous patch I provided recently to
fix the CVE-2021-3573
(https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=e305509e678b3a4af2b3cfd410f409f7cdaabb52),
which will throw a locking bug when the CONFIG_DEBUG_ATOMIC_SLEEP
option is enabled.

[    8.234583] BUG: sleeping function called from invalid context at
net/core/sock.c:3048
[    8.235336] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid:
125, name: exp
[    8.236038] CPU: 0 PID: 125 Comm: exp Not tainted 5.11.11+ #13
[    8.236542] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1ubuntu1 04/01/2014
[    8.237330] Call Trace:
[    8.237605]  dump_stack+0x1b9/0x22e
[    8.237946]  ? log_buf_vmcoreinfo_setup+0x45d/0x45d
[    8.238453]  ? tty_ldisc_hangup+0x4d7/0x6d0
[    8.238912]  ? show_regs_print_info+0x12/0x12
[    8.239383]  ? task_work_run+0x16c/0x210
[    8.239807]  ? syscall_exit_to_user_mode+0x20/0x40
[    8.240324]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    8.240897]  ? _raw_spin_lock+0xa1/0x170
[    8.241326]  ___might_sleep+0x32d/0x420
[    8.241749]  ? stack_trace_snprint+0xe0/0xe0
[    8.242204]  ? __might_sleep+0x100/0x100
[    8.242636]  ? deactivate_slab+0x1ca/0x560
[    8.243080]  lock_sock_nested+0x96/0x360
[    8.243523]  ? hci_sock_dev_event+0xfe/0x5b0
[    8.244007]  ? sock_def_destruct+0x10/0x10
[    8.244372]  ? kasan_set_free_info+0x1f/0x40
[    8.244738]  ? kmem_cache_free+0xca/0x220
[    8.245093]  hci_sock_dev_event+0x2fa/0x5b0
[    8.245454]  hci_unregister_dev+0x3fa/0x1700
[    8.245820]  ? rcu_sync_exit+0xe0/0x1e0

Recently I received several emails informing this. Thank Anand for his
detailed analysis, you can find the relevant discussion either in the
linux-kernel@vger.kernel.org mail list or the stable@vger.kernel.org
mail list. (https://www.spinics.net/lists/stable/msg476038.html for
example).

--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -755,7 +755,7 @@ void hci_sock_dev_event(struct hci_dev *
    /* Detach sockets from device */
    read_lock(&hci_sk_list.lock);
    sk_for_each(sk, &hci_sk_list.head) {
- bh_lock_sock_nested(sk);
+ lock_sock(sk);
    if (hci_pi(sk)->hdev == hdev) {
    hci_pi(sk)->hdev = NULL;
    sk->sk_err = EPIPE;
@@ -764,7 +764,7 @@ void hci_sock_dev_event(struct hci_dev *

    hci_dev_put(hdev);
    }
- bh_unlock_sock(sk);
+ release_sock(sk);
    }
    read_unlock(&hci_sk_list.lock);
    }

The core insight for the bug in the previous commit is that: the
lock_sock() I replaced can sleep while the
read_lock(&hci_sk_list.lock) two lines before is not going to allow
the sleep.

Okay, the reason I changed the bh_lock_sock_nested() to lock_sock() is
that I want this hci_sock_dev_event() function hangs out when other
functions, like hci_sock_bound_ioctl() holds the lock. Otherwise bad
UAF can happen. Check the OSS mail list for details:
https://www.openwall.com/lists/oss-security/2021/06/08/2

However, from the lock principle in the Linux kernel, this lock
replacement is not appropriate. I take a lot of time to try with other
lock combinations for this case but failed. For example, I tried to
replace the rwlock_t in the hci_sk_list with a sleep-able mutex lock.
But the CONFIG_DEBUG_ATOMIC_SLEEP tells me that this mutex lock is not
expected in the system call context.

In short, I have no idea if there is any lock replacing solution for
this bug. I need help and suggestions because the lock mechanism is
just so difficult.

Think about the UAF root cause, I find out another possible patch for
this, which is also provided as the attachment. That is, maybe we can
use a ref-count method as well as additional checks to prevent the UAF
of hdev object.

I mainly concentrated on the hci_sock_bound_ioctl() and
hci_sock_sendmsg() functions, which are the main targets for me to
write the exploit. For now I think these checks are enough and welcome
more advice.

Thanks
Lin Ma

--0000000000007475b705c5651252
Content-Type: application/octet-stream; name="demo.patch"
Content-Disposition: attachment; filename="demo.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kq8tast80>
X-Attachment-Id: f_kq8tast80

RnJvbSA0NDgyMTc3ODE4Y2EyNGNiOGM2YWEzNTAwNzU3M2JlM2I2OWUwMzE2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW4gTWEgPGxpbm1hQHpqdS5lZHUuY24+CkRhdGU6IFdlZCwg
MjMgSnVuIDIwMjEgMDk6MDk6MDIgKzA4MDAKU3ViamVjdDogW1BBVENIXSBCbHVldG9vdGg6IGZp
eCB0aGUgVUFGIHdpdGhvdXQgaW50cm9kdWNpbmcgdGhlIGxvY2sgYnVnCgpUaGlzIHBhdGNoIHJl
dmVydCB0aGUgcHJldmlvdXMgb25lIChlMzA1NTA5ZTY3OGIzYTRhZjJiM2NmZDQxMGY0MDlmN2Nk
YWFiYjUyKQp3aGljaCB3aWxsIHRyaWdnZXIgYSBsb2NrIGJ1ZyB3aGVuIGVuYWJsaW5nIENPTkZJ
R19ERUJVR19BVE9NSUNfU0xFRVAuCgpBdCB0aGUgc2FtZSB0aW1lLCB0byBtYWtlIHN1cmUgdGhh
dCB0aGUgaGRldiBvYmplY3Qgd2lsbCBub3QgYmUgcmVsZWFzZWQgd2hlbgpoY2lfc29ja19ib3Vu
ZF9pb2N0bCgpIGFuZCBoY2lfc29ja19zZW5kbXNnKCkgZnVuY3Rpb25zIHN0aWxsIGhvbGQgaXRz
IHJlZmVyZW5jZS4KVGhpcyBwYXRjaCB1dGlsaXplcyByZWZjb3VudCBtZXRob2RzIGluIHRoZXNl
IHR3byBmdW5jdGlvbnMuCgpTaWduZWQtb2ZmLWJ5OiBMaW4gTWEgPGxpbm1hQHpqdS5lZHUuY24+
Ci0tLQogbmV0L2JsdWV0b290aC9oY2lfY29ubi5jIHwgIDYgKysrKwogbmV0L2JsdWV0b290aC9o
Y2lfc29jay5jIHwgNzYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQog
MiBmaWxlcyBjaGFuZ2VkLCA1OSBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9uZXQvYmx1ZXRvb3RoL2hjaV9jb25uLmMgYi9uZXQvYmx1ZXRvb3RoL2hjaV9jb25u
LmMKaW5kZXggODhlYzA4OTc4ZmY0Li4yNzg3ZGE4ZmUxNGEgMTAwNjQ0Ci0tLSBhL25ldC9ibHVl
dG9vdGgvaGNpX2Nvbm4uYworKysgYi9uZXQvYmx1ZXRvb3RoL2hjaV9jb25uLmMKQEAgLTE3MTEs
NiArMTcxMSw5IEBAIGludCBoY2lfZ2V0X2Nvbm5faW5mbyhzdHJ1Y3QgaGNpX2RldiAqaGRldiwg
dm9pZCBfX3VzZXIgKmFyZykKIAlpZiAoY29weV9mcm9tX3VzZXIoJnJlcSwgYXJnLCBzaXplb2Yo
cmVxKSkpCiAJCXJldHVybiAtRUZBVUxUOwogCisJaWYgKCF0ZXN0X2JpdChIQ0lfVVAsICZoZGV2
LT5mbGFncykpCisJCXJldHVybiAtRU5FVERPV047CisKIAloY2lfZGV2X2xvY2soaGRldik7CiAJ
Y29ubiA9IGhjaV9jb25uX2hhc2hfbG9va3VwX2JhKGhkZXYsIHJlcS50eXBlLCAmcmVxLmJkYWRk
cik7CiAJaWYgKGNvbm4pIHsKQEAgLTE3MzcsNiArMTc0MCw5IEBAIGludCBoY2lfZ2V0X2F1dGhf
aW5mbyhzdHJ1Y3QgaGNpX2RldiAqaGRldiwgdm9pZCBfX3VzZXIgKmFyZykKIAlpZiAoY29weV9m
cm9tX3VzZXIoJnJlcSwgYXJnLCBzaXplb2YocmVxKSkpCiAJCXJldHVybiAtRUZBVUxUOwogCisJ
aWYgKCF0ZXN0X2JpdChIQ0lfVVAsICZoZGV2LT5mbGFncykpCisJCXJldHVybiAtRU5FVERPV047
CisKIAloY2lfZGV2X2xvY2soaGRldik7CiAJY29ubiA9IGhjaV9jb25uX2hhc2hfbG9va3VwX2Jh
KGhkZXYsIEFDTF9MSU5LLCAmcmVxLmJkYWRkcik7CiAJaWYgKGNvbm4pCmRpZmYgLS1naXQgYS9u
ZXQvYmx1ZXRvb3RoL2hjaV9zb2NrLmMgYi9uZXQvYmx1ZXRvb3RoL2hjaV9zb2NrLmMKaW5kZXgg
ZWVkMGRkMDY2ZTEyLi5hN2E5ZTVjNTVmZmQgMTAwNjQ0Ci0tLSBhL25ldC9ibHVldG9vdGgvaGNp
X3NvY2suYworKysgYi9uZXQvYmx1ZXRvb3RoL2hjaV9zb2NrLmMKQEAgLTc2Miw3ICs3NjIsNyBA
QCB2b2lkIGhjaV9zb2NrX2Rldl9ldmVudChzdHJ1Y3QgaGNpX2RldiAqaGRldiwgaW50IGV2ZW50
KQogCQkvKiBEZXRhY2ggc29ja2V0cyBmcm9tIGRldmljZSAqLwogCQlyZWFkX2xvY2soJmhjaV9z
a19saXN0LmxvY2spOwogCQlza19mb3JfZWFjaChzaywgJmhjaV9za19saXN0LmhlYWQpIHsKLQkJ
CWxvY2tfc29jayhzayk7CisJCQliaF9sb2NrX3NvY2tfbmVzdGVkKHNrKTsKIAkJCWlmIChoY2lf
cGkoc2spLT5oZGV2ID09IGhkZXYpIHsKIAkJCQloY2lfcGkoc2spLT5oZGV2ID0gTlVMTDsKIAkJ
CQlzay0+c2tfZXJyID0gRVBJUEU7CkBAIC03NzEsNyArNzcxLDcgQEAgdm9pZCBoY2lfc29ja19k
ZXZfZXZlbnQoc3RydWN0IGhjaV9kZXYgKmhkZXYsIGludCBldmVudCkKIAogCQkJCWhjaV9kZXZf
cHV0KGhkZXYpOwogCQkJfQotCQkJcmVsZWFzZV9zb2NrKHNrKTsKKwkJCWJoX3VubG9ja19zb2Nr
KHNrKTsKIAkJfQogCQlyZWFkX3VubG9jaygmaGNpX3NrX2xpc3QubG9jayk7CiAJfQpAQCAtOTAw
LDYgKzkwMCw5IEBAIHN0YXRpYyBpbnQgaGNpX3NvY2tfYmxhY2tsaXN0X2FkZChzdHJ1Y3QgaGNp
X2RldiAqaGRldiwgdm9pZCBfX3VzZXIgKmFyZykKIAlpZiAoY29weV9mcm9tX3VzZXIoJmJkYWRk
ciwgYXJnLCBzaXplb2YoYmRhZGRyKSkpCiAJCXJldHVybiAtRUZBVUxUOwogCisJaWYgKCF0ZXN0
X2JpdChIQ0lfVVAsICZoZGV2LT5mbGFncykpCisJCXJldHVybiAtRU5FVERPV047CisKIAloY2lf
ZGV2X2xvY2soaGRldik7CiAKIAllcnIgPSBoY2lfYmRhZGRyX2xpc3RfYWRkKCZoZGV2LT5ibGFj
a2xpc3QsICZiZGFkZHIsIEJEQUREUl9CUkVEUik7CkBAIC05MTcsNiArOTIwLDkgQEAgc3RhdGlj
IGludCBoY2lfc29ja19ibGFja2xpc3RfZGVsKHN0cnVjdCBoY2lfZGV2ICpoZGV2LCB2b2lkIF9f
dXNlciAqYXJnKQogCWlmIChjb3B5X2Zyb21fdXNlcigmYmRhZGRyLCBhcmcsIHNpemVvZihiZGFk
ZHIpKSkKIAkJcmV0dXJuIC1FRkFVTFQ7CiAKKwlpZiAoIXRlc3RfYml0KEhDSV9VUCwgJmhkZXYt
PmZsYWdzKSkKKwkJcmV0dXJuIC1FTkVURE9XTjsKKwogCWhjaV9kZXZfbG9jayhoZGV2KTsKIAog
CWVyciA9IGhjaV9iZGFkZHJfbGlzdF9kZWwoJmhkZXYtPmJsYWNrbGlzdCwgJmJkYWRkciwgQkRB
RERSX0JSRURSKTsKQEAgLTkzMSw0MyArOTM3LDY0IEBAIHN0YXRpYyBpbnQgaGNpX3NvY2tfYm91
bmRfaW9jdGwoc3RydWN0IHNvY2sgKnNrLCB1bnNpZ25lZCBpbnQgY21kLAogCQkJCXVuc2lnbmVk
IGxvbmcgYXJnKQogewogCXN0cnVjdCBoY2lfZGV2ICpoZGV2ID0gaGNpX3BpKHNrKS0+aGRldjsK
KwlpbnQgZXJyOwogCiAJaWYgKCFoZGV2KQogCQlyZXR1cm4gLUVCQURGRDsKIAotCWlmIChoY2lf
ZGV2X3Rlc3RfZmxhZyhoZGV2LCBIQ0lfVVNFUl9DSEFOTkVMKSkKLQkJcmV0dXJuIC1FQlVTWTsK
KwloZGV2ID0gaGNpX2Rldl9ob2xkKGhkZXYpOwogCi0JaWYgKGhjaV9kZXZfdGVzdF9mbGFnKGhk
ZXYsIEhDSV9VTkNPTkZJR1VSRUQpKQotCQlyZXR1cm4gLUVPUE5PVFNVUFA7CisJaWYgKGhjaV9k
ZXZfdGVzdF9mbGFnKGhkZXYsIEhDSV9VU0VSX0NIQU5ORUwpKSB7CisJCWVyciA9IC1FQlVTWTsK
KwkJZ290byBkb25lOworCX0KIAotCWlmIChoZGV2LT5kZXZfdHlwZSAhPSBIQ0lfUFJJTUFSWSkK
LQkJcmV0dXJuIC1FT1BOT1RTVVBQOworCWlmIChoY2lfZGV2X3Rlc3RfZmxhZyhoZGV2LCBIQ0lf
VU5DT05GSUdVUkVEKSkgeworCQllcnIgPSAtRU9QTk9UU1VQUDsKKwkJZ290byBkb25lOworCX0K
KworCWlmIChoZGV2LT5kZXZfdHlwZSAhPSBIQ0lfUFJJTUFSWSkgeworCQllcnIgPSAtRU9QTk9U
U1VQUDsKKwkJZ290byBkb25lOworCX0KIAogCXN3aXRjaCAoY21kKSB7CiAJY2FzZSBIQ0lTRVRS
QVc6CiAJCWlmICghY2FwYWJsZShDQVBfTkVUX0FETUlOKSkKLQkJCXJldHVybiAtRVBFUk07Ci0J
CXJldHVybiAtRU9QTk9UU1VQUDsKKwkJCWVyciA9IC1FUEVSTTsKKwkJZWxzZQorCQkJZXJyID0g
LUVPUE5PVFNVUFA7CisJCWJyZWFrOwogCiAJY2FzZSBIQ0lHRVRDT05OSU5GTzoKLQkJcmV0dXJu
IGhjaV9nZXRfY29ubl9pbmZvKGhkZXYsICh2b2lkIF9fdXNlciAqKWFyZyk7CisJCWVyciA9IGhj
aV9nZXRfY29ubl9pbmZvKGhkZXYsICh2b2lkIF9fdXNlciAqKWFyZyk7CisJCWJyZWFrOwogCiAJ
Y2FzZSBIQ0lHRVRBVVRISU5GTzoKLQkJcmV0dXJuIGhjaV9nZXRfYXV0aF9pbmZvKGhkZXYsICh2
b2lkIF9fdXNlciAqKWFyZyk7CisJCWVyciA9IGhjaV9nZXRfYXV0aF9pbmZvKGhkZXYsICh2b2lk
IF9fdXNlciAqKWFyZyk7CisJCWJyZWFrOwogCiAJY2FzZSBIQ0lCTE9DS0FERFI6CiAJCWlmICgh
Y2FwYWJsZShDQVBfTkVUX0FETUlOKSkKLQkJCXJldHVybiAtRVBFUk07Ci0JCXJldHVybiBoY2lf
c29ja19ibGFja2xpc3RfYWRkKGhkZXYsICh2b2lkIF9fdXNlciAqKWFyZyk7CisJCQllcnIgPSAt
RVBFUk07CisJCWVsc2UKKwkJCWVyciA9IGhjaV9zb2NrX2JsYWNrbGlzdF9hZGQoaGRldiwgKHZv
aWQgX191c2VyICopYXJnKTsKKwkJYnJlYWs7CiAKIAljYXNlIEhDSVVOQkxPQ0tBRERSOgogCQlp
ZiAoIWNhcGFibGUoQ0FQX05FVF9BRE1JTikpCi0JCQlyZXR1cm4gLUVQRVJNOwotCQlyZXR1cm4g
aGNpX3NvY2tfYmxhY2tsaXN0X2RlbChoZGV2LCAodm9pZCBfX3VzZXIgKilhcmcpOworCQkJZXJy
ID0gLUVQRVJNOworCQllbHNlCisJCQllcnIgPSBoY2lfc29ja19ibGFja2xpc3RfZGVsKGhkZXYs
ICh2b2lkIF9fdXNlciAqKWFyZyk7CisJCWJyZWFrOworCWRlZmF1bHQ6CisJCWVyciA9IC1FTk9J
T0NUTENNRDsKIAl9CiAKLQlyZXR1cm4gLUVOT0lPQ1RMQ01EOworZG9uZToKKwloY2lfZGV2X3B1
dChoZGV2KTsKKwlyZXR1cm4gZXJyOwogfQogCiBzdGF0aWMgaW50IGhjaV9zb2NrX2lvY3RsKHN0
cnVjdCBzb2NrZXQgKnNvY2ssIHVuc2lnbmVkIGludCBjbWQsCkBAIC0xNzQ1LDE0ICsxNzcyLDEx
IEBAIHN0YXRpYyBpbnQgaGNpX3NvY2tfc2VuZG1zZyhzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1
Y3QgbXNnaGRyICptc2csCiAKIAloZGV2ID0gaGNpX3BpKHNrKS0+aGRldjsKIAlpZiAoIWhkZXYp
IHsKLQkJZXJyID0gLUVCQURGRDsKLQkJZ290byBkb25lOworCQlyZWxlYXNlX3NvY2soc2spOwor
CQlyZXR1cm4gLUVCQURGRDsKIAl9CiAKLQlpZiAoIXRlc3RfYml0KEhDSV9VUCwgJmhkZXYtPmZs
YWdzKSkgewotCQllcnIgPSAtRU5FVERPV047Ci0JCWdvdG8gZG9uZTsKLQl9CisJaGRldiA9IGhj
aV9kZXZfaG9sZChoZGV2KTsKIAogCXNrYiA9IGJ0X3NrYl9zZW5kX2FsbG9jKHNrLCBsZW4sIG1z
Zy0+bXNnX2ZsYWdzICYgTVNHX0RPTlRXQUlULCAmZXJyKTsKIAlpZiAoIXNrYikKQEAgLTE3NjMs
NiArMTc4NywxMSBAQCBzdGF0aWMgaW50IGhjaV9zb2NrX3NlbmRtc2coc3RydWN0IHNvY2tldCAq
c29jaywgc3RydWN0IG1zZ2hkciAqbXNnLAogCQlnb3RvIGRyb3A7CiAJfQogCisgICAgICAgIGlm
ICghdGVzdF9iaXQoSENJX1VQLCAmaGRldi0+ZmxhZ3MpKSB7CisgICAgICAgICAgICAgICAgZXJy
ID0gLUVORVRET1dOOworICAgICAgICAgICAgICAgIGdvdG8gZHJvcDsKKyAgICAgICAgfQorCiAJ
aGNpX3NrYl9wa3RfdHlwZShza2IpID0gc2tiLT5kYXRhWzBdOwogCXNrYl9wdWxsKHNrYiwgMSk7
CiAKQEAgLTE4MzIsNiArMTg2MSw3IEBAIHN0YXRpYyBpbnQgaGNpX3NvY2tfc2VuZG1zZyhzdHJ1
Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1Y3QgbXNnaGRyICptc2csCiAJZXJyID0gbGVuOwogCiBkb25l
OgorCWhjaV9kZXZfcHV0KGhkZXYpOwogCXJlbGVhc2Vfc29jayhzayk7CiAJcmV0dXJuIGVycjsK
IAotLSAKMi4zMi4wCgo=
--0000000000007475b705c5651252--

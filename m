Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ED2C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 Oct 2021 00:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB988611F0
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 Oct 2021 00:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236535AbhJPA0f (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Oct 2021 20:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbhJPA0e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Oct 2021 20:26:34 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6583AC061570
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Oct 2021 17:24:27 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 133so10020315pgb.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Oct 2021 17:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=svFroZCghWmERPzr3TaoO/0tvjCGY3iaHZlY2nsuBKg=;
        b=dJh29VUzxDU63klcLS6l8F+ceT3CKJEVSDOKkNQhIJZBErFrmswttUDZvPq8mLCi+o
         dOSwJzsNLzNKOPTYLbgfsLtD3CyDOJ/6+RQH4upp4BcitzXR27UFZzx3m4fJbT0gH725
         Tyk28ULkEN8EEvAK5pAzU9asEG6HRA9kBVgHwW5R1x+MMtxatTiKZ76SRHNmHKHFtkfU
         A60YhU4TnsZjYNZcWhX4Sl3yfedoEVehgq5zqFvTjZaX1xiSpQpNunxg0Zgu4zaR0VuT
         IjeJE2/i6kWneJmU5lvhIrT3wbDXWG/yduAO6NLYduZwGlw0zoKUcPTcE99m0CnykTBQ
         JfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=svFroZCghWmERPzr3TaoO/0tvjCGY3iaHZlY2nsuBKg=;
        b=6kdI/hkUxgncnQnz6QiWaDRzA8pe6uTdviALJ1SBqseDszlofH7GYAJTf8XBA0MvSP
         8N4X1reGtvXOLXVkx/h48n4X79f1IPNPozTmNwMqTPZpU/oSrq+7j6AjVKnlB9p9sd+A
         pL93x5+8IdWqqF1GxG5+V+gOaJ1+Texn+f61y+5pT46jact2X/eXUWiotoV2jjwbz12P
         A01sqgnqn9HlYrzJDK/9fwytsjf2fSJSc+RPxu4tGZDwDiZZ4LM6s02pfWkIv1XLLfOb
         KohhO77JW2i7R8kJk35xlA3AV401v0Ms4SvsBrb3Bhu59nLmpxcjgGvHom8ugHe8juPi
         aBVw==
X-Gm-Message-State: AOAM531sipztOS6Ltb1GpePgZ3YLW9OvkZl3CMN0kJWa7Huupms/ZR9P
        fwxTJKBRkmE/ZFdc+6Jbi/IAms70zSxNbQ==
X-Google-Smtp-Source: ABdhPJxzegtPnYkX8BMJSZTXMtjyaPOJVGw3GGkTawLEqcNjisuRNmKnAkdXwq6TKftIFwvKc4TyOQ==
X-Received: by 2002:a63:2c4f:: with SMTP id s76mr6611025pgs.155.1634343866875;
        Fri, 15 Oct 2021 17:24:26 -0700 (PDT)
Received: from hermes.local (204-195-33-123.wavecable.com. [204.195.33.123])
        by smtp.gmail.com with ESMTPSA id p16sm2651634pgd.78.2021.10.15.17.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 17:24:26 -0700 (PDT)
Date:   Fri, 15 Oct 2021 17:24:23 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Fw: [Bug 214731] New: Information leakage from kernel to user space
 in /net/bluetooth/sco.c
Message-ID: <20211015172423.56598763@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org



Begin forwarded message:

Date: Fri, 15 Oct 2021 22:20:47 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: stephen@networkplumber.org
Subject: [Bug 214731] New: Information leakage from kernel to user space in=
 /net/bluetooth/sco.c


https://bugzilla.kernel.org/show_bug.cgi?id=3D214731

            Bug ID: 214731
           Summary: Information leakage from kernel to user space in
                    /net/bluetooth/sco.c
           Product: Networking
           Version: 2.5
    Kernel Version: 5.15-rc5
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: bao00065@umn.edu
        Regression: No

Hi Maintainers,
I recently reviewed the uninitialized value use bug in Linux kernel:

https://syzkaller.appspot.com/bug?id=3D739ce0bc6e4097668cbf94c862f3b643b364=
d589.=20
and patch:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Db42b3a2744b3e8f427de79896720c72823af91ad

The vulnerable function is:
int __sys_getsockname(int fd, struct sockaddr __user *usockaddr,
                      int __user *usockaddr_len)
{
        struct socket *sock;
        struct sockaddr_storage address; // allocation
        int err, fput_needed;

        sock =3D sockfd_lookup_light(fd, &err, &fput_needed);
        if (!sock)
                goto out;

        err =3D security_socket_getsockname(sock);
        if (err)
                goto out_put;

        err =3D sock->ops->getname(sock, (struct sockaddr *)&address, 0); //
initialization
        if (err < 0)
                goto out_put;
        /* "err" is actually length in this case */
        err =3D move_addr_to_user(&address, err, usockaddr, usockaddr_len);=
 //use

out_put:
        fput_light(sock->file, fput_needed);
out:
        return err;
}

static int move_addr_to_user(struct sockaddr_storage *kaddr, int klen,
                             void __user *uaddr, int __user *ulen)
{
        int err;
        int len;

        BUG_ON(klen > sizeof(struct sockaddr_storage));
        err =3D get_user(len, ulen);
        if (err)
                return err;
        if (len > klen)
                len =3D klen;
        if (len < 0)
                return -EINVAL;
        if (len) {
                if (audit_sockaddr(klen, kaddr))
                        return -ENOMEM;
                if (copy_to_user(uaddr, kaddr, len)) // use=20
                        return -EFAULT;
        }
        /*
         *      "fromlen shall refer to the value before truncation.."
         *                      1003.1g
         */
        return __put_user(klen, ulen);
}


the variable address is allocated in __sys_getsockname, and then is initial=
ized
in sock->ops->getname(sock, (struct sockaddr *)& address, 0); After that,
address is passed to move_addr_to_user() and finally it passed to
copy_to_user(), leading to uninitialized value use.=20

Main reason for this bug: initialization in sock->ops->getname(sock, (struct
sockaddr *)&address, 0) is partially initialized.  It only initializes the
fields in the struct but not the holes between the fields. As a result, sin=
ce
uaddr will be passed to copy_to_user(), and the holes inside the uaddr stru=
ct=20
contain uninitialized data inherited from the kernel stack, it may cause
information leakage from kernel space to user space

Here is the initialization function:

static int isotp_getname(struct socket *sock, struct sockaddr *uaddr, int p=
eer)
{
        struct sockaddr_can *addr =3D (struct sockaddr_can *)uaddr;
        struct sock *sk =3D sock->sk;
        struct isotp_sock *so =3D isotp_sk(sk);

        if (peer)
                return -EOPNOTSUPP;

        +memset(addr, 0, ISOTP_MIN_NAMELEN);//patch
        addr->can_family =3D AF_CAN;
        addr->can_ifindex =3D so->ifindex;
        addr->can_addr.tp.rx_id =3D so->rxid;
        addr->can_addr.tp.tx_id =3D so->txid;

        return ISOTP_MIN_NAMELEN;
}

The patch: memset() initializes the whole struct sockaddr_can, including the
holes within the struct sockaddr_can.

Sockaddr_can is declared here:
struct sockaddr_can {
        __kernel_sa_family_t can_family;
        int         can_ifindex;
        union {
                /* transport protocol class address information (e.g. ISOTP=
) */
                struct { canid_t rx_id, tx_id; } tp;

                /* J1939 address information */
                struct {
                        /* 8 byte name when using dynamic addressing */
                        __u64 name;

                        /* pgn:
                         * 8 bit: PS in PDU2 case, else 0
                         * 8 bit: PF
                         * 1 bit: DP
                         * 1 bit: reserved
                         */
                        __u32 pgn;

                        /* 1 byte address */
                        __u8 addr;
                } j1939;

                /* reserved for future CAN protocols address information */
        } can_addr;
};
There are a few holes inside the struct, but it doesn=E2=80=99t explicitly =
set to 0 in=20
isotp_getname()

At the same time, I realized  sock->ops->getname(sock, (struct sockaddr
*)&address, 0) is an indirect call. Thus it may go to different functions at
the run time. If one of these functions doesn't initialize the holes within=
 the
struct, it may cause an information leak from kernel space to userspace.=20


My tools find similar cloned bugs
The same bug happen in /net/bluetooth/hci_sock.c


static int sco_sock_getname(struct socket *sock, struct sockaddr *addr,
                            int peer)
{
        struct sockaddr_sco *sa =3D (struct sockaddr_sco *) addr;
        struct sock *sk =3D sock->sk;

        BT_DBG("sock %p, sk %p", sock, sk);

        addr->sa_family =3D AF_BLUETOOTH;

        if (peer)
                bacpy(&sa->sco_bdaddr, &sco_pi(sk)->dst);
        else
                bacpy(&sa->sco_bdaddr, &sco_pi(sk)->src);

        return sizeof(struct sockaddr_sco);
}
sockaddr_sco is declared here:

struct sockaddr_sco {
        sa_family_t     sco_family;
        bdaddr_t        sco_bdaddr;
};

We can see there is a hole between sco_family and sco_bdaddr. Thus, we have=
 to
explicitly set the hole to zero. Otherwise, the address will be passed to
copy_to_user and cause information leakage.

Suggested patch:
memset(maddr, 0, sizeof(sockaddr_sco));


Thank you for the review. I appreciate your time.=20

Andrew Bao

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

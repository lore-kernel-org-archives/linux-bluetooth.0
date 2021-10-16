Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFD1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 Oct 2021 00:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FD116120A
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 Oct 2021 00:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbhJPA1Y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Oct 2021 20:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbhJPA1X (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Oct 2021 20:27:23 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22EBC061570
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Oct 2021 17:25:16 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id nn3-20020a17090b38c300b001a03bb6c4ebso8489335pjb.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Oct 2021 17:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=LETtB3Bhroo+8zQAJewreZl1AxxBF89GIAhjZ09BFv8=;
        b=gsuwTPu3H+YIAI93/cbIQI2qEAaS+ItYbLOyy+cFr0BeZzSAayiB5qwCu+VeaKzOwl
         S4PqyWwborlIz0zRS1BWixY/4b+4dWXlvoOwxXK4vny8WSe75t/gi/Z65g4C6pxvGkzx
         17eTxUGYI2Htqdpxws/xAc9vwjsWwEFSPUfer6wN2vhl0aK9KRjoXfsvPgnP1CSdiOJz
         Yg83sBRYQIz4NxKl3XRMg6pJpm2f2VPi3mQS4SDjTNleLKRwBpiZtx3zRmZIPaGtboDy
         5TVSSo2IyQwBORUldZsy3AtplBQR+8TL+D2+Lz7rhKMBvX8kK6zF0cWd+9lE/rL49VX1
         Gfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=LETtB3Bhroo+8zQAJewreZl1AxxBF89GIAhjZ09BFv8=;
        b=t5j65WnHHk2o/1MfyrhV9TPUbrF3TQtVj/eLp7J8Ii/YAuZW3zM7JaG2+LZV16ISoC
         DltcFKE97nF5v4HawKoS0z/fZ9mK8LDkjp8baICyuupveAj3QQThbeBocSguU6TxEaZO
         EB5P4B2pDhjjTTINygbRholNNF1VLcRziY7CtroFD8pQ13Xsv+/a/4GRuCssMXfazOyI
         DUcGzMp5+taC4UazDu+7ha7neOwYn9Ac9EEQDNnf5SAvYS7ghMP4gJ8PP63/WGNWWLLm
         t/tf8SLAeH5LtzBQmWkhdg1rpgTZqw/ZTI40FBZy9L77tN/muKEN58SD2KS7lLFhP4U7
         Fz/Q==
X-Gm-Message-State: AOAM531zxsDAndhkNGQw8yBBBDdLa3hmC5ZLccSb9lmiHxdmyQ2LJqGJ
        EoRbBth3FyF4XxbmFHVdD67ok2QUONqzKA==
X-Google-Smtp-Source: ABdhPJxWe+BbUogiUVUTxywvx6Nh1vhhL0RwXNG0Wjieny8a3Jqceo94bLlN17v7rEXynkKskw6uWw==
X-Received: by 2002:a17:90b:1bc3:: with SMTP id oa3mr17091970pjb.75.1634343915954;
        Fri, 15 Oct 2021 17:25:15 -0700 (PDT)
Received: from hermes.local (204-195-33-123.wavecable.com. [204.195.33.123])
        by smtp.gmail.com with ESMTPSA id j20sm5503397pgb.2.2021.10.15.17.25.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 17:25:15 -0700 (PDT)
Date:   Fri, 15 Oct 2021 17:25:13 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     linux-bluetooth@vger.kernel.org
Subject: Fw: [Bug 214729] New: Information leakage from kernel to user space
 in /net/bluetooth/hci_sock.c
Message-ID: <20211015172513.2836ed31@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org



Begin forwarded message:

Date: Fri, 15 Oct 2021 22:14:56 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: stephen@networkplumber.org
Subject: [Bug 214729] New: Information leakage from kernel to user space in=
 /net/bluetooth/hci_sock.c


https://bugzilla.kernel.org/show_bug.cgi?id=3D214729

            Bug ID: 214729
           Summary: Information leakage from kernel to user space in
                    /net/bluetooth/hci_sock.c
           Product: Networking
           Version: 2.5
    Kernel Version: 5.15-rc5
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
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

s
static int hci_sock_getname(struct socket *sock, struct sockaddr *addr,
                            int peer)
{
        struct sockaddr_hci *haddr =3D (struct sockaddr_hci *)addr;
        struct sock *sk =3D sock->sk;
        struct hci_dev *hdev;
        int err =3D 0;

        BT_DBG("sock %p sk %p", sock, sk);

        if (peer)
                return -EOPNOTSUPP;

        lock_sock(sk);

        hdev =3D hci_hdev_from_sock(sk);
        if (IS_ERR(hdev)) {
                err =3D PTR_ERR(hdev);
                goto done;
        }

        haddr->hci_family =3D AF_BLUETOOTH;
        haddr->hci_dev    =3D hdev->id;
        haddr->hci_channel=3D hci_pi(sk)->channel;
        err =3D sizeof(*haddr);

done:
        release_sock(sk);
        return err;
}
sockaddr_hci is declared here:

struct sockaddr_hci {
        sa_family_t    hci_family;
        unsigned short hci_dev;
        unsigned short hci_channel;
};

We can see there is a hole between family and dev. Thus, we have to explici=
tly
set the hole to zero. Otherwise, the address will be passed to copy_to_user=
 and
cause information leakage.

Suggested patch:
memset(maddr, 0, sizeof(sockaddr_hci));


Thank you for the review. I appreciate your time.=20

Andrew Bao

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

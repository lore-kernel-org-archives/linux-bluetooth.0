Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618C7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Nov 2021 03:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42582600CD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Nov 2021 03:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbhKQDbt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Nov 2021 22:31:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:45606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232885AbhKQDbq (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Nov 2021 22:31:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 0FAAC617E4
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Nov 2021 03:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637119729;
        bh=PYZe06yQZQTrzNbrNiHyx+n0bcrt6KVmBUFBWG4L8pI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gCqLCwBiWtvvbhy2hVjNabrhlxnlQQ08+LNN5KvkcvnlJ33V+vZU4RSNfgOzBHGRr
         o9R7+l70jIc2l+uElWeaI0aAOfOGhOjf3Q17hk3ok9qqqksmiBhLlAjkjXqeSlXR9A
         z8XYtETRmVHc9WbtZoMvmnt0ErKVRSchoW5K7+CGIs/FmN5vqoW5frDUTs5LIcp4UO
         8BM8C5CWogJMxGW3ZoSy9px14iyZuQAFeL56D+1T6cUvsmyMruAFQHXz5pufCJykMX
         b9L920VzgnTO/i+4U/nhhIlMMDnTntSOBwXXob9+C4rUhJfHsvzJVsNyy8iM+IAojE
         s3skHbSBkHqxQ==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Wed, 17 Nov 2021 03:28:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: recovieira@hotmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-SQYy4lU1ex@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D60824

Reginaldo Coimbra Vieira (recovieira@hotmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |recovieira@hotmail.com

--- Comment #207 from Reginaldo Coimbra Vieira (recovieira@hotmail.com) ---
Hello everyone! Well, I got it and I am going to share my experience with a=
ll
of you, guys, and I do hope this is going to be fixed in the kernel soon.

The problem happens when the event HCI_OP_SET_EVENT_FLT (Clear Event Filter=
s)
is triggered. I thought: what would come up if that event did not happen at
all? So, I tried to skip it...

In the file include/net/bluetooth/hci.h, there are a couple of quirks to be
applied against some device. Maybe, a new one could be created to address s=
uch
specific problem (e.g.: HCI_QUIRK_CLEAR_EVENT_FAILURE or something like tha=
t)
for good practices. Anyways... I have used the quirk
HCI_QUIRK_BROKEN_ERR_DATA_REPORTING that is already used to address other
problems of that same particular driver to address that another problem too.

So, in the file net/bluetooth/hci_core.c, I have changed the function
bredr_setup this way (this is the function that causes that problem that
prevents it from being recognised as a controller):

static void bredr_setup(struct hci_request *req)
{
        __le16 param;
        //__u8 flt_type;        // move this line into the "if" below

        /* Read Buffer Size (ACL mtu, max pkt, etc.) */
        hci_req_add(req, HCI_OP_READ_BUFFER_SIZE, 0, NULL);

        /* Read Class of Device */
        hci_req_add(req, HCI_OP_READ_CLASS_OF_DEV, 0, NULL);

        /* Read Local Name */
        hci_req_add(req, HCI_OP_READ_LOCAL_NAME, 0, NULL);

        /* Read Voice Setting */
        hci_req_add(req, HCI_OP_READ_VOICE_SETTING, 0, NULL);

        /* Read Number of Supported IAC */
        hci_req_add(req, HCI_OP_READ_NUM_SUPPORTED_IAC, 0, NULL);

        /* Read Current IAC LAP */
        hci_req_add(req, HCI_OP_READ_CURRENT_IAC_LAP, 0, NULL);

        // Changed lines by me are below

        //flt_type =3D HCI_FLT_CLEAR_ALL;         // replaced this line to =
the
following
        //hci_req_add(req, HCI_OP_SET_EVENT_FLT, 1, &flt_type); // replaced
this line to the following

        /* Clear Event Filters if the device is able to do so */
        if (!test_bit(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING, &req->hdev->quir=
ks))
{
                __u8 flt_type;

                flt_type =3D HCI_FLT_CLEAR_ALL;
                hci_req_add(req, HCI_OP_SET_EVENT_FLT, 1, &flt_type);
        }

        // Change ends here

        /* Connection accept timeout ~20 secs */
        param =3D cpu_to_le16(0x7d00);
        hci_req_add(req, HCI_OP_WRITE_CA_TIMEOUT, 2, &param);
}

Then, I just compile that driver from the /usr/src folder, copy the
/pathToTheChangedKernel/net/bluetooth/bluetooth.ko to
/lib/modules/kernel/extra/bluetooth.ko and run the depmod. Change the paths
below accordingly to where the source of your system kernel and your changed
kernel are.

# cd /usr/src/kernels/5.14.17.x86_64
# make M=3D/pathToTheChangedKernel/net/bluetooth bluetooth.ko
  CC [M]  /kernel/5.14.17.x86_64/net/bluetooth/af_bluetooth.o
  CC [M]  /kernel/5.14.17.x86_64/net/bluetooth/hci_core.o
  CC [M]  /kernel/5.14.17.x86_64/net/bluetooth/hci_conn.o
  CC [M]  /kernel/5.14.17.x86_64/net/bluetooth/hci_event.o
  CC [M]  /kernel/5.14.17.x86_64/net/bluetooth/mgmt.o
  CC [M]  /kernel/5.14.17.x86_64/net/bluetooth/hci_sock.o
  CC [M]  /kernel/5.14.17.x86_64/net/bluetooth/hci_sysfs.o
  CC [M]  /kernel/5.14.17.x86_64/net/bluetooth/l2cap_core.o
  CC [M]  /kernel/5.14.17.x86_64/net/bluetooth/l2cap_sock.o
  CC [M]  /kernel/5.14.17.x86_64/net/bluetooth/smp.o
  CC [M]  /kernel/5.14.17.x86_64/net/bluetooth/lib.o
  CC [M]  /kernel/5.14.17.x86_64/net/bluetooth/ecdh_helper.o
  CC [M]  /kernel/5.14.17.x86_64/net/bluetooth/hci_request.o
  CC [M]  /kernel/5.14.17.x86_64/net/bluetooth/mgmt_util.o
  CC [M]  /kernel/5.14.17.x86_64/net/bluetooth/mgmt_config.o
  CC [M]  /kernel/5.14.17.x86_64/net/bluetooth/sco.o
  CC [M]  /kernel/5.14.17.x86_64/net/bluetooth/leds.o
  CC [M]  /kernel/5.14.17.x86_64/net/bluetooth/msft.o
  LD [M]  /kernel/5.14.17.x86_64/net/bluetooth/bluetooth.o
  MODPOST /kernel/5.14.17.x86_64/net/bluetooth/Module.symvers
  CC [M]  /kernel/5.14.17.x86_64/net/bluetooth/bluetooth.mod.o
  LD [M]  /kernel/5.14.17.x86_64/net/bluetooth/bluetooth.ko
  BTF [M] /kernel/5.14.17.x86_64/net/bluetooth/bluetooth.ko

# cp /pathToTheChangedKernel/net/bluetooth/bluetooth.ko
/lib/modules/5.14.17.x86_64/extra/bluetooth.ko
# depmod -aeF /boot/System.map 5.14.17.x86_64

The warning below still appears in the log, but it has not represented any
negative impact at all for me:

Bluetooth: hci0: CSR: Failed to suspend the device for our Barrot 8041a02
receive-issue workaround

For me, it is working perfectly from that change on. Woohoo!!! I do hope so=
me
snippet code like that one would be inserted into the kernel soon.

I do hope that it works perfectly for you too and let's get some pint of be=
er
to celebrate. It did not beat us. We all beat it instead! Please, give me
feedback :)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

Return-Path: <SRS0=E8Rw=U6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F120C0650E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jul 2019 07:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012ED20652
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jul 2019 07:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfGAHPZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Jul 2019 03:15:25 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:40480 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727173AbfGAHPZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Jul 2019 03:15:25 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id C95B128518
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jul 2019 07:15:24 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id BDDE728555; Mon,  1 Jul 2019 07:15:24 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 203997] [REGRESSION] Unable to connect BT audio device on
 5.1.15
Date:   Mon, 01 Jul 2019 07:15:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: matias.karhumaa@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-203997-62941-FDKBI4ez5w@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203997-62941@https.bugzilla.kernel.org/>
References: <bug-203997-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=203997

--- Comment #8 from Matias Karhumaa (matias.karhumaa@gmail.com) ---
Ah, I think recent regression fix [1] caused another bug:

--snip--
static bool l2cap_check_enc_key_size(struct hci_conn *hcon)
{
        /* The minimum encryption key size needs to be enforced by the
         * host stack before establishing any L2CAP connections. The
         * specification in theory allows a minimum of 1, but to align
         * BR/EDR and LE transports, a minimum of 7 is chosen.
         *
         * This check might also be called for unencrypted connections
         * that have no key size requirements. Ensure that the link is
         * actually encrypted before enforcing a key size.
         */
        return (!test_bit(HCI_CONN_ENCRYPT, &hcon->flags) ||
                hcon->enc_key_size > HCI_MIN_ENC_KEY_SIZE);
}
--snip--

If Encryption key size is 7, L2CAP connection will fail. I think it should be
something like this:

In l2cap_core.c

static bool l2cap_check_enc_key_size(struct hci_conn *hcon)
{
        /* The minimum encryption key size needs to be enforced by the
         * host stack before establishing any L2CAP connections. The
         * specification in theory allows a minimum of 1, but to align
         * BR/EDR and LE transports, a minimum of 7 is chosen.
         *
         * This check might also be called for unencrypted connections
         * that have no key size requirements. Ensure that the link is
         * actually encrypted before enforcing a key size.
         */
        return (!test_bit(HCI_CONN_ENCRYPT, &hcon->flags) ||
                hcon->enc_key_size >= HCI_MIN_ENC_KEY_SIZE);
}
--snip--

Could you test the fix?

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/net/bluetooth?id=693cd8ce3f882524a5d06f7800dd8492411877b3

-- 
You are receiving this mail because:
You are the assignee for the bug.

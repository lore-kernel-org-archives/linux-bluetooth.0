Return-Path: <SRS0=CkcR=5T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FFFC43331
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 17:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CCD2206F8
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 17:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q1PSJMZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgDCRBa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:01:30 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39871 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbgDCRBa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Apr 2020 13:01:30 -0400
Received: by mail-lf1-f68.google.com with SMTP id h6so6397510lfp.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2020 10:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bwkcnt1Q6kSd3+5sG5/ToGd4WR3anu5TFbYEcqAjXB8=;
        b=q1PSJMZZcW7Urx361aAGycIIB22UiHuMBnOk0HDHpOvzpgVYlHIUaU3WFh7Arzgo8w
         SiBOFupe8tksrejCh+xp45GuatduGpDGqcoQcC6amyvfcE/V0MYIij/QhpD61XGuROMc
         sU7ig/VkyB40MER85R7uDH2Uw34KSNz09q5freejrBMSTenDg9yNdZQghMmos8c3IuE2
         +glzptGBTPFuP0iSWAUhybFv8n+nYMISiAuRWqM3QibnmGt9+I1kj5+vywnd4mDBNAB4
         3Ynzub9B9V7+u0H84JemFafQK8+QxNbKEbCJMXc99BF32a0Z+47/kRt9YEto50D/johB
         ktAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bwkcnt1Q6kSd3+5sG5/ToGd4WR3anu5TFbYEcqAjXB8=;
        b=fBiihfW7p1l3ERpJTogpmgM+/sENSVG6pjy1cqf+rKHUM3r6FBSoiveWz7XKYO18ws
         CAFq+Ea81AvtqvONSQM48Lyr6X1by8KYnmyjWJMDPs5F1LMzxH19zBATnBRPgnOom8Z+
         a4j2sMDVfudPb8sCpgUjEAuVRQepQCZmMHHwv8U7SL2nY509zN8gWMfmIux3NTUdLdaU
         3FmJciSwyaPcs3/QGw5IPNPPrYLj1niNUTxNLPUDBBM7qUHXW4cBqHoNna/S+MEkKojk
         +5MHnMrvClTrpSu/6LM43Pzf9ffRXJP0pKEsTKtTm7GLyIvec442hg+q9iKC67yrKpAM
         dn7A==
X-Gm-Message-State: AGi0PuaBjBr85tC/6gQRuZBy7QG++AwbBWsuFpCHONQAOTb3EIGRuGhb
        AfS1JOmdPDdMNpjQDHtgbbBiKwpfBnUKLvNfikjZNO71
X-Google-Smtp-Source: APiQypLgt/MmtFo5qT5NNB6BwrVIP9tZ3kY2wG0ff+fR+wu8xTpWGajs0+LuKDKp8hZBdFEpDK7ajJabMbF0HPR/7V0=
X-Received: by 2002:ac2:5e36:: with SMTP id o22mr6141889lfg.142.1585933286004;
 Fri, 03 Apr 2020 10:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200402132956.642267-1-marcel@holtmann.org> <CALWDO_X-cN4pba3BiSKD7BP5KokaTcDefgyTZeXv0hbxz+LECA@mail.gmail.com>
 <1D4E9B3D-5BB6-4153-9982-B16E5E588C06@holtmann.org>
In-Reply-To: <1D4E9B3D-5BB6-4153-9982-B16E5E588C06@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Fri, 3 Apr 2020 13:01:14 -0400
Message-ID: <CALWDO_XCCsMBRWLSgjtJgDe2cUQeKNk46cwf3tQ9ypWfF6tY1g@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: Add support for reading security information
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Reviewed-by: Alain Michaud <alainm@chromium.org>

On Fri, Apr 3, 2020 at 1:00 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Alain,
>
> >> To allow userspace to make correcty security policy decision, the kernel
> >> needs to export a few details of the supported security features and
> >> encryption key size information. This command exports this information
> >> and also allows future extensions if needed.
> >>
> >> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> >> ---
> >> include/net/bluetooth/mgmt.h |  7 +++++
> >> net/bluetooth/mgmt.c         | 53 ++++++++++++++++++++++++++++++++++++
> >> 2 files changed, 60 insertions(+)
> >>
> >> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> >> index f41cd87550dc..65dd6fd1fff3 100644
> >> --- a/include/net/bluetooth/mgmt.h
> >> +++ b/include/net/bluetooth/mgmt.h
> >> @@ -674,6 +674,13 @@ struct mgmt_cp_set_blocked_keys {
> >>
> >> #define MGMT_OP_SET_WIDEBAND_SPEECH    0x0047
> >>
> >> +#define MGMT_OP_READ_SECURITY_INFO     0x0048
> >> +#define MGMT_READ_SECURITY_INFO_SIZE   0
> >> +struct mgmt_rp_read_security_info {
> >> +       __le16   sec_len;
> >> +       __u8     sec[0];
> >> +} __packed;
> >> +
> >> #define MGMT_EV_CMD_COMPLETE           0x0001
> >> struct mgmt_ev_cmd_complete {
> >>        __le16  opcode;
> >> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> >> index 6552003a170e..7b9eac339c87 100644
> >> --- a/net/bluetooth/mgmt.c
> >> +++ b/net/bluetooth/mgmt.c
> >> @@ -108,6 +108,7 @@ static const u16 mgmt_commands[] = {
> >>        MGMT_OP_SET_APPEARANCE,
> >>        MGMT_OP_SET_BLOCKED_KEYS,
> >>        MGMT_OP_SET_WIDEBAND_SPEECH,
> >> +       MGMT_OP_READ_SECURITY_INFO,
> >> };
> >>
> >> static const u16 mgmt_events[] = {
> >> @@ -155,6 +156,7 @@ static const u16 mgmt_untrusted_commands[] = {
> >>        MGMT_OP_READ_CONFIG_INFO,
> >>        MGMT_OP_READ_EXT_INDEX_LIST,
> >>        MGMT_OP_READ_EXT_INFO,
> >> +       MGMT_OP_READ_SECURITY_INFO,
> >> };
> >>
> >> static const u16 mgmt_untrusted_events[] = {
> >> @@ -3659,6 +3661,55 @@ static int set_wideband_speech(struct sock *sk, struct hci_dev *hdev,
> >>        return err;
> >> }
> >>
> >> +static int read_security_info(struct sock *sk, struct hci_dev *hdev,
> >> +                             void *data, u16 data_len)
> >> +{
> >> +       char buf[16];
> >> +       struct mgmt_rp_read_security_info *rp = (void *)buf;
> >> +       u16 sec_len = 0;
> >> +       u8 flags = 0;
> >> +
> >> +       bt_dev_dbg(hdev, "sock %p", sk);
> >> +
> >> +       memset(&buf, 0, sizeof(buf));
> >> +
> >> +       hci_dev_lock(hdev);
> >> +
> >> +       /* When the Read Simple Pairing Options command is supported, then
> >> +        * the remote public key validation is supported.
> >> +        */
> >> +       if (hdev->commands[41] & 0x08)
> >> +               flags |= 0x01;  /* Remote public key validation (BR/EDR) */
> >> +
> >> +       flags |= 0x02;          /* Remote public key validation (LE) */
> >> +
> >> +       /* When the Read Encryption Key Size command is supported, then the
> >> +        * encryption key size is enforced.
> >> +        */
> >> +       if (hdev->commands[20] & 0x10)
> >> +               flags |= 0x04;  /* Encryption key size enforcement (BR/EDR) */
> >> +
> >> +       flags |= 0x08;          /* Encryption key size enforcement (LE) */
> >> +
> >> +       sec_len = eir_append_data(rp->sec, sec_len, 0x01, &flags, 1);
> >> +
> >> +       /* When the Read Simple Pairing Options command is supported, then
> >> +        * also max encryption key size information is provided.
> >> +        */
> >> +       if (hdev->commands[41] & 0x08)
> >> +               sec_len = eir_append_le16(rp->sec, sec_len, 0x02,
> >> +                                         hdev->max_enc_key_size);
> >> +
> >> +       sec_len = eir_append_le16(rp->sec, sec_len, 0x03, SMP_MAX_ENC_KEY_SIZE);
> >> +
> >> +       rp->sec_len = cpu_to_le16(sec_len);
> >> +
> >> +       hci_dev_unlock(hdev);
> >> +
> >> +       return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_READ_SECURITY_INFO, 0,
> >> +                                rp, sizeof(*rp) + sec_len);
> >> +}
> >> +
> >> static void read_local_oob_data_complete(struct hci_dev *hdev, u8 status,
> >>                                         u16 opcode, struct sk_buff *skb)
> >> {
> >> @@ -7099,6 +7150,8 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
> >>        { set_blocked_keys,        MGMT_OP_SET_BLOCKED_KEYS_SIZE,
> >>                                                HCI_MGMT_VAR_LEN },
> >>        { set_wideband_speech,     MGMT_SETTING_SIZE },
> >> +       { read_security_info,      MGMT_READ_SECURITY_INFO_SIZE,
> >> +                                               HCI_MGMT_UNTRUSTED },
> >> };
> >>
> >> void mgmt_index_added(struct hci_dev *hdev)
> >> --
> >> 2.25.1
> >>
> > LGTM.
>
> Can I treat these as Reviewed-by: Alain Michaud <alainmichaud@google.com> ?
>
> Regards
>
> Marcel
>

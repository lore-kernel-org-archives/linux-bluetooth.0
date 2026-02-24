Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D58023AB87
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 14:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771944116; cv=pass; b=mXe+GXnyLpFW+UkDrB6RcScMYtptOellIkIVJl2XmUTD7jZ5jzYO1tyV/0iSC9QE1RKztAftbB1U244pc5eJyyvCm2IpN+QrN79NY7X2AWlacxTlWYG4HKTxv/0ni+L3CfIjlc1YBuzs8XJgkx1EyrNYP7m4/Eco3HtL9/J9fwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771944116; c=relaxed/simple;
	bh=DKQIK6K2WTHUIFvpIb97usFgZt/S7i3n4OTJ5SluD4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UdXfgkhjjAJ19chiJ3QqBz24YCsAhQ8dfdQJ5wVLoRAmc4o3RhKAd6B+Wt2hA5c2jVQ9YUNvDU7iZRsbAIybNZto9xT/ph0lwSfVBzZJeOEgLgV5e7mLIMUYmPBcKS8oB0I9jyeJ+YrjSuLQeSZCoVfDTOsyzxjAlOQ8YjohDsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZ7qyng2; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZ7qyng2"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64ad79df972so5486250d50.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 06:41:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771944113; cv=none;
        d=google.com; s=arc-20240605;
        b=IQUsbOsnk3krzfwj3XAmrcyDjBLqwwRPla0j+qUpZdUY97HH+/FSVVxRLK/uXZ+yhz
         fw5ANJTClT1veFqHAwhHzpMzgvIJoUrnH8Eiq/+cRo9/OEkkW6MlWOWzUw3PLTnp7/1R
         jYx/DZ5OcG1Jz9dS6A2OTD0hx3Skzo/b9aIKjT45CTY+PPdRiaiiGg7q1IrJjqWde0uO
         n6mkHySiT3QYxn27IOV/83hAFBTwo43oI2JnxwnCPgCgoD+tUOm2ylsIQbMw1RWeiRSz
         7RGXCRGnIEOog9j9cDRHNcXV12/j3vhzBac9qT7W/A2/x4+xmWm2gXxdFm/rdrMxFjUE
         6hkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CjfWJDHQ0H3cJ2jvNdAfB45Qj14gxgRckcC4mp3+4GM=;
        fh=CVyQHQOwb1JUJSj1ou+y0WudeQOMoUIjTkVuZB7IXZ4=;
        b=GEEt3F5hWtYpEtALbU4AxquW8Vg25i/AsbN2bzHfm1qzYk7aPmbpLatOciZzsyrvPF
         eQnT1SKOk/jrkF+DbicCCmiLP+hMRSF1mekkpoKXhmLP5IO8x8VF9VDFakVE+VxLsQuq
         tHYFDM5IpC1zG8aE77R16IM30nKJkFlIUK9TJ9gKwXEa7UKxfzUBw4l9rv9v1Ha2Tzvi
         BVIOpn6sVtu4jHxwFwpPqn+qf1nofAJiK7wPc1Gkn0Gu+CHGGjPdZr5jlbryX4S8dEuf
         Frx2jNzbySVfXKOVd/a6fCPT4sFQqSP7iSXLNhTYa2MxUUl3I5Fom2cOLUTebmYYGDJ1
         nbiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771944113; x=1772548913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjfWJDHQ0H3cJ2jvNdAfB45Qj14gxgRckcC4mp3+4GM=;
        b=mZ7qyng2sQB3Mx5Lb4nIdJRVkbWwgGQ2uLdzY3el7LnQ5pbzPlmVxC3ObvNKpL3tsP
         O+LGm7X3n7yrqkgMxSInE9MQL92pkqpelBsZEOQ+gI3/tjpyCs9fGsqCICI+tgr4cSyK
         LNg27DB0mxgvLK2YnNK/FSnE8l7H0DPSMJ/9S+F4yFQvQm6xxFTrt/gXqh1ThVVgAqYb
         vF8SaV4kLOSZ/erBFrkXKBFbziUSOfhC//POMhJZ8nji25lbvtIL2JzmzMygPIX+kZvC
         U0dTUsDFeGxrdsh/Dz8BrGV9G3C86JQCa8wg8y7iD3PCfxMFJWwyMwRjCnpnM7qw24KS
         agIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771944113; x=1772548913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CjfWJDHQ0H3cJ2jvNdAfB45Qj14gxgRckcC4mp3+4GM=;
        b=a9IZdg/xqKej+r7bmuU1d5nIKCpwLjzX+BGKrZX69gfgsBqw7mzgsIQMUlOqLS/EqC
         9Man4vRam07xrnGcUpi8k5w5NBZs2lSwnMsHlw3h2khtx1Qa0BNFCXgWbepP4JAGangM
         8XqaR3uoKln4uHH3+VB0w8+eNiJzI1KjJ1ugVfZtFNC9b/72jps+8wDMSEt8S6te8UOS
         rRj0dIYifuS+7TErbO5b0VINFQefNEd3hI+whLhnKYXV24IGyMGIX/HXbIuI4dgaZVts
         MM+B2Lb7H4IooSoR0o0ZN5ctvw+Nlw2avFXSudLPLL3yKaF/YuCQJNzi9z4J0UfK4sJj
         aj9g==
X-Gm-Message-State: AOJu0YxbheVpQmL+NMb3TRrV2vXr18APXLWTMykoNz4mpwjF8xkcjmRG
	f07N7lrZN/0Of1kRGaUImrsbYIrstFUljuDkSuAUZK4fsm3tkxEYW3UDIOSd+BCCnqDSEglncny
	7pfrSEziDSiHQADCHmXSoMfhV+MXbWj4=
X-Gm-Gg: ATEYQzwMVm7u0ZM4/ljXe5l0DeOIcf84vqBt1wE60Y0Lz5EfPsoT+uxNq/Jq4SY+GxR
	R4DzSvXwD05GEX8nb1TEiTFLtlf6chfsCO11nHiphAe5ABLxbwa5DkdR72W4k1xfxIVxP3aqiMY
	tUUg2wFTa/3bF9BN3Xdz6Y3qQfQKjqV/d2NaHoTcq93rbuDZRgZvivR4jx5omi6NfWljc/BeAe3
	WEHKHkM99mkLzux2ClyV1+MLnHs2/o5v/2KICWH9i6ahCeTBHq9XDHXWkJy7VdqwLObpZDVbgpN
	0G7AgekcmuHDHf6D5dvwQog+UVXdZ+wf/hI9LH8v6AowI5nWEXk3eGoxUJeaTTb6tKptlw==
X-Received: by 2002:a05:690e:22c4:b0:64a:f3fa:af5e with SMTP id
 956f58d0204a3-64c7909f2a0mr9197953d50.86.1771944113343; Tue, 24 Feb 2026
 06:41:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224105747.2718150-1-mengshi.wu@oss.qualcomm.com>
In-Reply-To: <20260224105747.2718150-1-mengshi.wu@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 24 Feb 2026 09:41:42 -0500
X-Gm-Features: AaiRm51n9MP1s1nA0vrliIS7tpnA6d86M6kQl2JJ3xbJfsk5op1E-IbAG5SryZc
Message-ID: <CABBYNZLxKPviLDTWmcE+SH33kLZandkZBdzL-xCo-wTgQukyrg@mail.gmail.com>
Subject: Re: [PATCH v5] gatt-client:Implement error handling for
 DB_OUT_OF_SYNC in GATT caching
To: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com, 
	cheng.jiang@oss.qualcomm.com, chezhou@qti.qualcomm.com, 
	wei.deng@oss.qualcomm.com, yiboz@qti.qualcomm.com, 
	jinwang.li@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mengshi,

On Tue, Feb 24, 2026 at 5:58=E2=80=AFAM Mengshi Wu <mengshi.wu@oss.qualcomm=
.com> wrote:
>
> Implement automatic retry logic for GATT operations that fail with
> DB_OUT_OF_SYNC error (0x12).
>
> This implementation follows the GATT caching specification and provides
> robust error recovery while minimizing unnecessary service discovery
> operations.
>
> When a DB_OUT_OF_SYNC error occurs, the implementation:
>
> 1. Pauses the failed operation in a pending_db_sync state
> 2. Notifies the GATT client layer via db_sync_callback
> 3. Reads the remote Database Hash characteristic (0x2B2A)
> 4. Compares it with the locally cached hash value
> 5. If hashes match: Retries the operation (database is in sync)
> 6. If hashes differ: Triggers full service discovery
>
> Workflow:
> ---------
>
> Hash Match Case:
>   App =E2=86=92 GATT Client =E2=86=92 ATT Layer =E2=86=92 Remote Device
>                                       =E2=86=93 (DB_OUT_OF_SYNC error)
>   App =E2=86=90 GATT Client =E2=86=90 ATT Layer =E2=86=90 Remote Device
>                 =E2=86=93
>          Read DB Hash (0x2B2A)
>                 =E2=86=93
>          Compare with local cache
>                 =E2=86=93 (Match)
>          bt_att_resend(att, id, ...)
>                 =E2=86=93
>   App =E2=86=92 GATT Client =E2=86=92 ATT Layer =E2=86=92 Remote Device (=
retry)
>                                       =E2=86=93 (Success)
>   App =E2=86=90 GATT Client =E2=86=90 ATT Layer =E2=86=90 Remote Device
>
> Hash Differ Case:
>   App =E2=86=92 GATT Client =E2=86=92 ATT Layer =E2=86=92 Remote Device
>                                       =E2=86=93 (DB_OUT_OF_SYNC error)
>   App =E2=86=90 GATT Client =E2=86=90 ATT Layer =E2=86=90 Remote Device
>                 =E2=86=93
>          Read DB Hash (0x2B2A)
>                 =E2=86=93
>          Compare with local cache
>                 =E2=86=93 (Differ)
>          bt_att_cancel(att, id)
>                 =E2=86=93
>          Trigger Service Discovery
>                 =E2=86=93
>   App =E2=86=90 GATT Client (operation failed, discovery in progress)
>
> Service Changed Ind Received (Handle Outside Affected Range):
>   App =E2=86=92 GATT Client =E2=86=92 ATT Layer =E2=86=92 Remote Device
>                                       =E2=86=93 (DB_OUT_OF_SYNC error)
>   App =E2=86=90 GATT Client =E2=86=90 ATT Layer =E2=86=90 Remote Device
>                 =E2=86=93
>          Service Changed Ind arrives
>                 =E2=86=93
>          Check error handle vs affected range
>                 =E2=86=93 (Outside range)
>          bt_att_resend(att, id, ...)
>                 =E2=86=93
>   App =E2=86=92 GATT Client =E2=86=92 ATT Layer =E2=86=92 Remote Device (=
retry)
>                                       =E2=86=93 (Success)
>   App =E2=86=90 GATT Client =E2=86=90 ATT Layer =E2=86=90 Remote Device
>
> Service Changed Ind Received (Handle Inside Affected Range):
>   App =E2=86=92 GATT Client =E2=86=92 ATT Layer =E2=86=92 Remote Device
>                                       =E2=86=93 (DB_OUT_OF_SYNC error)
>   App =E2=86=90 GATT Client =E2=86=90 ATT Layer =E2=86=90 Remote Device
>                 =E2=86=93
>          Service Changed Ind arrives
>                 =E2=86=93
>          Check error handle vs affected range
>                 =E2=86=93 (Inside range)
>          bt_att_cancel(att, id)
>                 =E2=86=93
>          Service Discovery already in progress
>                 =E2=86=93
>   App =E2=86=90 GATT Client (operation failed, discovery in progress)
>
> btmon traffics:
> --------------
>
> Hash Match Case:
>
> bluetoothd[91554]: < ACL Data TX: Handle 3 flags 0x00 dlen 7   #1 [hci1]
> 13.675271
>       ATT: Read Request (0x0a) len 2
>         Handle: 0x000d
> > HCI Event: Number of Completed Packets (0x13) plen 5         #2 [hci1]
> > 13.694287
>         Num handles: 1
>         Handle: 3
>         Count: 1
> > ACL Data RX: Handle 3 flags 0x02 dlen 9                      #3 [hci1]
> > 13.728279
>       ATT: Error Response (0x01) len 4
>         Read Request (0x0a)
>         Handle: 0x000d
>         Error: Database Out of Sync (0x12)
> bluetoothd[91554]: < ACL Data TX: Handle 3 flags 0x00 dlen 11  #4 [hci1]
> 13.730759
>       ATT: Read By Type Request (0x08) len 6
>         Handle range: 0x0001-0xffff
>         Attribute type: Database Hash (0x2b2a)
> > HCI Event: Number of Completed Packets (0x13) plen 5         #5 [hci1]
> > 13.754290
>         Num handles: 1
>         Handle: 3
>         Count: 1
> > ACL Data RX: Handle 3 flags 0x02 dlen 24                     #6 [hci1]
> > 13.820283
>       ATT: Read By Type Response (0x09) len 19
>         Attribute data length: 18
>         Attribute data list: 1 entry
>         Handle: 0x000f
>         Value: f74347d19eef647d97f0b2f7af502e33
> bluetoothd[91554]: < ACL Data TX: Handle 3 flags 0x00 dlen 11  #7 [hci1]
> 13.822792
>       ATT: Read By Type Request (0x08) len 6
>         Handle range: 0x0010-0xffff
>         Attribute type: Database Hash (0x2b2a)
> > HCI Event: Number of Completed Packets (0x13) plen 5         #8 [hci1]
> > 13.842581
>         Num handles: 1
>         Handle: 3
>         Count: 1
> > ACL Data RX: Handle 3 flags 0x02 dlen 9                      #9 [hci1]
> > 13.880369
>       ATT: Error Response (0x01) len 4
>         Read By Type Request (0x08)
>         Handle: 0x0010
>         Error: Attribute Not Found (0x0a)
> bluetoothd[91554]: < ACL Data TX: Handle 3 flags 0x00 dlen 7   #10
> [hci1] 13.880999
>       ATT: Read Request (0x0a) len 2
>         Handle: 0x000d
> > HCI Event: Number of Completed Packets (0x13) plen 5         #11
> > [hci1] 13.904288
>         Num handles: 1
>         Handle: 3
>         Count: 1
> > ACL Data RX: Handle 3 flags 0x02 dlen 6                      #12
> > [hci1] 13.940273
>       ATT: Read Response (0x0b) len 1
>
> --------------------
> Hash differ case:
>
> bluetoothd[91554]: < ACL Data TX: Handle 3 flags 0x00 dlen 7
>       ATT: Read Request (0x0a) len 2
>         Handle: 0x000d
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > #17 [hci1] 50.171857
>         Num handles: 1
>         Handle: 3
>         Count: 1
> > ACL Data RX: Handle 3 flags 0x02 dlen 9
> > #18 [hci1] 50.171970
>       ATT: Error Response (0x01) len 4
>         Read Request (0x0a)
>         Handle: 0x000d
>         Error: Database Out of Sync (0x12)
> bluetoothd[91554]: < ACL Data TX: Handle 3 flags 0x00 dlen 11
>       ATT: Read By Type Request (0x08) len 6
>         Handle range: 0x0001-0xffff
>         Attribute type: Database Hash (0x2b2a)
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > #20 [hci1] 50.201854
>         Num handles: 1
>         Handle: 3
>         Count: 1
> > ACL Data RX: Handle 3 flags 0x02 dlen 24
> > #21 [hci1] 50.268291
>       ATT: Read By Type Response (0x09) len 19
>         Attribute data length: 18
>         Attribute data list: 1 entry
>         Handle: 0x000f
>         Value: 5fa98eed072ee317aa521990be294bf3
> bluetoothd[91554]: < ACL Data TX: Handle 3 flags 0x00 dlen 11
>       ATT: Read By Type Request (0x08) len 6
>         Handle range: 0x0010-0xffff
>         Attribute type: Database Hash (0x2b2a)
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > #23 [hci1] 50.291849
>         Num handles: 1
>         Handle: 3
>         Count: 1
> > ACL Data RX: Handle 3 flags 0x02 dlen 9
> > #24 [hci1] 50.419999
>       ATT: Error Response (0x01) len 4
>         Read By Type Request (0x08)
>         Handle: 0x0010
>         Error: Attribute Not Found (0x0a)
> bluetoothd[91554]: < ACL Data TX: Handle 3 flags 0x00 dlen 11
>       ATT: Read By Group Type Request (0x10) len 6
>         Handle range: 0x0001-0xffff
>         Attribute group type: Primary Service (0x2800)
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > #26 [hci1] 50.471607
>         Num handles: 1
>         Handle: 3
>         Count: 1
> > ACL Data RX: Handle 3 flags 0x02 dlen 24
> > #27 [hci1] 50.471663
>       ATT: Read By Group Type Response (0x11) len 19
>         Attribute data length: 6
>         Attribute group list: 3 entries
>         Handle range: 0x0001-0x0007
>         UUID: Generic Access Profile (0x1800)
>         Handle range: 0x0008-0x0011
>         UUID: Generic Attribute Profile (0x1801)
>         Handle range: 0x0012-0x0014
>         UUID: Device Information (0x180a)
> --------------------
>
> Changes from v4:
>  - Fix errors reported by bluez.test.bot
>  - Link to v4
>    https://lore.kernel.org/all/20260210011347.3237740-1-mengshi.wu@oss.qu=
alcomm.com/
>
> Changes from v3:
>  - Reuses existing bt_att_resend() and bt_att_cancel() functions
>  - Add new structure pending_db_sync
>  - Link to v3
>    https://lore.kernel.org/all/20260121083804.4010106-1-mengshi.wu@oss.qu=
alcomm.com/
>
> Changes from v2:
>  - Detects DB_OUT_OF_SYNC errors during GATT operations
>  - Extracts affected handles from the original request PDU
>  - Checks if Service Changed indications overlap with those handles
>  - Verifies database consistency using Database Hash characteristic
>  - Automatically retries the original request if DB is consistent
>  - Automatically retries the original request if handle is not affected
>  - Link to v2
>    https://lore.kernel.org/all/20260105103828.105346-1-mengshi.wu@oss.qua=
lcomm.com/
>
> Changes from v1:
>  - Implement automatic recovery when ATT_ECODE_DB_OUT_OF_SYNC error is
>    received from the remote device.
>  - Link to v1
>    https://lore.kernel.org/all/20251208101915.247459-1-mengshi.wu@oss.qua=
lcomm.com/
>
> Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
> ---
>  src/shared/att.c          | 144 ++++++++++++++++++++++++++++++++-
>  src/shared/att.h          |   9 +++
>  src/shared/gatt-client.c  | 166 ++++++++++++++++++++++++++++++++++++++
>  src/shared/gatt-helpers.c |  16 ++++
>  src/shared/gatt-helpers.h |   3 +
>  5 files changed, 335 insertions(+), 3 deletions(-)
>
> diff --git a/src/shared/att.c b/src/shared/att.c
> index 77ca4aa24..6bc95e6d4 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -35,6 +35,7 @@
>  #define BT_ATT_SIGNATURE_LEN           12
>
>  struct att_send_op;
> +struct pending_db_sync;
>
>  struct bt_att_chan {
>         struct bt_att *att;
> @@ -47,6 +48,7 @@ struct bt_att_chan {
>
>         struct att_send_op *pending_req;
>         struct att_send_op *pending_ind;
> +       struct pending_db_sync *pending_db_sync;
>         bool writer_active;
>
>         bool in_req;                    /* There's a pending incoming req=
uest */
> @@ -78,6 +80,10 @@ struct bt_att {
>         bt_att_destroy_func_t timeout_destroy;
>         void *timeout_data;
>
> +       bt_att_db_sync_func_t db_sync_callback;
> +       bt_att_destroy_func_t db_sync_destroy;
> +       void *db_sync_data;
> +
>         uint8_t debug_level;
>         bt_att_debug_func_t debug_callback;
>         bt_att_destroy_func_t debug_destroy;
> @@ -199,6 +205,11 @@ struct att_send_op {
>         void *user_data;
>  };
>
> +struct pending_db_sync {
> +       struct att_send_op *op;
> +       struct bt_att_pdu_error_rsp error;
> +};
> +
>  static void destroy_att_send_op(void *data)
>  {
>         struct att_send_op *op =3D data;
> @@ -644,6 +655,11 @@ static void bt_att_chan_free(void *data)
>         if (chan->pending_ind)
>                 destroy_att_send_op(chan->pending_ind);
>
> +       if (chan->pending_db_sync) {
> +               destroy_att_send_op(chan->pending_db_sync->op);
> +               free(chan->pending_db_sync);
> +       }
> +
>         queue_destroy(chan->queue, destroy_att_send_op);
>
>         io_destroy(chan->io);
> @@ -682,6 +698,12 @@ static bool disconnect_cb(struct io *io, void *user_=
data)
>                 chan->pending_ind =3D NULL;
>         }
>
> +       if (chan->pending_db_sync) {
> +               disc_att_send_op(chan->pending_db_sync->op);
> +               free(chan->pending_db_sync);
> +               chan->pending_db_sync =3D NULL;
> +       }
> +
>         bt_att_chan_free(chan);
>
>         /* Don't run disconnect callback if there are channels left */
> @@ -800,9 +822,42 @@ static bool handle_error_rsp(struct bt_att_chan *cha=
n, uint8_t *pdu,
>                 return false;
>
>         /* Attempt to change security */
> -       if (!change_security(chan, rsp->ecode))
> -               return false;
> +       if (change_security(chan, rsp->ecode))
> +               goto retry;
> +
> +       /* Check if this is DB_OUT_OF_SYNC and we have a callback */
> +       if (rsp->ecode =3D=3D BT_ATT_ERROR_DB_OUT_OF_SYNC && att->db_sync=
_callback) {
> +               struct pending_db_sync *pending;
> +
> +               pending =3D new0(struct pending_db_sync, 1);
> +               if (!pending)
> +                       return false;
>
> +               pending->op =3D op;
> +               pending->error =3D *rsp;
> +
> +               /* Remove timeout since we're waiting for approval */
> +               if (op->timeout_id) {
> +                       timeout_remove(op->timeout_id);
> +                       op->timeout_id =3D 0;
> +               }
> +
> +               /* Move to pending_db_sync */
> +               chan->pending_db_sync =3D pending;
> +               chan->pending_req =3D NULL;
> +
> +               DBG(att, "(chan %p) DB sync pending for operation %p", ch=
an, op);
> +
> +               /* Notify upper layer */
> +               att->db_sync_callback(&pending->error, op->pdu + 1, op->l=
en - 1,
> +                                     op->id, att->db_sync_data);
> +
> +               return true;
> +       }
> +
> +       return false;
> +
> +retry:
>         /* Remove timeout_id if outstanding */
>         if (op->timeout_id) {
>                 timeout_remove(op->timeout_id);
> @@ -1142,6 +1197,9 @@ static void bt_att_free(struct bt_att *att)
>         if (att->timeout_destroy)
>                 att->timeout_destroy(att->timeout_data);
>
> +       if (att->db_sync_destroy)
> +               att->db_sync_destroy(att->db_sync_data);
> +
>         if (att->debug_destroy)
>                 att->debug_destroy(att->debug_data);
>
> @@ -1473,6 +1531,23 @@ bool bt_att_set_timeout_cb(struct bt_att *att, bt_=
att_timeout_func_t callback,
>         return true;
>  }
>
> +bool bt_att_set_db_sync_cb(struct bt_att *att, bt_att_db_sync_func_t cal=
lback,
> +                                               void *user_data,
> +                                               bt_att_destroy_func_t des=
troy)
> +{
> +       if (!att)
> +               return false;
> +
> +       if (att->db_sync_destroy)
> +               att->db_sync_destroy(att->db_sync_data);
> +
> +       att->db_sync_callback =3D callback;
> +       att->db_sync_destroy =3D destroy;
> +       att->db_sync_data =3D user_data;
> +
> +       return true;
> +}
> +
>  unsigned int bt_att_register_disconnect(struct bt_att *att,
>                                         bt_att_disconnect_func_t callback=
,
>                                         void *user_data,
> @@ -1650,6 +1725,7 @@ int bt_att_resend(struct bt_att *att, unsigned int =
id, uint8_t opcode,
>  {
>         const struct queue_entry *entry;
>         struct att_send_op *op;
> +       bool from_db_sync =3D false;
>         bool result;
>
>         if (!att || !id)
> @@ -1662,11 +1738,41 @@ int bt_att_resend(struct bt_att *att, unsigned in=
t id, uint8_t opcode,
>
>                 if (chan->pending_req && chan->pending_req->id =3D=3D id)
>                         break;
> +
> +               /* Also check pending_db_sync */
> +               if (chan->pending_db_sync && chan->pending_db_sync->op->i=
d =3D=3D id) {
> +                       from_db_sync =3D true;
> +                       break;
> +               }
>         }
>
>         if (!entry)
>                 return -ENOENT;
>
> +       /* If from pending_db_sync, extract operation details if not prov=
ided */
> +       if (from_db_sync) {
> +               struct bt_att_chan *chan =3D entry->data;
> +               struct pending_db_sync *pending =3D chan->pending_db_sync=
;
> +               struct att_send_op *stored_op =3D pending->op;
> +
> +               /* Auto-extract from stored operation if pdu is NULL */
> +               if (!pdu) {
> +                       opcode =3D stored_op->opcode;
> +                       pdu =3D stored_op->pdu + 1;
> +                       length =3D stored_op->len - 1;
> +                       callback =3D stored_op->callback;
> +                       user_data =3D stored_op->user_data;
> +                       destroy =3D stored_op->destroy;
> +               }
> +
> +               DBG(att, "(chan %p) Resending DB sync operation %p",
> +                   chan, stored_op);
> +
> +               /* Clear pending_db_sync state */
> +               chan->pending_db_sync =3D NULL;
> +               free(pending);
> +       }
> +
>         /* Only allow requests to be resend */
>         if (get_op_type(opcode) !=3D ATT_OP_TYPE_REQ)
>                 return -EOPNOTSUPP;
> @@ -1763,6 +1869,34 @@ bool bt_att_chan_cancel(struct bt_att_chan *chan, =
unsigned int id)
>         return true;
>  }
>
> +static bool bt_att_db_sync_cancel(struct bt_att_chan *chan, unsigned int=
 id)
> +{
> +       if (chan->pending_db_sync && chan->pending_db_sync->op->id =3D=3D=
 id) {
> +               struct pending_db_sync *pending =3D chan->pending_db_sync=
;
> +               struct att_send_op *op =3D pending->op;
> +               uint8_t error_pdu[sizeof(struct bt_att_pdu_error_rsp)];
> +
> +               /* Build error response PDU */
> +               memcpy(error_pdu, &pending->error, sizeof(pending->error)=
);
> +
> +               /* Clear pending state */
> +               chan->pending_db_sync =3D NULL;
> +               free(pending);
> +
> +               /* Notify callback with error */
> +               if (op->callback)
> +                       op->callback(BT_ATT_OP_ERROR_RSP, error_pdu,
> +                                    sizeof(error_pdu), op->user_data);
> +
> +               destroy_att_send_op(op);
> +               wakeup_chan_writer(chan, NULL);
> +
> +               return true;
> +       }
> +
> +       return false;
> +}
> +
>  static bool bt_att_disc_cancel(struct bt_att *att, unsigned int id)
>  {
>         struct att_send_op *op;
> @@ -1795,11 +1929,15 @@ bool bt_att_cancel(struct bt_att *att, unsigned i=
nt id)
>         if (!att || !id)
>                 return false;
>
> -       /* Lookuo request on each channel first */
> +       /* Lookup request on each channel first */
>         for (entry =3D queue_get_entries(att->chans); entry;
>                                                 entry =3D entry->next) {
>                 struct bt_att_chan *chan =3D entry->data;
>
> +               /* Check pending_db_sync first on each channel */
> +               if (bt_att_db_sync_cancel(chan, id))
> +                       return true;
> +
>                 if (bt_att_chan_cancel(chan, id))
>                         return true;
>         }
> diff --git a/src/shared/att.h b/src/shared/att.h
> index 53a3f7a2a..ba1f84677 100644
> --- a/src/shared/att.h
> +++ b/src/shared/att.h
> @@ -46,6 +46,11 @@ typedef void (*bt_att_disconnect_func_t)(int err, void=
 *user_data);
>  typedef void (*bt_att_exchange_func_t)(uint16_t mtu, void *user_data);
>  typedef bool (*bt_att_counter_func_t)(uint32_t *sign_cnt, void *user_dat=
a);
>
> +/* DB sync callback - notifies upper layer of DB_OUT_OF_SYNC error */
> +typedef void (*bt_att_db_sync_func_t)(const struct bt_att_pdu_error_rsp =
*error,
> +                                       const void *req_pdu, uint16_t req=
_len,
> +                                       unsigned int att_id, void *user_d=
ata);
> +
>  bool bt_att_set_debug(struct bt_att *att, uint8_t level,
>                         bt_att_debug_func_t callback, void *user_data,
>                         bt_att_destroy_func_t destroy);
> @@ -58,6 +63,10 @@ bool bt_att_set_timeout_cb(struct bt_att *att, bt_att_=
timeout_func_t callback,
>                                                 void *user_data,
>                                                 bt_att_destroy_func_t des=
troy);
>
> +bool bt_att_set_db_sync_cb(struct bt_att *att, bt_att_db_sync_func_t cal=
lback,
> +                                               void *user_data,
> +                                               bt_att_destroy_func_t des=
troy);
> +
>  unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
>                                         const void *pdu, uint16_t length,
>                                         bt_att_response_func_t callback,
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index f8ebab3fa..2056149ba 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -114,6 +114,10 @@ struct bt_gatt_client {
>
>         struct bt_gatt_request *discovery_req;
>         unsigned int mtu_req_id;
> +
> +       /* Pending retry operation for DB out of sync handling */
> +       unsigned int pending_retry_att_id;
> +       uint16_t pending_error_handle;
>  };
>
>  struct request {
> @@ -2342,6 +2346,165 @@ static void att_disconnect_cb(int err, void *user=
_data)
>                 notify_client_ready(client, false, 0);
>  }
>
> +static bool is_handle_out_of_range(uint16_t handle, struct bt_gatt_clien=
t *client)
> +{
> +       bool handle_out_of_range =3D false;
> +       uint16_t start_handle, end_handle;
> +
> +       if (handle) {
> +               start_handle =3D bt_gatt_req_get_start_handle(
> +                               client->discovery_req);
> +               end_handle =3D bt_gatt_req_get_end_handle(
> +                               client->discovery_req);
> +
> +               if (start_handle !=3D 0 && end_handle !=3D 0 &&
> +                       (handle < start_handle || handle > end_handle))
> +                       handle_out_of_range =3D true;
> +       }
> +
> +       return handle_out_of_range;
> +}
> +
> +static void db_hash_check_cb(bool success, uint8_t att_ecode,
> +                             struct bt_gatt_result *result,
> +                             void *user_data)
> +{
> +       struct bt_gatt_client *client =3D user_data;
> +       struct gatt_db_attribute *hash_attr =3D NULL;
> +       const uint8_t *local_hash =3D NULL;
> +       const uint8_t *remote_hash;
> +       uint16_t length, handle;
> +       struct bt_gatt_iter iter;
> +       bt_uuid_t uuid;
> +       unsigned int att_id =3D client->pending_retry_att_id;
> +       uint16_t pending_error_handle =3D client->pending_error_handle;
> +       bool handle_out_of_range;
> +
> +       client->pending_retry_att_id =3D 0;
> +       client->pending_error_handle =3D 0;
> +
> +       /* If a Service Changed indication is received at this stage, the
> +        * pending request may be retried once we have verified that the
> +        * affected attribute handle is not within the range impacted by
> +        * the service change.
> +        */
> +       if (client->in_svc_chngd) {
> +               handle_out_of_range =3D
> +                       is_handle_out_of_range(pending_error_handle, clie=
nt);
> +
> +               if (handle_out_of_range) {
> +                       DBG(client, "Error handle not effected, approving=
 retry");
> +                       bt_att_resend(client->att, att_id, 0, NULL, 0,
> +                                     NULL, NULL, NULL);
> +               } else {
> +                       DBG(client, "Error handle is in range of svc chng=
d");
> +                       bt_att_cancel(client->att, att_id);
> +               }
> +               return;
> +       }
> +
> +       if (!att_id) {
> +               DBG(client, "No pending retry operation");
> +               return;
> +       }
> +
> +       if (!success) {
> +               DBG(client,
> +               "Failed to read remote DB Hash, triggering full discovery=
");
> +               goto trigger_discovery;
> +       }
> +
> +       /* Extract hash value from result */
> +       if (!result || !bt_gatt_iter_init(&iter, result))
> +               goto trigger_discovery;
> +
> +       if (!bt_gatt_iter_next_read_by_type(&iter, &handle, &length,
> +                                            &remote_hash))
> +               goto trigger_discovery;
> +
> +       if (length !=3D 16) {
> +               DBG(client, "Invalid DB Hash length: %u", length);
> +               goto trigger_discovery;
> +       }
> +
> +       /* Get local hash from database */
> +       bt_uuid16_create(&uuid, GATT_CHARAC_DB_HASH);
> +       gatt_db_find_by_type(client->db, 0x0001, 0xffff, &uuid,
> +                            get_first_attribute, &hash_attr);
> +
> +       if (hash_attr) {
> +               gatt_db_attribute_read(hash_attr, 0, BT_ATT_OP_READ_REQ, =
NULL,
> +                                      db_hash_read_value_cb, &local_hash=
);
> +       }
> +
> +       /* Compare hashes */
> +       if (local_hash && !memcmp(local_hash, remote_hash, 16)) {
> +               /* Hashes match - safe to retry */
> +               DBG(client, "DB Hash matches, approving retry");
> +               bt_att_resend(client->att, att_id, 0, NULL, 0,
> +                             NULL, NULL, NULL);
> +               return;
> +       }
> +
> +       /* Hashes differ - need service discovery */
> +       DBG(client, "DB Hash differs, canceling retry and triggering disc=
overy");
> +
> +trigger_discovery:
> +       bt_att_cancel(client->att, att_id);
> +
> +       if (!client->in_svc_chngd)
> +               process_service_changed(client, 0x0001, 0xffff);
> +}
> +
> +static void gatt_client_db_sync_cb(const struct bt_att_pdu_error_rsp *er=
ror,
> +                                   const void *req_pdu, uint16_t req_len=
,
> +                                   unsigned int att_id, void *user_data)
> +{
> +       struct bt_gatt_client *client =3D user_data;
> +       bt_uuid_t uuid;
> +       uint16_t error_handle;
> +       bool handle_out_of_range =3D false;
> +
> +       assert(client);
> +
> +       /* Only handle DB_OUT_OF_SYNC errors */
> +       if (error->ecode !=3D BT_ATT_ERROR_DB_OUT_OF_SYNC)
> +               return;
> +
> +       error_handle =3D get_le16(&error->handle);
> +       client->pending_error_handle =3D error_handle;
> +
> +       /* If a Service Changed indication is received at this stage, the
> +        * pending request may be retried once we have verified that the
> +        * affected attribute handle is not within the range impacted by
> +        * the service change.
> +        */
> +       if (client->in_svc_chngd) {
> +               handle_out_of_range =3D
> +                       is_handle_out_of_range(error_handle, client);
> +
> +               if (handle_out_of_range)
> +                       bt_att_resend(client->att, att_id, 0, NULL, 0,
> +                                     NULL, NULL, NULL);
> +               else
> +                       bt_att_cancel(client->att, att_id);
> +               return;
> +       }
> +
> +       /* Store the att_id for later use */
> +       client->pending_retry_att_id =3D att_id;
> +
> +       /* Read remote DB Hash to compare */
> +       bt_uuid16_create(&uuid, GATT_CHARAC_DB_HASH);
> +       if (!bt_gatt_read_by_type(client->att, 0x0001, 0xffff, &uuid,
> +                                  db_hash_check_cb, client, NULL)) {
> +               DBG(client, "Failed to read DB Hash, rejecting retry");
> +               client->pending_retry_att_id =3D 0;
> +               client->pending_error_handle =3D 0;
> +               bt_att_cancel(client->att, att_id);
> +       }
> +}
> +
>  static struct bt_gatt_client *gatt_client_new(struct gatt_db *db,
>                                                         struct bt_att *at=
t,
>                                                         uint8_t features)
> @@ -2382,6 +2545,9 @@ static struct bt_gatt_client *gatt_client_new(struc=
t gatt_db *db,
>         client->db =3D gatt_db_ref(db);
>         client->features =3D features;
>
> +       /* Register DB sync callback for DB out of sync handling */
> +       bt_att_set_db_sync_cb(att, gatt_client_db_sync_cb, client, NULL);
> +
>         return client;
>
>  fail:
> diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
> index c1cbbdc91..8dee34a9e 100644
> --- a/src/shared/gatt-helpers.c
> +++ b/src/shared/gatt-helpers.c
> @@ -790,6 +790,22 @@ done:
>         discovery_op_complete(op, success, att_ecode);
>  }
>
> +uint16_t bt_gatt_req_get_start_handle(struct bt_gatt_request *req)
> +{
> +       if (!req)
> +               return 0;
> +
> +       return req->start_handle;
> +}
> +
> +uint16_t bt_gatt_req_get_end_handle(struct bt_gatt_request *req)
> +{
> +       if (!req)
> +               return 0;
> +
> +       return req->end_handle;
> +}
> +
>  static struct bt_gatt_request *discover_services(struct bt_att *att,
>                                         bt_uuid_t *uuid,
>                                         uint16_t start, uint16_t end,
> diff --git a/src/shared/gatt-helpers.h b/src/shared/gatt-helpers.h
> index 7623862e9..2bf5aad46 100644
> --- a/src/shared/gatt-helpers.h
> +++ b/src/shared/gatt-helpers.h
> @@ -101,3 +101,6 @@ bool bt_gatt_read_by_type(struct bt_att *att, uint16_=
t start, uint16_t end,
>                                         bt_gatt_request_callback_t callba=
ck,
>                                         void *user_data,
>                                         bt_gatt_destroy_func_t destroy);
> +
> +uint16_t bt_gatt_req_get_end_handle(struct bt_gatt_request *req);
> +uint16_t bt_gatt_req_get_start_handle(struct bt_gatt_request *req);
> --
> 2.34.1

Content looks, great work at commit message, but the format still need
some work:

Applying: gatt-client:Implement error handling for DB_OUT_OF_SYNC in
GATT caching
WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#79: FILE: src/shared/att.c:829:
+    if (rsp->ecode =3D=3D BT_ATT_ERROR_DB_OUT_OF_SYNC && att->db_sync_call=
back) {

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#99: FILE: src/shared/att.c:849:
+        DBG(att, "(chan %p) DB sync pending for operation %p", chan, op);

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#162: FILE: src/shared/att.c:1743:
+        if (chan->pending_db_sync && chan->pending_db_sync->op->id =3D=3D =
id) {

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#296: FILE: src/shared/gatt-client.c:2349:
+static bool is_handle_out_of_range(uint16_t handle, struct
bt_gatt_client *client)

WARNING:LONG_LINE_STRING: line length of 82 exceeds 80 columns
#343: FILE: src/shared/gatt-client.c:2396:
+            DBG(client, "Error handle not effected, approving retry");

WARNING:LONG_LINE_STRING: line length of 81 exceeds 80 columns
#397: FILE: src/shared/gatt-client.c:2450:
+    DBG(client, "DB Hash differs, canceling retry and triggering discovery=
");

I will fix it myself but please check with checkpath or made your
editor column limit be 80.

--=20
Luiz Augusto von Dentz

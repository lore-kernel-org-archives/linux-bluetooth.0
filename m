Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F6B3D4103
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775748127; cv=pass; b=fH1QxfZweIU7UQDhyqwA0qYZioy99zt12IiMKz6M7KwtYpwsTRQEYwZjJiU59gQSj2eCcwoRstbRukYmJq+QumTHr+rJm2F/SNY1FGDsUoRVz4MO7Pc9865lB+oukVTV0s6fXPylvBKHo48Fpoc5ZWu0rkLgQ89Cte0ZHJXL+Tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775748127; c=relaxed/simple;
	bh=meMgMr/h5W+MS/0Yh/1Per24DLP0Ws3LCGTS9OJSr5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pU9qiq6nVgbYteUlq3gNSpHekOGm7hVguoXL+d4ZN9kaSI/V/wa7ei/aK0W+57w2toCawDF05KCPRjiZsps7wBgAP3JTjnEhivICwyY052rAY5zCrQnUwcaWAiPc/gS5NqNv9uFzmyne9NXU6H6Ap7nwM80Bt5Yka5Tckla9zKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2PxuV1I; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2PxuV1I"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-65003f40a22so910593d50.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 08:22:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775748125; cv=none;
        d=google.com; s=arc-20240605;
        b=UNK9isfKEkkLBSAxJG28tmvg6kxSc2n5OrrKCGCRerPI1DG6jLH4ZBzZEwg/OolbhW
         d7w/lhJna4NtUlPNFuGrQk3dBB23isqaGAigDZY7s3gl+SViA6yDV20iHwhYLsdom2Re
         cBS8hjPtpK/JyE1kX0ykVy/jU7FDorpjnXOEKWQkQBsgRINzJ1Ho+oWk6KBi8oxY3Q8d
         iazK+wTej7LNkohzj+VbADlt9vxgRestq0nd+1dMZMqm4gpqO4oqdzsT7yDm5txDQgWa
         qt/VbWIPN6ZE61qWJkTjmxQbcv/rM6R2qY5g2uDSBUK1W4St3oS3wA/XXTArm+TaHSXV
         pOwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x4X5CmZAT1pVZBOn/ctm5Alifxeb/7sxa5gdbd1aUPo=;
        fh=e0N9qPapwIIGwYRViHBbS+v/mtzoIXlEmePA9Gt3K1U=;
        b=HeynVHej5DlCeIaET4EE8XekmZp9ZegO/Fa+k2sVE36tukhKY0mMMn4QzcZSLmhz8K
         MU44JYB/dASlTyrBhPyhpzW99jbe5yxZR3jTycJO1OAvYNXmWiMAFxQM/7CI5GDkPmmN
         OAoGU1vdziteGCsexj+sEOI2g9mTi4/1tl9HgXNF3tTb/IgrQAEIfzZ02wwzaj8jbnZz
         Qg7nn8xIjBGD8RZTnuqtZkXov0aptjlsaWssyVlKlWIQ5f7Mx13CzngfbwAyb0/yEJxi
         Uti225t8CAE3IBvF3OpVQfdmx7jPrzh4Y4xaKaFj4aajPhWDy7nmRomxrZFMD+WJrL1S
         RvCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775748125; x=1776352925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4X5CmZAT1pVZBOn/ctm5Alifxeb/7sxa5gdbd1aUPo=;
        b=O2PxuV1IbU3qNEACyWmEOH1M9p9bVfznNpOoN/mBF7alEmGQKGoErxdPCxprgysJkq
         X/80XAsnAOiddH1v2FGRgL89g3KkNxqqbnIoJDR745SIn1keFpVQXaw7bZzX1nPQ9Dvd
         tdzLEGVmo1U1myLUj+uOZrviftO2o80+EJ6CVFUiyEMFLeTpoNMWeBW+rDL2NQxL+dT+
         MaoQPhns3t8Y/5O2H3jwgJ9qaGTUk9zRxgVR0vKxaJdALFhGK5rW8+zmtwqCnp8n8pCY
         B5I/nCb0wICNiSTNkKqxXYe5Rs68lnwxNJ76gk6QH3MwEOsHMiFZoJ+GkIPj7SOO41Bf
         H9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775748125; x=1776352925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x4X5CmZAT1pVZBOn/ctm5Alifxeb/7sxa5gdbd1aUPo=;
        b=DYoQC824Mh4Jwp3LysEg7113bmsA+uYcHHF1oCYl6GYsfjQQEhNNSkFTadtCHeNwZ+
         e6z4GSNwjtN10j0p4k0k8Qhqj5vFh4fNu2BxaVGSZSBTEusD9TKFdyfsrRE7tO8DP/eY
         UWlrsjFkbDk2US9TflyjZpmHRpjIMPszIfyTFGN88ncZjQEuDQpGtmgtbfgRdfFa3Ag5
         Sc56Ok8Tu3i32ZfqWVYAT/N8ZwqumdfY9znmlhOKVTNA2SWFeU71bt5bN6hvUht2tuXH
         qXZAv6FKT+CoLsBhZ42M/BuT053Il98cZkcXsPoS3uHOPTyX2Hrvfj24Y5IDo6rKXaR1
         VAzA==
X-Forwarded-Encrypted: i=1; AJvYcCV+RNNrFEYfQ8H1MpGk0KVAQNDpHoOdSP9kVQwSe76F8cnib+TcLteRYlSQJJcVz0DWNAf5cHRCLhgBDXW7VgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/paCLQW7IbFOOZBHYiLgVUIkT2O5zIY6YUIYO8nxbDkhz+OTA
	vRCfJXB6ndeujunrxUjFk3iAf6tBxhUiElEnamLdD+O3Pi1pFmp3ylBxrydMecg9vKhDcCUzCH8
	ChQLzgcxJboICbEVr3eqNtT9wCaDvPL8=
X-Gm-Gg: AeBDieunnb1tCeMGb/SoJpRVNmR0FQMyrSddCgmrbUXVCiAxBg3qRagpJIk5GdMzwVR
	S6j9XpQ4J4knBJ1jHVsPJo1iqOJ8Jzpx05RXAL60SxXsx3GaDAs3kX+H2jEUfk+vx+XAPvdg9Wv
	IRHMUkxWqUovqpNWj++3qxVdAzz2jO7yKwzWIVAmxPEvA+jXXu/0J45M8QTIyM56qKR+NYxCjET
	1gLfEe7IrM+BSc1ZHgiK/pWsSblF9ReOOUpJi14yqNWKxI2UqzYiSstvrN6IU8czyQ7LThDOevA
	3EK5+zISU3dgKMOuu+h8PsouxkuxEubC+seiwH+uucdB6TjZpPLMxupKFvzhPJak8aw=
X-Received: by 2002:a05:690e:438b:b0:650:3396:52d0 with SMTP id
 956f58d0204a3-65187573d7emr2456882d50.13.1775748124653; Thu, 09 Apr 2026
 08:22:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409112233.3326467-1-shuai.zhang@oss.qualcomm.com>
In-Reply-To: <20260409112233.3326467-1-shuai.zhang@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 9 Apr 2026 11:21:53 -0400
X-Gm-Features: AQROBzCmtoBFJywFV2obk7F71rv-m4o5gJ80-OufF2THW4vlYHJC1HnPRJKppvY
Message-ID: <CABBYNZL25=Q6cR5HKf202D61oe6pYL-2NR3vb32ja+5W6xQcXA@mail.gmail.com>
Subject: Re: [PATCH v5] Bluetooth: qca: Fix delayed hw_error handling due to
 missing wakeup during SSR
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com, 
	wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com, 
	mengshi.wu@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuai,

On Thu, Apr 9, 2026 at 7:22=E2=80=AFAM Shuai Zhang <shuai.zhang@oss.qualcom=
m.com> wrote:
>
> When Bluetooth controller encounters a coredump, it triggers
> the Subsystem Restart (SSR) mechanism. The controller first
> reports the coredump data, and once the data upload is complete,
> it sends a hw_error event. The host relies on this event to
> proceed with subsequent recovery actions.
>
> If the host has not finished processing the coredump data
> when the hw_error event is received,
> it sets a timer to wait until either the data processing is complete
> or the timeout expires before handling the event.
>
> The current implementation lacks a wakeup trigger. As a result,
> even if the coredump data has already been processed, the host
> continues to wait until the timer expires, causing unnecessary
> delays in handling the hw_error event.
>
> To fix this issue, adds a `wake_up_bit()` call after the host finishes
> processing the coredump data. This ensures that the waiting thread is
> promptly notified and can proceed to handle the hw_error event without
> waiting for the timeout.
>
> Test case:
> - Trigger controller coredump using the command: `hcitool cmd 0x3f 0c 26`=
.
> - Use `btmon` to capture HCI logs.
> - Observe the time interval between receiving the hw_error event
> and the execution of the power-off sequence in the HCI log.
>
> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> ---
> Changes v5:
> - Replace clear_and_wake_up_bit with wake_up_bit
> - Link to v4
>   https://lore.kernel.org/all/20260327083258.1398450-1-shuai.zhang@oss.qu=
alcomm.com/
>
> Changes v4:
> - add Acked-by signoff
> - Link to v3
>   https://lore.kernel.org/all/20251107033924.3707495-1-quic_shuaz@quicinc=
.com/
>
> Changes v3:
> - add Fixes tag
> - Link to v2
>   https://lore.kernel.org/all/20251106140103.1406081-1-quic_shuaz@quicinc=
.com/
>
> Changes v2:
> - Split timeout conversion into a separate patch.
> - Clarified commit messages and added test case description.
> - Link to v1
>   https://lore.kernel.org/all/20251104112601.2670019-1-quic_shuaz@quicinc=
.com/
> ---
>  drivers/bluetooth/hci_qca.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index c17a462ae..9fffe665b 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1108,7 +1108,7 @@ static void qca_controller_memdump(struct work_stru=
ct *work)
>                                 qca->qca_memdump =3D NULL;
>                                 qca->memdump_state =3D QCA_MEMDUMP_COLLEC=
TED;
>                                 cancel_delayed_work(&qca->ctrl_memdump_ti=
meout);
> -                               clear_bit(QCA_MEMDUMP_COLLECTION, &qca->f=
lags);
> +                               wake_up_bit(&qca->flags, QCA_MEMDUMP_COLL=
ECTION);
>                                 clear_bit(QCA_IBS_DISABLED, &qca->flags);
>                                 mutex_unlock(&qca->hci_memdump_lock);
>                                 return;
> @@ -1186,7 +1186,7 @@ static void qca_controller_memdump(struct work_stru=
ct *work)
>                         kfree(qca->qca_memdump);
>                         qca->qca_memdump =3D NULL;
>                         qca->memdump_state =3D QCA_MEMDUMP_COLLECTED;
> -                       clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
> +                       wake_up_bit(&qca->flags, QCA_MEMDUMP_COLLECTION);
>                 }
>
>                 mutex_unlock(&qca->hci_memdump_lock);
> --
> 2.34.1

https://sashiko.dev/#/patchset/20260409112233.3326467-1-shuai.zhang%40oss.q=
ualcomm.com

Lots of comments which Im not sure are really valid, but one is
considered critical so we do have to pay attention if that is valid
then it should be addressed.

--=20
Luiz Augusto von Dentz

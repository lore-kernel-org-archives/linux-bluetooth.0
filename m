Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CFC17DFE7
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 01:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779066040; cv=none; b=pv0la+r+igLREJ/K9h38AGWeq68/868KEKC/52FEjPSWq8M4zyEMEELJHsMa7SoDZmvki9MYuwTG3P4+NDdO8Y2pwO7BAZtkWxJNzQdayvRh9YzoM3IDEMkaeKbMVCLfEpKRNety8SXHu/MUXGFHoIS6fxn5KppWceWE6Leh24I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779066040; c=relaxed/simple;
	bh=/PAGb0AvVuxMQZ9EWPg+15IzbZMM5u5h1WSSMcsAJIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G7VLowqthWsQLg1RzSLhqHIFdhDaY+/U5UaoCSebjlZrE02TM3hjbu8r5e1hZq+zV1ReHd1s5ljB90DPxF0DiT40Ohj+VDGDuliw8pVlCUcqDPTskvpXh0kZ9YB/fp1t2tZAHp2OTf4jBInM2VCVYvJlI9u1Dk9G/5YXag9jsc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7MqMxRy; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7MqMxRy"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-44ce78ab5feso1400316f8f.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 18:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779066038; x=1779670838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpKkJC2kMiT9OA/pGYmBdZ/qheRDKlodtbgW4gbsoLY=;
        b=T7MqMxRyN3mtIW6mrZt+ka+DGksd+qTs78VrJd/WZoOKJZEFsXPhRTkXyYazSdPUc7
         e66y9zgd+0HMEbSe1+buknqmv7MPpnbUrvvgNwSum4x15NgQ+8iP8gwBPePMmhz81zup
         J+zqXBeN49EF/gl/3/qVAuTzlES3RVRJNUmec03ovo6l3LiJvUhDh4Lximc8+KfMU8Or
         GFHRFY+ZFrZdHLDvTSZilPXaryCh+nF1vQemIpyAKEzDHcwb/HRCob8b2CwapWuGkBLI
         1GLrudUzoMZzimwt94qIUsziws7bKEeD6EjsD5q5Cru7mLreJFb2iEOg8I8D1inxkyRi
         +/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779066038; x=1779670838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TpKkJC2kMiT9OA/pGYmBdZ/qheRDKlodtbgW4gbsoLY=;
        b=iXprzDoLuITYHkBA1U1WqgbFYrC7anRwzsF4SpeB5I1U4l1VKwPlj549DQzahN1wWZ
         +9O0XHMvxpM3azw3sNUALTTgUqUL21GdGLQcUYen9fwM2HxqiImrE0zrvgxbtq9wPXdf
         unLVfVpSUPWv1qUObrrqGkqdsB1647/zhmQNyM779naCx92fVIrZZ4Bym4WFKFsUwAHt
         k8SKMmXSxlxvY8Ed7UwfsZGM2OuqNWehpKacxnFC63sj4jE1gpn4BXGnhTlPhGVAvlPl
         kQJhHkuNfd8nGLsf5aX4aAasENPbNyG2eDtSUAy8GE+8iAszpgTagt8Bf01OhmwDifmI
         QHiA==
X-Gm-Message-State: AOJu0YwljnK0rM56U/j3l1zyQ0oD0bWdPrCxkR6JWt2DguDmDW1kyawu
	6HZ6nPJGwSKbpdKPbIhv7PCYCyBI6fG4qPC91siUzIj4N2E/yioHahuP
X-Gm-Gg: Acq92OHYDOLwN56mjihqCCZ3/GjzT4vviHQ7ICzB3+UndaFqKfcb01+Ex4M67LhE9M8
	ahMJ7EZvok3juKubIUsDbv8JqRCALKDfQGsUxFyrCyue3T20aHRMJj9Vc49gcT7KjWRR5XE3QXc
	/UWV/Bpnaa/GqbFkYLNT/WHlVlfg9FOITUEe9w5DCqFTKFRl3xnukRbWb4UAmtcobN7u1g5Ww82
	D2As/ONdu44ZDwmk58Gt4E1skWrF+OjyGj/O/ibQLAMMhPJOzG+QTxKNeeqVyGIKOC4qC2sCh2n
	eqxFFg2R82PHcQUAqcrsQ2dR25A1lqVLfjWs0sPY/4WVj2WbMOH7xhO20eJbt0Y36bQNY1z98WH
	sZui9c5xdekd3ointn/OKJXuiMENtRQElkN7CJUUrS3+YmO3gAWarrGC2JwDT1StHVbbVEtveKh
	rmYSJdlXHhkEfbp8SfjATRU0+5Cw9kqPbjSgZqvV8FGDRdbsxzdaK8BIhrHAZ0lYMct340K4Uo/
	A==
X-Received: by 2002:a5d:5f47:0:b0:452:d03a:7abf with SMTP id ffacd0b85a97d-45e5c36bd31mr19056736f8f.15.1779066037595;
        Sun, 17 May 2026 18:00:37 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9adc2209sm30687972f8f.0.2026.05.17.18.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 18:00:37 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: michael.bommarito@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	johan.hedberg@gmail.com
Subject: Re: [PATCH] Bluetooth: L2CAP: rate-limit ECHO_RSP per signaling PDU
Date: Sun, 17 May 2026 21:00:19 -0400
Message-ID: <20260518010019.121323-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518002800.1361430-1-michael.bommarito@gmail.com>
References: <20260518002800.1361430-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Michael,

Thanks for the patch. The ECHO_REQ cap addresses one amplification
vector, but the same N:1 amplification appears reachable via the
unknown-command path in the same loop.

When l2cap_bredr_sig_cmd() returns an error for an unrecognised command
code, the loop calls l2cap_sig_send_rej() unconditionally:

        err = l2cap_bredr_sig_cmd(conn, cmd, len, skb->data);
        if (err) {
                BT_ERR("Wrong link type (%d)", err);
                l2cap_sig_send_rej(conn, cmd->ident);
        }

A peer that packs N commands with an unknown code (e.g. 0xFF, len = 0)
into a single signaling PDU would trigger N calls to
l2cap_sig_send_rej(), sending N COMMAND_REJ responses,
bypassing the new L2CAP_SIG_ECHO_BURST limit entirely. This produces
the same TX queue saturation the patch intends to prevent, and also
floods the kernel log with N BT_ERR() writes per PDU.

A response counter covering all outbound responses generated per PDU
would close both paths. Something like:

        int resp_count = 0;

        /* in the error path: */
        if (err) {
                if (++resp_count <= L2CAP_SIG_ECHO_BURST) {
                        BT_ERR("Wrong link type (%d)", err);
                        l2cap_sig_send_rej(conn, cmd->ident);
                }
                continue;
        }

        /* existing echo path: */
        if (cmd->code == L2CAP_ECHO_REQ &&
            ++resp_count > L2CAP_SIG_ECHO_BURST) {
                skb_pull(skb, len);
                continue;
        }

Using pr_warn_ratelimited() instead of BT_ERR() in the loop would
also reduce log amplification independent of the skb path.

Regards,
Muhammad Bilal

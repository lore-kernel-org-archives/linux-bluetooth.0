Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946850;
	b=NROerLW9uLeKml3iK9zi4sLwkP2/8RgABLGShuov5uRvSdjSCpBLkK+T6uV1S+6l2/tO
	 wjTFVvtkInkbR++0qpSXhnEsM4PHwyEaeFs0g5PVIf2ILeYWkCCbsyGMM+MdRhdJ8ibNI
	 +3mWenJLnm9fBSrJLo0+RADpkdgToAkNqzNSb2Q7fcBpU2/RMDB56n0oQ+oeOceJ7sgtf
	 10FdCVpmFrl87kEgR7oiB/yQVUhkm9Be49K6TW7oIGwXT8h1NN75H3bplifsIM24m58xK
	 AvmhNVvUOz0hcvTl1QuJJms0s7MAPq53cOMz3An//GFMTQYEnRrz1jwZnWMfJATG2Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ew4xUlYq9XHQQKaWXmQ916hAyHyvdSG/FigB791NcQk=;
	b=3vvk4C5KaZRKZM6UHQq2KDgl1w9wj4vIW27nSXC927fFTXB3YJ2L2M2WkNZVaqb6iTV8
	 ghpV6AxQU1y6gEXm7ZtCRjvvRUfVaRksGb4osQyqlOjjRmiqRy8HSYXBm74XEng/1k5Fk
	 ImEfrKfcTZ1gnTOe334zH47Ow/3PSBEQAndDv8McuQN1PDW/QEATjVjYw14FVXN3hyt2m
	 2tMeRdjoAs2ylOB+0JqeQIsXdvG0VLCsys+dZmwmJaFpuKV4btR8hUm5cQykZ3R5HdHub
	 c/mt5QbPA8OlFZFxeDJCYWBeKmacPrQaAYlcbqV0wiB+0FR2B2ewq9HeF3n1kmDgsVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pEoe+GdK;
	arc=none smtp.remote-ip=209.85.222.49
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B907E606A882
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 20:20:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B907E606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pEoe+GdK
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-9906a5410f5so1075811241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 12:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794946849; x=1795551649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ew4xUlYq9XHQQKaWXmQ916hAyHyvdSG/FigB791NcQk=;
        b=pEoe+GdKOo8ucIGsbPEBs6QPiuzzqY2dAwTH0ooxRiH79E3O3UN89sJmeTxIMNO36O
         sbmk7aDQbuwheWNQYfsz7JzpBNCvTaXHRINOeRKTl5Osi0x2I54np9sW+AJobBfqrEn6
         Xtpnbk8w1pjUe/MuD13CRTYUbHZElGnDJFdrG/ImDN3w0Z/pl8CByQKTSWy8qKzKMtzw
         PufGaPDeIvY3Z/klHzrQgLr3P9LFPxSnfOSs8hI/jsRugmtz02Tvlb33w/+eCV+TMgu7
         8nK6vPqQZh2HysB6EYE06PDMwmpvnj7QBUHL2z3NMPd2+zSzRLkPZ9ohsINYCi4/HWKH
         W2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794946849; x=1795551649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ew4xUlYq9XHQQKaWXmQ916hAyHyvdSG/FigB791NcQk=;
        b=0+NEiPqOq6aJ8UZg/OBpz0PE3I38pDgbZCilSso0oiFtvJYjRMNLA3Zty7IJa9S8j5
         UotPGFJ/EMsgb0TmHnZ2y+US8EWcySeB69zYn5GASGEXwwBF5QOvO0LyqzKp1u9/WcC0
         cdjpWAQdTDJ1ciNBIT2DmI+bS/Wc5h0vM7SgxvUMlR437M8DMd9Mqp16IfsQNiCWMaCY
         a3VNnTWa5murjjdZf+bv/VAqk6qaSLsTYMgOby0mLnvJzVzyhjHAda++DzLaimKqGArq
         HUrsokgGiveioebK38SLETQBqNO8dCGMaqxtGC2rOl0mjDDDdog4EWHl5PWTlQssqCpS
         BmUQ==
X-Gm-Message-State: APuU4Z/rs5RkOwwSdXAS0I1WOsCVAJYGX34yTLU8zNrzQeYR6mjzcNlD
	R2W8sX2YdHdOC4tN8skM+UxI1YKAQkd9mnQ5WGOiccicY2CtYaPt5IA3fxvZWg==
X-Gm-Gg: AYBFou2CQFBkEalaiYIZkX7Ez+s2BTnbxijWC4VEU/+AOS5xKUU8HztqEBhKfCkahdQ
	dA6X20deVYeXHETXcZFcGdbLoJiENuGJcztW7wpapEB2cikWrH4mPzeviqdH6hAjykGwXU9YK3j
	BqNlz2o6q8UJTWY0NssxyKyPLH2TnGkNSDZ7PuWYEBpGABg/tpUkehiBPqRv/T9XB0Tni39ZNR7
	0mSQX7GpQFzuyzT0NSFfpUMf+21N+Eq74Gq56wima3TgtPczTWnrpd2Uh8khDWAkhrvlUMo1kY1
	Q5GBrQ3R4dbHdUSOLkdbUTb+sJ1xOPIlQeVJW6pkLUId+J4/LOjfMa6Js//4J9EzvHtRK9bnrLN
	nQvXZBQuUiE4mVi3EtQ+v273mQpMPH9+RdjQCH7urLs6jizw25UoJ2KT+eiYn3dlHTV/dunXZMC
	M/U1HeBAGo3is3LlzUKL1/UX8o6p1YxZEaou+siaK2UOSC7TZG4+kQS2P3AVKf5uws0mT4AjDyg
	vaOF2N8V/O5E0DrqdcUWhvd59sb+dHQgXnHPLkqXI0TzJ5+cWRZwj3FN/6vV756XUD6mEx7CvJE
	vwtzWTv6lNhM1QL0stKYjLsSrJ7LWYOSdLqd1keuesyeQSf/WLK/xp2BO8v9vObADzqOQGo3Vtf
	B/KCFnK2pbbKX5FMJyVMDVuKdkDAsWzpQDuDKO0y21U3Vu/a1hIRcNVDqnxYxhMYR9UJ8XbZUU5
	bciHY=
X-Received: by 2002:a05:6102:2907:b0:7ce:a840:e736 with SMTP id ada2fe7eead31-7d6ba4a2102mr27659137.13.1794946848557;
        Tue, 17 Nov 2026 12:20:48 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b935ddf3sm303166137.11.2026.11.17.12.20.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:20:48 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 17/17] Bluetooth: hci_core: Don't fail removing a monitor unknown to the controller
Date: Tue, 17 Nov 2026 15:20:32 -0500
Message-ID: <20261117202032.3848411-18-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117202032.3848411-1-luiz.dentz@gmail.com>
References: <20261117202032.3848411-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

hci_remove_adv_monitor() frees the monitor when the controller has no
matching handle for it but still returned -ENOENT, so callers took it for
a failure of a monitor that is gone, and hci_remove_all_adv_monitor()
stopped at the first one leaving the others behind. Return success since
the monitor was removed.

Found by the sashiko.dev review of the previous patch in this series.
Fixes: 66bd095ab5d4 ("Bluetooth: advmon offload MSFT remove monitor")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5522d4397682..024960e9af66 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2134,7 +2134,10 @@ static int hci_remove_adv_monitor(struct hci_dev *hdev,
 	hci_free_adv_monitor(hdev, monitor);
 	hci_dev_unlock(hdev);
 
-	return status;
+	/* The monitor is gone, not having been known by the controller is not
+	 * an error for the caller.
+	 */
+	return status == -ENOENT ? 0 : status;
 }
 
 /* This function requires the caller holds hci_req_sync_lock */
-- 
2.56.0


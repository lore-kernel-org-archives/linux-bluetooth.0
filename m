Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E1C55D872
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791994847; cv=none; b=HExTCPOXx7MaiYKPHgI1hVC27ZDtDAOoOSJih9+21E/GvoPub+VP3kzDItzXAAsHdnRCjxXjtRs2eJMpgDPUC4H+xyolblAFVmIrwzat3oPqGNHrmZRgDAxCjKntiEAgD36uiOMLZ3x4uF1SJu28tR0DoCrwpPR30RA2ubNKNhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791994847; c=relaxed/simple;
	bh=KOpW9NL741Wqf6CDHthraNjLF873jIDlBdmDkXr6AkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QdmPNVU+AFuqDk7etuvRyu+Gm8zAdbqM+T04wrSncytaLzdbGHLj+j4gxvlWWDBdNsSGOkRYEQBXiib91SxnMdOCIpJB246BOfkOP1C7irgeetTPCLcVLhXEN17KxOpciZ95940+57qJ1KNCLJuXCilcEhA9vkdCcao1fQw//p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRDDZ5dL; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRDDZ5dL"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48c411d6615so3177082f8f.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 09:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791994844; x=1792599644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EjI1AUhEkeYaz5+gj/BBEQM/J50SQrXWS0m/4fb/0T0=;
        b=KRDDZ5dLvmQxVaWSv1xKVRejl6KzvnurMd7QKx5jrQMfTm1sHb+NW2H/JooVv7dMCk
         Pb2c9vwVkMr/qnYP9JaLq5XF1Tb27ltBNF20hbCk3qYvitN4ylM70f1TEqd0EWag1V9M
         FGUfSWa+kkvneTXncAGQfqaSVHhFDsrMQz3yeYC2ZTdMUfCi96lYMgjB0iXYA89xuwq3
         Gr3jh14dnflPLRoqu6oIRlPH+tHu/VWGTCgm+pKmAbYXMlo7KxMxwDuxu126gu9qnU4l
         +5uO41RXaYbb7UQrHaaNvyKPXvAZG8hTPxVPvz/tvP+7TqHdmywvyph0dfVTqbSjt6uy
         cMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791994844; x=1792599644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EjI1AUhEkeYaz5+gj/BBEQM/J50SQrXWS0m/4fb/0T0=;
        b=OBiajfPs6TwKIW2iRHn8g+dwtDrIBzAJxQ9Wi8/hrIj0kBMMNU+3HzUbqqPbQCpH35
         9Qc9VTOPCGYDHOHH25WFND8st+DGc6j3V2t/zT/Fu1RefoB8qonpyg3M09+bZ4FKsGd7
         W4Z2jEZfzIZPTWBRpjzWU5ZjzC+dW20CeZ4GdSPPvNQLrH3vrfjgz6r6Hlc+JvGnHdaw
         +KRddfXDzQoYpnP5e4yr/y4nNol10JBkbBsplUhGg6b3DxzM4T/TEM53n6Rrn8hav66w
         hbtAdK/l/SjL5cTnJQbMCD2G1jpUWPFqjDLRfU5UjeuRySDaqB0WRIYhhH2lbC4wdSAi
         55BQ==
X-Forwarded-Encrypted: i=1; AKwUvBz4O+9P2IGlVqcYx/DWWRoYrcsba5/rzjZwmw5iXq9VPMBmbSY4quQ2Uusi3hDoBOcf7KN2dR0/dQYOAOWPp/M=@vger.kernel.org
X-Gm-Message-State: AFq9FYIQXXStT7xoggu4tBk4sTixSCsfpeOyrlACKUfQU3peQaUT8Ue2
	7rycY8TTBY3WbfqoA6wMJO1++wCpyHepArXbzohfTZa7k5S02QHmKBsX
X-Gm-Gg: AYBFou1kaMad0SP6M6+tKAjgBvvCPY7UG2cK/g/9qGLs29qFg2Mngd6q3D9RWNYhHa0
	VlnfJniYBHUS+nB5V+JRP96BKYgoal23saqRTl6MM+5YKiaT3dxc+dIBug4D4wiwf2w+LxN0h8u
	m3eLTKb35/QmXq94XDL15HFvSLkIi9PSBRrSQe3TjeUvBoF7jlKhXfCJ94ddiUu+t6/D639LQV6
	zyO6ELppEz0eGprMlDfJy3D/12yOtrzIwaF08r6fEpyGpzPE5Wb2CVovQhLI0h6VeEitJCHv4dM
	oP5unWtlTlOaDDZALPhoQUfcscLqEPEY7ddVrF2+j250GKX/jw4Q0gzYCTF9Jc+nU1VundxMph0
	8mztfsBdL/QoEu6EcADDZsEmz47Io9JL5/Q3WsK+DHPxD9vtPqrEgpGcRmi7DzRN+cFCPmydsPF
	RSNDtXBFTgj0+vyk1aDLlM+iBEue63x3yFxch5WD9nGy2i9Rz3n/2epoUEOKuEigtp2OZEKMrYa
	5qpdHBwKocTpkzmQKh6bElQ9YyE6SZYofIc
X-Received: by 2002:adf:ed50:0:b0:48c:7caa:12cd with SMTP id ffacd0b85a97d-48dbaae379dmr21487148f8f.22.1791994843601;
        Wed, 14 Oct 2026 09:20:43 -0700 (PDT)
Received: from localhost.localdomain ([188.190.249.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de7273a0esm8545727f8f.29.2026.10.14.09.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 09:20:37 -0700 (PDT)
From: Vladyslav Tymoshchuk <tvlad744@gmail.com>
To: Birk Skyum <birk.skyum@pm.me>
Cc: Vladyslav Tymoshchuk <tvlad744@gmail.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_qca: Reset the in-band sleep state on power off
Date: Wed, 14 Oct 2026 19:20:24 +0300
Message-ID: <20261014162025.3733-1-tvlad744@gmail.com>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <179163212446.46972.2306254853726299632@pm.me>
References: <179163212446.46972.2306254853726299632@pm.me>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Birk,

On Sat, 10 Oct 2026 11:35:26 +0000, Birk Skyum wrote:
> qca_power_off() cuts the power of the controller but leaves the host
> side of the in-band sleep (IBS) protocol as it was. tx_ibs_state and
> rx_ibs_state are initialised in qca_open() only, so a controller that
> qca_setup() powers on again meets whatever state the last session ended
> in.

I ran into the same bug from another side, on a OnePlus Pad 3 (SM8750,
WCN7880 on UART at 8 Mbaud with IBS), and came to the same fix in the
same place, so here is a second trigger and some test numbers.

The second trigger is HCI_IBS_TX_AWAKE rather than WAKING:
qca_hci_shutdown() deletes the IBS timers and then sends the
pre-shutdown command, which goes through qca_enqueue() and arms
tx_idle_timer again for 2 s. If the device is opened again within those
2 s, the host still believes the controller is awake and sends the
frames after the new setup without an HCI_IBS_WAKE_IND, while the
freshly booted controller starts asleep. The commands right after the
setup get through, the first one after the controller has gone to sleep
breaks the link:

  Bluetooth: hci0: Frame reassembly failed (-84)
  Bluetooth: hci0: Opcode 0x0c56 failed: -110
  Bluetooth: hci0: crash the soc to collect controller dump

It shows up with "btmgmt power off" followed by "power on" within 2 s,
and on every boot of a board without local-bd-address when user space
sets the address with MGMT Set Public Address right after registration
(the unconfigured controller is powered down after its setup and up
again well within the 2 s). The stale idle timer can also queue an
HCI_IBS_SLEEP_IND in the middle of the next setup, which is what
df1e5c51492f was about.

> +	/* A controller that loses power is asleep when it comes back. */
> +	timer_delete(&qca->wake_retrans_timer);
> +	timer_delete(&qca->tx_idle_timer);
> +	qca->tx_ibs_state = HCI_IBS_TX_ASLEEP;
> +	qca->rx_ibs_state = HCI_IBS_RX_ASLEEP;
>  	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);

I agree with what the Sashiko review pointed out [1]: without _sync a
timer callback that is already waiting for hci_ibs_lock still runs
after the unlock, and ws_awake_device/ws_awake_rx can queue a wake
indication after the reset. As both timer callbacks take hci_ibs_lock,
the _sync variants have to be called outside of it. This is what I
have been testing (on bluetooth-next):

	/* From this point we go into power off state. But serial port may
	 * still be open, stop queueing the IBS data.
	 */
	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
	set_bit(QCA_IBS_DISABLED, &qca->flags);
	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);

	/* The controller loses the IBS state with its power and comes back
	 * with both sides asleep, as qca_open() assumes. Stop the IBS work and
	 * timers, drop what they queued and start over from there.
	 */
	cancel_work_sync(&qca->ws_awake_device);
	cancel_work_sync(&qca->ws_awake_rx);
	timer_delete_sync(&qca->wake_retrans_timer);
	timer_delete_sync(&qca->tx_idle_timer);

	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
	qca_flush(hu);
	qca->tx_ibs_state = HCI_IBS_TX_ASLEEP;
	qca->rx_ibs_state = HCI_IBS_RX_ASLEEP;
	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);

All callers of qca_power_off() can sleep, and the work items do not
call it, so there is no wait cycle. The flush moves after the waits,
so it also drops what the work and the timers queued in the meantime.

Sashiko also suggested Fixes: and Cc: stable, with df1e5c51492f. I
would point Fixes: further back:

Fixes: 3e4be65eb82c ("Bluetooth: hci_qca: Add poweroff support during hci down for wcn3990")
Cc: stable@vger.kernel.org

3e4be65eb82c is where the IBS state started to outlive the power of the
controller; the AWAKE case exists since then, and df1e5c51492f made the
WAKING case permanent. Mentioning the AWAKE trigger in the commit
message would help too.

Test numbers, five quick power cycles each (power on within 2 s of the
power off, then a scan): 4 of 5 fail without the change, with commands
timing out ("Opcode 0x2042 failed: -110"), and 0 of 5 with the code
above. With it, user space also sets the address at boot without having
to wait for the 2 s first, and it is now in the kernel I use on this
tablet every day. I have not tried your v1 as posted; I expect it to
cover my case as well most of the time, but I have only tested the form
above.

Would you fold this into a v2? I am happy to test it on this board and
give my Tested-by there. If you would rather not, I can send it as a
separate patch with your Reported-by, whichever you and the
maintainers prefer.

Thanks,
Vladyslav

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179163212446.46972.2306254853726299632%40pm.me

(I used an AI assistant, Claude, for the analysis and to draft this
mail; the tests ran on my device.)

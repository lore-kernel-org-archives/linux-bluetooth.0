Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=106.10.242.141
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795637100;
	b=MtgMJJ/v0tq4omhci4IUsNMRCNecLJwcwUzkGGpOAZDOZ+5AbrTjjuqBoJs8f7Q85//3
	 3poPep6HDb1+psrJDmB7Ojt0bxX5V1/pfYyj92ZjTKIDOBSHFtmlr6+8unBfxuNLUB/pm
	 kGGkAQzNdz+2MrZVkdXszHZTUt+deHhXD1BXFOcQ+I7bqowFpfH+mU1gfK/QSGo9o6FT5
	 dqR29xYjah2pIs9MBpL18n5AXmrldCybnMU2m74EdpBHdW8xV7Ar4LgupgYk2A+mjEUXy
	 04RuQbHl5BKZ9Ro2QYxRU4l/LZppT1u/3nQzutUFy4vq+w4QdsR3W3XwtdD6fHlpofA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795637100;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:References;
	bh=n9WudRKG92TIZtxgec08BaYCU8vqDKv9uhBMsODxaac=;
	b=Mg+3CfegLNn177XcE9yo/hdeQGoQ3FSG8NtoUY5AEA7Vfn+M8wCxhdwyACDAatcWJ9SS
	 Wi8Uw1ngSqNP79awpJRSEBQGzfNj5QC+8JtaZkcOc5W2ByDuU8VpvoF0JIyBeHWl4ur80
	 Ktei10a1g44OWGvCeT3p/1Mhzisf6srMbc2ZQs8e+hQZYi2htGzF0dN+QnjhW9VWtmQfP
	 1Uk0P5mv4Nw+7MGKiu34kKuY0AkqKOgdI13iBNlCH9xE8xMLPe7guFaB0OAz0om3ScIYx
	 IEuZEvrVi+IxfwHHrqbkFBMvs1LZdm5zJtxxYoa25z/CUWyv+p24mVFXgafDaEancfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=fy33EZoY;
	arc=none smtp.remote-ip=106.10.242.141
Received: from sonic302-21.consmr.mail.sg3.yahoo.com (sonic302-21.consmr.mail.sg3.yahoo.com [106.10.242.141])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC9D606A323
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 20:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BC9D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=fy33EZoY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1795637097; bh=n9WudRKG92TIZtxgec08BaYCU8vqDKv9uhBMsODxaac=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To:Content-Type; b=fy33EZoYFMOnFigckbReckBa3eJT/rpvujFgq8tsOROVMLkirzttxcBM7w/GOOtxDz+Psgn3qmVWJLDj4zs8K4phvoTAeYwrH/5BO+4+0GQHyBvnA0bMU62zbfDYbhtVWQ4aua5USxQTp8KuczYyRgv1CqX9W+QIiUS4A8HZRGeWWKc9jTpdfCsFCsWu03clDhcndR9+Joqsth/OL2O98H+r4Mhb+27oZCb+B3SOjfzAtkh4HSL4zkXKzIfpNS3TDNVNp2qP6gQieaVDazHxzouU63qdnNGTNnjJEX8Y96S8hvGeXI73Xn6TFISttsCrV6HPzTY+ljX6wRF4CjuzIg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1795637097; bh=SPJnfhqxU9p0p5Kakd/3BhfQ19bxdHsW5hH3hPvKvOT=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=UCgrcZ4MXa4o55a91h1bATwI0tp58z9xFyVRpFo2ydX6MvcOXluBomHh7eXk5xCRCcwiFnPI+lQxP+6uyvGXi486NMCf3W+fEmqvHsT0upgWnRsWXcHUOBplDFLonxMqoTzsx9KMhMyw4G07snWkXOJbYf/J4X82MUKJM3zHOixONhUFBpD2idUUq7bsPetH7XDHjlif3grqpO9+uUC88Hz5PI8IDP7iE7w7c+P2KW6PxWW/6W4o10Sn287EyFpkkV7jtb0kxJKf+re13MDLTjIiO4gykve+TGxqTmF+VLcP0l30E8GlPa6RYwTAQdpwsTVNEXrY2QEipLg/mmS5hw==
X-YMail-OSG: 8trdvQoVM1maTQp6rmMH5P.JG7NqQlOQ2rMBhQ7r6XH11SvqFWLa73I4Xp8v_gb
 PVGSyia8TnYaJ27hmSP1b54PTh3fCymYD_orfrApN1Urp3wCojES656.CtfI8wCDXyO8a4i5uwiN
 x_e.aDU3d_u_BDvdQmYsKwg7U.Z.Lw9qUCqa1jGA8aZ5_r5dqTxerBINn6a0AigB6uEToIIfkYzH
 b29K42rTSRrQIjzaytARFT4p6SVlHKqzuOAt4f4wk7NOABYFdqs6h9rIrl8REuq2LLSu8vHuWpuP
 eHKYGCRzrW8EcsHW.gc2cEjrfJAA84Ojm2ZLzWcNJCIZaQ.Qg4xlZbomhlQK7VrW3zHGOz8sOKBs
 ltDj9TfRJ2UPvSDysQlqHDdfRI71z0Ftfan3XEqhn6bRGjAffA_5nbQFopFOVYMsry80yLCTYrf4
 4jTBOFB.GoxK.ap8sb3j1WplHhtJxIqA3ez3NTI7i6_BYUoV7yQzZ9V1lckJYAypCEBa_gCBN5HW
 .ccemsgoyZ0C.LCCY85o3qdyd9ejYhuV0DWOgzWSKnRNMcpoUS3EbCWPwZyUGHVGrwjALgw41MAp
 ksRNshAEO9MXu3rpbfTppxVD2LNxxQSanF1B7rBawE10KYjLYOMj9LOvfJCWy1nWzCO_mTc5m9.o
 UbWSyCjajAaIG5.y.XUan7j0aJL9VDuXT.j1fbGe1QDaN0Gx6H1xs0oAvb9cEs.cd1qeaioRDh.K
 O.1wOXu2z8s3oyc31633Nx72XqN6aicnritLKB4eLOgMtcQvEQkMt7a_EJGfe6UHfuhPyhMCHVjQ
 eS.6CUn1HOtayK9Wni6b2S8cRhTfHROivw70qe2vuOIGLuQ.tf4X1dDB8w7OLNc_T5Sdsw5snkQ.
 OPR.I9xQ4lfTc2EFhItwtLOTXVBYCn.Iy_T3jd7t5ZOL1TI7Ipbfwo9kX.vLmvNZRTdWRf3EMQ_a
 drnvkqkJE4oct2vgrihNn7Q3EDNpmmQwXWlIjNVivayk.SOzZ7sD1ny3ZJQ.cgCb99t_KDpe.Yxe
 nZJswAFzlFwDJ.ce_Q4ih4b2y0ogq6jYvnOeAi.6ILOxJQfm8tgj4h.EukC_sCLw7Mwkl9vL0AB4
 3uKPG.VH4mBKRPvaUbu5jgFpem9cZG0SmwusaVMpzEuaD9ZEr5dloLCu1TwQSpq6yvwFwebZF5cn
 mj0sLWDfIi7gjL4qwdH0WL1gWw_c5rhJ1A1PQrxVKSfYFOG0.G7hOcZ5l0HJDmKMSflEvXMNTru2
 3gR15_4CS8kzUOJHaxoU9rvuCf06LOoITFPKv7jQvQL6rJ0K4nENlgMqqXoyolmL1qaPsDvNYIjD
 azKxlxKxgpmUK9q.o.IBTQ_r47ceWeekKQBDtIr206gyUoDCnw6g_rYuSgFOQGf52Qr8z.pPystk
 ZRuBpjA6lNAjaeVTCS_mHtmVnxy_.qb_ZoV1ePhn8eNTjfRcY6A4qYSaStFZUgX.5vYhOeBOOgnc
 SGYRL2urditkt2y9NQVxBIU8RJvOPqpa8fwJLHK8f7DhtZOpZZlds0odY3kipzG3CrCy1M7_R7.9
 uEtzqWMmx.5SUVs1Nlv2ATvv3pbtovYu231MxxsGXAw4ibiQ.n0GiKa0rjS02.WwjkwC4iJ1sxyZ
 W_CWYRiJJiOf1dRDrmOa1biUZRCaUDdMpw6jDkcH9YQ4Etg0vLG06HTKxMqfKpJATuYCurCdEv8i
 Vd6Zf6hr4ACZJI0aTfij.xMqp_RnfdOcBDlDN1z9DRAlxTyPs3a6iA6AwfTiWq.GOw_rhxVaQ6Mp
 4U_Gb4dpy0HKQvNetobrxfdtAto5S89UvVW4FiQrLJDVMEOn7qaGQRyeCwltPxKWhLceQe1C2HDf
 8nNWw1so09MVV8_8wABATNRNT_QFzoZ2GtP4XOh10BRLheB4lW3rsKdbEkyTunFaeCK0y0YvBtv1
 _CPm9.4DX4x2IMBiFKDOH1v0ziBWuKXWHgZKxKAVIoGQJBB9xyDaRn.ltsN5.flnKgyknsfBBldZ
 v9QJBEcmt.5iJLSRrorXpp7g11xawWeoNZ.A_lOsq48nIusjPdgZqHyTHEBRK4s.krplUlTJyGZ_
 6dJDynPtogpyhrhvje8Z2MQJ8U92kcXAMcwgMV_GBHFXXxUgR336H.7MZtQ1lDYM0JXBltT9fg9z
 Vkx7Q5nQTwBVdKgO1sjnMH7RNmFiQxKkCqc0_9csYXhyPs4L2N0k3HhW.cJWV39Tn0vV6NZrZbCx
 i13NqqEpO9PHQcytWkN0vpfJGJMgSZoCC4wCq0nwF2n.X91b3QQ--
X-Sonic-MF: <venkat.yadlapati@yahoo.com>
X-Sonic-ID: f8ef700c-c79a-451a-8fae-c9d5fd2b4cd2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.sg3.yahoo.com with HTTP; Wed, 25 Nov 2026 20:04:57 +0000
Received: by hermes--production-bf1-8768df57c-2bnv4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f42d62ca4a6ffea7a46eff020458cb38;
          Wed, 25 Nov 2026 20:04:50 +0000 (UTC)
From: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-wireless@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	phone-devel@vger.kernel.org
Subject: mt76: upstream support for MT6878 (CONNAC2 soc7_0) integrated Wi-Fi/BT
Date: Thu, 26 Nov 2026 01:34:35 +0530
Message-ID: <20261125200438.1586907-1-venkat.yadlapati@yahoo.com>
X-Mailer: git-send-email 2.56.1
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
References: <20261125200438.1586907-1-venkat.yadlapati.ref@yahoo.com>

Hi all,

I am bringing up mainline Linux on a MediaTek MT6878 (Dimensity 7300)
phone, the Lava Agni 3, and would like to ask how you would prefer the
integrated connectivity block to be supported before I shape any
patches.

The hardware is the CONNAC2 "soc7_0" WFSYS/BGFSYS with an MT6637 A-die.
In the vendor tree it is driven by gen4m (chips/soc7_0, HIF AXI) and
the conninfra/connv2 platform code. On this phone the bootloader (LK)
loads the Wi-Fi, BT and GNSS firmware from the connsys_*_a partitions
into the CONNSYS EMI region (CFG_WLAN_LK_FWDL_SUPPORT=1).

Current state, on next-20261123:

 - CONNSYS power-on (conn_infra, A-die init, calibration, low-power
   setup) in a small drivers/soc/mediatek driver shared by BT and Wi-Fi.
 - Bluetooth works: BGF power-on plus the BEIF shared-memory rings in
   EMI (H4 framing); hci0 comes up, LE scans find devices.
 - Wi-Fi: WFDMA on AXI with an mt7921-based SoC bus glue. The firmware
   preloaded by LK starts with INIT_CMD_ID_FW_IMAGE_START, and the
   NIC capability, CHIP_CONFIG and several EXT commands get answers.
   wlan0 registers.

Along the way I found what looks like a generic mt76 bug:
mt76_set_irq_mask() writes the mask with mt76_mmio_wr() rather than
through dev->bus->wr, so drivers that remap offsets in their bus ops
end up writing the wrong register. I will send that fix separately.

Where I am stuck, and my questions:

1. Command set. The soc7_0 firmware does not seem to answer unified
   commands (MCU_UNI_CMD DEV_INFO_UPDATE gets no reply); gen4m enables
   CFG_SUPPORT_UNIFIED_COMMAND only for CONNAC3. Does this firmware
   support the EXT DEV_INFO/BSS_INFO/STA_REC_UPDATE commands, as used
   by mt7915, or only gen4m's legacy CMD_IDs (BSS_ACTIVATE_CTRL,
   SET_BSS_INFO, UPDATE_STA_RECORD, ...)? Depending on the answer, which
   would you prefer: a soc.c variant inside an existing family, as
   MT7622 and MT7986 are handled, or a separate driver directory with
   its own mcu.c, in the way mt7925 split from mt7921? Is there by any
   chance a soc7_0 firmware build with unified command support?

2. Regulatory commands. CE SET_CHAN_DOMAIN (0x0f) and
   SET_RATE_TX_POWER (0x5d), built as mt76 builds them for mt7921, make
   the firmware assert:
     <ASSERT> wifi/open_core/wificore/rlm/domain.c #455 -
     prWifiCmd->u2Length == u4CmdSize
   As far as I can tell, the payload layouts match gen4m's
   CMD_SET_DOMAIN_INFO_V2 and
   CMD_SET_TXPOWER_COUNTRY_TX_POWER_LIMIT_PER_RATE (161 SKU entries).
   Is a different length or command version expected for this
   firmware? A CE REG_READ query (0xc0) also never gets an answer.

3. Firmware. Could the soc7_0 Wi-Fi RAM code, the ROM EMI patch and
   the BT RAM code be submitted to linux-firmware, so the driver can
   load them itself and recover from a firmware crash? Until then,
   would a "firmware already loaded by the bootloader" path be
   acceptable upstream, if it is documented and detected at probe?

4. Integration. Would you be fine with a shared CONNSYS power provider
   (drivers/soc/mediatek, refcounted, used by the Bluetooth driver and
   by mt76), with the firmware areas described as reserved-memory
   regions in DT? Or is there an existing or planned conninfra
   abstraction upstream that I should follow?

I am happy to share the WIP branch, register dumps or logs if that
helps. Thanks for any guidance.

Best regards,
Venkat Yadlapati

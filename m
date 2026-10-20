Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.6.128.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792508017;
	b=ULglVoTfJywuLy9L+G5FPCBFmC4mQzuPbiArWMeyHo0EueLrA63uD+9Fh7hLCn5NBOls
	 1RYtp4ffcchyya+50+TupfL9T+lEeRQd1di34xxaGcvYs7maR9URkn6DyQEuHkS2inXpM
	 Zlbv4qlO6t9UPE8QPZy8YUBuaCoRlusuenWKuFm+dg5S9Gix0gjgRGhzfXheOl0bkhcHh
	 BkbRAzLCGLCj60W1S9dDMuxML6TeHEASjYSbTeLiYyWyo+dzZqhe8k1iJHf7hdoEdDSHC
	 mt/GzLzSkShDyUQvgpf+iLC11cW/nd8FxXaaxwo4N7POywHV79RqCK6AtKWUwCU30qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792508017;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:References;
	bh=tTpV3ZIkgJtv86shuF+ZrfY4iEvhyoMN0YOMU7pRAGI=;
	b=vm4+bWdN1AmdGQ0sNE9kJVBJsPgZDTNCYF2YT6y9MQDt3gPeq/esLC7Nvg1ItXvHLGN3
	 Ms4gJT4VI9CW1Zio4hPuvr7m7h/1hKkR5pU9JVHh9cIssDtt52jHVeKNQ1HV4fkJccEo+
	 nN8OdBn7xChBNB3F04Nfyct60RS2PnQCUIqgw/P+OVQndTSIWhA7PH4kUmVTSDOoOp+1+
	 YtbjowNP1ZZYGHcwRHnpBUUqmu7RFtjzdvvJHom2+L9eN/eQmZ9WsQStxUuOnm0ddOjKJ
	 yckUGtQMjTBJiPJB99pQZlskgB+RuHaT/Bow3GBwXJKO06bF6/Tj64FigpHStoKxtOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=NQKFR+VW;
	arc=none smtp.remote-ip=74.6.128.32
Received: from sonic304-9.consmr.mail.bf2.yahoo.com (sonic304-9.consmr.mail.bf2.yahoo.com [74.6.128.32])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22C0606A32F
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Oct 2026 14:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C22C0606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=NQKFR+VW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1792508015; bh=tTpV3ZIkgJtv86shuF+ZrfY4iEvhyoMN0YOMU7pRAGI=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=NQKFR+VWIwSPtn9Z5Ugdhb6ky2Dl4V7AqDepHpWM3hud3kWK1GNvPhAr5qNdkOwPwZMnTTW53neIjU3ieRyOl+FBfnmVY9d8IlA/jbq45KqYM+XH5gPGB83zXFm9YExdVOd/45HiwYuq/Mm8kdX9ykMvSOi87U23i+S1QMH09f1Li/r/7fW5GjnT0Dx8Nh9Hrl0W4gLpgmoJRM9nEcTi3UDEKT7QWxKNZhJMW3zbX/5WJx99XP5lGCn2rgeMR8067Quz2mazx7piuOoesX4PfsX0nctIfDycF38tfS+mdrbXpkvMbW1xknq96zayzm4i0XJvBzlbGAfhKN1vRKmfMw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1792508015; bh=vI0rBTf8cJ2hsmTA6PqswkFo3F8kflvaSNzOCyG7+4d=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=DwcSqh2+ZA1APqIaPu+r51rjPtO3RqzJkJUuXjAb6IBJ4LzUyHowwPEVeGeKvdtRhcOlV0FxzSKFLI49SXLJZMRZYAeRKhFlgz3llfi1aUDq03VNEIItUAQWKZQaRBNxwZAtRuOa3APpqshxCDW13E2xnVCKUkgKacvN2M3qbesStqo0FEGhMTSRJdC2JsiIcA/gAKDntnLL49Ky7c8lEDICXeXyT7tmfDyDxuQcCFWWaE0olw4IcpVcbQIdvL+xJEemr3JDhc+nAk2RxtR3gyvhfCAVrkPqtb+/uoR9EKbO0QtGsjoWIuItkqu0ga0Sn82RZpUN5Wx76Kw1khSx7Q==
X-YMail-OSG: TQSkQ88VM1n7rzeQw8D.UvLGJavorU_Du.ByD4XMtatAVdR874wHDUmgBQh7jZ0
 phhFOsZ0dMrhaDDT3s0fYGfiM2.5phSNgaKNrtuWT97LfHbdIzhR6bdejQIYcNTGFsmliJarxstP
 UUVQGkEz7xsa3XMP1pdLxPaFsxZJiYjWAqvoDdV13Rb7Sr.0tI94yZxULONP_xx95UuwC9RTQ9Ek
 oaYN30FcPf81CH3hjtjFpNvoht4nyTjDMbTD9oj9hEo105KiubXYTzvhlGKQKsFzpIEapCB1o1eM
 OVhytW9EsS2tLeow.pIRM7AbTbZzQPjgtIWwn72uamlN3LP2vRvdKFF0dqd7hBFzSCpX2YVdZ5Az
 480HQGphE54DthQ9Kz5IBpS904BlrsW6VFrkdJXDfJ7Y__Z.0_2ITm6ZVC2vv1isGFEwAKNiKOFf
 dWHT0JORZQL9W.RtrLFoiD7KjMLff3Xxcu0Cbntq9hEUcytA31bdUDly3qVjAsRkPhX9OX1Le9L3
 qscx2g1PPvhKv2d9THaAKQWQ4OJ0lFyaJLmEPUBL8wtHmp_CNOGCkUP2dmX4MEsIMGIPTw2ZNXnG
 2Wa_cvfOl_nm2HBkKvTJcahuB0tYf.35y1LBBEjleU_kbSbfF448xIlqyfUkKKayvGdSSF7FJase
 kIEsY4lO.zkF4Zj1TmnHcXk.oRvdq.vNzrQRen19d8JN5fWvtq9ai_2ID0jo6mz1iPNnr2aCFyUG
 FoUfAod7.bLQ.BOi_cf9NQPWFrls6VCu1l4_9Wsja_zZ_ssOxTxhIllgwm3ZapPVlEYogikEbRjh
 _b2xSPZJy9SZjVM_u56bNI01CM590eo740cWOj_z9F2HBr2iP0wUIa7UfNBmtdpXS4gsaB8mtnf7
 FIy2lWAvZUCg3JNo7xSOaeYUQun7XGOt2Avl97UnazEa7hG1DytrypMtJNXiIJkWVZJNPl6DDdKC
 v686uoiJfA2YXeJ6BLz.9wJMt6h60d0hIjsP2Jn85IeMOVSZZGL26G8DzPhgiDuHXiY_GM0HwTbC
 Ku7vtdvm5a05_7JkekZkKI6BE2uNgGCV7kV88nZGD35W.o.PBi6bj4VXtugeNFnEvm8hbkk_s8Q8
 nZhiO7ArbAWt_8xBxEmFhHFpMlxLlqnWfabNi78huJWLIKHK2q_XXiM4Aw5xIudq99wU9cHcdvx.
 rv0tpWVLGClLeBhh0EmK5Rm1ZVkQiMVdnnQWQ8VFVmo.miMHeqRSVxOyzHe9AeUYx9oaq2MIjtn0
 fj0klh2UIUI5wfnkhNjzHEPRfnqsy9P.zz366Jq8txQq6M7grZ4vjhKGnpdn2klNdPJBXkkEoPMP
 rB3WS40lRLvJ9wVtRTNzAJu3tYPK92gfrVLwmV_S68lXQROUptUrB1.12J0O5VXLt46Nvju2Ow9A
 4f2UKvhmiYkLn9gDWEsDnaWaCy5WTK6o8IMcg8C4cPdtNQPsBo2WccwySqLlEXSkp10RhxfE43Wq
 Zcnsn5.GPC9i7GKdmvHMffxW2KeUwC77LLRIITh4NieRjxEuUzOlLqavHsjEW4HalblLeKNhBUCL
 X38tAZvt1T6HoRNI4QZ2bm.pz7MpIQOOZ1rhPRvZrvz.so6xOi5BRo0OUxiBuq4t0RPFun3bqdag
 NpEjfibtCGOYvwgAzxV4xnovuaNprLzL0wKRy0wZ9u6G2cuFMa2Fb7CCipRUil0J1wFN4.229MZY
 jm5EjuNcdtMKFdTTtVd1naXqwvTrXA0DPsQlNGgsWOzol8PvViVMz7GTcWZx2j_lOyJCZVp8rpBs
 1EDhziDR258KQYjfG1_FxeTx0GVoORtBvs_7R4xoE5hyTciHyam645BWEbMJ7uuMEb5RhWlypbkD
 w1QlrdzQrjoCsIh9rwyqq0S5xBsVVG5kiWuh0L6z5yD0IuCHpBNAs2wdN7BxNTXmFMbbeG266XRy
 IaAQI8YAoijnvF8Zy7v_XgO7dRsa7bbMIWN3frgoi3rd9Jcgg3zXz0c7VYfBMPEkMT2KwzxOYCT6
 2twcOa1rWX7pgeL3gmtv5j1_nM9Bhu76uS.PbGV8qqn5VS95e.YJStIqqc8yV.N2FRPd8rk5CBxa
 JomFIgn_Q0ML_fhNJUwDqlQqoUCSxcacFcMmY89GiGDc1X0Q0FwXHeCtOYM0Zbx5sdjSwhX.XguL
 7dvBtjwa_gSf1xqyNijBnPYkuFrmP.4vB9pm.kRlQIC9rP5GihG5AI43Sra6cdEDC9o4dnHW.meC
 Iodw26L._ZWmco1yfhi5kmLJ6zYTmIbTVYLSD7iTRpJA-
X-Sonic-MF: <deaner92@yahoo.com>
X-Sonic-ID: ebd0a12a-f1e6-420a-94e5-4b5bc2139d0c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Tue, 20 Oct 2026 14:53:35 +0000
Received: by hermes--production-bf1-6d6877594b-mcfwx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2a5d645ec72f5aa086fa0f54b124814e;
          Tue, 20 Oct 2026 14:53:30 +0000 (UTC)
From: Jeremy Dean Clifton <deaner92@yahoo.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hillf Danton <hdanton@sina.com>,
	Jeremy Dean Clifton <deaner92@yahoo.com>,
	syzbot+5897b3c764f5989ea942@syzkaller.appspotmail.com
Subject: [PATCH] Bluetooth: hci_core: Fix queuing disc_work while workqueue is drained
Date: Tue, 20 Oct 2026 14:53:20 +0000
Message-ID: <20261020145320.115333-1-deaner92@yahoo.com>
X-Mailer: git-send-email 2.43.0
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
References: <20261020145320.115333-1-deaner92.ref@yahoo.com>

hci_conn_drop() queues conn->disc_work on hdev->workqueue unconditionally
when the last reference to a connection is dropped. It can run from the
socket connect path while hci_dev_close_sync() is draining
hdev->workqueue (e.g. HCIDEVDOWN racing with an SCO connect). Since that
queue_delayed_work() is not chained from a work item already running on
the queue, __queue_work() sees the queue marked __WQ_DRAINING, warns and
drops the work:

  workqueue: cannot queue hci_conn_timeout on wq hci4
  WARNING: kernel/workqueue.c:2352 at __queue_work+0xdb7/0x1370
  Call Trace:
   __queue_delayed_work kernel/workqueue.c:2617
   queue_delayed_work_on kernel/workqueue.c:2669
   hci_conn_drop include/net/bluetooth/hci_core.h:1729 [inline]
   hci_connect_sco net/bluetooth/hci_conn.c:1881
   sco_connect net/bluetooth/sco.c:375 [inline]
   sco_sock_connect net/bluetooth/sco.c:764
   __sys_connect_file net/socket.c:2166
   __sys_connect net/socket.c:2183
   __x64_sys_connect net/socket.c:2186

hci_dev_close_sync() already sets HCI_CMD_DRAIN_WORKQUEUE and calls
synchronize_rcu() before draining, and keeps the flag set until the
device is fully closed. Skip queuing disc_work while the flag is set,
checking it under rcu_read_lock().

hci_conn_hash_flush(), called from hci_dev_close_sync(),
deletes the remaining connections.

Fixes: 525daaea459f ("Bluetooth: hci_sync: Set HCI_CMD_DRAIN_WORKQUEUE during device close")
Reported-by: syzbot+5897b3c764f5989ea942@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5897b3c764f5989ea942
Tested-by: syzbot+5897b3c764f5989ea942@syzkaller.appspotmail.com
Suggested-by: Hillf Danton <hdanton@sina.com>
Assisted-by: LLM
Signed-off-by: Jeremy Dean Clifton <deaner92@yahoo.com>
---

Notes:
    Testing:
    
    syzbot ran its reproducer for this bug on upstream 90201351a862:
      - without this patch, the warning reproduces:
        https://syzkaller.appspot.com/x/report.txt?x=17940305580000
      - with this patch, the reproducer does not trigger any issue:
        https://syzkaller.appspot.com/x/bisect.txt?x=1714618e580000
    
    The evidence is the pair of runs on
    90201351a862, where the same kernel crashed without this patch and
    did not crash with it. syzbot's own retest on
    58161ead29e5 (Oct 17) still reproduces the warning without this
    patch.
    
    This patch is based on bluetooth-next (185c11232d5f). I built
    net/bluetooth and hci_vhci for arm64 with CONFIG_PROVE_LOCKING=y
    with no new warnings, and the same change also builds on x86-64
    against v7.3. I could not run the reproducer locally; all runtime
    testing above is syzbot's.
    
    Hillf Danton tested an equivalent hci_conn_drop() check in February,
    together with a hci_dev_close_sync() change that is now upstream via
    525daaea459f:
    https://lore.kernel.org/all/694c9ee9.050a0220.35954c.0030.GAE@google.com/T/
    
    Tool use: An LLM helped me analyse the syzbot
    report, compare hci_conn_drop() with the existing
    HCI_CMD_DRAIN_WORKQUEUE checks, draft the changelog and prepare the
    syzbot test requests.
    
    I made the code change myself and checked the
    locking: the RCU read section pairs with synchronize_rcu() in
    hci_dev_close_sync(), and hci_conn_hash_flush() later deletes the
    remaining connections, so not queuing disc_work loses nothing.

 include/net/bluetooth/hci_core.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8f32c860d492..c8cc25d35195 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1775,8 +1775,11 @@ static inline void hci_conn_drop(struct hci_conn *conn)
 		}
 
 		cancel_delayed_work(&conn->disc_work);
-		queue_delayed_work(conn->hdev->workqueue,
-				   &conn->disc_work, timeo);
+		rcu_read_lock();
+		if (!hci_dev_test_flag(conn->hdev, HCI_CMD_DRAIN_WORKQUEUE))
+			queue_delayed_work(conn->hdev->workqueue,
+					   &conn->disc_work, timeo);
+		rcu_read_unlock();
 	}
 }
 
-- 
2.43.0


Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FE27485
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Oct 2024 23:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729467030; cv=none; b=SciuP/0UnrRlrph0FEQDQncEs2TeLHGMkxOuDya7WCaPYckkMCG5FfKF4NIsrGzSQ01ZiQD44NWbprrdIZfTW9lRq6cTmbG/VJ6UNRxdRfaEwGKs+0rwhq2jWc4XleMhMAXO9ji4n62C+/E3Z6JNNScv+ZMW4R6FHsDgPiOEcjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729467030; c=relaxed/simple;
	bh=D8G7Z7Yue/0AEFSfBnB/ewn27gYEW6D1Flaw75OqgxM=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=tyPmHy0QlV5vThGKQdupp95P0wOjc8yz7hDny+FHWlPHuJK6CrAN3+2STiG42tv3xBiCHQITSgxjUgVPD4kmIA6FwlpDpqEzXPS9USBhsezia99dPjPm3U4KibCEF1/6EVU3FByfiky+EjFQ0bj8k5U+NFMTV/zG3IbzfXEux8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nsm49cnx; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nsm49cnx"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so2951421a12.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Oct 2024 16:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729467028; x=1730071828; darn=vger.kernel.org;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1wTBfBkN2a3CdW8T4UvoI1rXrtkBVWVJoTI1l9mMZgo=;
        b=Nsm49cnxRK+DLKvsOpRcN8p5S5EYDDY0Sdgn0tklQRwWt6SgOQin1Fip8HQtTC8seQ
         WTaAqhua4Y5cHRmS40CZ/OxaEPMEG8B4L9Y/UenUgKPW/vFcrc+Amp40h0GKmz5gSZC2
         atNQU7LgsmtbfzDqVr3cp5DIKY/5GaGcqzRSAuWX6QkBHmNRC4E9TkBxOS6jwlWuVw7r
         7u1MIfQFnQo6yqV8gy54/uBNwxSmJWIEVD3KQE8AV+BYbRuzP4LpDOIgzgRkveOAeiS7
         OcKQE+RivUn1abMnHqjL1bwUI/CjobY+VU5Kfez7OBBUNGDePBElZkSaLk+Eu9lUcc3J
         Lipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729467028; x=1730071828;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1wTBfBkN2a3CdW8T4UvoI1rXrtkBVWVJoTI1l9mMZgo=;
        b=G+3DOJQU3KNjjYr8ZxE9bek7Wymm81eAm1ZlGFdwnK8lSUWR6YmmsZqlI/nBaeLvfz
         M7AZDStY6ZQR+vrl0RN+cK12fgHbwITQDLJ+mnQ0k27xkur8h7Ue/QMzSVrwEHuOfyrJ
         uq4W4H7e2l7/1UerbLolxb67mAFAk9XQsc0rUhjh4VOhmpFUSACC6u38RsPfY0B0WZGN
         YRYaIFQJ+mh/1W7K4RN63V5ejr3njwxuGO2GhDL/MxHGhisin6ySvpeqEMZxsURZ22b5
         FslCfBgFQcIRsWwW7IC6ClepuM3mcVqss87HMaReGtONuWiqpQDa7/mcl1YRyyOsdCma
         cJjw==
X-Gm-Message-State: AOJu0YyQ93zOzcEbv2EqMLlVdEK0J7tnwnrL/a5SYfXfl3hCXtdglb88
	ge3jTX6ekI3VH1UAiFLcmDGosriUnw03Uf4y/3YpsYZS3xeFeuxSBzza2g==
X-Google-Smtp-Source: AGHT+IFjG1+MoaF0WzBjUy+mI4XmgAgD2N9oq38Erx0b/yZP1WZIeu/xUv21jJYlBS2qSFFqdY5//Q==
X-Received: by 2002:a05:6a21:3a4a:b0:1d2:eaca:34ca with SMTP id adf61e73a8af0-1d92c5856d2mr13238016637.42.1729467027735;
        Sun, 20 Oct 2024 16:30:27 -0700 (PDT)
Received: from JUNHO-NEOSTACK. ([221.154.134.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeab581e4sm1799653a12.50.2024.10.20.16.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 16:30:27 -0700 (PDT)
Message-ID: <67159293.630a0220.14043a.3c56@mx.google.com>
X-Google-Original-Message-ID: <ZxWSkBg1iMbH1O88@JUNHO-NEOSTACK.>
Date: Mon, 21 Oct 2024 08:30:24 +0900
From: Junho Lee <tot0roprog@gmail.com>
To: bggixx@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Test information on BlueZ mesh SAR segmentation
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Brian,

I appreciate you taking the time to review the following patch:
https://patchwork.kernel.org/project/bluetooth/list/?series=898733

To assist you with the code review, I wanted to provide some additional
information.

This patches utilize as much of the existing code as possible to help you focus
on the changed logic. I plan to send an additional optimization patch later.

The testing for the Access message was conducted using DFU on an nRF firmware
device. We confirmed seamless communication with the Nordic DK by proceeding
with DFU using four segmentation packets as a single chunk.

For testing the Control message, we prepared two BlueZ-based nodes and applied
a dedicated patch. We confirmed functionality by periodically transmitting a
control message, and upon receiving the message, printing the packet data.

Below is the diff for reference:

---
diff --git a/mesh/net.c b/mesh/net.c
index 215db995c..91eb35a7a 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2358,6 +2358,7 @@ static bool ctl_rxed(struct mesh_net *net, uint32_t net_key_id,
        uint8_t rsp_ttl = DEFAULT_TTL;
        uint8_t n = 0;
        uint16_t net_idx;
+       int i;

        /* TODO: If length is greater than 11, it must be segmented, so it must
         * be able to handle Segmented Control messages when acting as a friend
@@ -2474,6 +2475,10 @@ static bool ctl_rxed(struct mesh_net *net, uint32_t net_key_id,
                                                        net->hb_sub.max_hops);
                }
                break;
+       case 0x4F:
+               l_debug("Get ctl message len: %d", len);
+               print_packet("Test RX", pkt, len);
+               break;
        }

        if (n)
@@ -3277,6 +3282,8 @@ bool mesh_net_set_key(struct mesh_net *net, uint16_t idx, const uint8_t *key,
        return true;
 }

+static void mesh_net_test_seg_transport_send(struct l_timeout *test_timeout, void *user_data);
+
 bool mesh_net_attach(struct mesh_net *net, struct mesh_io *io)
 {
        bool first;
@@ -3311,6 +3318,8 @@ bool mesh_net_attach(struct mesh_net *net, struct mesh_io *io)

        net->io = io;

+       l_timeout_create(10, mesh_net_test_seg_transport_send, net, NULL);
+
        return true;
 }

@@ -3693,6 +3702,34 @@ void mesh_net_ack_send(struct mesh_net *net, uint32_t net_key_id,
        print_packet("TX: Friend ACK", pkt + 1, pkt_len);
 }

+#define LOCAL 0x1001
+#define REMOTE 0x1003
+
+static void mesh_net_test_seg_transport_send(struct l_timeout *test_timeout, void *user_data)
+{
+       struct mesh_net *net = user_data;
+       uint32_t hdr;
+       uint8_t msg[33];
+       uint32_t hexa = 0xDEADBEEF;
+       int n = 0;
+       int i;
+
+       l_timeout_remove(test_timeout);
+
+       hdr = (0x4F << OPCODE_HDR_SHIFT) | ((uint32_t) 0x1 << SEG_HDR_SHIFT);
+       l_put_be32(hdr, msg);
+       l_debug("Send ctl message len: %d", 32);
+       for (i = 1; i < 33; i += 4) {
+               l_put_be32(hexa, msg + i);
+       }
+       print_packet("Test TX", msg + 1, sizeof(msg) - 1);
+       mesh_net_transport_send(net, 0, 0, mesh_net_get_iv_index(net),
+                                       20, 0, 0, LOCAL, msg, sizeof(msg));
+       mesh_net_transport_send(net, 0, 0, mesh_net_get_iv_index(net),
+                                       20, 0, 0, REMOTE, msg, sizeof(msg));
+       l_timeout_create(15, mesh_net_test_seg_transport_send, net, NULL);
+}
+
 void mesh_net_transport_send(struct mesh_net *net, uint32_t net_key_id,
                                uint16_t net_idx, uint32_t iv_index,
                                uint8_t ttl, uint32_t seq, uint16_t src,
---

Regards,
Junho Lee

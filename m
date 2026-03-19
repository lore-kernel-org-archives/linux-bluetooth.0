Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6523C9EDB
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933331; cv=none; b=tBGkrYBmv7LebAyn0tcsFYbcCIrOqZWE4lz2zXIWWBRJuIicvVE6yId6DKf1bc3c/oUBQglw/nlZey46joCL51PDtO3or22SZR0NOPqG595hTODwMb3OhRWmw1eFNN4+V3alwHYcB9wxFIty1s31PEjpHJQQ6MzvrVjGL4v7SYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933331; c=relaxed/simple;
	bh=syTlD6nGrdfE9YtjLFj7DmkRL8l4GcCln622yYEQdYY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iATPrT9bL/DtZot+6kkNyusRlF3ZdrhV7qDv2PTQU765n9VPgZVXeSoLGZ6CrdFSijB1+qcr0S2ojwaTsAMaXyBWEzVYiqT+VmMemPeL/Mu3KVMOnR6xbT7W27LEuCP2yKyM4AT1f3xVddHB/hMoSP7xqjLzORI6cJPycNq8gT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+nEhiFN; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+nEhiFN"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b0603ee486so7756955ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 08:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773933326; x=1774538126; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U7BEhkURUI8fvM2DHkqZeEyRidcEXN5OVDbxEAJ6Hcw=;
        b=g+nEhiFNbNgVmdHLMuswDpCSjhQ/yseQXPYw3weTi7ASsOR/3dm58GObT5kdrhCr3P
         0DxWXl/BBxbRBXFFALJYNjG47PU+YNaxeeoT9ECLU2MxPnYLpdSfi/EnpADUne3qQUcB
         CpfvpzLkwv0DV1RXD+B6TD+qlVjiIiG9LWPH6W+DqxfRLADDa+sY0FNlRfVmEjvRfw3m
         p2OFEpPR9kw6b6eFv/15wYYKriDPzNQlDYVSK3Ucyl+/H9OmHrxnd1l3c1CJ4zWzctCi
         lhlKIQs54KTvQiEEeRtMtOEfCYSrxfq7/BOlq6kOh8WSXQ8G6/OSYSAT6hgO0+C1Q4Hj
         CXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773933326; x=1774538126;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U7BEhkURUI8fvM2DHkqZeEyRidcEXN5OVDbxEAJ6Hcw=;
        b=FimVfzaFNWoKD87en3KigLkBwsYV8L6G7EjtvE3z3f3irtJ7Lm0jd9b4DxdT/3uqWR
         pUZiYRY+MYthI2ERKOms0NItXxH9HMOR+wBWG4bThRmiqnQtfw0BE6KDDmlHGHNKBrN0
         PkgZWqO6XQZY6ZJZG9/PlvrvbjPzS3tMMV48ez6+cJJyQFGE7IET22GMmjSBv215gDZi
         xScGOmKO947XNrajCFkKut2ax1w3uTqwp608058Go85pwM9Z9R3Ip9Lxa0eH1OjV6lwi
         mDfuYKO0G/MTy3Zg3hb8XYZ08+G4Pr4jQSzG4dZC5R397+5uNw/gVo2qQxpVTpwIgL3y
         Z+vQ==
X-Gm-Message-State: AOJu0YxWFpHDtx/dM/eieTI5IKTs8EoM9Tis1ex9dj5wwx41TVodiREn
	d9NIVVw/aZtlzhKoD35qfIQ9hy8t5SCyofeKGoo6ISAGZ2ajCCKvNLFn
X-Gm-Gg: ATEYQzx/IKlrhezNV/GGbXXeFwE4FVQI3sAEIWnxnX2pNqHA6un7yKhocW7shHy9AVm
	jVRWKI/zsE96F6nvGGcxxJzRXJQHpFFwodXB488SIKTkm4wgPXQK1uVVK0GDyJr+F+yguDxiJ8G
	egjTFZjJEbd9DeV4ge5c6GJBK6TVLmdJuf7sIJTPdV3iqUaU0+8zi9+/I+JUzvli06k986Yf3AS
	X26e268THIZRKPAcZRCpl3j94JaBHKqJj58s7P3J5GK6rhblMv08kJRR8ImhC9+yf6yKQt2/nG6
	4iD1jcgXkJcluIYtOGZhwm5dPMy+YxUEUbwIQfamlYlJ4Soz1xjKFcLo+r7y4qPuIIeKCYFBHQP
	WHtIu+8rrfyJzAR1FVZ8WBwBQRJXYGD19PwaQTQRITbH8zP7rc92qyopeYDeL15+cBeOZxcktzQ
	rtw+PtHOPEpsphMvfPtUMHUqS4l8PFTHXiThdltC3x1g==
X-Received: by 2002:a17:903:2f0c:b0:2b0:4f82:74b4 with SMTP id d9443c01a7336-2b06e42a983mr76907725ad.47.1773933325956;
        Thu, 19 Mar 2026 08:15:25 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e605108sm80315255ad.60.2026.03.19.08.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 08:15:25 -0700 (PDT)
Date: Fri, 20 Mar 2026 00:15:22 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH] Bluetooth: L2CAP: Fix ERTM re-init and zero pdu_len infinite
 loop
Message-ID: <abwTCkavRurEcEGO@v4bel>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

l2cap_config_req() accepts CONFIG_REQ when the channel is already in
BT_CONNECTED state. This causes l2cap_ertm_init() to be called a
second time, re-initializing tx_q, srej_q, srej_list, and
retrans_list without freeing the previous allocations, and setting
chan->sdu to NULL without freeing the existing skb. This leaks all
previously allocated ERTM resources.

Additionally, l2cap_parse_conf_req() does not validate the minimum
value of remote_mps derived from the RFC max_pdu_size option. A zero
value propagates to l2cap_segment_sdu() where pdu_len becomes zero,
causing the while loop to never terminate since len is never
decremented, exhausting all available memory.

Fix by removing BT_CONNECTED from the allowed states in
l2cap_config_req() and adding a pdu_len zero check in
l2cap_segment_sdu() as a safeguard.

Fixes: 96298f640104 ("Bluetooth: L2CAP: handle l2cap config request during open state")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/bluetooth/l2cap_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ad98db9632fd..a6ce09781083 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2381,6 +2381,9 @@ static int l2cap_segment_sdu(struct l2cap_chan *chan,
 	/* Remote device may have requested smaller PDUs */
 	pdu_len = min_t(size_t, pdu_len, chan->remote_mps);
 
+	if (!pdu_len)
+		return -EINVAL;
+
 	if (len <= pdu_len) {
 		sar = L2CAP_SAR_UNSEGMENTED;
 		sdu_len = 0;
@@ -4267,8 +4270,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
 		return 0;
 	}
 
-	if (chan->state != BT_CONFIG && chan->state != BT_CONNECT2 &&
-	    chan->state != BT_CONNECTED) {
+	if (chan->state != BT_CONFIG && chan->state != BT_CONNECT2) {
 		cmd_reject_invalid_cid(conn, cmd->ident, chan->scid,
 				       chan->dcid);
 		goto unlock;
-- 
2.43.0


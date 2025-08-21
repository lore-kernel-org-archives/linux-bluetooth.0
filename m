Received: from protect.koston.org (protect.koston.org [64.227.100.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D52A2E9EC2
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 20:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.227.100.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755808400; cv=none; b=axnZt4CHRBPsRW+QcMYBDc4nIgUEVGEZmZvD4L8U/QDPRDe1GMlor/plEF7sBkMXJbC8IK/q8ELDompfN24LvQYEagXeNqXY2l+/sIj7WIB+vSryK9qMkSefSoXSyRfr0WoUQiRdnJl8SIXhnSUgauFstF6/EOhpEu0Jug0HrSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755808400; c=relaxed/simple;
	bh=SR1n2emNKI/sN4+ug4bV5TK9ZIbBIBOJMdHKv9BPgXw=;
	h=Mime-Version:Content-Type:From:To:Subject:Message-Id:Date; b=OQlEVxpBoRw7lqRLq3sk7RxUyJGPNkbiCfgaqsZWGxmavyfC3UaTi6dxLFCFnKhvCHcDef8GN/7hiS89ApBzlfPHutm/4cmzUOcfszH9ag0w5f7lR65aaVN/rVH9+50pOE6of7qL3xxpFWEXentHlUXKJi7SluCjGdDlJdnjBbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=koston.org; spf=pass smtp.mailfrom=koston.org; dkim=pass (2048-bit key) header.d=koston.org header.i=@koston.org header.b=ITpjA797; arc=none smtp.client-ip=64.227.100.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=koston.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=koston.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=koston.org header.i=@koston.org header.b="ITpjA797"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=koston.org;
	s=default; h=Date:Message-Id:Subject:To:From:Content-Type:Mime-Version:Sender
	:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ucQFBMXJY2v4wK0mJpXT8b5wZGTrgYgLTdLtUdnhpd8=; b=ITpjA797VchPYlA8ZbxCep3s8t
	pEsQqa7FDj+1sBuqZ5el8US+CClS8l3QbmcBnXZwACRpYbnyRJVu55FF4JhtEnEMp5xqhWzMQSt/D
	BA/WE9IRR7XeIxk6PUqQGw5MMQRVRb9JSDy5JsluHffTzq1iQEljKWpJlt/jGqQgxyTn45XYbgrVW
	2SUcel7L3Lw4TkrNS30cqw7C6dMqEoXZo2fNbc0C9elRY+vhktjpqSah7jBcoZx2cAXn//SJi2WRV
	vwEoitjIQQirrcE9arPoW2/BnCWTfd9B7NAVOzVlMjvZxIla2Bnbdi1xwXWRcRPaK64yOgW2Om1p3
	OWD/680g==;
Received: from koston by protect.koston.org with local (Exim 4.98.2)
	(envelope-from <nick@koston.org>)
	id 1upByI-00000002ZGa-0PGL
	for linux-bluetooth@vger.kernel.org;
	Thu, 21 Aug 2025 20:33:18 +0000
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
X-Boxtrapper: k2pG7wXZewdqT_cpWr7qQmZd3i90dZGv
X-Autorespond: k2pG7wXZewdqT_cpWr7qQmZd3i90dZGv
Precedence: auto_reply
X-Precedence: auto_reply
From: "J. Nick Koston" <nick@koston.org>
To: linux-bluetooth@vger.kernel.org
Subject: Your email requires verification verify#rytsCpsStxBOz1ckg2wcT-1755808398
Message-Id: <E1upByI-00000002ZGa-0PGL@protect.koston.org>
Date: Thu, 21 Aug 2025 20:33:18 +0000
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - protect.koston.org
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [1006 993] / [47 12]
X-AntiAbuse: Sender Address Domain - koston.org
X-Get-Message-Sender-Via: protect.koston.org: authenticated_id: koston/from_h
X-Authenticated-Sender: protect.koston.org: nick@koston.org
X-Source: 
X-Source-Args: /usr/local/cpanel/bin/boxtrapper nick@koston.org /mnt/home2/koston 
X-Source-Dir: /mnt/home2/koston

The message you sent requires that you verify that you
are a real live human being and not a spam source.

To complete this verification, simply reply to this message and leave
the subject line intact.


Or, you can click the following link:

http://www.koston.org/cgi-sys/bxd.cgi?a=nick@koston.org&id=rytsCpsStxBOz1ckg2wcT-1755808398


The headers of the message sent from your address are shown below:

From bluez.test.bot@gmail.com Thu Aug 21 20:33:18 2025
Received: from preserve.koston.org ([167.71.162.95]:42568)
	by protect.koston.org with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <bluez.test.bot@gmail.com>)
	id 1upByJ-00000002ZGR-2vHS
	for nick@koston.org;
	Thu, 21 Aug 2025 20:33:17 +0000
Received: from mail-pf1-f172.google.com ([209.85.210.172]:51321)
	by preserve.koston.org with esmtps  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <bluez.test.bot@gmail.com>)
	id 1upByH-00000004GqH-2T3H
	for nick@koston.org;
	Thu, 21 Aug 2025 20:33:17 +0000
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e2ea94c7cso1428803b3a.2
        for <nick@koston.org>; Thu, 21 Aug 2025 13:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755808355; x=1756413155; darn=koston.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KFInzZ/3OoqVkkZV1Dw/uQ7v17cldrTFbxh826Sa9zQ=;
        b=PBDpDgGGDteY5IyG7PkxmABsqnjIL0t2261fIbnyeSS5ye3cpHrU9h2p78v/01QuLD
         sHeCvP95xTTAg8aNTty4vCCtlWzgNMuUiBfrPOtwb/h05kVjz9stpp98jo4MqrPyuW/i
         CD223YiOAo46LyMzK3PVqZGT7crvaR2/254yxT1SLd2hgtEJ/PGGEO6hlR2V89Q66Z9V
         kzsNYQ2os8qh1k9O7nc3bx/Mw2UwoEGxK7mhiwwoxPWD8s+84FSOyS1w+umA11LFafEe
         5rq71AqJLM3QKtqWQIEZlg1TsUHDw8JK+ERFaNQNJJu7BCCA1pPu+6FeZaeQr7u+EI5E
         Bi4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755808355; x=1756413155;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KFInzZ/3OoqVkkZV1Dw/uQ7v17cldrTFbxh826Sa9zQ=;
        b=c/YM1BiMd0iLr2d60nx3+V0YTBQLDocmCAMTdb76MEXwwBfhD34L+Tj7piIUcM6TEs
         Q/ttS6WIieU0amEEnGwNuOHHQeUy+8g6X1CKtHFYxF2iw28xwlb/G+jw3SNH/w8afrpQ
         rFgMsRmgPULtbYBGYC/5VumBk46zAi4m5WeNS/3WxvF1qIjKyhkRK7qJG9k0n88eIDlM
         NwEyCjxncn7GJWLXKmO1PwhDKicG2Ww9d/eQWA252d9K6djsNvKsFj1EFtkbZ3nV4bbe
         SaID0lz8d9VvrMXPeLPtBzmvTHZS9WVhvFIgZNMEYbvjj0kLk7Dfcwg2EtG+/Dzz0SLF
         rJqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVB0JHc7OXve2yv3zkDZyw6sOBhKGWdNag/u9g1q3SVB23YRy9PQPGolQnfUauugMzTra8j@koston.org
X-Gm-Message-State: AOJu0YxUM9NphdlLdoKEe3iYiAvTSSjtn/cxokBqzPhohgIZ4D1lKtEu
	9qQhpZmzW8VG1vz7nLAvl3XNg2WsM70YjkE0V5SN4p8mcFzcisOMfwCSWUCxpg==
X-Gm-Gg: ASbGncvnnlBJFVe7Gpta6k0xHuGEv38qJoNyE9qWuXFbLty9Gk/4YpusdJWc3lG/r2u
	lIQ0nGdqHs8byTXWPHYNMcm0CN/g0MklUQSup3UHDcKyZ4QYOdi3usiFyBVcr7iGSr36sA+lixa
	lPmBlxJSLZ7Pa6b/T6d3k8gk2xDsHbaEeKSVUOYuDAnlm5ekiChJOd+0e3muTUuy+7/GFguJw/x
	Jd3e1GB/SGyXVpeW0fx3AWAPlJJ/nTu5fbRffMNORofIsE2QNs/Y6V9gWMrgwja/bLZLnnCdB9U
	KsWGAmHLt+3jRjF26X3yu1y5HcT6N2eKg0lywR+sSvlpNIgYTvhZ1CEDkhzB1Uy+kdhtyKTQbRL
	7nWdF8GVsciThJ8lRfvkdzwhQtxSZie8=
X-Google-Smtp-Source: AGHT+IFdBxtrgEoPMBFi1IGTGlmSPgKc1s3Ev9N7xMo5l9uydNYxAkR+M5f94UceLrpUseBoY0rR/Q==
X-Received: by 2002:a05:6a00:a2a:b0:736:8c0f:7758 with SMTP id d2e1a72fcca58-7702fa4f732mr798995b3a.10.1755808355454;
        Thu, 21 Aug 2025 13:32:35 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.220.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770300797d0sm303312b3a.64.2025.08.21.13.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:32:34 -0700 (PDT)
Message-ID: <68a78262.050a0220.35639b.1447@mx.google.com>
Date: Thu, 21 Aug 2025 13:32:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5189031996542681875=="
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nick@koston.org
Subject: RE: [BlueZ] device: Fix device removal on le-connection-abort-by-local
In-Reply-To: <6C943D79-4B06-49E8-82C2-EC23F903F91A@koston.org>
References: <6C943D79-4B06-49E8-82C2-EC23F903F91A@koston.org>
Reply-To: linux-bluetooth@vger.kernel.org
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - preserve.koston.org
X-AntiAbuse: Original Domain - koston.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - gmail.com
X-Get-Message-Sender-Via: preserve.koston.org: mailgid no entry from get_recent_authed_mail_ips_entry
X-Authenticated-Sender: preserve.koston.org: 
X-Source: 
X-Source-Args: 
X-Source-Dir: 


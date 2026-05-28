Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E38D18CC13
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 14:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779979399; cv=pass; b=b9/t0c4WgG0ctrI75YF7+TxTwauhY+Qk74KEH19wegTLqSbJyuLEuzYfBqUNYp+ialVHbSOuZ5HNUF6GxejdqhoM0VotKZJklduRTAmAxp2mnZXkK6QPnhToqYBePLCMyZidMwpo5zs0PSAzvi4TvNv/870YOjlDlrF/IJEuCP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779979399; c=relaxed/simple;
	bh=bqRrZ/ZT9kobSCQ/vSFrjPw7J2S/QN8pzC52BPuxBS0=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=e0DQctKe0CAOJY2aLnlDLLIMqPjUb6C4f+67cAqAQMUHulXB5ee1lN8Pn7M7ZKMT97O7o9UAFY+TUitAqMR6+AezzqB8msOa5o7qSlATXw4A8RHYBn50QzLtCL9JpDEYMyS6s3uu1b3mWA6peZlS2o7cS3TYIVyXuDCHorrBFhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=george.kiagiadakis@collabora.com header.b=Wn+ctmsZ; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=george.kiagiadakis@collabora.com header.b="Wn+ctmsZ"
ARC-Seal: i=1; a=rsa-sha256; t=1779979395; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EdKxiP/4wq9nz13t4qLjAiv0q1Z+olflW7IoAv5NaCPi0XwNmrxQ2kwPHm9+VnLK2o3EbjK36WH7dB2TLczFjcydNPS2CWwA6uDmrLrHn/Bp+LIutAZq0pYOHITC9Ky8pBt8H943NEPGzzmTrtjcGbPDqBFGJVxvvjAutiPEge0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779979395; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=bqRrZ/ZT9kobSCQ/vSFrjPw7J2S/QN8pzC52BPuxBS0=; 
	b=Cs0I7//hBaP/Y77WhwIvvtysHGESu3IuV3CaoJTislsq8zq7tTDMgexnDPV1SI3uaJkpSwPJRuzgjH0GR10pv8bOWK6dXsoxzpKvjlGQ9XUh7tFr71JE0n/jTPz8kLevhKlL2lOxnrYLqrW3/Xsfag3fTdco+HSgkCElJuXZP+E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=george.kiagiadakis@collabora.com;
	dmarc=pass header.from=<george.kiagiadakis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779979395;
	s=zohomail; d=collabora.com; i=george.kiagiadakis@collabora.com;
	h=From:From:Content-Type:Content-Transfer-Encoding:Mime-Version:Subject:Subject:Message-Id:Message-Id:Date:Date:To:To:Reply-To:Cc;
	bh=bqRrZ/ZT9kobSCQ/vSFrjPw7J2S/QN8pzC52BPuxBS0=;
	b=Wn+ctmsZ7edKG53O2lZUKyiBEAcm0ADruzu3wNc0EMSJGCdnt0FHxR7akRT7V00i
	bqhLVeJvW2z3XRsxz11KkeQUwj0AIPAB2BW+RdOp4poGXUX3M4NeRUuQnkiAXcRQYEa
	Rkm+dNa92zL86kmSNF+iA62kRRjn52lS02VhTVes=
Received: by mx.zohomail.com with SMTPS id 1779979393910194.44353518649564;
	Thu, 28 May 2026 07:43:13 -0700 (PDT)
From: George Kiagiadakis <george.kiagiadakis@collabora.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: PipeWire & BlueZ face-to-face meetings 29-31st May
Message-Id: <D08B7EE1-2591-4E99-990C-1F991195191A@collabora.com>
Date: Thu, 28 May 2026 16:43:01 +0200
To: linux-bluetooth@vger.kernel.org
X-Mailer: Apple Mail (2.3864.600.51.1.1)

Hello everyone,

Tomorrow and until Sunday we are having a co-located face-to-face =
meeting in Nice for the PipeWire and BlueZ projects (along with other =
events). For more details, see https://embedded-recipes.org/2026/colo/=20=


As a reminder to everyone, the schedule will be as follows:
 * Friday 29th: PipeWire hackfest
 * Saturday 30th: PipeWire hackfest & BlueZ face-to-face (co-located in =
the same room)
 * Sunday 31st: BlueZ face-to-face

The plan is to start on Friday at 9am CEST and we have the room until =
6pm.

I have created a spreadsheet to help us plan the schedule. You can view =
it at:
 - =
https://docs.google.com/spreadsheets/d/137Rxjt1_mIwWkJDCWPI2SPPWPcq3tg3XgF=
CYE2TSw8U/edit?usp=3Dsharing=20

If you are interested in attending the discussions remotely, feel free =
to join us anytime at:
 - =
https://meetings.dialpad.com/room/collabora/pipewire-hackfest-bluez-face-t=
o-face-2026

The online meeting room will be available all 3 days.

Best regards,
George


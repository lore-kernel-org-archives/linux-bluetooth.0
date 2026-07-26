Received: from mails.wedevs.org (mails.wedevs.org [107.172.252.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC9433A70A
	for <linux-bluetooth@vger.kernel.org>; Sun, 26 Jul 2026 20:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=107.172.252.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785099419; cv=none; b=Ywb8kheXXW4LBWzrncXRPU4hJIDJ73QdEFylRRJbNlMe8/3Qx5oxGZcPKRjrPAubEeV1eqSd0xUOhUpGEk0f60Oont93FGyoVTUGmLBkPQ3fCieDZUIuWPnBDg41vYJu/fTUIky5386kt5OH9ee3XZ7r5xAOeknLS5JVPcbmPGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785099419; c=relaxed/simple;
	bh=ECywIikZmMLxN5IlZMaV+SNXfbIFhrqx9i/69S/pLBA=;
	h=Content-Type:MIME-Version:From:To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=crbE5e6R9gCsaokpMWZ+PXllm9Lwz2yOxSlvMv5Cqz1W3qdG56giUV9DqXG2oU7l+JJmif9gQsfzPEljqc2d8OtZKK5OZip5GTPZJD0RLuOYKV7tTRZbkCMCQBCeuxdfmWBQOtQy9a1iLP7NVy170GeDdsa/kQrbjqwbecf9ouY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mails.wedevs.org; spf=pass smtp.mailfrom=mails.wedevs.org; dkim=pass (2048-bit key) header.d=mails.wedevs.org header.i=@mails.wedevs.org header.b=WEamEN5R; dkim=permerror (0-bit key) header.d=mails.wedevs.org header.i=@mails.wedevs.org header.b=VsJqR5sH; arc=none smtp.client-ip=107.172.252.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mails.wedevs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.wedevs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mails.wedevs.org header.i=@mails.wedevs.org header.b="WEamEN5R";
	dkim=permerror (0-bit key) header.d=mails.wedevs.org header.i=@mails.wedevs.org header.b="VsJqR5sH"
DKIM-Signature: v=1; a=rsa-sha256; s=202601r; d=mails.wedevs.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1785099418; bh=ECywIikZmMLxN5IlZMaV+SN
	XfbIFhrqx9i/69S/pLBA=; b=WEamEN5R1R8k574WtnV7iKtyk7invHugVU3Q6yNi+5+s0u/bbB
	4lxIsiMbGpUL9qmuWqC4NBxmspBvfIPl2+o7WiVXFqvOyRjV7UpX4PjSXdPtquRsq0B2FeBsC1T
	KHXOTttvzObi7fnpu/Qq0T8xz3nYz8yGOn0hE0lDFUv64A2RjR5EtPzS6rqSfoc0NhoJLY0yRry
	kTfmlU+XdmPflCfI/8raLFR4Ta8DJ5UPWozXI5BFkeXt4lf+Uz1YWNwDu8uh1rwWpVlmnG009gs
	N7UyzjO2iHIRvLeCDU7AZyCo0ZejzolgHrUtvuUU9LfO2+uMb2loLHZ+qqTTk+2MGFA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202601e; d=mails.wedevs.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1785099418; bh=ECywIikZmMLxN5IlZMaV+SN
	XfbIFhrqx9i/69S/pLBA=; b=VsJqR5sHDfmC+4B1RMhTE1Ivp1uTRJznsrikcettMW8SBiUXB1
	LhRAflX4DE6hlKfqLiWDpPQgWElL+SZCSyAg==;
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Bug Report <bugreport@mails.wedevs.org>
To: linux-bluetooth@vger.kernel.org
Subject: [Bug] Intel AX200 Bluetooth (8087:0029) firmware download failure -19
 on MECHREVO WUJIE15XA
Date: Mon, 27 Jul 2026 04:56:55 +0800
Message-ID: <178509941543.717042.15160055403720914460@mails.wedevs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

SGksCgpPbiBhIE1FQ0hSRVZPIFdVSklFMTVYQSBsYXB0b3AsIHRoZSBJbnRlbCBBWDIwMCBCbHVl
dG9vdGgKY29udHJvbGxlciAoVVNCIElEIDgwODc6MDAyOSkgZmFpbHMgdG8gaW5pdGlhbGl6ZToK
CiAgQmx1ZXRvb3RoOiBoY2kwOiBGVyBkb3dubG9hZCBlcnJvciByZWNvdmVyeSBmYWlsZWQgKC0x
OSkKICBCbHVldG9vdGg6IGhjaTA6IHNlbmRpbmcgZnJhbWUgZmFpbGVkICgtMTkpCiAgQmx1ZXRv
b3RoOiBoY2kwOiBSZWFkaW5nIHN1cHBvcnRlZCBmZWF0dXJlcyBmYWlsZWQgKC0xOSkKICBCbHVl
dG9vdGg6IGhjaTA6IEhDSSBMRSBDb2RlZCBQSFkgZmVhdHVyZSBiaXQgaXMgc2V0LCBidXQgaXRz
IHVzYWdlIGlzIG5vdCBzdXBwb3J0ZWQuCgpUaGUgV2lGaSBzaWRlIChpd2x3aWZpKSB3b3JrcyBm
aW5lIGFuZCBjb25uZWN0cyBub3JtYWxseS4KCktlcm5lbDogTGludXggZGUgNi4xMi45NitkZWIx
My1hbWQ2NCAjMSBTTVAgUFJFRU1QVF9EWU5BTUlDIERlYmlhbiA2LjEyLjk2LTEgKDIwMjYtMDct
MjApIHg4Nl82NCBHTlUvTGludXgKRmlybXdhcmU6IGZpcm13YXJlLWFtZC1ncmFwaGljcyAyMDI2
MDUxOS0xfmJwbzEzKzEKbHN1c2I6IEJ1cyAwMDEgRGV2aWNlIDAwNDogSUQgODA4NzowMDI5IElu
dGVsIENvcnAuIEFYMjAwIEJsdWV0b290aAoKLTE5ICgtRU5PREVWKSBzdWdnZXN0cyB0aGUgQmx1
ZXRvb3RoIGNvbnRyb2xsZXIgaXMgbm90IHJlc3BvbmRpbmcKdG8gZmlybXdhcmUgZG93bmxvYWQg
cmVxdWVzdHMuIFRoaXMgaXMgYSBkdWFsLWJhbmQgQVgyMDAgbW9kdWxlCndoZXJlIG9ubHkgV2lG
aSB3b3Jrcy4KCkFueSBzdWdnZXN0aW9ucyBmb3IgZnVydGhlciBkZWJ1Z2dpbmc/

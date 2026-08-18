Received: from sender-of-o59.zoho.eu (sender-of-o59.zoho.eu [136.143.169.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9053A47ACE9
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787070334; cv=pass; b=KuoRAjcAncWJrvQDKFU5hbLh78FJK5JJKYkh4YPoZQqOBcfud+DcqbU21R6B+3tGzDUrVICivfOO6XCIr+J1rNI8nMVfKnX5c0MJ1k/NZKMg8z9YDzGatd4gwznFK1BG4qO9keRBud86LLA/W9voSLKM3QqzovKzCKxzXmwCjYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787070334; c=relaxed/simple;
	bh=JcRm3Eu1x2kuQggo28Y7ULyNVyEzHJMSHw04nnLd5jU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jgI9P25GLFuZVQt+cjXOgGrGbSx6v3oThDM1rTb+DLTMlpCp0N3jksI8Pw8RKK6Ov39a5TgtMNd8bXlAtTWsvGjZbs5YJ+qPFAofbE4/JNBNIAklZrVZ5Yu2uWx18NJGwzBhsJylFBkBhkzZJmcnyPWig92J/TCNfN0OXurVV+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=Q3BOSsuw; arc=pass smtp.client-ip=136.143.169.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="Q3BOSsuw"
ARC-Seal: i=1; a=rsa-sha256; t=1787070316; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=NfyIB4T56rw+WDS0KPfTH3zWpj8oEwDl6hH2y5Xpr3gXWtKO2rP+YM1O4+EsrHbQsCymKAszifzbhvVjjxjiXIOJVcUNzJl0oSEhIvmsIyGhJ2dlN7cSWUO363AoqC/SDx6qRcEsuP/ZKg7TzOSLQmln4NLxnIBFQJzap5OEy4U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1787070316; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JcRm3Eu1x2kuQggo28Y7ULyNVyEzHJMSHw04nnLd5jU=; 
	b=YHxvtvrlOUR8K4aXA96+BkT6f4XY1iKM7U8wbAIcC7z6cKhG9CfqDUu75OLll9qEUGFGeKEC3WhFpYfZQzFJr19ObTDEFUwxYcPHY0ze0XrUM10LbEInzYvUVWKth5pGubv8kYmiGBK5Qwdgasfo73sdQ+zZGx8BwrNCZE3+wqE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787070316;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=JcRm3Eu1x2kuQggo28Y7ULyNVyEzHJMSHw04nnLd5jU=;
	b=Q3BOSsuwPn7Kn7ytF15ZKE08+jtXrcjvomt/RZqEnTw5S1+SXTCOuunAgkfHa1EC
	k8bjtvj4WTNbEWBefiyBtGmUkr5W+rngx+eDHLxVyaEM8Y4L7MO47AQoU5wTBenquRb
	OYtLYbkTweLJDpZ/HcnkYW/SBFM5+BZJxNbQzxYE=
Received: by mx.zoho.eu with SMTPS id 1787070313451397.4724743764061;
	Tue, 18 Aug 2026 18:25:13 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: neeraj.sanjaykale@nxp.com,
	amitkumar.karwar@nxp.com,
	marcel@holtmann.org,
	alex.zhou@nxp.com,
	song.xue_1@nxp.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btnxpuart: Keep FW dump header in coredump chunks
Date: Tue, 18 Aug 2026 16:24:30 +0000
Message-ID: <20260818162501.584425-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CABBYNZ+yDwFJ7YFB60-SG6Tr1R+6BeE1E=06d5+UEK_y4j7g+Q@mail.gmail.com>
References: <AS4PR04MB969206113CDC2F5C66994E6EE7A62@AS4PR04MB9692.eurprd04.prod.outlook.com> <20260818080104.563675-1-ali@iusegentoo.com> <CABBYNZ+yDwFJ7YFB60-SG6Tr1R+6BeE1E=06d5+UEK_y4j7g+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Luiz,

On Tue, Aug 18, 2026 at 11:51 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Ok, but if that is the case why are we parsing the headers in the
> kernel? I thought the idea was that the kernel would assemble all the
> segments and then push the dump as a whole. However, the above
> suggests the NXP FW analyzer expects the headers. In that case I would
> just have each segment reported on its own rather than appending it to
> a separate skb including the headers.

The two fields are not just optional parsing for a concatenated
dump. They are what the driver uses to handle the dump state.

seq_num == 0x0001 tells us that a new dump has started, so
hci_devcd_init() is called. buf_len == 0 marks the end of the dump,
so hci_devcd_complete() is called.

The chunks are passed to hci_devcd_append() as they
arrive. nxp_process_fw_dump() does not check whether the dump is
currently active before calling it. That state is handled by the
coredump code itself.

> Id argue that this should be appended as is then, and the analyzer
> should be the one checking it, _or_ it needs changing and then it only
> process the dump _after_ reassemble.

The driver also does not otherwise interpret the chunk contents. It
does not validate the payload length against buf_len, slice the
payload, or remove anything from it. Once the chunk is long enough
to contain the header, the whole skb is passed to hci_devcd_append()
as-is, including the header.

So the length check is only there to make reading seq_num and buf_len
safe. It does not change what gets appended.

The only packets we drop are those that are too short to contain
the header. Without the header, there is no seq_num or buf_len,
so we cannot determine whether the packet starts or ends a dump.

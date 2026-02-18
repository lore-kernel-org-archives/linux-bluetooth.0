Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E3D35966
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 02:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771382802; cv=none; b=d3x2g0pan3W77q+WzCWnlSOrv5JWIG7z+fGI96qiKMTn4RWSM5wIvlSo71ykiAgiON3TjRxwz+JlCtfz6OMnmQtegp1zV3B7ItoLizsUnXht5fQ5N5IY3ufKL3blKmnG8CAgzeoKI0FVf2NxaD9lvami6VHm8DgC+jloNyKb/Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771382802; c=relaxed/simple;
	bh=WK4avjGl1XEI46lBrG/VraGL4nl//x8Ai0b3HHS4T1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=risamsOfXUjsZsAPRlNSde9lHNWmQ+3JQUsCEgzSYvfRArn+gTP5nF02swIKiV5XZHXm7LQcIKzXhtbLUuz92pgEL/MV7kJCtl79KEQZ1+w7r7vc2HyErq51Gui6J85h4WgPvkcs+xcDvnSb2l62Ccj5lIbIMoZSk0wrMrLVFpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rjp.ie; spf=pass smtp.mailfrom=rjp.ie; dkim=pass (1024-bit key) header.d=rjp.ie header.i=@rjp.ie header.b=J/g49o9O; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rjp.ie
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjp.ie
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rjp.ie header.i=@rjp.ie header.b="J/g49o9O"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
	t=1771382798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nI4faPd2ZlM3MNNcx4921MgeUBOXEQV0/tzgJpoNbHM=;
	b=J/g49o9OiE8FZvauztiu0H+YXlHjF0OlRrwasVBRNrLBBc7AuYgVuRworllTljQjEO0btH
	PfeGQrKzcFaLrs26trSxR+DZ1veRSV0/w9Gi64shUuOvIZBh3OaNXAZdH8OdMlZWcMNpqb
	bX5ouTIaLwY1T5kECWJZo1AHFNhWHfA=
From: Ronan Pigott <ronan@rjp.ie>
To: linux-bluetooth@vger.kernel.org
Cc: Ronan Pigott <ronan@rjp.ie>
Subject: [PATCH BlueZ 0/2] shared: recover from failed input initialization
Date: Tue, 17 Feb 2026 19:32:58 -0700
Message-ID: <20260218024605.70890-1-ronan@rjp.ie>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This fixes an issue where bluetoothctl stopped printing values outside
of the shell. I reported this in [1] and bisected the error to commit
e73bf582dae60356641a32fc27ae03d359ec4c47.

My motivation is to keep the zsh completions functional, so I have also
included a few small fixes for the zsh completions.

I saw that another patch was submitted which unfortunately is not a
satisfactory resolution, since it causes bluetoothctl to print all the
extraneous lines present in the interactive session for non-interactive
sessions as well. So I have submitted this suggestion instead.

[1] https://github.com/bluez/bluez/issues/1896

Ronan Pigott (2):
  zsh: amend completions
  shared/shell: gracefully recover from failed input initialization

 completion/zsh/_bluetoothctl | 133 ++++++++++++++++-------------------
 src/shared/shell.c           |  23 ++++--
 2 files changed, 79 insertions(+), 77 deletions(-)

-- 
2.53.0


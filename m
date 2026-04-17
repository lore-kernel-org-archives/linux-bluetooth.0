Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F072373BF4
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 12:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776427909; cv=none; b=dtqtb5JteqA9t0J7iqi6yFWqt2YDDt5JSITB7wODuIPQKlZAxfXfx3eNhDcDjecy166AGnIt5n2ahqrRSy3fphrIZPH9zZpau0FIeLLy33zAJwYn2ZXPCXQHqgd27Pk2/mgblR7IPwCVdmSf/Mi+aa1HzM7FvKaOI6d921gqajA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776427909; c=relaxed/simple;
	bh=TQj+kX7VHg8LOp0LLYISrBHItZOP8r1rxAHoYApaXmM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=T1F54w7arpdElExUBJBNQO+TTh55R1CkE0WH+mujKHO5gbJf7O/B8D5eyfiomtjS8LJJxrDQA3J1PxvAnai0PVzW0xkssJHgR6cQQ9p+qBQqxExTPlcQpjqlNjLqAxW07nDPrvnrxPDaa3yzWm2AVvxESt20rQSRgdEXZo3CXpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SwEg2RV5; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SwEg2RV5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776427907;
	bh=20sqwPeRn43N5QovOFfbrkoAHfsxWf1FQ8Z02A5pD9o=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SwEg2RV5NXcxFx9HTUGpLm8CZlQ6haei1KfW1eZ1DDr+p0eJa3YMLlIS4O+Vmdonn
	 kCc4TEe7THvI9yB5aRyGb30Y6bXu9G9RsXHLE9oZ+n1KwI9dwp/D0geZIhBPRJW7j/
	 a83jmTQf23mpulACHsWLWODjigSJ49k/gyFfdwGs=
Received: from github.com (hubbernetes-node-63e25fe.ac4-iad.github.net [10.52.85.58])
	by smtp.github.com (Postfix) with ESMTPA id AA5D8941177
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 05:11:47 -0700 (PDT)
Date: Fri, 17 Apr 2026 05:11:47 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1082418/5bea6e-000000@github.com>
Subject: [bluez/bluez]
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1082418
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

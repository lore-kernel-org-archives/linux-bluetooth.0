Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10873DFC6A
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776348634; cv=none; b=XIV0tql3UvyQh/aN6e2oUxVodOFwQ8g2ldjDJCxAhhz06rAiBkebgHUQKP/RwYkkxz2IqpAM1kv5AC/+EaI9DIolSywjf+8LDUtXjz2buYNQ4aGE/EDqJDIJGAQEf3JCtKh46KDAfroZ2j0RJh7TrONyENHZd3h2qRKZGCURbyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776348634; c=relaxed/simple;
	bh=9rCrKs5RpPc//72rupGqFzRB3Q6dhCudINu8GhulcFI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kJ4GJgVwmd5Co8Xaiixxay947uPqOcAjjkweVcLH049XEyBofmSXLK5t0WXjIfHRnGELuxxEV1Sd/BewPpT+du8xD8tx4Z/wRpZtVfEreDA2VwUpwX6KJfvlsa0Rh78SoVdz7tYyXhYqYKcHEGX8dnJhsSoM9PMwvBf93CGWu9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id E07893EC53
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 14:10:29 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/3] Remove glib dep from non-glib shared library
Date: Thu, 16 Apr 2026 16:08:39 +0200
Message-ID: <20260416141021.3970323-1-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTEzq7ptM8wmadsYLLOrORSJTkQ+tgRoipMyo+JFHr9M75xWgQFZEH1vhv0q7StTbJCWhFyq8Su1YjNEeX4Xsjw/VttfyJqlKmdSLfe8CYRZZn3c7mvnC8L/f8v7SEr579QYWlS75OK1j/dKJVFQ08/HVKc3VDpDE3GJfbbIs24jlgpR0diNp8yTG8YKTelEXSFvolYGTWIIdxmLuFOtJVWbcVoINCYass/DkVVwrWTt8FpkIygF/o+NdIHwd7OyNjO8E0hzGX/VgCMpebWDqD+WEHVT3pNUIkizMfvk5Q17nNqFbZ5bbSWejdBmNvSs+fKcPgP5RHktVTgPD4gdsHBtqIF6WlahVdvtO0fEox4YE0A+DKpR9yywxj4d0u3ek0MyCPZBsicS1DLyC9Fu9ySHZCpqaTEyP8LrH8Dg+rgfkq41TOzav8UsTDer5az2ce/xVHrgaO4WQqOEDaEm8aVQzpor+cts5YUUOfUpUGc4SxplCI2mbbgERRy1wPmkAIm1ldLBjwfP/09WGGJZhjfkLHLk8SURllKUh7xgsFf/b6FRSOHRQnPGT9uX681Y56ufjrxBXf9TS26X6HE+TTyus/Wid0nsCDLnQCZa//YI/QyO/BOk1ZVGqKw4EojknkN3QHVTw5hACfFEEps4V0/wHq1M4j38BRjWXxBzcFCzMw

Changes since v1:
- remove queue_peek_head_entry() patch, we already had similar API

Bastien Nocera (3):
  shared: Remove glib dependency from src/shared/ad.c
  shared/queue: Fix warning when compiling ad.c
  shared: Remove unneeded glib includes

 plugins/neard.c    |  4 ++--
 src/adapter.c      | 10 +++++-----
 src/device.c       | 29 +++++++++++++++--------------
 src/device.h       | 10 ++++++----
 src/eir.c          | 41 ++++++++++++++++++++++-------------------
 src/eir.h          | 11 +++++------
 src/shared/csip.c  |  2 --
 src/shared/queue.h |  2 ++
 src/shared/rap.c   |  1 -
 unit/test-eir.c    | 29 ++++++++++++++---------------
 10 files changed, 71 insertions(+), 68 deletions(-)

-- 
2.53.0


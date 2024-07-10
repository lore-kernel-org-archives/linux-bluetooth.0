Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686B83BBED
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 18:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720635497; cv=none; b=iEghATk6zAlJD3KdKncVeocKyOi3pqKtrq8jtKkS76/q6Vc/L+Vi7xk/e6J6VfemOsMzMKsTFGrpdCbTe0qiaS6hdC9LW86zt+wM5R6tUqelV8jkHWWObKm62/vQDLUJcxErk5ycphyi74xF+UYpm1NbO6BLY/1Jg8cA5w9SGBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720635497; c=relaxed/simple;
	bh=zzOFJbpDrE90ZT/Yamv130qgAYLTexVdBRA0RSKbzlk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZLzGVzQJVooV4uoQZzCJRpdrg9IU9+yn/e1Xph5cWFzi7et2SEfAWcLCW2Y75hKgEDYv8DRWIn2qWcADllKXMQH7YDeri6Ldo979Rz7Fk/Oo0AfeLeKaOdV4jaw0nEMJvO2itF6vzN1AMOOzSoxLvzjQ378ey+q5wDzzaNhQIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sandhuservices.dev; spf=pass smtp.mailfrom=sandhuservices.dev; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sandhuservices.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandhuservices.dev
Date: Wed, 10 Jul 2024 18:18:01 +0000
To: linux-bluetooth@vger.kernel.org
From: Rahul Sandhu <rahul@sandhuservices.dev>
Cc: Rahul Sandhu <rahul@sandhuservices.dev>
Subject: Re: [PATCH BlueZ] tools/hex2hcd: fix musl compatibility
Message-ID: <20240710181803.24275-1-rahul@sandhuservices.dev>
In-Reply-To: <20240710165459.26813-1-rahul@sandhuservices.dev>
References: <20240710165459.26813-1-rahul@sandhuservices.dev>
Feedback-ID: 82291650:user:proton
X-Pm-Message-ID: 3556d195c82eeb30bb482caf7bc8f64cd2892f34
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello, I made a mistake generating the V2 patch. Sincere apologies. Please =
disregard this thread. I will generate V3 shortly.


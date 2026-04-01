Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313C23DD53F
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775058787; cv=none; b=cE7/DrsrfYc8+S1fHOkSaIQQqgnu17QXSTiSuIAVZAz8Al4X16kgIFWB1VD+vYE4VINjvGFsdG+OrPuCmVXkPYdUYPvwL1KqnsY3+BPCyvlKvCL/0WyIIgiAsHAfS9e8fjqm6Ew4lDg2kXRywpboTIiKPyJTTf9RH9bsP7HlPMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775058787; c=relaxed/simple;
	bh=cyXwWWZt7Hnjt7foKUmSN5bkri03ItG2zyjWaIBKq1c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=I3CVxJRJE2ZVBWqu9T3e2zxYhTlrZPmYQVnEio7ULMZ2NH2HQ1iVfCOxAJXhwrTKLKDoxLgefUMGwi5Bof4qYZnXpphrUuPcsp/7/8gPZDI/8+KczU98kpNPBP+gL5GDJ8IeIpnxEQatYubY78XJBmw1EMLMwC7IUa/lEw0tVZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbAaglQt; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbAaglQt"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2b4520f6b32so7955088eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Apr 2026 08:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775058785; x=1775663585; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IhelzMsajZXruAY8FUddWyuuuWEvG65kW/flkTqt4Ls=;
        b=UbAaglQtQC+NzcB1ljCm1f/Zd5fDlcl9tKxfX6d7aohTOxJ1wsveGXqnzXOEsrH88J
         k4letYzkLdHhoX5ovyuQaSRBhs3OPBAwXVQ8Dpkis9PjdQQc3pbV73esuDJf0nO+wlxt
         CukLksdnSqO0dcPIvfEC+ho2nPcIAjtihT3goumwm6mGMfYKTw2FmRuyyaz8IHJ93k+k
         95yPb2Fw0LjnN9f6NQLaigJI7RSxoDK50472cOvG4KWR5XeGQUUvLlg4PvGN+OS1AJJS
         GFmZ1seTSeCey8np3d/aSuEOsdGguCthFgumtNZ6F9rWjpNUSJ6vZ00dSYLWSfPjWoH2
         dVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775058785; x=1775663585;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhelzMsajZXruAY8FUddWyuuuWEvG65kW/flkTqt4Ls=;
        b=reZ10jHD2RQVwTvgJYKyyvySd3XdQlqVwiBl/tLaaimUgIlK2SgjABkodzZtD0c+uw
         83H6nEsx7cQ3NFOCOBsfZZ1Z9RYfq7e20ZtSbJqbuqIHZAka5tHD1UC2JVGjdSvivx+T
         dNCMyeofAvGoxwmTJVKC3STMMLaJDtcD5Q4XVj2+TiYO7IClp6sIm/m9DXNUdcn7sDDB
         1B0DdM4Ya7etldc1agLqYM4HlYHou6iVNMe3M/lsz/2LnOANgltiUyw51xmXCnCuNbYy
         GlBEeXjkuaU4W0iKbz5wpTQgdmK+kOsi5V7dP3yZGlfc2NF88OEsJC6hnNs/nSIga0/1
         6YNw==
X-Gm-Message-State: AOJu0Yz2PZtKcpqYjJYXu1jAm04XzzN4xD0waRdPXGt+DprttWUqOccY
	MTTYKbgX0IPp93sLFISdV4pcN3QEmLqt+bDWO5lMb3DbzKpTkaTpaFqxOXUq/g==
X-Gm-Gg: ATEYQzwSFgX7XbYHwh3wCizB5k4cK2LJwavxO5FFpwLUSOfA9WYwpjZk/wBfBygsMGr
	IP2rqMcohvoUVfPNiOudimrSS5srNEVtcKxP6IvI5NWGSaBLZo+gkoBLaiEa6soscoSVSC7Z62D
	Ru9H+jRPIvL6tTpL9syHrevvC3yxp4lS8Za95q8zeelhdR24w8gapsjWyLk/fDepRnr3ZbgSa2E
	eaKIKRsho3KMsDiGjbxXqhRzTnMI0/Er7XBUim7mQThg5S8Orx7SzF7cB51xIPimGG9nEcUSIGT
	P408EaQxKZgIb48+T/+GQWmVg1rSzF4sQFEq4iQqQTFSb9zUmh9u8+2FG4iwBGwO43Kn6YIBIhn
	t1OA4P1VkkF3A8TJmgUOlXxX++a4UXGPBJPOhO3M3iOY+0ni426plEdLnEu/j6NoVws56UNpjKW
	XUWgR3lTkY0rXleUoUKoMmarysJptj
X-Received: by 2002:a05:7300:fd0e:b0:2ba:a2fb:403f with SMTP id 5a478bee46e88-2c9329a0cc6mr2416349eec.21.1775058784943;
        Wed, 01 Apr 2026 08:53:04 -0700 (PDT)
Received: from [172.17.0.2] ([57.151.138.8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca78df3b84sm105447eec.5.2026.04.01.08.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 08:53:04 -0700 (PDT)
Message-ID: <69cd3f60.050a0220.a5617.7a96@mx.google.com>
Date: Wed, 01 Apr 2026 08:53:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5072694492312775995=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] shared/gatt-server: Add bt_gatt_server_set_permissions
In-Reply-To: <20260401142627.1944044-1-luiz.dentz@gmail.com>
References: <20260401142627.1944044-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5072694492312775995==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1075892

---Test result---

Test Summary:
CheckPatch                    PENDING   0.45 seconds
GitLint                       PENDING   0.57 seconds
BuildEll                      PASS      20.66 seconds
BluezMake                     PASS      646.60 seconds
MakeCheck                     PASS      18.67 seconds
MakeDistcheck                 PASS      245.24 seconds
CheckValgrind                 PASS      292.95 seconds
CheckSmatch                   WARNING   347.01 seconds
bluezmakeextell               PASS      181.08 seconds
IncrementalBuild              PENDING   0.39 seconds
ScanBuild                     PASS      1020.38 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/gatt-server.c:279:25: warning: Variable length array is used.src/shared/gatt-server.c:622:25: warning: Variable length array is used.src/shared/gatt-server.c:720:25: warning: Variable length array is used.src/shared/gatt-server.c:279:25: warning: Variable length array is used.src/shared/gatt-server.c:622:25: warning: Variable length array is used.src/shared/gatt-server.c:720:25: warning: Variable length array is used.src/shared/gatt-server.c:279:25: warning: Variable length array is used.src/shared/gatt-server.c:622:25: warning: Variable length array is used.src/shared/gatt-server.c:720:25: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



https://github.com/bluez/bluez/pull/2000/checks

---
Regards,
Linux Bluetooth


--===============5072694492312775995==--

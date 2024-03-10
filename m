Received: from relay-b02.edpnet.be (relay-b02.edpnet.be [212.71.1.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6725F14011
	for <linux-bluetooth@vger.kernel.org>; Sun, 10 Mar 2024 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.71.1.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710081428; cv=none; b=Tj9q5SD7nnncaenB4UiAmTFSmM27MICIZpXj5FgRxql/oB5bB3XIOgWrGFhdBlLAof7bomtUXE4n7Y18sQlX/os9KrZttILB5agN1wCDQA4q2s8NlKgUHQMMvD0Cy/7/b0K/THRdfctdzUu7lBuHLNR6GAn0M8zk3FMPrwo/g9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710081428; c=relaxed/simple;
	bh=1trfzmTGNTDJ39yuyVSHqNVYSI3qJNFwIoOyfNW1Ncc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=fs5HZRogX2Ix0a5LpuI9NuT1dguJQ4iA6ZK2wmwj1uBxPSTfeq3wQT+lTSF9defQEVGtkCB8CvNdIxULlrC8TX0DLiPuq4aljpBjHcHC/5DHWo6moimZvYM2NG1uM+1jUoMSdQIcZqiJ5RSiXDlEymbVmSYbgHzhuecIHYtej0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kabelmail.de; spf=fail smtp.mailfrom=kabelmail.de; arc=none smtp.client-ip=212.71.1.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kabelmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kabelmail.de
X-ASG-Debug-ID: 1710080766-214fdf1bd810c070001-Y6scnF
Received: from [192.168.177.53] (212.233.35.143.adsl.dyn.edpnet.net [212.233.35.143]) by relay-b02.edpnet.be with ESMTP id w14pgzam73Ql8lTI for <linux-bluetooth@vger.kernel.org>; Sun, 10 Mar 2024 15:26:06 +0100 (CET)
X-Barracuda-Envelope-From: janpieter.sollie@kabelmail.de
X-Barracuda-Effective-Source-IP: 212.233.35.143.adsl.dyn.edpnet.net[212.233.35.143]
X-Barracuda-Apparent-Source-IP: 212.233.35.143
Message-ID: <4fe6b834-e48c-405c-879a-151cf994d8b5@kabelmail.de>
Date: Sun, 10 Mar 2024 15:25:57 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: nl
To: linux-bluetooth@vger.kernel.org
From: Janpieter Sollie <janpieter.sollie@kabelmail.de>
Subject: android pairing: the mystery
Autocrypt: addr=janpieter.sollie@kabelmail.de; keydata=
 xsBNBFhRXM0BCADnifwYnfbhQtJso1eeT+fjEDJh8OY5rwfvAbOhHyy003MJ82svXPmM/hUS
 C6hZjkE4kR7k2O2r+Ev6abRSlM6s6rJ/ZftmwOA7E8vdSkrFDNqRYL7P18+Iq/jM/t/6lsZv
 O+YcjF/gGmzfOCZ5AByQyLGmh5ZI3vpqJarXskrfi1QiZFeCG4H5WpMInml6NzeTpwFMdJaM
 JCr3BwnCyR+zeev7ROEWyVRcsj8ufW8ZLOrML9Q5QVjH7tkwzoedOc5UMv80uTaA5YaC1GcZ
 57dAna6S1KWy5zx8VaHwXBwbXhDHWvZP318um2BxeTZbl21yXJrUMbYpaoLJzA5ZaoCFABEB
 AAHNMEphbnBpZXRlciBTb2xsaWUgPGphbnBpZXRlci5zb2xsaWVAa2FiZWxtYWlsLmRlPsLA
 pwQTAQgAUQIbIwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAUJD6DYHRYhBGBBYpsrUd7LDG6r
 UrFUjEUPH5JbBQJlAXcQEhhoa3A6Ly9wZ3AubWl0LmVkdQAKCRCxVIxFDx+SW3oXB/9A4g3v
 /Mq6uZlBDWBrQ98AFhlkRLwI2mDiNOlP4zJlejqt8S2GvCvhiQAtXV0BSl42sHo9Uxda8sZM
 d1eOU+oPexaK9iryCEYvOj+IK+n/rR8kyH5P7lzdpHIKYGtZ2y2NtpEuIA9A28MvliGjutJ2
 QIAdUaO1GdFVHXvHConuXvBfpmJsBhJeVfoTdzrTlloFTloCC+00a6Q6ndGnwzQQVgfgzRtq
 +x3O8smVnzsHb7Wu25+sbJl55GONAqyxuRmAF8IB4HAQ9gjgiCxTfjhCt9rhXQgPlT8EAuKT
 9MohNtqpXXZFpuQUYRMEqpM7mPfbm4L8fXiPv/szVM0ZIwVCzsBNBFhRXM0BCAD2fJkCQE6L
 UjUpVltzXjxeRTNQK/W3PC1i3EsjHFSJT04MY12zmXWI0ItNqnRaB2c/X/rtWTuYazSsgQTQ
 P/qZSts2890GD51y3BAw443rN0plVp4dX6JG/p3V0ha7rXwFjn4Hzgt4IDJSVuNa9nGEceId
 qTnvZO+F4ukgzV2YVAUWcuDowCBDfRm3yU0GU3rxOHfBTpYwljqFWbGqijsTjF1/Le4ULF+q
 HUQqwTDY1ijpxRCIeu46WoQEf5Dv0aTIwOJgPK8229uRDHlHhMPvXpqtBYKwQ/rOCz7EfITD
 lPsHhjnqR+mjeLy7tK/qIyaE7A8HTdoxYoYhAR+AqylRABEBAAHCwHwEGAEIACYCGwwWIQRg
 QWKbK1Heywxuq1KxVIxFDx+SWwUCXowzcAUJD6DYIwAKCRCxVIxFDx+SW1J3CADK79k3T1La
 jEHZGkxWPoAuixN8F6pf7hnofoR2KFkMbQk+9WYfiGsOcZwJjiUyQgiaSZcdz6QGkGPDjfLL
 iNDKvGGGAgRT99ruA4uyfAXjObbrMp8VGr0fI6eRF3nWuh5Rk4W2DY/wjaygA0FJ/vpw8XFs
 9NycYvk7yPcXW29N6/56TIc1I7SxmsEzwriGxvuRNZBzuNsEvdgzkF0kTL4nMhH/olPFW1+f
 2Y0kA3aAa1ZyjzHsgDUBSKyv35MJRxPLkLK4I/5DisNfjfygE/gvSh+Iss+ZqtZhYzR9oA6k
 mg7rIQaHeVNOBwFsmkHmXDmH5beCJsgB6hwxiQAUaOaO
X-ASG-Orig-Subj: android pairing: the mystery
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Barracuda-Connect: 212.233.35.143.adsl.dyn.edpnet.net[212.233.35.143]
X-Barracuda-Start-Time: 1710080766
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1161
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.121927
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

Hi everyone,

Does anybody know what bluez needs to actually pair an android device?
I tried on a x86_64 and arm64 device with bluez 5.72, but could not get the pairing done from 
android side.
on a lineageos android 13 device, it starts pairing, and according to bluetoothctl, everything 
is fine (even without passkey), but the lineageos device never sees the pairing process as 
completed, even when trusting it
on a samsung android 13 device, it (sometimes) requests a passkey, but after confirming, the 
process is the same.

Are there some specific requirements bluez needs to obey in order to accept android 13 connections?
in a desperate attempt to find something useful, I captured a btmon of both devices' connection 
attempt (twice), only to realize I didn't get any further at all:
Samsung tablet device: Tab S7 van Janpieter(C4:18:E9:70:05:64)
https://pastebin.com/Jn4rackQ
Lineageos 17 device: aptx.sniff.trojan.root.exploit (4C:02:20:92:13:5C):
https://pastebin.com/izqpZJTS

So my last idea would be to find a set of requirements Android 13 has for bluetooth connections.
Are there any?

Kind regards,

Janpieter Sollie

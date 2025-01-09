Received: from qs51p00im-qukt01071901.me.com (qs51p00im-qukt01071901.me.com [17.57.155.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EA819CC14
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jan 2025 06:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736404584; cv=none; b=ZVP1DRBQeWe+PSY7/Jhz+6oXWNMNi4JELAQCAluYiCsxB3sencB8OhIJa9omiEzfXrsQ6UNZHk8TUd+a1XdkEgDwINC00TV2lvTUEB9R+11KctI7nKEkwy0JsCMpjE9kxXEpN+k53aM8IUSmHF04w7bOWSd1XL/y5eU7aKY8slQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736404584; c=relaxed/simple;
	bh=Iviifxl9Ai3uMy0C3x/wc3DRdLl1gwTcV109Vxjwlzk=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=K9RwFFnoKASRobLQYK8roFx++v1DYBkgZtvaXgH4IdJlCVHU7lwLTcnsq6alXyGbP9aksaxdHgZS25Xdce4VN25XonQorq2k1yOb0Ov/xtC9PKIbXFO+9I/XAcwvjPNXuJLilX0l7otvxqOVkTrFuq/zICa3UCSnw5TiTKgrgtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=yRmhjLx1; arc=none smtp.client-ip=17.57.155.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="yRmhjLx1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1736404582;
	bh=DecwZB3rQj5tzRSiij8skl3A0AWQofuqeEUwolwApbA=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type:
	 x-icloud-hme;
	b=yRmhjLx11btnLMKOQoM7CQAVnnX+ZpR0jZ9NpBkSgoxQjdxmp6z7a2ktLy0AjsT4n
	 6swfKLekaf9y2E3qWWyBuyOm1AU2cdjZIV/b/O9pKexPKtrUqC/RqMZCHoeYyd+lIT
	 v4u0/z8co+bjR/POO6wxP28rrboZyGpCyePlmoD04MCHHPoat8gHR8s0gNL4wNtb5S
	 YVOBiZb3dfH8KqmJ/LzHWm/KAGPwey5hVUc6ahetD3NkNZatwLmQkzicONjgqC+OcL
	 d5I7rW+5l7u7v6f0eVllpfO+/ej3VYxdeSycDxOu245V3yjfKRupv4Agtkat/CISQ1
	 VcdzZdQBxL6Jw==
Received: from [192.168.86.109] (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01071901.me.com (Postfix) with ESMTPSA id 84BB7628012C
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jan 2025 06:36:21 +0000 (UTC)
Message-ID: <87589eb5-a6ae-4987-88e1-dc4bc67b085d@icloud.com>
Date: Thu, 9 Jan 2025 01:36:20 -0500
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Icedove Daily
Content-Language: en-US
From: Andrew Wong <wongandj@icloud.com>
To: linux-bluetooth@vger.kernel.org
Subject: BUG: Undocumented "Enable" Config Variable
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: nhgKiaaJ8bw57sHvTkwWl4sqQIuZgoeq
X-Proofpoint-GUID: nhgKiaaJ8bw57sHvTkwWl4sqQIuZgoeq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-09_02,2025-01-09_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 suspectscore=0 clxscore=1011 malwarescore=0 phishscore=0 spamscore=0
 mlxlogscore=459 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2501090052

Hello,

I hope this is the right place for bug reports--I think I've found an 
undocumented config option. I've been adding the line 
"Enable=Control,Gateway,Headset,Media,Sink,Socket,Source" to my 
/etc/Bluetooth/main.conf file as suggested by the Arch Wiki[1] in order 
to get my Bluetooth headset* to work--and it indeed does as the wiki 
described. However, in trying to find the provenance of this config 
option, I've turned up nothing. I've tried grepping the source code of 
the latest git, the version my system* uses, even the version from 
around 2014, when the Wiki's cited Gentoo forums post was 
made--unfortunately, it seems that I don't have the "developer 
intuition" to figure it out. Could anyone advise?

Andrew

*My system is the latest GNU Guix, with blueZ 5.72.

[1] 
https://wiki.archlinux.org/title/Bluetooth_headset#Connecting_works,_but_the_device_does_not_show_up_in_PulseAudio_sinks


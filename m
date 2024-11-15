Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3416D183CC7;
	Fri, 15 Nov 2024 07:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655652; cv=none; b=mgJXYsatIzmKu+mwjZsh3UkJA76Gc07MY1T5C0fmrJ6A2M5z31zNgv8MYHTBXXUnENHSEOTmjtTyVCt6kXOS1GN5j5MHkrl/HBPefwjRe7X1BSH6/G7A2e+67ZCKZll+q53Y7GzzC1xgzuGE0SIW1XVsDFpKBlnlgAvH6oa5lnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655652; c=relaxed/simple;
	bh=Sa90FOF3ZCw78OsaCzV54IiZx5tvk9l7aqFRB3SmkUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EykTs0vntOBKOTv38HDTWOPbYrURYYVNgEwdqJ7yUG2zVfzaXs7sFVzrSNuOTts9F4IoGtfm6vu0GWRxxqBairE7U2ToOIWqHAvQD5GVlEyLqHGNj5HJvced0glbsUzvZuuj36xdprW9yDu/CMBeUfekc9iZXTmdgdqCtIeJdkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oldschoolsolutions.biz; spf=pass smtp.mailfrom=oldschoolsolutions.biz; dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b=Q1e3Rx9K; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b="Q1e3Rx9K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oldschoolsolutions.biz; s=s1-ionos; t=1731655648; x=1732260448;
	i=jens.glathe@oldschoolsolutions.biz;
	bh=Sa90FOF3ZCw78OsaCzV54IiZx5tvk9l7aqFRB3SmkUQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Q1e3Rx9Kpp7Np1ZBlW8Uyx7NOTSmlC6vaA64lW5ldq/bmVyYR1NxUoDDQlQwzs4I
	 dEHbZcIVEe0ev7EDBCSB1izrRYuHa6EvAIXK06EPjNHdOYdqGBvJcLXw7e4kwLdkV
	 ftrss57TJNNJFaEZjUqkUOsjNMUkqLmNI7zLQi+Bo8ToGOaT3NC9+fHvAnax4YIoH
	 xgpYyyzXm4A0sqzZaUKXstYBw0SJ+m1HAmH9MoPkjJw89CkouZim58Bb72g4BJIG4
	 KC4lueLXWNsxGI0gIYdt6pHGkElINS+hUeXtsdllE+1LBrNXLexW484oOd5NbC8zz
	 xyMvzrKFOb8lKUSBsA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.0.174] ([91.64.229.215]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N17gw-1tvGN43tPO-00vjPP; Fri, 15 Nov 2024 08:13:57 +0100
Message-ID: <4186566a-0aa5-4413-96df-fb1b7ebd9db2@oldschoolsolutions.biz>
Date: Fri, 15 Nov 2024 08:13:55 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: qca: Support downloading board id specific NVM
 for WCN6855
To: Paul Menzel <pmenzel@molgen.mpg.de>, Zijun Hu <quic_zijuhu@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Zijun Hu
 <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Andersson <bjorande@quicinc.com>,
 Aiqun Yu <quic_aiquny@quicinc.com>, Cheng Jiang <quic_chejiang@quicinc.com>,
 Johan Hovold <johan@kernel.org>, Steev Klimaszewski <steev@kali.org>
References: <20241113-x13s_wcn6855_fix-v1-1-15af0aa2549c@quicinc.com>
 <4d973d61-27be-4830-880a-a3d74c4bbbc7@molgen.mpg.de>
Content-Language: en-US
From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
In-Reply-To: <4d973d61-27be-4830-880a-a3d74c4bbbc7@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QDF4apY+T0AwDVjXuiNCoEElOEv+7nq3WiS9e1Fp3AABbpXrT9G
 Z2r9/6StBxLD62oJpV2slEIQwyl3f6EULx9tsIj3flXbhiKShNooQFNg+n30M/zyc7bDnGm
 0JRDZyvXpWNRECY+I2/HGQ6ceh5ZNMi8Hue54miymrXpy+NqDBdHiuerZdL/8YD5/AzTgD3
 rXS8WfxOOnfzb84iQ05sw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gCTczlT7cqc=;zWMK2h1h0R4eXYwxZ/1gW8gJF4n
 G+FFA66si+X7oxppRLwT8p1IkMuKQWBNM6dsbjAeKDlhxeDUWXJEQgOKkeEv7pNIXWZ8neV20
 vhanKMXxteoqvtLUGo+BYEGbYoFlYpLYcmoNj93sLw51CldF3qr49Pwg3FdirK+9L8+8xEMfK
 5B1YOM782XNRczBs/JD1QgP/d5tggDBIko82nLGxLhsA5jpAQRA4BB4ewuvmlYT6vNjvunbJ5
 ePtMSABkFXu/FNDTXEm90z0pNQdAnr+uUkc2HF9IoZMAbSuiqSpf5iQViOUhiWH8t6BpILaAy
 ZtwseP3jBYBwp9kyaY738VdS33VmeDqS5kn7V6XQDUUpM1q1bbi/Y7ElifR0o0ZAKQkud7qyk
 vFi/Ro5Ymx2DDBIKiyDvMJJ0U5Gm/JkbKTsjyBnshHIMFz7UA8jue4zCedGxluHGkZA0pP3iS
 /a6esTh05G7ZNQb4yJ9Vf8ebdQskdSB1diBvKGkDrjCOcAD0gcvSIZ/egJYppHXPxzZZ46r+K
 VVj0vsX6QlO8EOTAbEcDh3LVdMs58Vdx22pyMiMo+gSjHAq/jUjR3/QkrhXRM5tjWCfZqOICn
 wVQQS92zXcMrIKvoigaBQdzhotRGiKgU8K4oKTuRaLinWgZ8uAtM5/uHUCPHW6gZbmVYJAG+t
 jXhikkn2QnxsLtT1zJ3aiuMb5RumCEIeHRanFmb7VT3Vr8aOyhVLdHcYJYOT1+E8xc4oqR8Or
 3QxLjO9iGYtFliSvCYtQXpZ6Co/xyDA2NUZJZkOSrsdfEuOlGtx4Hdskln5xOX6VhKmy7/DHf
 jsDjW34URN+OUYACrWTXFJEMdWml85RlLbx8+FG0jT2GLMVXGJU9UUVKJONeXD66gh

On 14.11.24 10:49, Paul Menzel wrote:
> Dear Zijun,
>
>
> Thank you for your patch.
>
> Am 14.11.24 um 07:26 schrieb Zijun Hu:
>> Download board id specific NVM instead of default for WCN6855 if board
>> id is available, and that is required by Lenovo ThinkPad X13s.
>
> Could you please start by describing the problem/motivation. What does
> not work with the Lenovo ThinkPad X13s before your pacth.
>
> What is variant *g*?
>
> Maybe also describe the file naming convention in the commit message.
>
>
Hi Paul,

Zijun was so kind to review my RFC patch [1] and post an alternate
implementation. The problem is/was that the default firmware patch files
for WCN6855 don't enable the possible quality and range that you get
with board specific files, which are now [2] available in
linux-firmware. It is not only the Lenovo Thinkpad X13s that is
affected, it is quite a range of devices.

The variant *g* is a SoC variant with some extended capabilities as it
seems. The X13s doesn't have it, the Windows Dev Kit 2023 and the HP
Omnibook X14 have it. I have no real information about what the
difference is, but there is code in btqca.c to generate distinct
firmware names.

with best regards

Jens

[1]
https://lore.kernel.org/all/20241003-bt-nvm-firmware-v1-1-79028931214f@old=
schoolsolutions.biz/

[2]
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.gi=
t/commit/qca?id=3D77a11ffc5a0aaaadc870793d02f6c6781ee9f598


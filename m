Return-Path: <cyrus@holtmann.org>
Message-ID: <4C587AFF.7060402@aircable.net>
Date: Tue, 03 Aug 2010 17:24:31 -0300
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Johan Hedberg <johan.hedberg@gmail.com>,
	BlueZ <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH][RFC] Fix SDP resolving segfault
References: <4C46324D.5070800@aircable.net>	<20100721101934.GA12188@jh-x301>	<4C470E2D.7000607@aircable.net>	<AANLkTi=8=BUThjVdc4EN_8uupGKmdgHQzGOe560Cv+pm@mail.gmail.com>	<AANLkTi=jzZScnCK6rFpKjBJesnw=71y5hNG3kDBhxv1u@mail.gmail.com>	<4C505806.3040508@aircable.net>	<AANLkTikRQfhAKm-UW+on+ZeEp709z_ku_NDjeVD_US1b@mail.gmail.com>	<AANLkTi=9Top+9kRwtZj-nZw8szQU4ff9CTSNSGuexmEL@mail.gmail.com>	<4C518373.6000706@aircable.net>	<AANLkTi=i8MhyC80qis9TjZBmtNUJDBMNw5g2rjKPQvdj@mail.gmail.com> <AANLkTinYN=KDban-WsF4wZw-ZZDU7fQ0SFnAWdofbokd@mail.gmail.com>
In-Reply-To: <AANLkTinYN=KDban-WsF4wZw-ZZDU7fQ0SFnAWdofbokd@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Luiz,
> This looks like a different issue, at least it doesn't seems to crash
> in the same point, so I assume the patch does fix something but
> uncover another problem. But we have to find out where exactly is this
> other problem because btd_device_unref doesn't seems to be the place,
> can't you get any core dumps from the tests you did?
>    
I agree it looks like it triggered another issue, I will try to get logs 
tomorrow.

Manuel


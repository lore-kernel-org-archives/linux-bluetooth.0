Return-Path: <cyrus@holtmann.org>
Message-ID: <492C939E.7010007@gmail.com>
Date: Wed, 26 Nov 2008 08:09:02 +0800
From: Sam Lin <itrs.lin@gmail.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Johan Hedberg <johan.hedberg@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: HBH-PV270 headset get locked
References: <492B7A98.90603@gmail.com> <492BB3F2.3050005@gmail.com>	 <C2133416-B233-4FFF-B29B-0BCF3B3402E1@gmail.com> <2d5a2c100811250634vd53daafvce6791992a3c621@mail.gmail.com>
In-Reply-To: <2d5a2c100811250634vd53daafvce6791992a3c621@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I have several headset to try and only HBH-PV270 has this problem.
So it seems to be device dependant and causes compatibility problem.

Sam Lin


Luiz Augusto von Dentz 提到:
> yep, client->dev = NULL seems to be a bug, although by looking the log
>  it seems there is another problem, the sco connection doesn't succeed
> but it still attempt to send the file descriptor. The logic on a2dp is
> a little different, since it doesn't start the stream on
> BT_SETCONFIGURATION_REQ and unlock the sep in any possible error.
>
> Btw, I couldn't reproduce the problem here by using aplay, arecord or
> even both together.
>
>   


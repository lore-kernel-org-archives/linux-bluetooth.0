Return-Path: <cyrus@holtmann.org>
Subject: Re: Read clock not implemented in management
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Elvis Pfutzenreuter <epx@signove.com>
In-Reply-To: <BANLkTi=qBBOkmcS4SD+QJ-BLu7is=ghLTg@mail.gmail.com>
Date: Thu, 9 Jun 2011 09:23:20 -0300
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <A4DF21E7-112D-4AA7-9043-90C744A33CE0@signove.com>
References: <BANLkTim=DVTzgBXDp4Rsed8LNwfrY47ACg@mail.gmail.com> <BANLkTimboYUW4v=tHmVKiCKELqbGfAxegg@mail.gmail.com> <BANLkTi=qBBOkmcS4SD+QJ-BLu7is=ghLTg@mail.gmail.com>
To: Santiago Carot <sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Jun 9, 2011, at 6:48 AM, Santiago Carot wrote:

> Hi.
> 
> 2011/6/8 Santiago Carot <sancane@gmail.com>:
>> Hello Claudio.
>> 
>> 2011/6/8 Claudio Takahasi <claudio.takahasi@openbossa.org>:
>>> Hi Santiago and Elvis,
>>> 
>>> Read clock is not implemented in the management interface. Does it
>>> break something important in the health plug-in?
>>> 
> 
> Coming back to this issue. I'm not caught up with this stuff and I
> dont know if there are any special reason to not provide a read clock
> functionality in the bluetooth API. although I think it's a pity  to
> restrict MCAP features after the good work Elvis did in CSP.

More to the point, could we implement HCI read clock for mgmt interface? Or
it simply won't have read clock by design?

Return-Path: <cyrus@holtmann.org>
Subject: Re: Read clock not implemented in management
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Elvis Pfutzenreuter <epx@signove.com>
In-Reply-To: <20110609122805.GA8875@dell.ccr.corp.intel.com>
Date: Thu, 9 Jun 2011 09:42:42 -0300
Cc: Santiago Carot <sancane@gmail.com>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <82461851-7132-415D-A9D1-AE5C1B64440E@signove.com>
References: <BANLkTim=DVTzgBXDp4Rsed8LNwfrY47ACg@mail.gmail.com> <BANLkTimboYUW4v=tHmVKiCKELqbGfAxegg@mail.gmail.com> <BANLkTi=qBBOkmcS4SD+QJ-BLu7is=ghLTg@mail.gmail.com> <A4DF21E7-112D-4AA7-9043-90C744A33CE0@signove.com> <20110609122805.GA8875@dell.ccr.corp.intel.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Jun 9, 2011, at 9:28 AM, Johan Hedberg wrote:

> Hi,
> 
> On Thu, Jun 09, 2011, Elvis Pfutzenreuter wrote:
>>> Coming back to this issue. I'm not caught up with this stuff and I
>>> dont know if there are any special reason to not provide a read clock
>>> functionality in the bluetooth API. although I think it's a pity  to
>>> restrict MCAP features after the good work Elvis did in CSP.
>> 
>> More to the point, could we implement HCI read clock for mgmt interface? Or
>> it simply won't have read clock by design?
> 
> There's no obvious reason why it couldn't have it. However other means
> should be considered too, e.g. would it be cleaner to get the info
> directly through the socket (using a socket option or something
> similar)? Or was this already considered when the HCI socket solution
> was implemented?

Not exactly, I just made use of hci_read_clock() that already existed in BlueZ
API, and copied the code into hciops.

Getting clock via a socket option sounds better to me since a) we need
connection ACL to read it, getting it through a L2CAP socket would imply the
ACL; b) it would allow other apps to use the feature (e.g. PyBluez that
currently reads clock using an HCI socket).
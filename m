Return-Path: <cyrus@holtmann.org>
Message-ID: <50CE38D1.8010303@linux.intel.com>
Date: Sun, 16 Dec 2012 22:10:41 +0100
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Kevin Wilson <wkevils@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: PSCAN and ISCAN flags in hciconfig
References: <CAGXs5wWXOLpn1O77RMiQ-Cvp3vXEKm3KCbRvz07dN6jJwFoe-A@mail.gmail.com>
In-Reply-To: <CAGXs5wWXOLpn1O77RMiQ-Cvp3vXEKm3KCbRvz07dN6jJwFoe-A@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 16/12/2012 18:58, Kevin Wilson wrote:
> Hello,
> I have 2 PC with Linux which once used to recognize each other by
> "hcitool scan" and  to create
> a PAND-based connection.
>
> Now I fail to see each other with "hcitool scan".
> My question is :
> I see now only the PSCAN flag when running "hciconfig" on both of then.
> Is the ISCAN flag (inquiry) mandatory so that a device will be discoverable ?

Yes, ISCAN means that your adapter will respond to inquiry scan, so it 
will be discoverable.

Regards

Fred

-- 
Frederic Danis                            Open Source Technology Center
frederic.danis@intel.com                              Intel Corporation


Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH 1/9] doc: Introduce connection monitoring API
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1401177171-19994-2-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Sat, 31 May 2014 07:17:13 +0200
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Message-Id: <84F1FEF9-5872-4456-9460-EC8CAEDADE87@holtmann.org>
References: <1401177171-19994-1-git-send-email-andrzej.kaczmarek@tieto.com> <1401177171-19994-2-git-send-email-andrzej.kaczmarek@tieto.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

> This patch introduces API to monitor connection parameters.
> 
> New device properties are introduced: ConnectionRSSI, ConnectionTXPower
> and ConnectionTXPowerMax.
> 
> Client can request to poll for updates of RSSI and TX power via Start-
> and StopConnectionMonitor methods.

I am not convinced on the naming of the method calls and properties. They feel complicated and long and not really clear with its purpose.

What I am curious if we just expose the calculated pathloss or some value that has a more clear sense and usefulness for proximity. Why not do the job for the application instead of letting the application figure it out by itself.

Regards

Marcel


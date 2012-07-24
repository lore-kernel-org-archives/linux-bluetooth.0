Return-Path: <cyrus@holtmann.org>
Message-ID: <1343138034.24426.55.camel@aeonflux>
Subject: Re: [PATCH 0/2] Support for reserving bandwidth on L2CAP socket
From: Marcel Holtmann <marcel@holtmann.org>
To: Manoj Kumar Sharma <manojkr.sharma@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org,
	Anurag Gupta <anurag.gupta@stericsson.com>
Date: Tue, 24 Jul 2012 15:53:54 +0200
In-Reply-To: <1343123700-23375-1-git-send-email-manojkr.sharma@stericsson.com>
References: <y>
	 <1343123700-23375-1-git-send-email-manojkr.sharma@stericsson.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Manoj,

> These patches allows L2CAP socket user to reserve bandwidth in
> percentage. Underlying socket reserves calculated number of
> HCI credits for this L2CAP channel.

this description is by far not enough. Explain why you are doing this.
And make it a detailed description. Preferable with hcidump traces
showing why this makes a difference at all.

Regards

Marcel



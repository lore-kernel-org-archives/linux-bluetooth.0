Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Mon, 31 Oct 2011 17:18:09 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: "Cho, Yu-Chen" <acho@suse.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, acho@novell.com, jlee@novell.com,
	oneukum@suse.com
Subject: Re: [PATCH 1/2] add device entry for Broadcom Valentine combo card
Message-ID: <20111031191809.GB10164@joana>
References: <2eb6d1b761a3fddea28294959bde7e9c7ef88043.1319086508.git.acho@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2eb6d1b761a3fddea28294959bde7e9c7ef88043.1319086508.git.acho@suse.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yu-Chen,

* Cho, Yu-Chen <acho@suse.com> [2011-10-20 12:58:29 +0800]:

> This device declares itself to be vendor specific
> It therefore needs to be added to the device table
> to make btusb bind.

It would be good to have the output of usb-devices for this specific device in
the commit message.

	Gustavo

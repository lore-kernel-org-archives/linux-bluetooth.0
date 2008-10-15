Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Fix Apple Wireless keyboard pairing?
From: Bastien Nocera <hadess@hadess.net>
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <48F63904.6090902@dell.com>
References: <1224032783.5268.1418.camel@cookie.hadess.net>
	 <48F63904.6090902@dell.com>
Content-Type: text/plain
Date: Wed, 15 Oct 2008 22:32:19 +0100
Message-Id: <1224106339.5268.3642.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2008-10-15 at 13:40 -0500, Mario Limonciello wrote:
> Hi Bastien:
> 
> I've got one of these Aluminum BT keyboards, but it's MAC address is
> quite different:
> 
> 00:1B:63:FA:CD:5A Apple Wireless Keyboard
> 
> Where did you get your data from indicating that it shared the same
> prefix as the mighty mouse?

Some of them would. See bug report at:
https://bugzilla.redhat.com/show_bug.cgi?id=466988

Pairing keyboards still doesn't work as expected, but I should get some
hardware soon to fix that.

Cheers


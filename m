Return-Path: <cyrus@holtmann.org>
Message-ID: <1336390976.4325.20.camel@jlt3.sipsolutions.net>
Subject: Re: [RFCv2 5/6] mac80211: softamp: Netlink interface to softamp
From: Johannes Berg <johannes@sipsolutions.net>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org
Date: Mon, 07 May 2012 13:42:56 +0200
In-Reply-To: <1335273460-12682-6-git-send-email-Andrei.Emeltchenko.news@gmail.com> (sfid-20120424_151709_148267_ACF80DFF)
References: <1335273460-12682-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1335273460-12682-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 (sfid-20120424_151709_148267_ACF80DFF)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2012-04-24 at 16:17 +0300, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Adds basic netlink interface. Those packets which are not handled in
> softamp will be sent via netlink for processing in user space.

You must be kidding -- we have nl80211.

johannes


Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Sort devices by type in the treeviews
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1225136737.7157.26.camel@californication>
References: <1225024770.1503.1398.camel@cookie.hadess.net>
	 <1225136737.7157.26.camel@californication>
Content-Type: text/plain
Date: Mon, 27 Oct 2008 19:56:22 +0000
Message-Id: <1225137382.3584.115.camel@cookie.hadess.net>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2008-10-27 at 20:45 +0100, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > Sorting by RSSI means that the devices just around in the treeview
> > which is painfully annoying.
> 
> we want to sort by RSSI to list devices in range first. However we
> should extend the sorting to always list already known or paired devices
> first. This should stop them from moving around.
> 
> If it stil jumps too much for you, then we might just improve the
> sorting mechanism to be a little bit more resistance for jumping around,
> but sorting by type gives us no advantage.

It certainly jumps around far too much. It flickers tens of times a
second, switching between a phone and the Mac mini just next to it...

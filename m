Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Sort devices by type in the treeviews
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1225024770.1503.1398.camel@cookie.hadess.net>
References: <1225024770.1503.1398.camel@cookie.hadess.net>
Content-Type: text/plain
Date: Mon, 27 Oct 2008 20:45:37 +0100
Message-Id: <1225136737.7157.26.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> Sorting by RSSI means that the devices just around in the treeview
> which is painfully annoying.

we want to sort by RSSI to list devices in range first. However we
should extend the sorting to always list already known or paired devices
first. This should stop them from moving around.

If it stil jumps too much for you, then we might just improve the
sorting mechanism to be a little bit more resistance for jumping around,
but sorting by type gives us no advantage.

Regards

Marcel



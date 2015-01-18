Return-Path: <cyrus@holtmann.org>
References: <54A956DC.2050100@cschramm.eu>
From: Jakub Sitnicki <jsitnicki@gmail.com>
To: Christopher Schramm <blueman@cschramm.eu>
Cc: linux-bluetooth@vger.kernel.org, blueman@ml.mate-desktop.org
Subject: Re: Services connected in BlueZ 5
In-reply-to: <54A956DC.2050100@cschramm.eu>
Date: Sun, 18 Jan 2015 11:34:19 +0100
Message-ID: <87k30kgyxg.fsf@frog.home>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christopher,

On Sun, Jan 04, 2015 at 04:06 PM CET, Christopher Schramm wrote:
> So, is there any way to determine a specific service's connection state
> in BlueZ 5? If not, ConnectProfile / DisconnectProfile seem pretty
> useless, since one is left in the dark, so the only valid way would be
> using Connect and hope all services desired by the user get connected
> which is pretty unsatisfying. Can you confirm the awkward behavior of
> Device.Connect and Device.Connected e.g. in conjunction with a network
> service?

While I can't definitely confirm that it is not possible to check if
specific service is connected because I'm not a developer in this
project, I would say that this note from Device1.DisconnectProfile() API
docs suggests it:

> There is *no connection tracking* for a profile, so as long as the
> profile is registered this [DisconnectProfile()] will always succeed.

Also, in case you haven't already seen it, I think you might find
interesting a part of the discussion of this patchset from some time ago
(regarding the need to show in UI which services are connected):

http://thread.gmane.org/gmane.linux.bluez.kernel/36507

Hope this helps,
Jakub

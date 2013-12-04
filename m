Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Timo Mueller <mail@timomueller.eu>
Cc: linux-bluetooth@vger.kernel.org,
	Timo Mueller <timo.mueller@bmw-carit.de>
Subject: Re: [PATCHv1 0/2] Introduce default adapter property
Date: Wed, 04 Dec 2013 09:32:51 +0100
Message-ID: <3146259.c398076Ovj@uw000953>
In-Reply-To: <cover.1386078490.git.timo.mueller@bmw-carit.de>
References: <cover.1386078490.git.timo.mueller@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Timo,

> From: Timo Mueller <timo.mueller@bmw-carit.de>
> 
> Hi,
> 
> the information about the default adapter is currently not available
> through the D-Bus API of BlueZ. But as plugins can use this
> information to choose the adapter they act upon it would be helpful
> for users to be able to retrieve this information as well.
>
> For example the neard plugin uses this information to decide for which
> adapter oob data is generated. Users could use the same information to
> power the adapter before actually sending the oob data.

I think this property is bluetoothd internal detail and should not be needed
to be exported to user. If reason for this is scenario where multiple BT and
NFC adapters are present and you need to match them in pairs, then proper
solution would probably require extending neard agent interface. Neard plugin
could be also made 'smarter' about multiple adapters eg. try to choose other
controller if default one is not powered etc. Regarding changing power state
of bt controller, I think this could be done by neard plugin itself (possible
based on some static configuration or even runtime dbus setting...). It is on
my 'TODO when have some spare time' list :)

It would be good if you could outline usecases you are trying to address with
this change.

-- 
BR
Szymon Janc



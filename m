Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] [RFC] doc: Add StartDiscoveryWithOptions
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CA+bD78jRm4_Xd3UhhAwnA7jA1H3o2khKcqr3ZtRYmbMcTW4HdA@mail.gmail.com>
Date: Tue, 1 Jul 2014 12:31:36 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4F821DBD-AE7F-4DBA-8FB9-0F12217F2BC3@holtmann.org>
References: <1403896589-6135-1-git-send-email-scott@netsplit.com> <90AEC8D9-5894-4083-AD82-F8D9A8DC1000@holtmann.org> <CA+bD78jRm4_Xd3UhhAwnA7jA1H3o2khKcqr3ZtRYmbMcTW4HdA@mail.gmail.com>
To: Scott James Remnant <scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

>> The reason why I like to keep discovery separate from searching for a known device, these are separate operations. There is subtle difference between advertising non-discoverable and advertising discoverable. While many devices always advertise discoverable, they do not need it. And StartDiscovery will not report non-discoverable devices back. However a FindDevice of course can look for a specific device matching its search pattern even if it is not discoverable.
>> 
> 
> Thinking about this a bit more, does StartDiscovery return devices
> advertising with non-connectable undirected advertising? If the goal
> of that method is for the UI then does it make sense for it to be
> returning devices we can't connect to as well?

this is an interesting question. So non-connectable or scannable undirected advertising events will not allow for any connection whatsoever. Even if they have the discoverable or limited discoverable flags set.

For the D-Bus API, I think we should only return devices with discoverable and limited discoverable flags set when calling StartDiscovery since that are the ones we are looking for at that point. Should we also return devices that are not connectable is something we might need to discuss.

I think we should not return them since you would expect users to be able to just click on these and pair them. That however will never succeed sine you can not connect to these devices. An alternative option is to just add a property Connectable that allows us to see if we can connect or not. Feels a bit weird to me.

For the kernel side, we have to report a lot of things. However since we now enabled passive scanning, we can be a bit more detailed in what we are supporting.

First thing we have to do is add a new flag to Device Found event that indicates if the device is connectable or not. That is needed no matter what. That alone will allow bluetoothd to do the right filtering and transactions.

In addition to that, I am thinking that Start Discovery triggered Device Found should be limited to connectable and discoverable events. Unless of course we have them also in Add Device. Then they should be reported out always.

And then we start building proper observer API for D-Bus and also extra filtering for the kernel side.

Regards

Marcel


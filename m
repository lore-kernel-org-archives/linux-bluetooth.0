Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <90AEC8D9-5894-4083-AD82-F8D9A8DC1000@holtmann.org>
References: <1403896589-6135-1-git-send-email-scott@netsplit.com>
	<90AEC8D9-5894-4083-AD82-F8D9A8DC1000@holtmann.org>
Date: Mon, 30 Jun 2014 13:16:34 -0700
Message-ID: <CA+bD78jRm4_Xd3UhhAwnA7jA1H3o2khKcqr3ZtRYmbMcTW4HdA@mail.gmail.com>
Subject: Re: [PATCH] [RFC] doc: Add StartDiscoveryWithOptions
From: Scott James Remnant <scott@netsplit.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jun 27, 2014 at 1:15 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:

>
> The reason why I like to keep discovery separate from searching for a kno=
wn device, these are separate operations. There is subtle difference betwee=
n advertising non-discoverable and advertising discoverable. While many dev=
ices always advertise discoverable, they do not need it. And StartDiscovery=
 will not report non-discoverable devices back. However a FindDevice of cou=
rse can look for a specific device matching its search pattern even if it i=
s not discoverable.
>

Thinking about this a bit more, does StartDiscovery return devices
advertising with non-connectable undirected advertising? If the goal
of that method is for the UI then does it make sense for it to be
returning devices we can't connect to as well?

Scott
--=20
Have you ever, ever felt like this?
Had strange things happen?  Are you going round the twist?

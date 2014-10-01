Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Oct 2014 15:34:08 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 2/4] shared/gatt-client: Take fd in
 bt_gatt_client_new
Message-ID: <20141001123408.GA26432@t440s.lan>
References: <1412163494-20283-1-git-send-email-luiz.dentz@gmail.com>
 <1412163494-20283-2-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1412163494-20283-2-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Oct 01, 2014, Luiz Augusto von Dentz wrote:
> -struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att, uint16_t mtu)
> +struct bt_gatt_client *bt_gatt_client_new(int fd, uint16_t mtu)

This becomes a bit cumbersome since pretty much any time you have a
connected ATT socket you must be able to be both client and server in
order not to exhibit broken behavior.

With the above change you'd need something like the following since the
fd should really only be processed in one place (bt_att).

	client = client_new(fd);
	att = client_get_att(client);
	server = server_new(att);

Without your change I assume the code has been something like:

	att = att_new(fd);
	client = client_new(att);
	server = server_new(att);

The above is fine except I don't really see the point in having separate
client and server objects to begin with. I might have missed the
reasoning behind it (in which case please enlighten me), but why don't
we hide both roles behind the same object, since they're anyway tied to
the same connection?

I have no objections to having clearly name-spaced functions for client
and server side behavior, and even keeping these in separate c-files,
but having independent objects for them seems a bit pointless. So why
couldn't we have server_foo(att) and client_foo(att) while keeping just
this one "att" context?

Johan

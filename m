Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Fri, 14 Jan 2011 14:30:56 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: David Sterba <dsterba@suse.cz>
Cc: akpm@linux-foundation.org, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@profusion.mobi>
Subject: Re: [PATCH resend] Bluetooth: l2cap: fix misuse of logical
 operation in place of bitop
Message-ID: <20110114163056.GA3736@vigoh>
References: <1295013584-15592-1-git-send-email-dsterba@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1295013584-15592-1-git-send-email-dsterba@suse.cz>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

* David Sterba <dsterba@suse.cz> [2011-01-14 14:59:44 +0100]:

> CC: Marcel Holtmann <marcel@holtmann.org>
> CC: "Gustavo F. Padovan" <padovan@profusion.mobi>
> CC: Jo=E3o Paulo Rechi Vita <jprvita@profusion.mobi>
> Signed-off-by: David Sterba <dsterba@suse.cz>
> ---
>=20
> Andrew, this has not been picked up by maintainers since 27.12., please c=
onsider it for -mm.
>=20
>  net/bluetooth/l2cap.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

I'm taking care of this. Sorry for the delay, I've been away a bit.
Patch is now applied to Bluetooth tree. Thanks.

--=20
Gustavo F. Padovan
http://profusion.mobi

Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 Feb 2011 18:00:45 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: anderson.briglia@openbossa.org
Cc: linux-bluetooth@vger.kernel.org,
	Ville Tervo <ville.tervo@nokia.com>
Subject: Re: [PATCH 1/2] Bluetooth: Fix LE conn creation
Message-ID: <20110221210045.GG2965@joana>
References: <y>
 <4d62aa6e.47f3d80a.5ea1.ffffd98d@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4d62aa6e.47f3d80a.5ea1.ffffd98d@mx.google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Briglia,

* anderson.briglia@openbossa.org <anderson.briglia@openbossa.org> [2011-02-21 15:09:23 -0300]:

> From: Anderson Briglia <anderson.briglia@openbossa.org>
> 
> This patch prevents a crash when remote host tries to create a LE
> link which already exists. i.e.: call l2test twice passing the
> same parameters.
> 
> Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
> Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
> ---
>  net/bluetooth/hci_conn.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi

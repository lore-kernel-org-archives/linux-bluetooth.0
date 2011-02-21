Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 Feb 2011 18:04:21 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: anderson.briglia@openbossa.org
Cc: linux-bluetooth@vger.kernel.org,
	Ville Tervo <ville.tervo@nokia.com>
Subject: Re: [PATCH 2/2] Bluetooth: Use ERR_PTR as return error from
 hci_connect
Message-ID: <20110221210421.GH2965@joana>
References: <y>
 <4d62aa7a.47f3d80a.5ea1.ffffd992@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4d62aa7a.47f3d80a.5ea1.ffffd992@mx.google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* anderson.briglia@openbossa.org <anderson.briglia@openbossa.org> [2011-02-21 15:09:24 -0300]:

> From: Ville Tervo <ville.tervo@nokia.com>
> 
> Use ERR_PRT mechanism to return error from hci_connect.

Btw, Johan added a new call to hci_connect, so be sure to add the ERR_PTR
stuff there too.

-- 
Gustavo F. Padovan
http://profusion.mobi

Return-Path: <cyrus@holtmann.org>
Date: Wed, 10 Feb 2010 09:02:54 -0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	daniel.orstadius@gmail.com, luiz.dentz-von@nokia.com
Subject: Re: [PATCH] osso-gwobex export
Message-ID: <20100210110254.GA20720@jh-x301>
References: <1265738807.2383.6336.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1265738807.2383.6336.camel@localhost.localdomain>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Tue, Feb 09, 2010, Bastien Nocera wrote:
> Here's a patch to fix libgwobex not using a soname, and fixing a few
> build problems.

Thanks. It's now pushed upstream.

> I couldn't run the test suite, as gnome-bluetooth's ancient btctl Python
> module isn't around any more.

Yep, nobody has really maintained the test tools for a while. Patches
are always welcome :)

> Could I bribe someone into making a release that I could use for gvfs'
> ObexFTP module[1]?

I have nothing against a release, but either Daniel or Luiz will have to
do it since I'm a bit limited with time at the moment.

Johan

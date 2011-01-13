Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Check authorization when sec_level goes
 high.
From: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Reply-To: matti.j.aaltonen@nokia.com
To: ext Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        padovan@profusion.mobi
In-Reply-To: <AANLkTikm8_spOCzLAFytNfNEFxxaqNhTxK__YVjkSxe-@mail.gmail.com>
References: <1294834111-29658-1-git-send-email-matti.j.aaltonen@nokia.com>
	 <AANLkTikm8_spOCzLAFytNfNEFxxaqNhTxK__YVjkSxe-@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 13 Jan 2011 10:08:31 +0200
Message-ID: <1294906111.17385.2.camel@masi.mnp.nokia.com>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hello

On Thu, 2011-01-13 at 00:31 +0200, ext Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Wed, Jan 12, 2011 at 2:08 PM, Matti J. Aaltonen
> <matti.j.aaltonen@nokia.com> wrote:
> > Initiate authorization check also in cases where the
> > security level of an existing connection changes to
> > BT_SECURITY_HIGH.
> >
> > This patch fixes a bug which makes commands bluez-test-device and
> > bluez-simple-agent fail, if the latter is given before the connection
> > created by bluez-test-device has expired.
> >
> I don't think this fixes the problem properly, the authentication
> request could have been sent before because other levels might require
> it, also Im afraid this can break sockets using the same link since
> the state got reseted to BT_CONFIG when it could previously be
> BT_CONNECTED, what happens if there a socket in use and the link is
> set back to BT_CONFIG after connected?

Yes. One of our bluetooth specialists suggested a simpler and probably
better fix for this. He'll probably send his patch shortly...

Thanks,
Matti

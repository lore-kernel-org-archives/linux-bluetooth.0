Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4C52A995.8080205@hschmitt.de>
References: <4C4EC2B5.2030204@xxxxxxxxxxx>
	<AANLkTi=WSgMe86k-h=_HdzsPTZ=rK5ab5O9mYf8C6jnc@xxxxxxxxxxxxxx>
	<20100729181649.GA9339@joshua.mesa.nl>
	<4C52A995.8080205@hschmitt.de>
Date: Fri, 30 Jul 2010 18:08:23 +0300
Message-ID: <AANLkTimKLcbg2d5Ev5AVBhQqRRrgV-aKKkTRfRzOFAK=@mail.gmail.com>
Subject: Re: obexd 0.29 and N900 PC Suite
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Harald Schmitt <linux@hschmitt.de>
Cc: "Marcel J.E. Mol" <marcel@mesa.nl>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Jul 30, 2010 at 1:29 PM, Harald Schmitt <linux@hschmitt.de> wrote:
> I have testes following command and it seems to work:
> dbus-send --system --type=signal / com.meego.usb_moded.sig_usb_state_ind
> string:'ovi_suite'
> If one would just add this line to pcsuite-enable.sh under the SIGUSR1 then
> both types of obexd would work?
> Luiz could you confirm this? Do we also need a dbus-command for disconnect
> with string:'USB disconnected' in pcsuite-disable.sh?

Hmm it may work with that but I would first just revert the patch I
suggest other day since without that part there could be some other
components still sending SIGUSR1 to obexd which might kill it, maybe I
can just reintroduce SIGUSR1 and then have a config option saying
which method to use for usb cable detection. What do you guys think?

In future I really want a standard way to do the cable detection, I
guess udev + libusb could be a better alternative.

-- 
Luiz Augusto von Dentz
Computer Engineer

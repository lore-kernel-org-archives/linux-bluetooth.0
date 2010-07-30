Return-Path: <cyrus@holtmann.org>
Date: Fri, 30 Jul 2010 22:49:43 +0200
From: "Marcel J.E. Mol" <marcel@mesa.nl>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Harald Schmitt <linux@hschmitt.de>, linux-bluetooth@vger.kernel.org
Subject: Re: obexd 0.29 and N900 PC Suite
Message-ID: <20100730204943.GA15065@joshua.mesa.nl>
References: <4C4EC2B5.2030204@xxxxxxxxxxx> <AANLkTi=WSgMe86k-h=_HdzsPTZ=rK5ab5O9mYf8C6jnc@xxxxxxxxxxxxxx> <20100729181649.GA9339@joshua.mesa.nl> <4C52A995.8080205@hschmitt.de> <AANLkTimKLcbg2d5Ev5AVBhQqRRrgV-aKKkTRfRzOFAK=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset*=utf-8''%E2%80%9Cus-ascii
In-Reply-To: <AANLkTimKLcbg2d5Ev5AVBhQqRRrgV-aKKkTRfRzOFAK=@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jul 30, 2010 at 06:08:23PM +0300, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Fri, Jul 30, 2010 at 1:29 PM, Harald Schmitt <linux@hschmitt.de> wrote:
> > I have testes following command and it seems to work:
> > dbus-send --system --type=signal / com.meego.usb_moded.sig_usb_state_ind
> > string:'ovi_suite'
> > If one would just add this line to pcsuite-enable.sh under the SIGUSR1 then
> > both types of obexd would work?
> > Luiz could you confirm this? Do we also need a dbus-command for disconnect
> > with string:'USB disconnected' in pcsuite-disable.sh?
> 
> Hmm it may work with that but I would first just revert the patch I
> suggest other day since without that part there could be some other
> components still sending SIGUSR1 to obexd which might kill it, maybe I
> can just reintroduce SIGUSR1 and then have a config option saying
> which method to use for usb cable detection. What do you guys think?

Well, I just tested the dbus method on the n900 with an obexd 0.29 
(including the updates I already posted here plus a few other updates
including a basic IRMC server implementation) and pcsuite seems to 
work fine. But I did not test extensively (contact/calendar download
work file and file browsing too).

I don't know if there are other tools using signalling to obexd, maybe
people from the nokia n900/maemo group can tell...

-Marcel
-- 
     ======--------         Marcel J.E. Mol                MESA Consulting B.V.
    =======---------        ph. +31-(0)6-54724868          P.O. Box 112
    =======---------        marcel@mesa.nl                 2630 AC  Nootdorp
__==== www.mesa.nl ---____U_n_i_x______I_n_t_e_r_n_e_t____ The Netherlands ____
 They couldn't think of a number,           Linux user 1148  --  counter.li.org
    so they gave me a name!  -- Rupert Hine  --  www.ruperthine.com

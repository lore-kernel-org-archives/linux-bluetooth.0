Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 Sep 2013 13:28:26 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 7/8] Bluetooth: Add new mgmt setting for LE advertising
Message-ID: <20130925102826.GA8101@x220.p-661hnu-f1>
References: <1380031363-1266-1-git-send-email-johan.hedberg@gmail.com>
 <1380031363-1266-8-git-send-email-johan.hedberg@gmail.com>
 <CAJdJm_MDoR2ed6++x5JAxaG2=0+zUdAGztL_L3i-ObtaM+WbRA@mail.gmail.com>
 <20130924172120.GA30191@x220.p-661hnu-f1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130924172120.GA30191@x220.p-661hnu-f1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Sep 24, 2013, Johan Hedberg wrote:
> On Tue, Sep 24, 2013, Anderson Lizardo wrote:
> > On Tue, Sep 24, 2013 at 10:02 AM,  <johan.hedberg@gmail.com> wrote:
> > > This patch adds a new mgmt setting for LE advertising and hooks up the
> > > necessary places in the mgmt code to operate on the HCI_LE_PERIPHERAL
> > > flag (which corresponds to this setting). This patch does not yet add
> > > any new command for enabling the setting - that is left for a subsequent
> > > patch.
> > 
> > How this code behaves if we enable/disable LE advertising using
> > hciconfig hci0 leadv/noleadv? IIRC the LE_SET_ADV_ENABLE command will
> > fail if advertising is already set on the controller.
> 
> You're right that a mix of mgmt and hciconfig will mix things up on the
> kernel side. This is something I was aware of but didn't investigate
> much further since I was assuming it would add too much complexity to
> the code. The principle has always been that we keep compatibility/good
> behavior with mixed mgmg/raw HCI access only as long as it doesn't
> needlessly complicate the code.
> 
> That said, I'll take a another look if the flag setting could be moved
> to a hci_event.c handler from the request callback without requiring the
> addition of a second flag or state variable. This issue is not unique to
> this new setting but actually exists for many of them. What we probably
> need is a generic mgmt_send_new_settings function that hci_event.c
> handlers can call when they know that new_settings should be emitted. I
> suspect that might solve the issue.

So I did take another look and this gets tricky since we don't just need
to emit a new_settings, but also ensure that it does not get emitted on
the mgmt socket that may have caused the command to be sent. Therefore,
I decided against trying to have "full" support of mixing mgmt with raw
HCI. What I did do is ensure that our dev_flags remain correct by using
the hci_event.c handler to set them. This ensures that subsequent mgmt
commands still work even though bluetoothd may not always be completely
up to date with these settings.

Johan

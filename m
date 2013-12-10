Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAD=nrE_R6h++1AofwTHoHjRT=YOc1VPUaic7AYO_jbh6Eb_koQ@mail.gmail.com>
References: <CAD=nrE_R6h++1AofwTHoHjRT=YOc1VPUaic7AYO_jbh6Eb_koQ@mail.gmail.com>
Date: Tue, 10 Dec 2013 20:46:13 +0100
Message-ID: <CAD=nrE8jVpXsP+RuR6mznHT1azn8mSVtmqTYCYfXL13WhTwVpg@mail.gmail.com>
Subject: Re: Unknown option 'pin_helper
From: "valent.turkovic@gmail.com" <valent.turkovic@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Dec 10, 2013 at 8:39 PM, valent.turkovic@gmail.com
<valent.turkovic@gmail.com> wrote:
> Hi,
> on OpenWrt latest version of bluez-utils is still 3.36 and when I add
> pin_helper to hcid.conf file I see this error when starting hcid
> daemon:
>
> # hcid -n
> hcid[1063]: Bluetooth HCI daemon
> hcid[1063]: Unknown option 'pin_helper' line 26
>
>
> Should bluez-utils 3.36 have support for pin_helper by default? I have
> checked source code of OpenWrt and can't find any patch that disables
> pin_helper.
>
> What could the issue here?

Ah, I was already searching day ago for this issue an by Murphy's Law
as soon as email was send I found an answer:

"the "pin_helper" option is only valid with bluez-libs-2.x &
bluez-utils-2.x and below.
Thats what is causing the service to fail to start up.
Bluez-3.X has replaced pin helpers with passkey agents such as
kbluetoothd and bluez-gnome, the bluez-utils also comes with an
command line agent passkey-agent. "

Can anybody please point me in the direction of documentation that
explains how to use passkey agents on bluez-utils 3.x and later?

I saw that BlueZ website had wiki but that it is no longer available.

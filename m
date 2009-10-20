Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Oct 2009 23:14:11 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Valmantas =?iso-8859-15?Q?Palik=A8a?= <walmis@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Corruption in bluetoothd if started when adapter was rfkilled
Message-ID: <20091020201411.GA6878@jh-x301>
References: <1255696908.12027.15.camel@walmis-laptop> <20091020133610.GA14042@jh-x301> <2d5a2c100910201257g45d802cia7719035874c5a3d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <2d5a2c100910201257g45d802cia7719035874c5a3d@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Oct 20, 2009, Luiz Augusto von Dentz wrote:
> On Tue, Oct 20, 2009 at 10:38 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> > Hi,
> >
> > On Fri, Oct 16, 2009, Valmantas Palik¨a wrote:
> >> Steps to reproduce:
> >> 1. rfkill block bluetooth
> >> 2. start bluetoothd
> >> 3. kill bluetoothd
> >
> > I don't seem to have rfkill support (at least using that command) on my
> > laptop so I can't verify this fix, but could you try the attached patch
> > and see if it resolves the issue? The problem seems to be that in this use
> > case we never load/probe the adapter drivers but still call their remove
> > callbacks when the adapter initialization fails. This causes some drivers
> > to call btd_adapter_unref on adapter objects for which they do not own a
> > reference.
> 
> Yep, it fixes the problem.

Great! The patch is now pushed upstream.

Johan

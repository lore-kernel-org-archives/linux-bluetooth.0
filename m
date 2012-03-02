Return-Path: <cyrus@holtmann.org>
Date: Fri, 2 Mar 2012 08:02:58 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: obexd 0.45 compilation problem
Message-ID: <20120302160258.GA18401@x220>
References: <1330692190.20578.15.camel@novo.hadess.net>
 <CABBYNZKQWvNmTrqjKrkVKxeWGzVN9eV1KwkNXZChgUS6nSwydQ@mail.gmail.com>
 <1330697618.20578.16.camel@novo.hadess.net>
 <CABBYNZKx9GS8WGMa=5K+zX5EqOT-qJPhxYLfg_nfsR2J29kEnQ@mail.gmail.com>
 <1330701462.20578.21.camel@novo.hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330701462.20578.21.camel@novo.hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Fri, Mar 02, 2012, Bastien Nocera wrote:
> > >> > Trying to compile obexd 0.45 with bluez-4.98, I get:
> > >> > btio/btio.c: In function 'get_key_size':
> > >> > btio/btio.c:522:14: error: 'struct bt_security' has no member named 'key_size'
> > >> >
> > >> > Do you need to either up the bluez dependency, or is obexd lagging?
> > >> >
> > >> > Install log:
> > >> > http://koji.fedoraproject.org/koji/getfile?taskID=3846402&name=root.log
> > >> > Compile log:
> > >> > http://koji.fedoraproject.org/koji/getfile?taskID=3846402&name=build.log
> > >>
> > >> It is a known problem, until we are depending on a new release of
> > >> bluez (4.99) then we can add the build dependency properly, after that
> > >> we will probably have a new release for obexd as well.
> > >
> > > I don't understand. Are you telling me that obexd relies on an
> > > unreleased version of bluez?
> > 
> > Not exactly obexd, but btio yes
> 
> Given that btio is copy/pasted into obexd, it's obexd relying on an
> unreleased version of bluez.
> 
> I could understand the idea if bluez hadn't had releases in ages, and
> you didn't have any control over it. But that's hardly helpful to the
> people downstream distributing your code.

This was obviously a mistake from our side. We didn't realize this
dependency was there. The right thing to do would have been to wait for
BlueZ 4.99 before pushing a new obexd release out.

Johan

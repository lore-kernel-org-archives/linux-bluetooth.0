Return-Path: <cyrus@holtmann.org>
Message-ID: <1330701462.20578.21.camel@novo.hadess.net>
Subject: Re: obexd 0.45 compilation problem
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Fri, 02 Mar 2012 15:17:42 +0000
In-Reply-To: <CABBYNZKx9GS8WGMa=5K+zX5EqOT-qJPhxYLfg_nfsR2J29kEnQ@mail.gmail.com>
References: <1330692190.20578.15.camel@novo.hadess.net>
	 <CABBYNZKQWvNmTrqjKrkVKxeWGzVN9eV1KwkNXZChgUS6nSwydQ@mail.gmail.com>
	 <1330697618.20578.16.camel@novo.hadess.net>
	 <CABBYNZKx9GS8WGMa=5K+zX5EqOT-qJPhxYLfg_nfsR2J29kEnQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2012-03-02 at 17:06 +0200, Luiz Augusto von Dentz wrote:
> Hi Bastien
> 
> On Fri, Mar 2, 2012 at 4:13 PM, Bastien Nocera <hadess@hadess.net> wrote:
> > On Fri, 2012-03-02 at 14:57 +0200, Luiz Augusto von Dentz wrote:
> >> Hi Bastien,
> >>
> >> On Fri, Mar 2, 2012 at 2:43 PM, Bastien Nocera <hadess@hadess.net> wrote:
> >> > Heya,
> >> >
> >> > Trying to compile obexd 0.45 with bluez-4.98, I get:
> >> > btio/btio.c: In function 'get_key_size':
> >> > btio/btio.c:522:14: error: 'struct bt_security' has no member named 'key_size'
> >> >
> >> > Do you need to either up the bluez dependency, or is obexd lagging?
> >> >
> >> > Install log:
> >> > http://koji.fedoraproject.org/koji/getfile?taskID=3846402&name=root.log
> >> > Compile log:
> >> > http://koji.fedoraproject.org/koji/getfile?taskID=3846402&name=build.log
> >>
> >> It is a known problem, until we are depending on a new release of
> >> bluez (4.99) then we can add the build dependency properly, after that
> >> we will probably have a new release for obexd as well.
> >
> > I don't understand. Are you telling me that obexd relies on an
> > unreleased version of bluez?
> 
> Not exactly obexd, but btio yes

Given that btio is copy/pasted into obexd, it's obexd relying on an
unreleased version of bluez.

I could understand the idea if bluez hadn't had releases in ages, and
you didn't have any control over it. But that's hardly helpful to the
people downstream distributing your code.


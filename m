Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1452537920.4584.16.camel@hadess.net>
Subject: Re: example GATT code to talk with a sensortag
From: Bastien Nocera <hadess@hadess.net>
To: Don Zickus <dzickus@redhat.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 11 Jan 2016 19:45:20 +0100
In-Reply-To: <20160111145735.GW152924@redhat.com>
References: <20160108222608.GU152924@redhat.com>
	 <CABBYNZ+bpQQH6XhM20d62wy5Y-PWw_Vq7_jhriHFmmLvJVHtAg@mail.gmail.com>
	 <20160111145735.GW152924@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2016-01-11 at 09:57 -0500, Don Zickus wrote:
> On Sun, Jan 10, 2016 at 07:13:56PM -0300, Luiz Augusto von Dentz
> wrote:
> > Hi Don,
> > 
> > On Fri, Jan 8, 2016 at 7:26 PM, Don Zickus <dzickus@redhat.com>
> > wrote:
> > > Hi,
> > > 
> > > Sorry for the newbie question.  I stumbled upon a TI sensortag
> > > and was able
> > > to communicate with it using the gatttool.  Now I am trying to
> > > figure out
> > > how to build an app around that.  Googling has shown me lots of
> > > examples of
> > > folks using expect scripts (around the gatttool).
> > > 
> > > I was hoping for something in C or python.  Is there an example
> > > program/script around that I can copy and expand to get me
> > > started?
> > > 
> > > Thanks!
> > > 
> > > Cheers,
> > > Don
> > 
> > bluetoothctl has some generic support for GATT attributes, in
> > addition
> > we have some examples in python under test/example-gatt-client and
> > test/example-gatt-server.
> 
> Hi Luis,
> 
> Perfect, thanks!!

Let me know how far you manage to get. I have one such device from
"Proximo" which I was hoping to be able to use.

Cheers


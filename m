Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 11 Jan 2016 09:57:35 -0500
From: Don Zickus <dzickus@redhat.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: example GATT code to talk with a sensortag
Message-ID: <20160111145735.GW152924@redhat.com>
References: <20160108222608.GU152924@redhat.com>
 <CABBYNZ+bpQQH6XhM20d62wy5Y-PWw_Vq7_jhriHFmmLvJVHtAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZ+bpQQH6XhM20d62wy5Y-PWw_Vq7_jhriHFmmLvJVHtAg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Jan 10, 2016 at 07:13:56PM -0300, Luiz Augusto von Dentz wrote:
> Hi Don,
> 
> On Fri, Jan 8, 2016 at 7:26 PM, Don Zickus <dzickus@redhat.com> wrote:
> > Hi,
> >
> > Sorry for the newbie question.  I stumbled upon a TI sensortag and was able
> > to communicate with it using the gatttool.  Now I am trying to figure out
> > how to build an app around that.  Googling has shown me lots of examples of
> > folks using expect scripts (around the gatttool).
> >
> > I was hoping for something in C or python.  Is there an example
> > program/script around that I can copy and expand to get me started?
> >
> > Thanks!
> >
> > Cheers,
> > Don
> 
> bluetoothctl has some generic support for GATT attributes, in addition
> we have some examples in python under test/example-gatt-client and
> test/example-gatt-server.

Hi Luis,

Perfect, thanks!!

Cheers,
Don

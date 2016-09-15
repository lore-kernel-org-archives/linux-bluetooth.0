Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Thu, 15 Sep 2016 17:27:50 -0400
From: Don Zickus <dzickus@redhat.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: using d-bus api to set security level
Message-ID: <20160915212750.GP98438@redhat.com>
References: <20160914155910.GC98438@redhat.com>
 <CABBYNZLrgvqSDu-CPAWek02SOFAKLzKdg5pQdQfU+vw-hWgL1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZLrgvqSDu-CPAWek02SOFAKLzKdg5pQdQfU+vw-hWgL1g@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Sep 14, 2016 at 07:52:11PM +0300, Luiz Augusto von Dentz wrote:
> Hi Don,
> 
> On Wed, Sep 14, 2016 at 6:59 PM, Don Zickus <dzickus@redhat.com> wrote:
> > Hi,
> >
> > I am trying to find the equivalent of using gatttool's --sec-level when
> > writing a python script to connect to an LE device over the d-bus API.
> >
> > It seems like I have to set the Characteristic correctly.  But I am missing
> > something obvious when looking through the doc/ api files.
> >
> > Can someone point me to the right spot?  Thanks!
> 
> You can call Device1.Pair if you want to authenticate, once the LTK is
> exchanged it will be used automatically in the next connections.

Hi Luiz,

Thanks for the response.  I guess if the Pair() fails with Authentication
failure, that implies the device does not support it?  I was playing with
this TI sensortag and wanted to double check how it was connecting.

So does the authentication get setup by the agent?  And the Pair() to the
agent determines if the link will be encrypted?

Cheers,
Don

Return-Path: <cyrus@holtmann.org>
Date: Fri, 7 May 2010 16:49:19 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Elvis =?iso-8859-1?Q?Pf=FCtzenreuter?= <epx@signove.com>
Cc: =?iso-8859-1?Q?Jos=E9?= Antonio Santos Cadenas
	<jcaden@libresoft.es>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Data transmission and reconnections in HDP
Message-ID: <20100507194919.GA4857@vigoh>
References: <201005071302.36198.jcaden@libresoft.es>
 <20100507120859.GD12461@vigoh>
 <82D1897F-4DEE-47F9-BD00-57087F182C3D@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <82D1897F-4DEE-47F9-BD00-57087F182C3D@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

* Elvis Pfützenreuter <epx@signove.com> [2010-05-07 10:20:59 -0300]:

> 
> >> Option 1: Fd_passing the l2cap socket of the data channel to the client. The 
> >> problem with this is that some data can be lost by d-bus if the channel is 
> >> disconnected. (We have to check how fd-passing works).
> > 
> > DBus just pass the fd and then don't touch the fd anymore, data can't be
> > lost by DBus.
> 
> Actually the worry is not whether D-BUS can lose the data midway (it can't indeed), but if the L2CAP connection closes and the application is not sure about the last message having been sent.

If the close is requested by the local side I guarantee on ERTM that
close will return only after receive the ack of the last packet sent
or some error happens and the channel get closed anyway -- I have to
check if I report a error in this case. ERTM has to guarantee the case
you are talking about, since it is reliable.

Also I still have to check the case when the remote side requests a
disconnect. I'm adding these stuff to my todo list an I'll work on it
soon.

It's nice that we are going to have real users to my ERTM code. ;-)

Regards,

-- 
Gustavo F. Padovan
http://padovan.org

Return-Path: <cyrus@holtmann.org>
Date: Fri, 7 May 2010 17:17:20 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Elvis =?iso-8859-1?Q?Pf=FCtzenreuter?= <epx@signove.com>
Cc: =?iso-8859-1?Q?Jos=E9?= Antonio Santos Cadenas
	<jcaden@libresoft.es>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Data transmission and reconnections in HDP
Message-ID: <20100507201648.GA5682@vigoh>
References: <201005071302.36198.jcaden@libresoft.es>
 <20100507120859.GD12461@vigoh>
 <82D1897F-4DEE-47F9-BD00-57087F182C3D@signove.com>
 <20100507194919.GA4857@vigoh>
 <BC6ABF7A-4847-4DDE-B3D6-584BEF215D65@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <BC6ABF7A-4847-4DDE-B3D6-584BEF215D65@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Elvis Pfützenreuter <epx@signove.com> [2010-05-07 16:55:13 -0300]:

> > 
> > Also I still have to check the case when the remote side requests a
> > disconnect. I'm adding these stuff to my todo list an I'll work on it
> > soon.
> 
> I imagined the case when send(msg) returns, the msg is still in output buffer and then the connection drops due e.g. to faint signal (not voluntary close). (I understand ERTM guarantees atomic delivery of message, but I don't think it blocks send() until the message is safely at the other side.)

The sock stays connected, if such error happen it will be disconnected
and error will be reported. Also blocking on sending doesn't guarantee
if you data will be delivered.

-- 
Gustavo F. Padovan
http://padovan.org

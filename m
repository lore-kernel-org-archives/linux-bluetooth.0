Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <8D8F1AA1-A7C1-4636-BB75-1EF1A2E1A556@signove.com>
References: <201005071302.36198.jcaden@libresoft.es> <20100507120859.GD12461@vigoh>
	<k2taa32413d1005071125ob7ce6505q8bb2cc57a77f1c8f@mail.gmail.com>
	<20100507195704.GC4857@vigoh> <8D8F1AA1-A7C1-4636-BB75-1EF1A2E1A556@signove.com>
From: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Date: Sun, 9 May 2010 22:08:04 -0300
Message-ID: <u2paa32413d1005091808n54065c98o26ac89de1dde8770@mail.gmail.com>
Subject: Re: Data transmission and reconnections in HDP
To: =?UTF-8?Q?Elvis_Pf=C3=BCtzenreuter?= <epx@signove.com>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	=?UTF-8?Q?Jos=C3=A9_Antonio_Santos_Cadenas?= <jcaden@libresoft.es>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, May 7, 2010 at 18:18, Elvis Pfützenreuter <epx@signove.com> wrote:
>
>>> I guess the problem Jose tried to address here is the case that HDP
>>> had temporarily disconnected the data channel and then the application
>>> try to write to the FD (which will be closed). Some data may be lost
>>> by the application on this process.
>>
>> If you are using Streming Mode you really don't care, if ERTM an error
>> will be reported and the application will get notified. ;)
>
> Ok, I think we have a conclusion, the Libresoft guys were right all along.
>
> Since the IEEE protocol over the data channel is a request-indication guy, one of these possible scenarios will happen:
>
> a) send request, receive indication
> b) send request, socket closes
> c) send request, socket closes, MCAP connection dropped feedback
>
> Our problem is the (b) case. We don't know if the request arrived at the other end. So the application must be able to replay the request upon receving the new socket for the same data channel. The reconnection itself does not need to be notified (though fd replacement is a clear sign that it happened.). And best of all, we can pass the L2CAP socket itself, not a pipe.
>
> The only thing that must be crystal clear in API is: the fd socket may get invalid anytime, and the application must be able to replay the pending requests. The reconnection is "transparent" pero no mucho :)
>

Automatic reconnection should happen only in the case HDP has
disconnected the transport for power-saving, because the data layer is
idle, doesn't it? So will (b) ever happen? In the case the connection
is dropped (loss of signal etc) the data layer should always be
notified IMO (case c).

-- 
João Paulo Rechi Vita
http://jprvita.wordpress.com/

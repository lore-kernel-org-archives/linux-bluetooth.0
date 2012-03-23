Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1332434275-25394-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1332434275-25394-1-git-send-email-frederic.dalleau@linux.intel.com>
Date: Fri, 23 Mar 2012 11:14:55 -0300
Message-ID: <CABBYNZKLCzWb-SD7-g+J0thtg8-016_QtC9FOD+Xqv+hVXwhRg@mail.gmail.com>
Subject: Re: [RFC 0/7] A2DP MP3 support with media API
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

2012/3/22 Frédéric Dalleau <frederic.dalleau@linux.intel.com>:
> Hi,
>
> I'm trying to make A2DP MP3 work in pulseaudio using media API.
> In contrast to Unix API, media API lacks the possibility to reconfigure the
> transport BT_SET_CONFIGURATION. So I've defined a dbus API that offers a
> similar functionnality.
> First there is a MediaTransport.Codecs property to list supported codecs on a
> transport.
> Then there is a Reconfigure method that tries to reconfigure the transport
> to use a specified endpoint.
>
> I'm sending a patch on pulseaudio list for using this new APIs at same time.
>
> This is an RFC so feel free to comment, especially on the way a configuration
> could be specified.

I don't think reusing the same transport object is the best approach
here, I would prefer to create a new one and reconfigure transparently
when switching instead of trying to use the same transport. Btw with
A2DP we could in theory have multiple streams configured
simultaneously, so we could have multiple transports configured,
actually even active as AVDTP Start can take a list of seid, now we
could face some iop problems with such approach but we could rely on
AVDTP Close.


-- 
Luiz Augusto von Dentz

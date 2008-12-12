Return-Path: <cyrus@holtmann.org>
Subject: Re: Adapter API - Devices property not updated if connection
 initiated by remote device
From: Marcel Holtmann <marcel@holtmann.org>
To: Bea Lam <blam@trolltech.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <200812121452.37564.blam@trolltech.com>
References: <200812111357.59004.blam@trolltech.com>
	 <1229046197.22285.21.camel@violet.holtmann.net>
	 <200812121452.37564.blam@trolltech.com>
Content-Type: text/plain
Date: Fri, 12 Dec 2008 11:58:47 +0100
Message-Id: <1229079527.22285.38.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bea,

can you please stop top-posting. Like every other open source mailing
list we are using bottom-posting and you are just destroying the flow of
the replies with top-posting. And KMail is perfectly capable of doing
so ;)

> Yes, FindDevice() is useful when I need to check whether a particular device 
> is connected at the moment. But what if I don't know the address of the 
> connecting device? That is, should BlueZ also be able to tell me when some 
> random, unknown device connects to me?

I think we do create a temporary device structure for incoming
connections in all cases since that is needed for pairing. However we
might not add this to the Devices list.

Johan, any comments here. Should we just send out signals? I think the
current reason for not doing so is that in most cases this is during a
pairing event and we do wanna wait until it succeeds. However I don't
see the big harm in adding it to the list.

Regards

Marcel



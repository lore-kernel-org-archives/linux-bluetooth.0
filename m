Return-Path: <cyrus@holtmann.org>
Subject: Re: possible recursive locking in 2.6.30-rc6
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Hartkopp <oliver@hartkopp.net>
Cc: Dave Young <hidave.darkstar@gmail.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <4A1CD504.9090202@hartkopp.net>
References: <4A1A9D1D.2050301@hartkopp.net> <4A1AF7B0.4020701@hartkopp.net>
	 <4A1BA619.4040401@hartkopp.net>
	 <a8e1da0905261813i3577af33g101336259a51c03c@mail.gmail.com>
	 <4A1CD504.9090202@hartkopp.net>
Content-Type: text/plain
Date: Wed, 27 May 2009 08:27:25 +0200
Message-Id: <1243405645.20399.9.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

> > Could you try the attached patch and report your result?
> > 
> 
> that fixed the problem!
> 
> BT DUN is working properly again. Many thanks!
> 
> Tested-by: Oliver Hartkopp <oliver@hartkopp.net>

thanks for testing. I am going to queue this up for upstream inclusion.

Regards

Marcel



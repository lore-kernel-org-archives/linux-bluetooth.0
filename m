Return-Path: <cyrus@holtmann.org>
Subject: Re: regression introduced on v2.6.30-rc1
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <2d5a2c100906230651m679ccfat5bf4bfb20c130955@mail.gmail.com>
References: <2d5a2c100906090617m167d3815pae998d06bdbd6646@mail.gmail.com>
	 <2d5a2c100906210708x1816e5d9hb9a80c82d76da6dd@mail.gmail.com>
	 <1245595707.15367.66.camel@violet>
	 <2d5a2c100906210930q394fcf77hcd2bf39c26ae74f8@mail.gmail.com>
	 <1245603529.15367.68.camel@violet>
	 <2d5a2c100906211047n31b9d4dajac290601c184380b@mail.gmail.com>
	 <1245611096.15367.76.camel@violet>
	 <2d5a2c100906221449y6e37cb19x1bc27085bac318f4@mail.gmail.com>
	 <2d5a2c100906221608v5e3e3d8aydf66b13826ad88fa@mail.gmail.com>
	 <2d5a2c100906230651m679ccfat5bf4bfb20c130955@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 23 Jun 2009 16:40:36 +0200
Message-Id: <1245768036.15367.78.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> Cleanup version, which include code style fixing suggested by Johan on irc.
> 
> There are 2 other things that comes to my mind that need discussing:
> 
>  - 20 sec timeout is perhaps too big
>  - clear the timer on rfcomm_session_close is perhaps not save then we
> can move it to rfcomm_session_del

what about just triggering the timer and then sending DISC for DLCI 0. I
don't see a big benefit for this reference counting overhead.

When we send the DISC, we will receive UA and thus get the required
rfcomm_session_put() that then leads to the ACL disconnect.

Regards

Marcel



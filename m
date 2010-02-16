Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Fix signal watch when a service name is given
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <2d5a2c101002160715l7f9a2f07y4a40b19e31fa98b3@mail.gmail.com>
References: <2d5a2c101002160659j1fd3fff8hc5418ddb7481b25d@mail.gmail.com>
	 <2d5a2c101002160715l7f9a2f07y4a40b19e31fa98b3@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 16 Feb 2010 07:37:08 -0800
Message-ID: <1266334628.8849.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> > This should fix g_dbus_add_signal_watch when a service like org.bluez is given.
> 
> 
> Updating since the last one was broken.

I also think that in check_service() we actually have a missing call to
dbus_pending_unref(). That would cause a memory leak.

Regards

Marcel



Return-Path: <cyrus@holtmann.org>
Message-ID: <1356894144.19248.85.camel@aeonflux>
Subject: Re: [PATCH BlueZ 00/11] Add experimental command line switch option
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sun, 30 Dec 2012 11:02:24 -0800
In-Reply-To: <1356699069-5469-1-git-send-email-luiz.dentz@gmail.com>
References: <1356699069-5469-1-git-send-email-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> These set of patches introduces g_dbus_set_flags along with experimental flags,
> g_dbus_set_flags is not per connection as originally suggested to avoid using
> dbus_connection_allocate_data_slot which requires calling
> dbus_connection_free_data_slot once done but currently we don't keep any data
> associated with connections, besides the flags comes from command line options
> which would end up setting the same flags for every connection anyway.
> 
> In addition to experimental it also add support to enable deprecated via compat
> swith option, this makes any API marked as deprecated to be disabled if compat
> is not set. This is on purpose to expose applications using deprecated APIs.

besides the deprecated switch, all patches have been applied.

Regards

Marcel



Return-Path: <cyrus@holtmann.org>
Message-ID: <1357937240.1806.83.camel@aeonflux>
Subject: Re: [PATCH BlueZ 2/7] gdbus: Add g_dbus_proxy_get_client function
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 11 Jan 2013 12:47:20 -0800
In-Reply-To: <1357905018-23237-2-git-send-email-luiz.dentz@gmail.com>
References: <1357905018-23237-1-git-send-email-luiz.dentz@gmail.com>
	 <1357905018-23237-2-git-send-email-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> This is convenient as some callbacks don't provide the client which
> the proxy belongs.

and I did not add that one on purpose. You should know where your proxy
belongs to and worst case hand it over via user_data.

Regards

Marcel



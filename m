Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] g_dbus_remove_watch function
From: Marcel Holtmann <marcel@holtmann.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <f9d4bd31002111306h143c82den71b0e89c41c98463@mail.gmail.com>
References: <f9d4bd31002111306h143c82den71b0e89c41c98463@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 12 Feb 2010 18:57:51 +0100
Message-ID: <1265997471.21559.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

> this patch removes an unnecessary argument(D-Bus connection) of
> g_dbus_remove_watch.

I would prefer if we keep it. In theory we can open watches on per
connection basis. And keep the watch id based on this connection.

Regards

Marcel



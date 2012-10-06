Return-Path: <cyrus@holtmann.org>
Message-ID: <1349530857.27233.45.camel@aeonflux>
Subject: Re: [PATCH BlueZ 1/9] gdbus: Remove connection from
 g_dbus_remove_watch
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 06 Oct 2012 15:40:57 +0200
In-Reply-To: <1349472050-25928-1-git-send-email-luiz.dentz@gmail.com>
References: <1349472050-25928-1-git-send-email-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> The connection is not really needed since the list of listeners is
> global not per connection, besides it is more convenient this way as
> only the id is needed.

they are not global, they are per connection. That we do not fully
implement this correctly is another story. That should be fixed here.

Regards

Marcel



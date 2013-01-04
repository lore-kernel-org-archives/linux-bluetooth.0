Return-Path: <cyrus@holtmann.org>
Message-ID: <1357277776.19248.131.camel@aeonflux>
Subject: Re: [PATCH BlueZ] gdbus: Don't include just added interfaces in
 GetManagedObjects
From: Marcel Holtmann <marcel@holtmann.org>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 03 Jan 2013 21:36:16 -0800
In-Reply-To: <1357270424-24036-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1357270424-24036-1-git-send-email-lucas.demarchi@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

> If we received a call to ObjectManager.GetManagedObject we should not
> include in the response the interfaces in data->added. This is because
> it's not guaranteed that those interfaces will trigger an
> InterfacesAdded signal, which is the case if the interface is removed in
> the same mainloop iteration.
> ---
>  gdbus/object.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

patch has been applied.

Regards

Marcel



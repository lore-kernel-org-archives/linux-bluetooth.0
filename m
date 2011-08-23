Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/2] serial: Add support to Disconnect fd passing
 connections
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 23 Aug 2011 09:18:13 -0700
In-Reply-To: <1314033585-22244-2-git-send-email-padovan@profusion.mobi>
References: <1314033585-22244-1-git-send-email-padovan@profusion.mobi>
	 <1314033585-22244-2-git-send-email-padovan@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1314116296.3373.213.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> Disconnect can also be called for connections created with ConnectFD
> ---
>  doc/serial-api.txt |    3 +++
>  serial/port.c      |   14 ++++++++++----
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/doc/serial-api.txt b/doc/serial-api.txt
> index 98b0ad4..09a4c0d 100644
> --- a/doc/serial-api.txt
> +++ b/doc/serial-api.txt
> @@ -53,5 +53,8 @@ Methods		fd ConnectFD(string pattern) [experimental]
>  			In that case one of patterns of the Connect method should
>  			be suplied instead of the TTY device.
>  
> +			Connection created with Serial.ConnectFD only accept
> +			as parameter the same parameters ConnectFD accepts.
> +
>  			Possible errors: org.bluez.Error.InvalidArguments
>  					 org.bluez.Error.DoesNotExist

I really fail to see how this is all going to work. We already had this
problem with the PrivateNetwork API in ConnMan. We can not use the fd as
a unique reference.

Having the file descriptor instead of a TTY is a great idea, but
unfortunately it is not all this simple.

Regards

Marcel



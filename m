Return-Path: <cyrus@holtmann.org>
Message-ID: <1357277531.19248.129.camel@aeonflux>
Subject: Re: [PATCH BlueZ 2/3] gdbus: Simplify generated introspection
From: Marcel Holtmann <marcel@holtmann.org>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org,
	Lucas De Marchi <lucas.de.marchi@gmail.com>
Date: Thu, 03 Jan 2013 21:32:11 -0800
In-Reply-To: <1357262465-19231-2-git-send-email-lucas.demarchi@profusion.mobi>
References: <1357262465-19231-1-git-send-email-lucas.demarchi@profusion.mobi>
	 <1357262465-19231-2-git-send-email-lucas.demarchi@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

> The generated introspection is not supposed to be read as is by human,
> so there's no point in printing the indentation or writing more code to
> use auto-close tags.
> 
> If it's desired to read the raw xml file, user can always use other
> tools to transform the output such as "xmllint --format".
> 
> This also fixes a missing </property> when property is deprecated.
> ---
>  gdbus/object.c | 103 +++++++++++++++++++++------------------------------------
>  1 file changed, 38 insertions(+), 65 deletions(-)

patch has been applied.

Regards

Marcel



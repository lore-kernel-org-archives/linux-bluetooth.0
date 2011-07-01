Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/2] Add common macro for safely deriving the size of
 array
From: Marcel Holtmann <marcel@holtmann.org>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 01 Jul 2011 14:59:02 -0700
In-Reply-To: <1309546401-19867-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1309546401-19867-1-git-send-email-lucas.demarchi@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1309557544.8855.5.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

> This provides a simple ARRAY_SIZE() macro, which (given a good compiler)
> will also break compile if you try to use it on a pointer. This can
> ensure your code is robust to changes, without needing a gratuitous
> macro or constant. Credits to Rusty Russell
> (http://ccan.ozlabs.org/info/array_size.html)
> 
> Having a util.h file, this kind of things can be shared among all users
> and we can remove all the declarations of ARRAY_SIZE.
> ---
>  acinclude.m4 |   22 ++++++++++++++++++++++
>  configure.ac |    1 +
>  src/util.h   |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 78 insertions(+), 0 deletions(-)
>  create mode 100644 src/util.h

I am not sure that I actually want this. Where are the use cases of
ARRAY_SIZE actually. Maybe we should just change them with proper NULL
terminated arrays or other constants.

Regards

Marcel



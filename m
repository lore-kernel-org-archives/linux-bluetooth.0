Return-Path: <Johan.Hedberg@nokia.com>
Date: Mon, 26 Nov 2007 16:12:12 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Cc: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-devel] [PATCH] Bluez exceptions refactoring updated
	patch
Message-ID: <20071126141212.GA6437@localhost>
References: <4749E9DB.3020801@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4749E9DB.3020801@free.fr>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Fabien,

On Sun, Nov 25, 2007, Fabien Chevalier wrote:
> I finally managed to spend a few hours of my spare time on Bluez.
>
> As a result i updated the patch that updates the common/ directory as well 
> as the various services to share the exceptions definition.
>
> Changes compared to previous version:
>  - renamed the common .h and .c as error.h and error.c
>  - completely removed various error.{c,h} from services directory
>  - updated api documentation (dbus-api.txt + services api definition).
>
> The patch is pretty big, if needed i can provided splitted patches for 
> various directories.

The patch is now fixed, split into parts and commited to the CVS as
Marcel suggested so no need to do further work on that part.

Johan

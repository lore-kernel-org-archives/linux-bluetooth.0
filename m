Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Add rfkill plugin
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1248798884.23466.12024.camel@localhost.localdomain>
References: <1248798884.23466.12024.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 28 Jul 2009 22:06:33 +0200
Message-Id: <1248811593.28545.227.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> The plugin allows us to restore the previous power state on
> adapters when the killswitch on them has been unblocked.
> 
> Otherwise we end up with the adapter disabled when coming back from a
> soft killswitch.

I think that having this as a plugin is overkill. I would just integrate
this as src/rfkill.c. Especially since it has no dependencies.

Regards

Marcel



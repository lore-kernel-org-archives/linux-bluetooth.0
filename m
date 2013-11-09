Return-Path: <cyrus@holtmann.org>
Message-ID: <1384016658.3880.39.camel@nuvo>
Subject: Re: [PATCH 1/3] gdbus: Don't try to remove removed sources
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Sat, 09 Nov 2013 18:04:18 +0100
In-Reply-To: <1384016577.3880.36.camel@nuvo>
References: <1384016577.3880.36.camel@nuvo>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, 2013-11-09 at 18:02 +0100, Bastien Nocera wrote:
> When we return FALSE from idle handlers, the source is removed.
> This will be causing warnings in glib 2.40.
> 
> See https://bugzilla.gnome.org/show_bug.cgi?id=710724

Note that there's plenty of other places where this should be fixed.
I'll leave those up to somebody who doesn't get RSI ;)


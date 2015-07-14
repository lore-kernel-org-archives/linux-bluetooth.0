Return-Path: <cyrus@holtmann.org>
Message-ID: <1436873556.20249.50.camel@hadess.net>
Subject: Re: Reaching out again for serious bug in sixaxis plugin
From: Bastien Nocera <hadess@hadess.net>
To: Sergey Kondakov <virtuousfox@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>,
	Szymon Janc <szymon.janc@gmail.com>
Date: Tue, 14 Jul 2015 13:32:36 +0200
In-Reply-To: <55A4BA19.6030109@gmail.com>
References: <55A4BA19.6030109@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2015-07-14 at 12:28 +0500, Sergey Kondakov wrote:
> Since both my attempts, in kernel bugzilla and here, were ignored and
> you still don't have your own bugtracker I repeat my plea from
> previously with plugin's authors CCed in hope that bug's existence at
> least would be acknowledged.

Did you re-read your original mail? Are you genuinely still wondering
why you didn't receive an answer?

> Details are in 
> http://article.gmane.org/gmane.linux.bluez.kernel/62305
> Moreover, this livecd is almost identical to my running system which 
> is
> based on it, so it may be used to reproduce the glitch (antimicro,
> jstest and evtest should help):
> http://sourceforge.net/projects/hackeurs-sans
> -frontieres/files/0.8.1%20-%20The%20White%20Devil/Linux%20Live%20
> -%20HSF%20-%200.8.1_20150708.iso/download
> If it could not be reproduce I'm afraid it may be a bug in handling 
> my
> BT controller.
> 
> Also, this kernel patch or a better alternative still hasn't been
> applied and that's no good: 
> https://patchwork.kernel.org/patch/1075972/

The device is connected correctly via Bluetooth. Then the bug is in the
device's input driver, which you could probably also see when it's
connected via USB. The right forum for this is the linux-input mailing
-list.

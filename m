Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Nov 2009 12:04:21 +0100
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
To: BlueZ devel list <linux-bluetooth@vger.kernel.org>
Subject: Re: PAND error?
Message-ID: <20091110120421.00dd42c9@strolchi.home.s3e.de>
In-Reply-To: <4AF8CE07.402@tozzi.eu>
References: <4AF8CE07.402@tozzi.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 10 Nov 2009 03:20:55 +0100
Gabriele Tozzi <gabriele@tozzi.eu> wrote:

> Hello,
> 
> after a system update, I got a nice "success" pand error issuing the
> command:
> 
> pand --connect <address>
> 
> The error is:
> 
> Connect to <address> failed. Success(0)
> 
> I'm trying to connect to a Windows Mobile NAP to be a PANU. Everyting
> worked fine util some weeks ago.

I am successfully using the dbus API to achieve that as written here:
http://seife.kernalert.de/blog/2009/08/10/using-pannap-instead-of-rfcommppd/
-- 
Stefan Seyfried

"Any ideas, John?"
"Well, surrounding them's out."

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1503599405.12938.1.camel@hadess.net>
Subject: Re: [PATCH 1/3] build: Enable BIND_NOW
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Florian Weimer <fweimer@redhat.com>
Date: Thu, 24 Aug 2017 20:30:05 +0200
In-Reply-To: <20170824182824.8465-1-hadess@hadess.net>
References: <20170824182824.8465-1-hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2017-08-24 at 20:28 +0200, Bastien Nocera wrote:
> From: Florian Weimer <fweimer@redhat.com>
> 
> Partial RELRO means that the object is GNU_RELRO but not
> BIND_NOW.  This
> reduces the effectiveness of RELRO.  bluez triggers this because it
> enables PIE during the build, and rpmdiff takes this as an indicator
> that the best possible hardening is desired.
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=983161

Florian made the comments, I made the patch and sent it. Feel free to
remove the internal Bugzilla reference before pushing.

Cheers

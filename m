Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1511796502.11411.33.camel@hadess.net>
Subject: Re: [PATCH v2 1/2] autopair: Add more common PIN codes for audio
 devices
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Mon, 27 Nov 2017 16:28:22 +0100
In-Reply-To: <20171127152651.18997-1-hadess@hadess.net>
References: <20171127152651.18997-1-hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2017-11-27 at 16:26 +0100, Bastien Nocera wrote:
> PIN codes "1111", and "1234" are fairly common PIN codes used for
> audio
> devices such as speakers and headsets. This replaces similar quirks
> already present in gnome-bluetooth's PIN database.

V2 of this patch, I've tested it again, and it seems to work in my
tests. I've also added another special case for gaming input devices
and remote controls in a second patch.

Cheers

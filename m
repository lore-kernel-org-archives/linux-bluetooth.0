Return-Path: <cyrus@holtmann.org>
Message-ID: <1339665747.3987.73.camel@novo.hadess.net>
Subject: Re: [PATCH 00/21] BlueZ 5.0 patches
From: Bastien Nocera <hadess@hadess.net>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Date: Thu, 14 Jun 2012 10:22:27 +0100
In-Reply-To: <1339620223-6639-1-git-send-email-gustavo@padovan.org>
References: <1339620223-6639-1-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2012-06-13 at 17:43 -0300, Gustavo Padovan wrote:
> 
>   remove compat daemons 

Seeing as I can't find 01/21 on the mailing-list (too big?).


> compat/hidd.1                      |   41 -
> compat/hidd.c                      |  848 --------

We need something to replace hidd --show, for debugging purposes.

> compat/fakehid.c                   |  669 ------

Is there something to replace the support for those devices? Nobody
seems to have added the support to input/fakehid.c which would be the
logical place.


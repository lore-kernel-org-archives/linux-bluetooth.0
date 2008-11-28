Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Move PIN codes to an external database
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1227886615.26649.1181.camel@cookie.hadess.net>
References: <1227886615.26649.1181.camel@cookie.hadess.net>
Content-Type: text/plain
Date: Fri, 28 Nov 2008 16:50:46 +0100
Message-Id: <1227887446.19071.1.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> This is a patch to move the PIN quirks to an external tab-separated text
> file. The parser is very simple and naive, but does the job for all the
> devices I tested.
> 
> string_to_type() should probably be using an array instead of the
> current code, and I've managed to move the current quirks to the
> external file without a problem.
> 
> When this gets in, I'll work on moving all the quirks filed as bugs
> against the wizard[1] into bluez-gnome proper.

should we not better store this in GConf?

Regards

Marcel



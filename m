Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: Bluez with uclibc
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <747C1E83C744F44E9ACFB89FAEEC2C7B2414E86034@EXDCVYMBSTM005.EQ1STM.local>
Date: Mon, 8 Jul 2013 12:02:46 -0700
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <601DC609-FB98-4A61-89E1-2EBC8639F667@holtmann.org>
References: <747C1E83C744F44E9ACFB89FAEEC2C7B2414E86034@EXDCVYMBSTM005.EQ1STM.local>
To: Julien COUVRAND <julien.couvrand@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Julien,

> Today, I need to cross compile Bluez for arm with uclibc library into Buildroot environment. 
> However, I meet some dependencies between bluez-utils package and MMU deactivation due to dBus.
> 
> Do you know a way to use Bluez with uclibc library?

you need to be more specific. I know from projects successfully building BlueZ with uclibc in the past, but I am not doing such thing on a daily basis. So things might have changed. What are the logs or errors you see?

Regards

Marcel


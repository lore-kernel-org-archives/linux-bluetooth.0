Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Add sixaxis cable-pairing plugin
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1244107722.30768.837.camel@cookie.hadess.net>
References: <1244107722.30768.837.camel@cookie.hadess.net>
Content-Type: text/plain
Date: Thu, 04 Jun 2009 20:13:59 +0200
Message-Id: <1244139239.23850.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> Works for me, comments welcome.
> 
> It uses gudev. See http://blog.fubar.dk/?p=106

no way. Please use just plain libudev and spare use the GObject
overhead. I have used libudev before and it is just fine. Not that I
have actually looked at your patch at all.

Regards

Marcel



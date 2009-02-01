Return-Path: <cyrus@holtmann.org>
Subject: Re: wifi coexistence II
From: Marcel Holtmann <marcel@holtmann.org>
To: Paulo Bustelo Codesido <pbustelo@ontouch.es>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1709A787-A8E2-4D2A-BBDB-3C09301FCFC5@ontouch.es>
References: <1709A787-A8E2-4D2A-BBDB-3C09301FCFC5@ontouch.es>
Content-Type: text/plain
Date: Sun, 01 Feb 2009 17:54:57 +0100
Message-Id: <1233507297.4809.5.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Paulo,

> As far as I know with hcitool afh I can just read the afh map...
> 
> I'm checking with this command
> 
> Set AFH Host Channel Classification (0x03|0x003f)
> 
> running every second...
> 
> but it seems to have no efect...
> my problem is during inquiring....
> is afh working in inquire mode?
> what more can I try?

you have to write your own command that actually sets the AFH map. The
hcitool only reads it.

However during inquiry you have lost anyway. It is using a fixed
frequency hopping.

Regads

Marcel



Return-Path: <cyrus@holtmann.org>
Subject: Re: Does anyone help me to setup PAN connection?
From: Marcel Holtmann <marcel@holtmann.org>
To: chanyeol.park@samsung.com
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <3708754.307311228983254624.JavaMail.weblogic@epml14>
References: <3708754.307311228983254624.JavaMail.weblogic@epml14>
Content-Type: text/plain
Date: Fri, 12 Dec 2008 02:41:14 +0100
Message-Id: <1229046074.22285.19.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> Does anyone help me to setup PAN connection?
> 
> Environment
> NAP Role : Note PC . Windows XP, JABRA a320s stack (BT address 00:16:38:BF:12:C4)
> PAN Role : Desktop Linux 2.6.24-22-generic BlueZ 4.22 
> 
> 
> I use dbus-send connect command like this.
> #>dbus-send --system --type=method_call --print-reply --dest="org.bluez" /org/bluez/10043/hci0/dev_00_16_38_BF_12_C4 org.bluez.Network.Connect string:"00001116-0000-1000-8000-00805f9b34fb"

might be a bug with the UUID. Try using "nap".

Regards

Marcel



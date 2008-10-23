Return-Path: <cyrus@holtmann.org>
Subject: Re: Could you explain how to discover remote devices without
	periodic inquiry ?
From: Marcel Holtmann <marcel@holtmann.org>
To: chanyeol.park@samsung.com
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <22696206.256481224054636606.JavaMail.weblogic@epml03>
References: <22696206.256481224054636606.JavaMail.weblogic@epml03>
Content-Type: text/plain; charset=utf-8
Date: Thu, 23 Oct 2008 06:53:30 +0200
Message-Id: <1224737610.9386.175.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> Could you explain how to discover remote devices without periodic inquiry ? 
> When I send dbus command “dbus-send --system --type=method_call  --dest="org.bluez" /org/bluez/hci0 org.bluez.Adapter.StartDiscovery“, Bluetooth module starts periodic search. 
> 
> I just want only normal search. Even though I have an experience of Bluez 3.x. it's not easy to use BlueZ 4.x API.  

there is no real difference in Periodic Inquiry and Inquiry from the
baseband point of view. Check the Bluetooth specification.

Regards

Marcel



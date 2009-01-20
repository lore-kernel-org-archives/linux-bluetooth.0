Return-Path: <cyrus@holtmann.org>
Subject: Re: hcitool link quality
From: Marcel Holtmann <marcel@holtmann.org>
To: Guido Fischer <fischer_guido@yahoo.de>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <397412.35398.qm@web27903.mail.ukl.yahoo.com>
References: <397412.35398.qm@web27903.mail.ukl.yahoo.com>
Content-Type: text/plain
Date: Tue, 20 Jan 2009 10:29:52 +0100
Message-Id: <1232443792.4655.1.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Guido,

> I'm using the bluez implementation for a prototype I developed for my thesis. Therefor I would need to know how the link quality is calculated (or at least its unit) when calling "hcitool lq <bdaddr>".  I looked into the hcitools bluez provides but only got as far as hci_read_link_quality. Probably someone can give me some infos on the calculations or a direction where to look at.

if you read the Bluetooth specification, then you see that this is
vendor specific. It depends on the chip manufacturer.

Regards

Marcel



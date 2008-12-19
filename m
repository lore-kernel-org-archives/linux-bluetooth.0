Return-Path: <cyrus@holtmann.org>
Subject: Re: [bluez-gnome/proximity] replace g_timeout_add with
 g_timeout_add_seconds
From: Marcel Holtmann <marcel@holtmann.org>
To: Baptiste Mille-Mathias <baptiste.millemathias@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1229686032.6392.4.camel@oak>
References: <1229686032.6392.4.camel@oak>
Content-Type: text/plain
Date: Fri, 19 Dec 2008 19:50:35 +0100
Message-Id: <1229712635.879.3.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Baptiste,

> Please find attached a patch to replace the usage of g_timeout_add with
> g_timeout_add_seconds in the proximity application in bluez-gnome.
> g_timeout_add_seconds does less wake up, ans so saves a little bit of
> power.

patch has been applied. Thanks.

Regards

Marcel



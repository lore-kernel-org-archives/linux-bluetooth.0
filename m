Return-Path: <cyrus@holtmann.org>
Subject: Re: /var/lib/bluetooth/$BDADDR/names, when does that file get
 updated?
From: Marcel Holtmann <marcel@holtmann.org>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20081212180131.GI19659@vanheusden.com>
References: <20081212180131.GI19659@vanheusden.com>
Content-Type: text/plain
Date: Fri, 19 Dec 2008 19:59:54 +0100
Message-Id: <1229713194.879.10.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Folkert,

> When does /var/lib/bluetooth/$BDADDR/names get updated?
> Because hcitool inq does not tell the names while hcitool scan does not
> tell class of the devices.

every time a HCI remote name complete event is received. Or in case of
Bluetooth 2.1 when an Extended Inquiry Result with name information is
recieved.

Regards

Marcel



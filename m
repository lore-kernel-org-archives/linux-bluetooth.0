Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2316A524B7DB8C4AB39B9EDEDF597C8F015B35BB064F@EXGMBX01.sasken.com>
References: <2316A524B7DB8C4AB39B9EDEDF597C8F015B35BB064F@EXGMBX01.sasken.com>
Date: Tue, 3 Apr 2012 13:59:23 +0200
Message-ID: <CACLukz+SboBt-XZ5+gPX3L4d6S-BUiP4s-cq-S1KcsTxwEfPkA@mail.gmail.com>
Subject: Re: how to test thermometer profile using existing example available
 in bluez
From: Santiago Carot <sancane@gmail.com>
To: Anju Manoj <anju.manoj@sasken.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anju,

2012/4/3 Anju Manoj <anju.manoj@sasken.com>:
>
> Hi all
>
>              Can u share how to test thermometer python script available in bluez4.99
>

In order to test the thermometer pythin script, just run it and pair a
device which implements the health Thermometer service. The script
will show you every measurements collected. You can also set the
EnableIntermediateMeasurement flag if your device supports it.

Regards.

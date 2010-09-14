Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC] BlueZ D-Bus Sim Access Profile Server API description
From: Marcel Holtmann <marcel@holtmann.org>
To: Suraj Sumangala <suraj@atheros.com>
Cc: linux-bluetooth@vger.kernel.org, Jothikumar.Mothilal@Atheros.com
In-Reply-To: <1284374584-12282-1-git-send-email-suraj@atheros.com>
References: <1284374584-12282-1-git-send-email-suraj@atheros.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 14 Sep 2010 14:42:26 +0900
Message-ID: <1284442946.2405.50.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

> Below is the Sim Access Profile server role API discription.
> Please let me know your comments.

my obvious question is why do we wanna do this over D-Bus and not
connect it directly to the hardware via a plugin?

Remember that SIM transaction are timing critical and just relaying them
over D-Bus doesn't sound the right approach right now. While of course
even bluetoothd can't guarantee and response time, it is clearly better
than over D-Bus.

Regards

Marcel



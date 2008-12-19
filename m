Return-Path: <cyrus@holtmann.org>
Subject: Re: BlueZ and Secure Simple Pairing
From: Marcel Holtmann <marcel@holtmann.org>
To: Jeroen Egelmeers <Jeroen.Egelmeers@tomtom.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <C3C930591D7B9D4083B73AC7CB7A5FF3046F4A55@nl-exc-02.intra.local>
References: <C3C930591D7B9D4083B73AC7CB7A5FF3046F4A55@nl-exc-02.intra.local>
Content-Type: text/plain
Date: Fri, 19 Dec 2008 07:58:57 +0100
Message-Id: <1229669937.17082.28.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jeroen,

> I am using BlueZ 3.24 and
> I am trying to enable Secure Simple Pairing. Does version 3.24 contain
> proper functionality for SSP ? If not, which version does?
> Furthermore, can you give a quick start how to use SSP with BlueZ
> between my 2 devices? How should I determine/set the IO capabilities?

it is a better idea to use 4.22 for Simple Pairing support and it will
be enabled by default if the hardware supports it.

Regards

Marcel



Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <11f7a7550901090852s30060e38g7c9240731d3a9a4f@mail.gmail.com>
References: <11f7a7550901090850x4c276806v6c3c4bfad804986f@mail.gmail.com>
	 <11f7a7550901090852s30060e38g7c9240731d3a9a4f@mail.gmail.com>
Date: Sat, 10 Jan 2009 13:02:46 +0100
Message-ID: <11f7a7550901100402o790bd614ud46a613e2dce1dbd@mail.gmail.com>
Subject: Re: Inconsistencies with UUIDs in XML service descriptors
From: Daniele Benucci <d.benux@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2009/1/9 Daniele Benucci <d.benux@gmail.com>
> I've noticed a strange behaviour in the last versions of Bluez (at
> least >= 4.19) when retrieving services via the DBus method in
> org.bluez.Device.DiscoverServices:

I compiled 4.18 from source and the result of DiscoverServices reports
the correct UUIDs both for 16-bit and 128-bit

Daniele Benucci

--
Grabel's Law:
2 is not equal to 3 -- not even for large values of 2.

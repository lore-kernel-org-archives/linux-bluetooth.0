Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Sep 2009 21:16:44 +0100 (BST)
To: Jai Kishore <kishore.gj@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Unknown SDP Service UUID
In-Reply-To: <8073ecd30909170036l4fa7cf39q383ecc4430262e14@mail.gmail.com>
References: <8073ecd30909170036l4fa7cf39q383ecc4430262e14@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1253218604.644617.20563.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 17 Sep 2009, Jai Kishore wrote:

> Dear Team,
>
> When I try to connect my Bluetooth Mobile with some Hands Free device,
> it is asking for SDP request with service search uuid as 8E 77 13 02.
> The information regarding this uuid is not present in Bluetooth
> specifications at
> https://www.bluetooth.org/Technical/AssignedNumbers/service_discovery.htm.
>
> Can somebody kindly provide a pointer to the mentioned service search
> uuid or any other link which includes information about this service
> uuid.

if you google for 0x8e771302 you will find something. I don't know if its
much use since it only really gives references to the BlueZ sdptool which
knows about it as relating to "SEMC High Level Authentication". It seems
that SEMC is "Sony Ericsson Mobile Communications".

Much more information is found by googling "SEMC HLA" but I don't care to
wade through it, good luck!

iain



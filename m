Return-Path: <cyrus@holtmann.org>
Subject: Re: "packet types" wrong in libbluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: Iain Hibbert <plunky@rya-online.net>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1231595402.312160.19752.nullmailer@galant.ukfsn.org>
References: <1231595402.312160.19752.nullmailer@galant.ukfsn.org>
Content-Type: text/plain
Date: Sat, 10 Jan 2009 15:21:24 +0100
Message-Id: <1231597284.5229.2.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Iain,

> The HCI packet type functions ptypetostr() and strtoptype() in lib/hci.c
> don't work correctly. This is because the HCI spec is messed up wrt the 2
> and 3 Mbps packet types, which are indicated by inverted bit logic (see
> "Create Connection Command" in core spec document)

current situation is perfectly fine. It follows the spec. closely and
this means for EDR the types are inverted. Trying to make them looks
nice doesn't help. You should not mess with packet types at all. It is
the link managers' job to get this right.

Regards

Marcel



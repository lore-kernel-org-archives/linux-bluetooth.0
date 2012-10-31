Return-Path: <cyrus@holtmann.org>
Message-ID: <1351711915.1828.15.camel@aeonflux>
Subject: Re: BLE kernel supported
From: Marcel Holtmann <marcel@holtmann.org>
To: John Tobias <john.tobias.ph@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 31 Oct 2012 12:31:55 -0700
In-Reply-To: <CACUGKYNaeyTq-1+5=4DNhb6hc0jVCp=xsh705qXLCtgJ37z6Nw@mail.gmail.com>
References: <CACUGKYNaeyTq-1+5=4DNhb6hc0jVCp=xsh705qXLCtgJ37z6Nw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

> I am evaluating a dev board based on iMX6 chipset from freescale with
> Bluetooth LE in the next few days or so. The stable kernel for the
> said chipset is based on linux kernel 3.0.35.x and I am not sure if
> the Bluetooth "Low Energy" support is already part of the linux kernel
> 3.0.35.x.

you need at least a 3.5.x kernel. Any previous kernel does not have Low
Energy enabled.

Regards

Marcel



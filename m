Return-Path: <cyrus@holtmann.org>
Message-ID: <1341472848.1963.34.camel@aeonflux>
Subject: Re: BT LMP
From: Marcel Holtmann <marcel@holtmann.org>
To: victor yeo <victoryeo1974@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 05 Jul 2012 09:20:48 +0200
In-Reply-To: <CADX0rsZBM+2Sz564FrkVxe318dCFue_pea_OLpxvrk5bd9cHWQ@mail.gmail.com>
References: <CADX0rsZBM+2Sz564FrkVxe318dCFue_pea_OLpxvrk5bd9cHWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Victor,

> Anyone know which part of linux kernel processes the LMP au_rand and
> LMP not_accepted event?
> 
> I want to modify the Bluetooth kernel code so that when it receives
> LMP not_accepted event, it will do re-pairing.

LMP is implemented in the Bluetooth chip's firmware and not the kernel.

Regards

Marcel



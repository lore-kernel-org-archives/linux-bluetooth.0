Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] bluetooth: remove useless variable in virtual hci
 driver
From: Marcel Holtmann <marcel@holtmann.org>
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1256340575-19359-1-git-send-email-cascardo@holoscopio.com>
References: <1256340575-19359-1-git-send-email-cascardo@holoscopio.com>
Content-Type: text/plain
Date: Sat, 24 Oct 2009 17:41:28 +0900
Message-Id: <1256373688.7812.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Thadeu,

> Commit ac28494c has removed the option to give a minor number as
> parameter for VHCI driver. Remove the variable used for that parameter.
> Print the error code when registering the device fails, instead of the
> requested minor number (which would always be MISC_DYNAMIC_MINOR).

I see the point in removing the variable. That is clearly a leftover,
but what is the error code printing for? That is pointless since we can
just return misc_register(&vhci_miscdev); since it is the module loading
function. And in the exit module case I don't care. The misc_deregister
should not return an error to begin with. It is pointless. Fix up the
patch and re-sent it.

Regards

Marcel



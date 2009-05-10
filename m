Return-Path: <cyrus@holtmann.org>
Subject: Re: question on use of flags in btusb
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <200905101038.38169.oliver@neukum.org>
References: <200905101038.38169.oliver@neukum.org>
Content-Type: text/plain
Date: Sun, 10 May 2009 08:14:23 -0700
Message-Id: <1241968463.2880.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver

> btusb still has the BTUSB_INTR_RUNNING and BTUSB_BULK_RUNNING flags.
> This seems to collide with the need to keep interrupt and bulk running.
> Is this just legacy, a plan for future extensions or am I misunderstanding 
> things?

that is legacy. Feel free to remove them as needed.

Regards

Marcel



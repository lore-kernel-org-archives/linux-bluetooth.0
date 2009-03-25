Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] AVDTP Qualification: Fix error handling for AVDTP set
 configuration command
From: Marcel Holtmann <marcel@holtmann.org>
To: Nick Pelly <npelly@google.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <35c90d960903261651i46cb32c6qc061f7f718e3d669@mail.gmail.com>
References: <35c90d960903261651i46cb32c6qc061f7f718e3d669@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 26 Mar 2009 00:01:36 +0100
Message-Id: <1238022096.8206.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nick,

> +
> +               if ((cap->category == AVDTP_MEDIA_TRANSPORT) &&
> (cap->length != 0)) {
> +                       err = AVDTP_BAD_MEDIA_TRANSPORT_FORMAT;
> +                       goto failed;

no need to put brackets around cap->cat == ... check etc. The comparison
takes precedence over &&. Please fix and re-send the patch.

Regards

Marcel



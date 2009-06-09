Return-Path: <cyrus@holtmann.org>
Subject: Re: Problems building lexer.c in rfcomm
From: Marcel Holtmann <marcel@holtmann.org>
To: David Stockwell <dstockwell@frequency-one.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <C8BAD89E00F6479FBCA47D5EB8A39A98@freqonedev>
References: <C8BAD89E00F6479FBCA47D5EB8A39A98@freqonedev>
Content-Type: text/plain
Date: Tue, 09 Jun 2009 17:23:13 +0200
Message-Id: <1244560993.3068.15.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> I am working in audio/control.c, and cannot "make" bluez 4.40 (plus my 
> changes, all in audio/control.c).
> 
> The make is failing when building rfcomm/lexer.c:
> 
> cc1: warnings being treated as errors
> lexer.c: In function 'yy_get_next_buffer'
> lexer.c:1095: error: comparison between signed and unsigned
> 
> Has anyone else seen this error?  How did you deal with it or work 
> around it?

it is a compiler warning and should be fixed with newer Bison versions.
I don't see that one anymore.

Regards

Marcel



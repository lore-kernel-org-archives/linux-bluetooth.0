Return-Path: <Johan.Hedberg@nokia.com>
Date: Thu, 8 Apr 2004 13:38:26 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] weird behaviour with bluez and obex
Message-ID: <20040408103826.GA17349@kone>
References: <20040408100543.GA10479@kone> <1081419587.2970.11.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1081419587.2970.11.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

On Thu, Apr 08, 2004, Marcel Holtmann wrote:
> the rfcomm connect method allows you to specific the --raw switch which
> sets the resulting /dev/rfcommX device into TTY raw mode. By default the
> echoing is enabled on TTY's and this can cause problems.

This solved the problem. Thanks!

Johan

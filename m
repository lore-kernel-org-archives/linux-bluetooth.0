Return-Path: <justin-qt-dated-1065592592.7144db@affinix.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-devel] dtl1_cs suspend bug
Date: Tue, 23 Sep 2003 14:44:09 -0700
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
References: <200309220408.04569.justin-qt@affinix.com>
	<200309231409.47300.justin-qt@affinix.com> <1064353054.1620.40.camel@pegasus>
In-Reply-To: <1064353054.1620.40.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309231444.09863.justin-qt@affinix.com>
From: Justin Karneges <justin-qt@affinix.com>
List-ID: <bluez-devel.lists.sourceforge.net>

On Tuesday 23 September 2003 02:37 pm, Marcel Holtmann wrote:
> the main problem is the reset of the card itself. I actually don't know
> how to do this and I don't have the specs for this card.

Ok, so it appears that the resetting of the card itself is the issue at hand.

How did you write the rest of the driver without the specs?  It would seem if 
you were able to get this far, that deriving the reset function would be 
possible.

-Justin

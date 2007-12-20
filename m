Return-Path: <cyrus@holtmann.org>
From: Hendrik Sattler <post@hendrik-sattler.de>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-devel] SDP services cannot be unregistered
Date: Thu, 20 Dec 2007 22:40:33 +0100
References: <200712192341.02293.post@hendrik-sattler.de> <200712200229.40589.post@hendrik-sattler.de> <1198116580.8050.232.camel@aeonflux>
In-Reply-To: <1198116580.8050.232.camel@aeonflux>
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200712202240.34586.post@hendrik-sattler.de>
List-ID: <bluez-devel.lists.sourceforge.net>

Am Donnerstag 20 Dezember 2007 schrieben Sie:
> first of all you are using the unregister function wrongly. You have to
> give it the exact record structure you gave the register function. So
> when you allocate a new record, then the unregister has no idea what to
> do with it.

Ok, I remember now everything related to the record and it works. One note 
though: the sdp_record_free() function always crashes. Is it actually 
supposed to be used? Or asked the other way: how is one supposed to free the 
previously allocated stuff correctly? Or is this done automatically?

> Why it doesn't cleanup after program termination is unclear to me. That
> should actually work. You might wanna investigate on that one.

I will try that, although I took the way of catching SIGINT and SIGTERM, now.

Thanks for your help.

HS

Return-Path: <cyrus@holtmann.org>
Date: Thu, 6 Aug 2009 22:37:46 +0200
From: Andreas Volz <lists@brachttal.net>
To: linux-bluetooth@vger.kernel.org
Subject: Re: Adressbook with bluez?
Message-ID: <20090806223746.53e8f28d@frodo.mittelerde>
In-Reply-To: <1249585049.27046.7.camel@delphi>
References: <20090803202404.5d62b6a4@frodo.mittelerde>
	<20090804054928.GC26953@titan.makhutov-it.de>
	<1249585049.27046.7.camel@delphi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am Thu, 06 Aug 2009 20:57:29 +0200 schrieb Per Thomas Jahr:

> On Tue, 2009-08-04 at 07:49 +0200, Artem Makhutov wrote:
> > > If not, what is missing in the implementation to get it working?
> > 
> > You need to send special AT-Commands over the rfcomm like to the
> > phone.
> 
> I guess also the Bluetooth profiles PBAP and PAB can be used for this?
> Have no idea if bluez supports those profiles yet (some googling
> indicates that they are being worked on).
> 
> See:
> http://en.wikipedia.org/wiki/Bluetooth_profile#Phone_Book_Access_Profile_.28PBAP.2C_PBA.29

I found this:

http://gitorious.org/bluez-sap/bluez-sap/commit/e5fb1b8e7c900f6d9f9aebab0f77a20dbfec3121

Does someone know more about this. (I wrote also an E-Mail to the
commiter).

regards
Andreas

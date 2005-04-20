Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Documentation for development
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <200504201931.06626.alan@mizrahi.com.ve>
References: <200504192237.53314.alan-bluez@mizrahi.com.ve>
	 <1113989398.2469.95.camel@pegasus> <200504201931.06626.alan@mizrahi.com.ve>
Content-Type: text/plain
Message-Id: <1114040928.13803.14.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 21 Apr 2005 01:48:48 +0200

Hi Alan,

> > > I want to make a program that communicates with my cellphone through
> > > bluetooth.
> > >
> > > I already installed and configured the bluez packages, but I can't find
> > > the developers documentation, can anybody point me to the right place?
> >
> > the question is what kind of communication do you mean?
> >
> 
> Just basic synchronous communication.  I don't intend to transfer files, my 
> project is to be able to control a program from the cellphone (something like 
> RPC).  Maybe the cellphone will get some feedback from the commands too.
> 
> The cellphone program will be written in java-midp and the computer part in C.
> 
> So what do you suggest?
> Is there any documentation I can read about bluetooth development?

I have no idea how Java-MIDP works, but I think it will end up with a
program that communicates over RFCOMM. So rctest and attest are very
good examples.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

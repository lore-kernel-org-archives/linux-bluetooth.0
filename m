Return-Path: <cyrus@holtmann.org>
Subject: RE: [PATCH] BT_SECURITY_HIGH requires 16 digit pin code
From: Bastien Nocera <hadess@hadess.net>
To: Waldemar.Rymarkiewicz@tieto.com
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	joakim.xj.ceder@stericsson.com, johan.hedberg@gmail.com,
	arunkr.singh@stericsson.com
In-Reply-To: <99B09243E1A5DA4898CDD8B7001114480976E15A2C@EXMB04.eu.tieto.com>
References: <1282909526-19374-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
	 <1282911133.835.30.camel@localhost.localdomain>
	 <99B09243E1A5DA4898CDD8B7001114480976E15A2C@EXMB04.eu.tieto.com>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Fri, 27 Aug 2010 13:32:35 +0100
Message-ID: <1282912355.835.40.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2010-08-27 at 15:26 +0300, Waldemar.Rymarkiewicz@tieto.com
wrote:
> Hi,
> 
> >-----Original Message-----
> >From: Bastien Nocera [mailto:hadess@hadess.net] 
> >Sent: Friday, August 27, 2010 2:12 PM
> >To: Rymarkiewicz Waldemar
> >Cc: linux-bluetooth@vger.kernel.org; 
> >par-gunnar.p.hjalmdahl@stericsson.com; 
> >joakim.xj.ceder@stericsson.com; johan.hedberg@gmail.com
> >Subject: Re: [PATCH] BT_SECURITY_HIGH requires 16 digit pin code
> >
> >On Fri, 2010-08-27 at 13:45 +0200, Waldemar Rymarkiewicz wrote:
> >> The security level BT_SECURITY_HIGH expects secure connection and a 
> >> minimum 16 digit pin code used for bonding. It's requitred 
> >by the Sim 
> >> Access Profile.
> >
> >How is user-space (meaning the pairing agent) supposed to handle that?
> >I'd need to make changes to gnome-bluetooth to use longer PIN 
> >codes for the maximum security.
> >
> >Cheers
> >
> 
> I assume that user will know that the 16 digit pin is requred, so
> should be enough to let the user type 16 digit in an agent I guess.
> Usually a service that requires high security will generate right pin
> code.

How would they know? Pairing the device isn't connecting to the
service... Furthermore, gnome-bluetooth's wizard takes a lot of care
generating pin codes for the user by default, so we'd need to know that
a 16 digit pin code is required.

Supporting 16 digits pin code would probably require interface changes.

And I was under the impression that the PIN code's length didn't come
into account for the creation of the encryption, just for the initial
challenge-response needed to verify the device is who it says it is.

> Originaly the high security level was planned to require max pin code
> lenght as I know.




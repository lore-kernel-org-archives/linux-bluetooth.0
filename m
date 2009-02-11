Return-Path: <cyrus@holtmann.org>
In-Reply-To: <4992B59D.4090205@isc.cnr.it>
To: linux-bluetooth@vger.kernel.org
Subject: Re: Obex Push
MIME-Version: 1.0
Message-ID: <OFE8B06621.CA8FE1EF-ONC125755A.00407F0E-C125755A.00415175@aweurope.be>
From: Thierry Pierret <extern.Thierry.Pierret@awtce.be>
Date: Wed, 11 Feb 2009 12:53:26 +0100
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Actually, the sender program stimulates the "SenFiles" method of the 
org.openobex.Client interface. Therefore I thought it was an OBEX Push 
operation. The "FTP send" operation would rather have been implemented by 
the "PutFile" method of the org.openobex.FileTransfer interface.
But since the mobile I'm testing with implements both profiles, I cannot 
be sure.

To be sure, here, could an author intervene !? ... ;-)
Thanks

Regards.
Thierry




GianPiero Puccioni <gianpiero.puccioni@isc.cnr.it> 
Sent by: linux-bluetooth-owner@vger.kernel.org
2009/02/11 12:25

To
"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
cc

Subject
Re: Obex Push







Thanks, I tried it but it doesn't seem to work on my phone, it's a good 
starting point to
study 'tho. Just as an info, it does an Obex "Send" (FTP like) not a 
"Push"? From what I
understand there is a difference but I am not sure as I cannot find info 
on the subject.




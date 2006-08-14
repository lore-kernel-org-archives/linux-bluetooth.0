Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000301c6bfb3$830a4f60$9d0cc70a@dlh.st.com>
References: <000301c6bfb3$830a4f60$9d0cc70a@dlh.st.com>
Date: Mon, 14 Aug 2006 22:29:20 +0200
Message-Id: <1155587360.4075.14.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Phonebook Access Profile (Server)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Mayank,

> I've been working on the Phonebook Access Profile (PBAP) Server for quite some time now.
> I've come up with an implementation which does the following:
> 
> (i) Store SDP Record for PBAP Server.
> (ii) Receive Connections on OBEX.
> (iii) Implements the mandatory SetPhoneBook Function (Using OBEX SetPath)
> (iv) Implements the mandatory PullPhoneBook Function (Using OBEX Get)
> (v) Implements the mandatory PullvCardListing Function (Using OBEX Get)
> (vi) Implements the mandatory PullvCardEntry Function (Using OBEX Get)
> 
> For building the vCard Listing XML Object, I've written a Tcl script, which takes the necessary information from the user, builds the vCard File (.vcf) and simultaneously updates the vCardListing Object.
> 
> Now, my question is that since this application links with libopenobex.a, can it be included in the bluez-utils? Because, I've not seen any application in bluez-utils that links with libopenobex.a.

no problem to link with OpenOBEX. Works perfectly fine. The configure
script already checks for the presence of OpenOBEX.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

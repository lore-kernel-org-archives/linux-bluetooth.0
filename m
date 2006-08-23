Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: bluez-devel@lists.sourceforge.net
Date: Wed, 23 Aug 2006 16:21:38 +1000
References: <20060817100604.GA3350@srcf.ucam.org>
	<1156043737.3989.32.camel@aeonflux.holtmann.net>
	<20060820175957.GA2750@srcf.ucam.org>
In-Reply-To: <20060820175957.GA2750@srcf.ucam.org>
MIME-Version: 1.0
Message-Id: <200608231621.38333.denis.kenzior@trolltech.com>
Subject: [Bluez-devel] RFComm auth/encrypt
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

Marcel,

I'm trying to use the OpenOBEX bluetooth functions, but want to control the 
service level security options.  Since OpenOBEX does a listen for me, I can't 
set the security options before a listen occurs.  So my question is:
On a rfcomm server socket, when is the right time to set the link_mode flags?  
E.g. do I have to set it before the listen call?  Or setting them at any 
point after the listen is OK (and actually works) as well?

E.g. Here's what I'm trying to do:
	BtOBEX_ServerRegister(self, &bdaddr, channel);
	setsockopt(OBEX_GetFD(self), SOL_RFCOMM, RFCOMM_LM, &lm, sizeof(lm));

And on the client side, it seems that the client can request security options 
to be set as well.  Again, when is the right time to do this? After the 
socket call but before the connect?  Can authentication be requested after 
the client socket is connected?

-Denis

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

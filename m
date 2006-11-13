Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200611131114.43541.denis.kenzior@trolltech.com>
References: <200610231025.51818.denis.kenzior@trolltech.com>
	<e1effdeb0611101009t24de879fk3bca7ed96821514e@mail.gmail.com>
	<e1effdeb0611101338v1902b247if13f2239622f1a3a@mail.gmail.com>
	<200611131114.43541.denis.kenzior@trolltech.com>
Date: Mon, 13 Nov 2006 07:21:58 +0100
Message-Id: <1163398918.26272.11.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Proposed DTD
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

Hi Denis,

> > this patch replaces string_t by sdp_buf_t and fix system bus
> > disconnection problem. Check if this patch make sense or if it is
> > better keep  string_t.
> 
> I agree we should replace string_t by sdp_buf_t since this avoids an extra 
> strlen.  However, I think that the buffer should be grown by factors.  Your  
> proposed solution would call realloc many times, as the append function is 
> called quite frequently with small strings, but this is no biggie.
> 
> Would the attached patch be better?

looks good to me.

Claudio, please review it and then commit this to the CVS.

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

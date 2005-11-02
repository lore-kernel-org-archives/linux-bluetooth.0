Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Some thoughts on the current D-BUS interface
Message-ID: <20051102111853.GA4414@localhost.localdomain>
References: <20051031224006.GA14057@localhost.localdomain> <1130799900.31561.38.camel@blade> <20051031233610.GA14937@localhost.localdomain> <e1effdeb0511010433x11bbef22q8648e30b565cf41c@mail.gmail.com> <20051101155447.GA26044@localhost.localdomain> <1130863617.31561.74.camel@blade> <20051101194822.GA29725@localhost.localdomain> <20051102095146.GA2925@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="sdtB3X0nJg68CQEu"
In-Reply-To: <20051102095146.GA2925@localhost.localdomain>
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
Date: Wed, 2 Nov 2005 13:18:53 +0200


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 02, 2005, Johan Hedberg wrote:
> I've now uploaded the first version of the script here:
> http://www.iki.fi/~jhedberg/bluez-python/pybt.py

I just uploaded a new version which fixes listening for
AuthenticationComplete events. However the attached patch is also
required for hcid because othervice it doesn't send a proper method
return to the Authenticate method call.

Johan

--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="auth.patch"

Index: dbus.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.c,v
retrieving revision 1.41
diff -u -r1.41 dbus.c
--- dbus.c	1 Nov 2005 19:49:49 -0000	1.41
+++ dbus.c	2 Nov 2005 11:15:05 -0000
@@ -1712,6 +1712,8 @@
 		goto failed;
 	}
 
+	reply = dbus_message_new_method_return(msg);
+
 failed:
 	if (dd >= 0)
 		close(dd);

--sdtB3X0nJg68CQEu--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

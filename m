Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Alignment issue
From: Marcel Holtmann <marcel@holtmann.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Daryl Van Vorst <daryl@wideray.com>,
   "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1106483393.6480.11.camel@localhost.localdomain>
References: <001301c47f09$3900e650$1301010a@baked>
	 <1092208405.4564.227.camel@pegasus>
	 <1106231454.26551.582.camel@hades.cambridge.redhat.com>
	 <1106232343.8190.187.camel@pegasus>
	 <1106233175.26551.597.camel@hades.cambridge.redhat.com>
	 <1106480346.9269.2.camel@pegasus>
	 <1106483393.6480.11.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1106491241.9269.10.camel@pegasus>
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
Date: Sun, 23 Jan 2005 15:40:41 +0100

Hi David,

> > your patch results in a lot of "initialization from incompatible
> > pointer type" errors in the utils and hcidump. Basically in
> > conjunction with functions like ntohs() etc. How do we fix this?
> 
> Mea culpa... forgot to cast when we deliberately use an integer pointer
> as a pointer to our packed structure containing the same type of int. 

patch is now in the CVS and everything seems fine again. Btw what is the
difference between typeof and __typeof__. The latter one is used by the
previous macro and you used the other?

> We might as well also switch sdp_internal.h to use the same macros while
> we're at it.

Fine with me, but then I simply replace it with bt_{get|put}unaligned
and remove the complete stuff. There is no external user sdp_interal.h.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

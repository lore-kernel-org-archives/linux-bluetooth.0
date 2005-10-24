Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH] Add CancelInquiry D-BUS method
Message-ID: <20051024075603.GA9349@localhost.localdomain>
References: <20051023211355.GB14179@localhost.localdomain> <1130103081.19317.19.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
In-Reply-To: <1130103081.19317.19.camel@blade>
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
Date: Mon, 24 Oct 2005 10:56:03 +0300


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 23, 2005, ext Marcel Holtmann wrote:
> > HCI_Inquiry_Cancel command will not cause a inquiry complete HCI event
> > to be generated, so I also changed security.c to send the inquiry
> > complete D-BUS signal when it encounters a command complete event for
> > HCI_Inquiry_Cancel.
> 
> the patch is in the CVS now, thanks.

I forgot one important thing: EVT_CMD_COMPLETE should also be enabled in
the filter. Here's a patch to fix it.

Johan

--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cmd-complete.patch"

Index: hcid/security.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/security.c,v
retrieving revision 1.42
diff -u -r1.42 security.c
--- hcid/security.c	23 Oct 2005 21:27:41 -0000	1.42
+++ hcid/security.c	24 Oct 2005 07:52:55 -0000
@@ -775,6 +775,7 @@
 	hci_filter_clear(&flt);
 	hci_filter_set_ptype(HCI_EVENT_PKT, &flt);
 	hci_filter_set_event(EVT_CMD_STATUS, &flt);
+	hci_filter_set_event(EVT_CMD_COMPLETE, &flt);
 	hci_filter_set_event(EVT_PIN_CODE_REQ, &flt);
 	hci_filter_set_event(EVT_LINK_KEY_REQ, &flt);
 	hci_filter_set_event(EVT_LINK_KEY_NOTIFY, &flt);

--DocE+STaALJfprDB--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

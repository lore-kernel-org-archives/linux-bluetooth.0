Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Add CancelInquiry D-BUS method
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20051024075603.GA9349@localhost.localdomain>
References: <20051023211355.GB14179@localhost.localdomain>
	 <1130103081.19317.19.camel@blade>
	 <20051024075603.GA9349@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1130151895.19317.21.camel@blade>
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
Date: Mon, 24 Oct 2005 13:04:55 +0200

Hi Johan,

> > > HCI_Inquiry_Cancel command will not cause a inquiry complete HCI event
> > > to be generated, so I also changed security.c to send the inquiry
> > > complete D-BUS signal when it encounters a command complete event for
> > > HCI_Inquiry_Cancel.
> > 
> > the patch is in the CVS now, thanks.
> 
> I forgot one important thing: EVT_CMD_COMPLETE should also be enabled in
> the filter. Here's a patch to fix it.

this patch is in the CVS, too.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

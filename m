Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <37D1FAB2FA7B7E4993785B956F853C73181467@ednex506.dsto.defence.gov.au>
From: "Wodecki, Victor (Contractor)" <Victor.Wodecki@dsto.defence.gov.au>
To: "'bluez-devel@lists.sourceforge.net'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] HCI Events and errors
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
Date: Wed, 2 Feb 2005 16:21:48 +1030

Marcel,

> is there a reason why you use only DM1 packets and haven't 
> activated any of the link policies? Try if this changes something.

I've tried changing them with no difference to the test results.

> the "hci_num_comp_pkts_evt: hci0 num_hndl 1" is missing here and this
> means that the flow is suspended and we can't send HCI commands or
> data anymore. You may run into an memory problem if you keep 
> sending and the hardware never wakes up again,

The user-space app doesn't see any problem at the point where the
hardware error is raised, so it keeps calling send() until eventually
send() fails with a 'resource unavailable' error status, presumably
because of the lack of sk_buf's.

> but the question is why the hardware never wakes up?

The NatSemi chip appears to be a LMX9814; I'll see how I go with the
data sheets.

-- 

This email remains the property of the Australian Defence Organisation and is subject to the jurisdiction of section 70 of the Crimes Act 1914.  If you have received this email in error, you are requested to contact the sender and delete the email.


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

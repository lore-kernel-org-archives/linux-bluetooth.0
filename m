Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Message-ID: <1D6EDDB3E43F3B40BC089CCFEE99DB7D14D202@exnanycmbx1.corp.root.ipc.com>
From: "Downing, Thomas" <Thomas.Downing@ipc.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Bluez support for SCO
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
Date: Tue, 31 Jan 2006 15:47:44 -0500

Hi,

I have got bluez running on linux 2.6.11.12 (soon to be 2.6.15). I
built bluez from -libs-2.25, -hcidump-1.24, -utils-2.28. I can pair my
Treo with my linux box.

What I want to do is get my linux box to look like a HS or HF device.
HS will do nicely for starters.  I think there may already be some=20
work done in this direction (viz sco.ko) but can't find any pointers=20
to resources to help out my effort.

I am not trying to integrate with ALSA or any other sound framework, I
just get the SCO connection set up as a first step.  The hcidump tool
doesn't show anything when I tell the treo to look for a HS device.

I don't see any support for TCS, etc.  Is anyone working on this?

(Obviously I am just starting in with BT!)

Thanks in advance,

td


DISCLAIMER:
Important Notice *************************************************
This e-mail may contain information that is confidential, privileged or =
otherwise protected from disclosure. If you are not an intended =
recipient of this e-mail, do not duplicate or redistribute it by any =
means. Please delete it and any attachments and notify the sender that =
you have received it in error. Unintended recipients are prohibited from =
taking action on the basis of information in this e-mail.E-mail messages =
may contain computer viruses or other defects, may not be accurately =
replicated on other systems, or may be intercepted, deleted or =
interfered with without the knowledge of the sender or the intended =
recipient. If you are not comfortable with the risks associated with =
e-mail messages, you may decide not to use e-mail to communicate with =
IPC. IPC reserves the right, to the extent and under circumstances =
permitted by applicable law, to retain, monitor and intercept e-mail =
messages to and from its systems.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

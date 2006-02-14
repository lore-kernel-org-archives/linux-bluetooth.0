Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43F1B8DE.3060206@yahoo.com>
From: Pedro Monjo Florit <pmonjo2000@yahoo.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] Possible bug in sdp.c
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
Date: Tue, 14 Feb 2006 12:02:54 +0100

Hi,

I have seen what *may* be a possible bug in sdp.c. If there is an error 
in a SDP PDU sent by a bluetooth device, it seems that the SDP parsing 
code in sdp.c enters an infinite loop filling syslog with the following 
message: "Unknown sequence type, aborting".

I have been tracking down the cause and I have found where the problem 
might be. The function sdp_extract_seqtype() may return 0 in case of 
unrecognized data, but this case does not seem to be handled in the 
calls to this function (for example, in sdp_service_search_attr_req() or 
in sdp_extract_pdu()).

Could anybody tell me whether am I right or wrong? Has anybody seen a 
similar behaviour?

Regards,

Pedro


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

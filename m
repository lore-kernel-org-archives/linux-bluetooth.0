Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43F1CA4F.8030102@yahoo.com>
From: Pedro Monjo Florit <pmonjo2000@yahoo.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
References: <43F1B8DE.3060206@yahoo.com>
In-Reply-To: <43F1B8DE.3060206@yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] Re: Possible bug in sdp.c
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
Date: Tue, 14 Feb 2006 13:17:19 +0100

Pedro Monjo Florit wrote:
> Hi,
>=20
> I have seen what *may* be a possible bug in sdp.c. If there is an error=
=20
> in a SDP PDU sent by a bluetooth device, it seems that the SDP parsing=20
> code in sdp.c enters an infinite loop filling syslog with the following=
=20
> message: "Unknown sequence type, aborting".
>=20
> I have been tracking down the cause and I have found where the problem=20
> might be. The function sdp_extract_seqtype() may return 0 in case of=20
> unrecognized data, but this case does not seem to be handled in the=20
> calls to this function (for example, in sdp_service_search_attr_req() o=
r=20
> in sdp_extract_pdu()).
>=20
> Could anybody tell me whether am I right or wrong? Has anybody seen a=20
> similar behaviour?
>=20

I have been doing some further research and it is a Samsung. In previous=20
posts, there have been some bug reports regarding this brands, such as=20
raising SIGSEGV while looking up for DUN service. Lo=EFc Lefort sent a=20
patch that works pretty well with many phones, but there seems to be a=20
new Samsung phone that sends other unexpected SDP data, but I still do=20
not know which model.

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

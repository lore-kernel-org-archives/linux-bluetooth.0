Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] sdp seq of raw data
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1133429978.1037.22.camel@panic>
References: <1133429978.1037.22.camel@panic>
Content-Type: text/plain
Message-Id: <1133430940.1190.28.camel@blade>
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
Date: Thu, 01 Dec 2005 10:55:40 +0100

Hi Collin,

> I'm trying (for hours now) to put a raw binary string into a sdp
> attribute so that it shows up like this:
> 
> ---8<----
> Data Sequence
>       Data : 0B 0X 09 06 a1 01 85 01 05 07 19 e0 29 e7 15 00 25 01 75 01
> 95 08 81 02 75 08 95 01 81 01 75 01 95 05 
> 05 08 19 01 29 05 91 02 75 03 95 01 91 01 75 08 95 06 15 00 26 ff 00 05 
> ------>8------

this is a known (maybe only by me) problem. I fixed it for the receiving
path, but not for the sending path. You need to patch the library.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

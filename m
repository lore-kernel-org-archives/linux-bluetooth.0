Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <439823BF.1@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Inquiry Time
References: <45bf5ff80512070503g6cfc5189hec21ab22768ed9cd@mail.gmail.com>
In-Reply-To: <45bf5ff80512070503g6cfc5189hec21ab22768ed9cd@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
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
Date: Thu, 08 Dec 2005 12:14:55 +0000

Artur Almeida wrote:
>  The Bt specification says that once you send a inquiry request, you should
> get all the responses +-11 seconds. Many times i send an inquiry and it
> lasts a lot more then that (Sometimes it goes over a minute). Can someone
> explain how can i limit the inquiry time to the 11 sec window? Why does this
> happens?  Also, where can i find a detailed document with all the features
> and parameters of the hciconfig?

I think the way the spec phrases it is that you must inquire for at least
10.24 seconds to have a good probability of picking up all devices.
However, it doesn't say that the inquiry process will stop after 10.24
seconds. The host specifies how long it wants to inquire for in one of
the parameters to HCI_Inquiry. If the host says to inquire for 30
seconds (or whatever) then the chip quite happily will.

hcidump -X -V should reveal the parameters to the HCI_Inquiry command.
>From there you should be able to work out how long the chip has been
told to inquire for.

	- Steven
-- 


This message has been scanned for viruses by BlackSpider MailControl - www.blackspider.com


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

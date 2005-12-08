Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Inquiry Time
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <45bf5ff80512071633x7abfe08dnfccd0aee21b94008@mail.gmail.com>
References: <45bf5ff80512070503g6cfc5189hec21ab22768ed9cd@mail.gmail.com>
	 <1133961236.3752.27.camel@blade>
	 <45bf5ff80512071633x7abfe08dnfccd0aee21b94008@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1134020618.3752.59.camel@blade>
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
Date: Thu, 08 Dec 2005 06:43:38 +0100

Hi Artur,

> I have 3 dongles attached to my pc, in attach the hciconfig -a output:

all of these devices are CSR chips with a decent firmware and I can't
explain why this happens. However you should keep SNIFF and HOLD as link
policy. Show us the output of "hcidump -X -V" for the problem.

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

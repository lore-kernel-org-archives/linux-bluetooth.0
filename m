Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4390D50F.9020208@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] SBC Decoder Performance
References: <20051018062749.78971.qmail@web34106.mail.mud.yahoo.com>	 <4389D1EC.4070703@xmission.com> <1133116270.13629.3.camel@blade>	 <438A22EE.1020504@xmission.com> <1133128269.13629.24.camel@blade> <438A3135.6080208@xmission.com>
In-Reply-To: <438A3135.6080208@xmission.com>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Fri, 02 Dec 2005 16:13:19 -0700

Marcel,

> it's ugly, but what should it look like? it doesn't look much better by
> removing floating from the list.

Unfortunately I've been noticing a difference in quality between fixed
and floating. It is subtle, but high-frequency content is harsh and a
little distorted with the fixed point encoder. I could encode some
violin notes if you want to hear the difference.

It would be nice to implement the objective quality measures suggested
by Steven Singer so we could track this down more that's another thing
on the todo list for now.

Brad


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

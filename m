Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4389D1EC.4070703@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net, sjoe2@yahoo.com
Subject: Re: [Bluez-devel] SBC Decoder Performance
References: <20051018062749.78971.qmail@web34106.mail.mud.yahoo.com>
In-Reply-To: <20051018062749.78971.qmail@web34106.mail.mud.yahoo.com>
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
Date: Sun, 27 Nov 2005 08:34:04 -0700

Joe,

(just cleaning out my inbox)

fwiw, we have a fixed-point decoder in the btsco cvs now. If you try it,
let me know how it goes.

Brad

> While experimenting with the SBC codec, I observed
> that the decoder tends to be sluggish as compared with
> the encoder (about 20 times). Has anyone noticed this?
> Is this behavior expected or did I make some mistake
> in my analysis?
> 
> Joe
> 
> 
> 		
> ___________________________________________________________ 
> How much free photo storage do you get? Store your holiday 
> snaps for FREE with Yahoo! Photos http://uk.photos.yahoo.com
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Power Architecture Resource Center: Free content, downloads, discussions,
> and more. http://solutions.newsforge.com/ibmarch.tmpl
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

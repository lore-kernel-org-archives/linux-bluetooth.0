Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] sdp seq of raw data
From: "Collin R. Mulliner" <collin@betaversion.net>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1133430940.1190.28.camel@blade>
References: <1133429978.1037.22.camel@panic>
	 <1133430940.1190.28.camel@blade>
Content-Type: text/plain
Message-Id: <1133431401.1037.33.camel@panic>
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
Date: Thu, 01 Dec 2005 02:03:21 -0800


> this is a known (maybe only by me) problem. I fixed it for the receiving
> path, but not for the sending path. You need to patch the library.

so patching the TEXT_STR stuff would be the right way?

... Collin

--
Collin R. Mulliner <collin@betaversion.net>
BETAVERSiON Systems [www.betaversion.net]
info/pgp: finger collin@betaversion.net
Life is hard, but unfair!



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

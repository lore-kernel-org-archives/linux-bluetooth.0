Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Encryption
From: "Collin R. Mulliner" <collin@betaversion.net>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <9d47cfd0512011325x4de6e0a6wbd78806c2072dc5f@mail.gmail.com>
References: <9d47cfd0512011325x4de6e0a6wbd78806c2072dc5f@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1133500233.15695.3.camel@panic>
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
Date: Thu, 01 Dec 2005 21:10:33 -0800

Hi Abu,

On Thu, 2005-12-01 at 15:25 -0600, Abu hasnat Sayem wrote:
> I am working on doing Encryption and Authentication at the RFCOMM and
> L2CAP level using BlueZ. I would like to know if there exists certain
> function calls to accompolish it or i have to incorporate new code in
> it.

this is done via setsockopt(2), take a look at: 
/usr/src/bluez-utils-2.22/pand/main.c (search for SECURE)

or check sobexsrv (http://www.mulliner.org/bluetooth/sobexsrv.php)

... Collin

--
Collin R. Mulliner <collin@betaversion.net>
BETAVERSiON Systems [www.betaversion.net]
info/pgp: finger collin@betaversion.net
Don't talk just code!



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

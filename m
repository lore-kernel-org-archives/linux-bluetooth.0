Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] more sdp patches
From: "Collin R. Mulliner" <collin@betaversion.net>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1133586906.31106.12.camel@blade>
References: <1133509258.15695.8.camel@panic>
	 <1133552877.24022.5.camel@blade>
	 <20051203000701.qx95jgmadj5wkcso@admin.betaversion.net>
	 <1133586906.31106.12.camel@blade>
Content-Type: text/plain
Message-Id: <1133682782.30803.9.camel@panic>
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
Date: Sat, 03 Dec 2005 23:53:02 -0800

Hi Marcel,


On Sat, 2005-12-03 at 06:15 +0100, Marcel Holtmann wrote:
> Hi Collin,
> 
> > > this won't work, because the additional protocol descriptor list is a
> > > sequence of sequence of sequence. Compare this from my HCRP capable
> > > printer:
> > 
> > ah mmmh the code I send in works for me, so maybe it's just unclean :-(
> 
> show me how you use it.

you were right, it doesn't work. sdptool browse just did somehow display
it, but of course the third sequence did not exist ... 

*remember: Marcel is always right when talking about BlueZ stuff*

so I guess I have to write my own function to do
SDP_ATTR_ADD_PROTO_DESC_LIST?

> > About the "leng" issue, I thought you would tweak my patch anyway so I didn't
> > bothered making it nice ... sorry!
> 
> Make it looks nice and re-send it. I like nice looking patches ;)

I will, I just need to finish some other stuff now


... Collin

--
Collin R. Mulliner <collin@betaversion.net>
BETAVERSiON Systems [www.betaversion.net]
info/pgp: finger collin@betaversion.net
AAAAA - American Association Against Acronym Abuse



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

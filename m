Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] more sdp patches
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1133682782.30803.9.camel@panic>
References: <1133509258.15695.8.camel@panic>
	 <1133552877.24022.5.camel@blade>
	 <20051203000701.qx95jgmadj5wkcso@admin.betaversion.net>
	 <1133586906.31106.12.camel@blade>  <1133682782.30803.9.camel@panic>
Content-Type: text/plain
Message-Id: <1133683687.4427.15.camel@blade>
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
Date: Sun, 04 Dec 2005 09:08:07 +0100

Hi Collin,

> > > > this won't work, because the additional protocol descriptor list is a
> > > > sequence of sequence of sequence. Compare this from my HCRP capable
> > > > printer:
> > > 
> > > ah mmmh the code I send in works for me, so maybe it's just unclean :-(
> > 
> > show me how you use it.
> 
> you were right, it doesn't work. sdptool browse just did somehow display
> it, but of course the third sequence did not exist ... 
> 
> *remember: Marcel is always right when talking about BlueZ stuff*

not always, but I already ran into this problem when I wrote the CUPS
backend with HCRP support some time ago. And actually HID is the same.

> so I guess I have to write my own function to do
> SDP_ATTR_ADD_PROTO_DESC_LIST?

Please do so.

> > > About the "leng" issue, I thought you would tweak my patch anyway so I didn't
> > > bothered making it nice ... sorry!
> > 
> > Make it looks nice and re-send it. I like nice looking patches ;)
> 
> I will, I just need to finish some other stuff now

My plan was to do another release this weekend, but it got postponed due
some timing issues. However I will do a new release early next week and
I actually like to see this patches included.

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

Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Patch to add a --dailup option to dund, needed
	to make TomTomGo navigators connect to linux
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1137340560.3001.21.camel@laptopd505.fenrus.org>
References: <1137340560.3001.21.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Message-Id: <1137451092.24817.2.camel@localhost>
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
Date: Mon, 16 Jan 2006 23:38:12 +0100

Hi Arjan,

> Below is a patch to dund that adds a -dailup option. This option changes
> the class that is advertized by dund to be "dailup", TomTom Go
> navigators require this to connect to (they only want to connect to
> phones normally ;)
> 
> http://www.fenrus.org/tomtom has a howto-in-progress on how to use the
> linux bluez stack to connect a tomtom go to the internet, this patch is
> one of the more hairy aspects of this, so it'd be nice if this got
> merged...
> 
> In addition I suspect that tomtom isn't the only one wanting a dailup
> device, so it ought to be a pretty generic feature.

nice patch, but do you mind redoing it and change "dailup" into "dialup"
for some nicer English ;)

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

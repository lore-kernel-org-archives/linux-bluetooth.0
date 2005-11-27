Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] multiple rfcomm listeners
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <438A325A.10803@xmission.com>
References: 
	 <Pine.LNX.4.33.0511271455120.20980-100000@redbean.intranet.gw-instruments.de>
	 <1133116410.13629.6.camel@blade>  <438A21B2.40609@xmission.com>
	 <1133128026.13629.18.camel@blade>  <438A2C5B.9050306@xmission.com>
	 <1133129290.13629.37.camel@blade>  <438A325A.10803@xmission.com>
Content-Type: text/plain
Message-Id: <1133133590.13629.51.camel@blade>
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
Date: Mon, 28 Nov 2005 00:19:50 +0100

Hi Brad,

> > What you might wanna do is to modify the sdpd server to handle out
> > different service records (based on the remote BD_ADDR).
> 
> Yeah... I was considering how sdpd could have a pool of service records
> and record which addrs it had handed them out to. (I am thinking of the
> generic solution, not one in which all the addrs are known in advance)

you can assign the channel number to a specific BD_ADDR on the first
time a request for that service records comes in.

However I don't think there is a general solution for this problem. The
problem with the multiple serial port services has been addressed by
Microsoft ActiveSync and Palm HotSync already. They first look for a
specific UUID-128 service and only fallback to SP when this is not
available. This of course need better clients. A really good client
would also try to match the additional attributes to correctly identify
the service, but this is not specified anywhere in the specification and
I doubt that any client is doing this.

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

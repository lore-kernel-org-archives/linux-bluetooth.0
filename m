Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <438A325A.10803@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] multiple rfcomm listeners
References: <Pine.LNX.4.33.0511271455120.20980-100000@redbean.intranet.gw-instruments.de>	 <1133116410.13629.6.camel@blade>  <438A21B2.40609@xmission.com>	 <1133128026.13629.18.camel@blade>  <438A2C5B.9050306@xmission.com> <1133129290.13629.37.camel@blade>
In-Reply-To: <1133129290.13629.37.camel@blade>
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
Date: Sun, 27 Nov 2005 15:25:30 -0700

Marcel

> What you might wanna do is to modify the sdpd server to handle out
> different service records (based on the remote BD_ADDR).

Yeah... I was considering how sdpd could have a pool of service records
and record which addrs it had handed them out to. (I am thinking of the
generic solution, not one in which all the addrs are known in advance)

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

Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Device scan property
Message-ID: <20051125145657.GA18684@localhost.localdomain>
References: <3013cac80511250643s30a3e836qb9559289e68ee75c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3013cac80511250643s30a3e836qb9559289e68ee75c@mail.gmail.com>
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
Date: Fri, 25 Nov 2005 16:56:57 +0200

Hi Eduardo,

On Fri, Nov 25, 2005, Eduardo Rocha wrote:
> I'm going to start the scan property implementation for device path
> now. From early discussions, I think we have agreeded to split page
> scan and inquire scan property. Starting to think in implementation
> now, I realized that this imply in an extra getdeviceinfo, as we have
> to now if the exactly page flag status to modify it. If we join this
> two properties into scan property, with 2 boolean parameters for pscan
> and iscan, we can eliminate this operation. What do you guys think?

I think we should have two boolean properties: "discoverable" and
"connectable", even if that means doing an extra HCI_Read_Scan_Enable
command when setting the value of either one.

Johan


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

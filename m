Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Robert Siemer <Robert.Siemer@backsla.sh>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: Jumpy cursor with Wacom Graphire Bluetooth
Message-ID: <20051128102222.GN15156@polar.elf12.net>
References: <20051127234927.GI15156@polar.elf12.net> <1133136167.13629.58.camel@blade> <20051128015303.GJ15156@polar.elf12.net> <1133143721.13629.67.camel@blade> <20051128022901.GK15156@polar.elf12.net> <1133146623.13629.74.camel@blade> <20051128084428.GL15156@polar.elf12.net> <1133168403.31513.2.camel@blade> <20051128092101.GM15156@polar.elf12.net> <1133170611.31513.27.camel@blade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1133170611.31513.27.camel@blade>
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
Date: Mon, 28 Nov 2005 11:22:22 +0100

> > > > > Don't even think about switching into security mode 3. Use the -E switch
> > > > > of hidd instead.
> > 
> > Why? What is the difference?
> 
> the security mode 3 comes with a lot of troubles and unless you really
> know what you are doing, don't use it. Period.

I don't yet "really know", but I would like to.

> You can check with "hcitool con" is the encryption for a link is active.

I thought so, too, but as it did not say neither "yes" nor "no"...

siemer@panorama:/var/lib/bluetooth$ hcitool con
Connections:
        > ACL 00:13:C2:00:11:2C handle 42 state 1 lm MASTER 

> The new tools store the link keys under /var/lib/bluetooth and if the
> tablet is detected as mouse then maybe the encryption will never be
> requested by hidd.

How can I force hidd to try the encryption? I'm sure it sees the tablet
as a mouse...


Anyway: should be noted in /etc/bluetooth/hcid.conf as a comment to try
the (sometimes undocumented) "-E" switch instead of enableing it
there...


Robert


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

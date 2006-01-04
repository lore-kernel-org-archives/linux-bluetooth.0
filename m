Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43BB269C.5060304@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] the bluetooth-alsa driver
References: <20051231185308.E3D14130C8@sc8-sf-spam2.sourceforge.net> <Pine.LNX.4.63.0512312154150.23868@sundust> <1136201460.22810.10.camel@localhost> <Pine.LNX.4.63.0601022121160.23868@sundust> <1136230278.24985.4.camel@localhost> <Pine.LNX.4.63.0601030202140.23868@sundust> <1136282199.20704.1.camel@localhost> <004501c610ce$4737bb60$c70a10ac@TOM>
In-Reply-To: <004501c610ce$4737bb60$c70a10ac@TOM>
Content-Type: text/plain; charset=Big5
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
Date: Tue, 03 Jan 2006 18:36:28 -0700

tom

the sink prototype is more complete than the source just because it
doesn't have to be modified to plug into an audio system. it does need
help to be a proper daemon iirc.

check out the project from cvs. the receiver (a2recv) can be run and
will listen for incoming connections. (see the docs though--we still
have to modify device class and sdp advertisements before running it)

brad

> Recently i would like to use the bluetooth-alsa driver for A2DP
> streaming , but what i need is sink side but not the source side, i
> would like to know if this project is still advancing and are going to
> implemented two-way audio ? Hope anyone can give me some help.
> 
> 
> Regards,
> TOM
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log
> files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
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

Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43BB527D.3020704@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: tom <tomko@avantwave.com>, bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] the bluetooth-alsa driver
References: <20051231185308.E3D14130C8@sc8-sf-spam2.sourceforge.net> <Pine.LNX.4.63.0512312154150.23868@sundust> <1136201460.22810.10.camel@localhost> <Pine.LNX.4.63.0601022121160.23868@sundust> <1136230278.24985.4.camel@localhost> <Pine.LNX.4.63.0601030202140.23868@sundust> <1136282199.20704.1.camel@localhost> <004501c610ce$4737bb60$c70a10ac@TOM> <43BB269C.5060304@xmission.com> <006d01c610d7$2e667f00$c70a10ac@TOM>
In-Reply-To: <006d01c610d7$2e667f00$c70a10ac@TOM>
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
Date: Tue, 03 Jan 2006 21:43:41 -0700

tom

How funny... I just realized you're with avantwave. I have a module from
you that I've been trying to connect to my gumstix. I am going to try
again when I get a newer gumstix board.

The documentation on http://bluetooth-alsa.sf.net explains the build
process more.

Are you running this on an embedded cpu like arm? be sure when you run
configure to do it this way:

 ./configure --enable-fixed

What you do is follow the build instructions and then run:

hciconfig hci0 class 0x200404
sdptool add A2SNK
./a2recv

a2recv will listen for a connection and then send the received audio
directly to /dev/dsp. The audio stream is not really available as an
alsa device as you describe. How are you planning to process the sound?

Brad

> Hi brad,
> 
> Thank you very much for your reply. But is the sink part is ready to use
> and is full compatitable with the alsa subsystem ? That means if i would
> like to put a application on top of this driver and read from this
> driver through alsa subsystem like reading pcm from a mic , can it work
> fines ?
> 
> Regards,
> TOM


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

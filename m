Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Documentation for hcid.conf ?
From: Marcel Holtmann <marcel@holtmann.org>
To: "Collin R. Mulliner" <collin@betaversion.net>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040323225438.6b7bb3ee@coredump>
References: <1080053029.7507.40.camel@gryffindor>
	 <20040323183818.3d21f901@coredump> <1080064121.2515.35.camel@pegasus>
	 <20040323225438.6b7bb3ee@coredump>
Content-Type: text/plain
Message-Id: <1080081387.2515.58.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 23 Mar 2004 23:36:27 +0100

Hi Collin,

> using:
> 
> device hci0 {
>  ...
>  copy of default section (from hcid.conf)
>  ...
> }
> 
> OR
> 
> device 00:11:22:33:44:55 {
>  ...
>  copy of default section (from hcid.conf)
>  ...
> }
> 
> gives me a syntax error for the line containing "device hci0 {" and for
> all following lines within the section, same goes for 
> "device 00:11:22.33.44:55 {"
> 
> I have bluez-utils-2.4 (btw. hcid reports 2.4)

try bluez-utils-2.5

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

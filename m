Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Peter Wippich <pewi@gw-instruments.de>
To: <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] MTU limited to 672
In-Reply-To: <43FB1B2A.4060104@masaka.cs.ohiou.edu>
Message-ID: <Pine.LNX.4.33.0602211504300.21864-100000@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Tue, 21 Feb 2006 15:09:28 +0100 (CET)


Sorry, MTU size larger than 672 is possible in general. But it is not
guaranteed that the remote device will support it. The minimum MTU is 48
Bytes. Most devices support MTU sizes up to 672 bytes (the default value).

Maximum MTU size is negotiated during L2CAP connection setup. See L2CAP
specification. So what happens is that you tried to connect to a remote
device with an MTU size larger than the remote device supports.

You should check L2CAP implementation and HCI.

Ciao,

Peter

On Tue, 21 Feb 2006, Jim Wyllie wrote:

> I am implementing a protocol over L2CAP and would like to increase the
> MTU over 672 bytes.  However, attempting a connection with the requisite
> size will fail in connect() with "Connection Reset by Peer".  I am also
> unable to get an actual MTU over 672 using l2test.
>
> I was unable to find the location in the kernel where this functionality
> was implemented.  Could someone let me know if it's the case that one
> can't get an MTU over 672 with the current kernel and libraries, and if
> so, if there are any workarounds?
>
> Thank you for your time,
> Jim
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

|	Peter Wippich 			Voice: +49 30 46776411		|
|	G&W Instruments GmbH		fax:   +49 30 46776419		|
|	Gustav-Meyer-Allee 25, Geb. 12	Email: pewi@gw-instruments.de	|
|	D-13355 Berlin  / Germany					|




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

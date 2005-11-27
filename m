Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Peter Wippich <pewi@gw-instruments.de>
To: <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] multiple rfcomm listeners
In-Reply-To: <43895560.3050801@xmission.com>
Message-ID: <Pine.LNX.4.33.0511271455120.20980-100000@redbean.intranet.gw-instruments.de>
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
Date: Sun, 27 Nov 2005 15:05:11 +0100 (CET)


Hi Brad,

just for one of your topics :

On Sat, 26 Nov 2005, Brad Midgley wrote:

> Hey
>
> I have been playing around with gpsd, DGPS and repeating gps data over
> bluetooth. I'm considering how feasible it would be to run two rfcomm SP
> listeners on one computer. Essentially I want to repeat the
> (dgps-corrected) data to more than one bluetooth gps client.
>
> If I run rfcomm listeners on two channels, can I just remove and add the
> SP service on the alternate channel when a client connects?
>
> I've heard that bluetooth clients are supposed to check for the SP
> channel via sdp on every connect, but bluez doesn't do that in its
> rfcomm bindings, eh? Do other devices check the channel only when pairing?
This behaviour is completly implementation depended. The Widcom stack and
even some other implementaions do request the server channel number for a
service just before connection setup. Other implementations just store the
server channel during pairing. The SDP variant has the problem that it is
not realy possible to distinguish between two identical services which
only have different server channels, e.g. many mobile phones and some
other devices offer two SPP channels. With the SDP variant it is likely
that you connect to the wrong service.
The pairing variant has the drawback that you can not connect to a service
anymore if its server channel changes dynamicly. This again is
implementation depoendent on the client side. However, most devices I'm
aware off use fixed server channels.


> Is there a daemon to help with firing up the listener as soon as the
> connection is made? I saw a script on my gumstix that uses rfcomm to
> poll the rfcomm state and fire up a getty when connected. But will an
> app with an rfcomm device open get sighup'd when the connection is broken?
>
> Brad

Peter



>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
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
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Peter Wippich <pewi@gw-instruments.de>
To: <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] signal-to-noise ratio (rssi)
In-Reply-To: <1459505994@web.de>
Message-ID: <Pine.LNX.4.33.0511151145340.4802-100000@redbean.intranet.gw-instruments.de>
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
Date: Tue, 15 Nov 2005 11:50:01 +0100 (CET)


Hello Wolfgang,

what do you mean by "RSSI value when there is no traffic" ?? There will
always be some traffic even without any ACL traffic. And you will only get
RSSI values for an existing connection. Further, what the RSSI realy tells
you is chip specific and may give you completly misleading values. So I'm
afraid your idea will not work at all.

Ciao,
Peter


On Tue, 15 Nov 2005, Wolfgang Krug wrote:

>
>
> Hi,
>
>  I'm trying to display a signal-to-noise ratio for a bluetooth connection.
>  My plan is to read out the RSSI and divide it though another RSSI
> value which is measured when no traffic occurs.
>
>  Unfortunately I'm not an expert, so could someone please point me in
> the right direction howto realize it?
>
>  Thank you!
> ______________________________________________________________
> Verschicken Sie romantische, coole und witzige Bilder per SMS!
> Jetzt bei WEB.DE FreeMail: http://f.web.de/?mc=021193
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
> Register for a JBoss Training Course.  Free Certification Exam
> for All Training Attendees Through End of 2005. For more info visit:
> http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
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
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

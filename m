Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <3013cac80512270949w6b4fac8cga5c119b24044fcd4@mail.gmail.com>
From: Eduardo Rocha <folhabranca@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Auto-sniff
In-Reply-To: <1135350704.3985.5.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <3013cac80512220514o71543396ye02a2848ad2c5df5@mail.gmail.com>
	 <1135271896.6002.99.camel@localhost>
	 <3013cac80512230519t38047b25wcf25b46f25f33ee9@mail.gmail.com>
	 <1135350704.3985.5.camel@localhost>
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
Date: Tue, 27 Dec 2005 14:49:38 -0300

Hi Marcel,

I thought that in sniff mode we only reduce the duty cicle on a link
between two device, but you still could do transfer of data packets
within the negociated interval.

I've tested the sniff using:
hcitool cmd 0x02 0x0004 0x06(handle) - stop
hcitool cmd 0x02 0x0003 0x06(handle) 0x00 0x50 0x00 0x10 0x00 0x05
0x00 0x02 - start

So, what is still missing to be implemented? So far we have listed this:
 - detecting idle link and link activity
 - the timer

BR,
Eduardo.


On 12/23/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Eduardo,
>
> > I've done some initial research on this area, and I've found some
> > proposals of algoritms for dynamic ajusting of sniff parameters based
> > on traffic history of the link.  But before working with sniff
> > parameters, is there anything that neeeds to be done in the sniff mode
> > itself? Can you enumarate it?
>
> what do you mean by this? In sniff mode you normally don't have any data
> transfer at all. That's the only requirement. Thus you need a timer to
> detect when a link goes idle.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


--
Eduardo Rocha
Instituto Nokia de Tecnologia - INdT


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

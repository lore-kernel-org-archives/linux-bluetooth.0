Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: tOpSy TuRvY <topsyturvy@nemo.student.utwente.nl>
To: Peter Stephenson <pws@csr.com>
cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Slaves in Sniff mode
In-Reply-To: <200406231741.i5NHfnqF022172@news01.csr.com>
Message-ID: <Pine.BSO.4.58.0406241134240.10334@nemo.student.utwente.nl>
References: <200406231741.i5NHfnqF022172@news01.csr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 24 Jun 2004 11:43:26 +0200 (CEST)


Hi,

On Wed, 23 Jun 2004, Peter Stephenson wrote:

> 
> Yes, there's no reason the sender would notice apart from the data in
> small bursts.  (It's not like park mode where data isn't sent.)

Isn't it technically possible for the  master to send small amount of 
BNEP data to PANUs in parked mode using the PSB logical channel? The 
PANU would of course have to shift into connected mode before replying.

The above would allow the system to support a BNEP layer broadcast (e.g. 
ARP) to all PANUs attached to the GN (i.e those in connected and parked mode).


> > One last question on this issue. Can the GN in Bluez ask the PANU to go 
> > into sniff mode *automatically* based on some criteria (e.g. low 
> > activity), or ask it to come out of sniff mode (e.g. based on a large 
> > queue).
> 
> It would be up to the host code to do this.  There's nothing stopping
> (say) the bnep layer from monitoring data and sending sniff and unsniff
> requests.  There's no facility for doing this below HCI.
> 

Isn't it better for e.g. the link manager to do this since the BNEP layer 
can only see BNEP traffic, but the link manager can also see SCO and ACL 
traffic.

Thanks for your explaination.

Regards,
Assed


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

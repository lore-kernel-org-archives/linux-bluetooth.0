Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: Re: [Bluez-users] Socket CF adaptor,
 limited to 2-3KB/sec RFCOMM PPP connection?
In-reply-to: <Pine.GSO.4.58.0410121425040.24690@gaia3.cc.gatech.edu>
To: bluez-users@lists.sourceforge.net
Message-id: <20041012210802.GA4827@nalle>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <Pine.GSO.4.58.0410121425040.24690@gaia3.cc.gatech.edu>
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
Date: Wed, 13 Oct 2004 00:08:02 +0300

On Tue, Oct 12, 2004 at 02:37:16PM -0400, Jay W. Summet wrote:
> However, when I connect to my GPRS data provider, I only get 2.1 to 2.5
> KBytes/second of transfer. If I use IrDA instead of bluetooth, I can
> obtain the typical 5.1 to 5.6 KBytes/second transfer that I am expecting
> from GPRS.

I propose you first try to repeat this slow connection problem with plain 
Bluetooth data transfer between Linux and the phone (OBEX or something), 
since GPRS networks and cells may give you anything between 0 and ~50 kbps 
of bandwidth depending on all kinds of things like network/cell load/number 
of users etc etc. 

And if the issue still exists, I'd say Marcel and other wizards would like 
to see the hcidump, perhaps with -t ;)

-Mikko


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

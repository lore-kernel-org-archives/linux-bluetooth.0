Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Fred Schaettgen <buez-devel@schaettgen.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] how to recognize whether the connected device is a headset
References: <1098352217.1912.4.camel@debian>
In-Reply-To: <1098352217.1912.4.camel@debian>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410211300.07230.buez-devel@schaettgen.de>
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
Date: Thu, 21 Oct 2004 13:00:07 +0200

On Thursday 21 October 2004 11:50, Chen Bin wrote:
> Hi all,
>
> Thanks very much for previous help from Holtman, and I happen a new
> problem when I try to find out whether a connected device is a headset.
>
> It can't be browsed using sdptool in both connected mode and discovery
> mode(paring state), I wonder how I can know its charactics after
> connected?

You can look at the device class first.
And instead of browsing try to search for the profile instead with 

sdptool search --bdaddr <add> <uuid>

You are supposed to use the headset uuid (0x1108), but you can use the 
L2CAP-UUID (0x100) just as well. This little trick will list almost every 
service of a device, even if it's not in the public browse group.

Fred

-- 
Fred Schaettgen
bluez-devel@schaettgen.de


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

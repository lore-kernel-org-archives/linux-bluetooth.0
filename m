Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] inquiry_info device class to string
From: Stephen Crane <steve.crane@rococosoft.com>
To: bluez@spamzed.com
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <275070-2200410219819354@M2W046.mail2web.com>
References: <275070-2200410219819354@M2W046.mail2web.com>
Content-Type: text/plain
Message-Id: <1098177829.4538.121.camel@baroque.rococosoft.com>
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
Date: Tue, 19 Oct 2004 10:23:49 +0100

Hi,

On Tue, 2004-10-19 at 09:19, postmaster@spamzed.com wrote:
> Im sort of new to bluetooth and bt development but its going ok so far. Im
> writing a little tool which displays all current devices in range. Since my
> code uses ripped parts from hcitool scan i can succesfully enumerate the
> device address and name, my question is , how do I parse  the device_class
> item from the inquiry_info structure ? Say device ID is 001, i want to
> convert it to an human readable string like 001 == Phone, 002 == Audio
> etc... where can i find an translation list for this ? after a heavy google
> battle i found a PalmOS site which mentions the bluetooth specs, but the
> prop is , i can find only parts of it and my 'bluetooth unreveiled' book is
> currently beeing shipped to me (i hope its mentioned there). I hope im not
> forced to use a sdptool query since some 'light' devices dont have it
> onboard, like headsets etc

See hciconfig.c in bluez-utils.

Cheers,
Steve
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] patched script
References: <200404150002.29515.cijoml@volny.cz> <1082160114.4489.17.camel@pegasus>
In-Reply-To: <1082160114.4489.17.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200404171304.09559.cijoml@volny.cz>
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
Date: Sat, 17 Apr 2004 13:04:09 +0200

Hi Marcel,

I rewrited script to use /etc/default/bluetooth, but can't find existing 
scripts for pand, dund? sdpd is in script included.

Send me that ones and I'll include them. Problem is, that I don't use pand and 
dund so I don't know how they should work

Thanks

Michal

Dne so 17. dubna 2004 02:01 jste napsal(a):
> Hi Michal,
>
> > sending patched script bluetooth for debian
> >
> > 1]added bthid daemon to start/stop sections
> > 2]fixes variables to prevent atacker pass some extended values into them
> >
> > Hope you`ll include it
>
> nice script, but I don't include it. However I am going to include dund
> and pand into the utils package and I also wanna put a version of the
> bthid into it that uses the old SDP library.
>
> Right now there are three Debian init script from bluez-utils, bluez-sdp
> and bluez-pan package. If you wanna do me a favour, write a complete new
> one with the same features and the settings in /etc/default/bluetooth
> and I am going to include that one.
>
> And please use "hidd" as name for the HID daemon, because I am going to
> use that name to keep the namespace a little bit cleaner.
>
> Regards
>
> Marcel


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

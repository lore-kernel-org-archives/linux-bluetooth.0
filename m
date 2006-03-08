Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Dave Mielke <dave@mielke.cc>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] PIN helper
Message-ID: <20060308214031.GZ4516@beta.private.mielke.cc>
References: <20060308221925.17d20407.fotopiper@o2.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
In-Reply-To: <20060308221925.17d20407.fotopiper@o2.pl>
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
Date: Wed, 8 Mar 2006 16:40:32 -0500


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[quoted lines by Radek on 2006/03/08 at 22:19 +0100]

>from whot I had read in the net there had been some controversies about
>the pinhelpers. The d-bus one need d-bus, and the python one need some
>extra libs as well as X..

May I use this opportunity to "readvertise" a script I tried to bring to your
collective attention some months ago. It's attached to this post as "bluepin". 
It works in text mode, supports a file containing address/pin mappings, and
uses the dialog utility to bring up a text-mode prompt on a spare virtual
terminal for devices not listed in the file. Please give it some consideration.
I'll be glad to enhance it as necessary regarding whatever features it's
missing or could use in addition to what it already does. See the comments at
the top of the script for more detail. 

-- 
Dave Mielke           | 2213 Fox Crescent | I believe that the Bible is the
Phone: 1-613-726-0014 | Ottawa, Ontario   | Word of God. Please contact me
EMail: dave@mielke.cc | Canada  K2A 1H7   | if you're concerned about Hell.
http://FamilyRadio.com/                   | http://Mielke.cc/bible/

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=bluepin

#!/bin/sh
# This script has been written by Dave Mielke <dave@mielke.cc>. It's a light 
# weight, text mode, Bluetooth PIN helper script. Its dependencies are:
# *  /bin/sh  The standard system command shell.
# *  open     A command which opens a free virtual terminal.
# *  dialog   A command which presents a text-mode dialog.
#
# The file /etc/bluetooth/pins is searched for a line corresponding to the 
# Bluetooth address of the device. Each line of this file should contain the
# address of a device and its PIN, in that order, separated by space. If the
# address is found then the corresponding PIN is automatically supplied. If
# it's not found then the user is prompted via a text-mode dialog in a free 
# virtual terminal. The console automatically returns to the original virtual
# terminal as soon as the PIN is entered.

pinsFile="/etc/bluetooth/pins"
pinLimit=16

[ "${#}" -gt 0 ] && {
   direction="${1}"
   shift

   [ "${#}" -gt 0 ] && {
      address="${1}"
      shift

      if [ "${#}" -gt 0 ]
      then
         name="${1}"
         shift
      else
         name=""
      fi

      [ -f "${pinsFile}" -a -r "${pinsFile}" ] && exec <"${pinsFile}" && {
         while read a p x
         do
            [ "${a}" = "${address}" ] && {
               echo "PIN:${p}"
               exit 0
            }
         done
      }

      if [ "${direction}" = "out" ]
      then
         adjective="outgoing"
         preposition="to"
      else
         adjective="incoming"
         preposition="from"
      fi

      title="Bluetooth PIN Prompt"
      time="`date '+%Y-%m-%d@%H:%M:%S'`"
      prompt="Enter PIN for ${adjective} Bluetooth connection ${preposition} ${name}[${address}]"
      pin="`open 3>&1 -s -w -- dialog --output-fd 3 --clear --title "${title}" --cr-wrap --max-input "${pinLimit}" --inputbox "${time}\n\n${prompt}" 0 0 ""`"
      [ -n "${pin}" ] && {
         echo "PIN:${pin}"
	 exit 0
      }
   }
}

echo ERR
exit 0

--wRRV7LY7NUeQGEoC--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

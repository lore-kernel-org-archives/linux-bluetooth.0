Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Dave Mielke <dave@mielke.cc>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20041219161903.GA3262@alpha.private.mielke.cc>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
Subject: [Bluez-devel] Text-mode Bluetooth PIN helper script. (fwd)
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
Date: Sun, 19 Dec 2004 11:19:03 -0500


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Has anyone had an opportunity to look at this script yet? I've attached an
updated version of it to this message so, if you're interested, please look=
 at
this copy instead.

I don't mean to nag, but the unfortunate fact is that blind users, especial=
ly
those with braille displays which connect via bluetooth, have a very diffic=
ult
time with the current bluepin helper script. This script, I believe, resolv=
es
their (our) problems while still remaining a reasonable solution for sighted
users. As I mention below, I'll be glad to address any issues which any of =
you
feel might further improve its functionality.

----- Forwarded message from Dave Mielke <dave@mielke.cc> -----

Date: Sun, 12 Dec 2004 02:33:54 -0500
From: Dave Mielke <dave@mielke.cc>
To: bluez-devel@lists.sourceforge.net
Subject: Text-mode Bluetooth PIN helper script.

The PIN helper script which is currently being distributed, a python script
named bluepin, uses an X dialog to prompt the user for a PIN. This poses a
two-fold problem for blind users. Firstly, it's essentially unusable since X
support for both speech and braille isn't yet at the point where blind users
use the X environment on anything more than an experimental basis. Secondly,
those using braille displays which connect via Bluetooth can't "see" the sc=
reen
in order to respond to the prompt so that their braille displays can become
connected.

I've written a script (attached to this message as "bluepin") which resolves
both of these problems, and which, I think, is still a good solution for
sighted users as well. It first searches the file /etc/bluetooth/pins for a
line matching the Bluetooth address of the device. Each line in this file
consists of the address and the PIN separated from one another by space. If=
 a
matching line is found then the script responds automatically. If one can't=
 be
found then a text-mode dialog is presented on a free virtual terminal. As s=
oon
as the PIN is entered, the console returns to the virtual terminal which was
previously being used.

Would you people please have a look at the attached script and let me know =
what
you think of it and if you'd consider it for inclusion within the base
Bluetooth software? I'll be glad to make any further enhancements to it whi=
ch
you feel would improve its functionality.

--=20
Dave Mielke           | 2213 Fox Crescent | I believe that the Bible is the
Phone: 1-613-726-0014 | Ottawa, Ontario   | Word of God. Please contact me
EMail: dave@mielke.cc | Canada  K2A 1H7   | if you're concerned about Hell.
http://familyradio.com/                   | http://mielke.cc/bible/

#!/bin/sh
# This script has been written by Dave Mielke <dave@mielke.cc>. It's a ligh=
t=20
# weight, text mode, Bluetooth PIN helper script. Its dependencies are:
# *  /bin/sh  The standard system command shell.
# *  open     A command which opens a free virtual terminal.
# *  dialog   A command which presents a text-mode dialog.
#
# The file /etc/bluetooth/pins is searched for a line corresponding to the=
=20
# Bluetooth address of the device. Each line of this file should contain the
# address of a device and its PIN, in that order, separated by space. If the
# address is found then the corresponding PIN is automatically supplied. If
# it's not found then the user is prompted via a text-mode dialog in a free=
=20
# virtual terminal. The console automatically returns to the original virtu=
al
# terminal as soon as the PIN is entered.

pinsFile=3D"/etc/bluetooth/pins"
pinLimit=3D16

[ "${#}" -gt 0 ] && {
   direction=3D"${1}"
   shift

   [ "${#}" -gt 0 ] && {
      address=3D"${1}"
      shift

      if [ "${#}" -gt 0 ]
      then
         name=3D"${1}"
         shift
      else
         name=3D""
      fi

      [ -f "${pinsFile}" -a -r "${pinsFile}" ] && exec <"${pinsFile}" && {
         while read a p x
         do
            [ "${a}" =3D "${address}" ] && {
               echo "PIN:${p}"
               exit 0
            }
         done
      }

      if [ "${direction}" =3D "out" ]
      then
         adjective=3D"outgoing"
         preposition=3D"to"
      else
         adjective=3D"incoming"
         preposition=3D"from"
      fi

      time=3D"$(date '+%Y-%m-%d@%H:%M:%S')"
      pin=3D"$(open 3>&1 -s -w -- dialog --output-fd 3 --clear --cr-wrap --=
title "Bluetooth PIN Prompt" --max-input "${pinLimit}" --inputbox "${time}\=
n\nEnter PIN for ${adjective} Bluetooth connection ${preposition} ${name}[$=
{address}]" 0 0 "")"
      [ -n "${pin}" ] && {
         echo "PIN:${pin}"
	 exit 0
      }
   }
}

echo ERR
exit 0


----- End forwarded message -----

--=20
Dave Mielke           | 2213 Fox Crescent | I believe that the Bible is the
Phone: 1-613-726-0014 | Ottawa, Ontario   | Word of God. Please contact me
EMail: dave@mielke.cc | Canada  K2A 1H7   | if you're concerned about Hell.
http://FamilyRadio.com/                   | http://Mielke.cc/bible/

--UlVJffcvxoiEqYs2
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

--UlVJffcvxoiEqYs2--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

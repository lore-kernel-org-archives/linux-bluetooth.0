Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Dave Mielke <dave@mielke.cc>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] PIN helper
Message-ID: <20060309193423.GF4516@beta.private.mielke.cc>
References: <20060308221925.17d20407.fotopiper@o2.pl> <20060308214031.GZ4516@beta.private.mielke.cc> <20060308230109.202dc5ff.fotopiper@o2.pl> <20060308221644.GA4516@beta.private.mielke.cc> <20060309064424.584539d2.fotopiper@o2.pl> <20060309055552.GB4516@beta.private.mielke.cc> <20060309070649.007fba22.fotopiper@o2.pl> <20060309061255.GC4516@beta.private.mielke.cc> <20060309192953.52ee8c2e.fotopiper@o2.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mxv5cy4qt+RJ9ypb"
In-Reply-To: <20060309192953.52ee8c2e.fotopiper@o2.pl>
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
Date: Thu, 9 Mar 2006 14:34:23 -0500


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[quoted lines by Radek Rurarz on 2006/03/09 at 19:29 +0100]

>For security reasons an simplicyty...  one is a good idea.
>But having an option to try more then one is more universal (but not
>nessesary).
>If it's not a big problem (both for you to implement and for the system
>to compute..) it would be a nice feature.

The latest version of the script is attached to this post. Please have a look
at it and/or give it a try. I've went with making this option (-c) be
non-cumulative for the time being, but it'd be very easy to change that. Please
let me know what else you think needs to be done.

>I prefer a working program, then a problematic one with documentation ;)

I tend to agree. 

-- 
Dave Mielke           | 2213 Fox Crescent | I believe that the Bible is the
Phone: 1-613-726-0014 | Ottawa, Ontario   | Word of God. Please contact me
EMail: dave@mielke.cc | Canada  K2A 1H7   | if you're concerned about Hell.
http://FamilyRadio.com/                   | http://Mielke.cc/bible/

--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=bluepin

#!/bin/bash
# This script has been written by Dave Mielke <dave@mielke.cc>. It's a light 
# weight, text mode, Bluetooth PIN helper script. Its dependencies are:
# *  /bin/bash  The interpreter for this script.
# *  open     A command which opens a free virtual terminal.
# *  dialog   A command which presents a text-mode dialog.
# *  logger   A command which writes to the system log.
#
# Step 1: The PINs file, /etc/bluetooth/pins (can be changed with the -f
# option), is searched for a line which corresponds to the Bluetooth address of
# the device. Each line in this file should contain the address of a device and
# its PIN, in that order, separated by space. Any additional data on the line
# is ignored and can be used as a comment to help identify the device. For
# example, if the address of your cell phone is 01:23:45:67:89:AB, and if its
# PIN is 12345, then its line would look like this:
#
#    01:23:45:67:89:AB 12345 my cell phone
#
# If the address is found within the PINs file then the corresponding PIN is
# returned.
#
# Step 2: If the -c option has been specified then its operand is interpreted
# as the command which is to be used to prompt the user for the PIN. If it is
# appropriately quoted so that it can contain space then options may be
# specified after the command name. It must interpret its positional parameters
# and return its response as if it were being directly invoked as a Bluetooth
# PIN helper. If it returns a PIN then that PIN is returned.
#
# Step 3: If the -n option has not been specified then the user is prompted for
# the PIN via a text-mode dialog in a free virtual terminal. The console
# automatically returns to the original virtual terminal as soon as the user
# responds to the dialog. If the response contains at least one character then
# the entire response is returned as the PIN.
#
# Step 4: Return the fact that the PIN could not be determined.
#
# Error messages are written to the system log (syslog) if "logger" is in the
# command search path ($PATH) and if standard output is not a terminal (tty or
# pty). If any of these conditions is not satisfied then errors are written to
# standard error.
#
# Invoke this script with the -h option to see its usage summary.

programName="${0##*/}"
programMessage() {
   typeset message="${1}"
   typeset level="${2}"

   echo >&2 "${programName}: ${message}"
}

programError() {
   typeset status="${1}"
   typeset message="${2}"

   programMessage "${message}" error
   exit "${status}"
}

syntaxError() {
   typeset message="${1}"

   programError 2 "${message}"
}

findCommand() {
   typeset variable="${1}"
   typeset command="${2}"

   typeset path="$(type -p "${command}")"
   [ -n "${path}" ] && {
      eval "${variable}"'="${path}"'
      return 0
   }

   programMessage "command not found: ${command}"
   return 1
}

respondWithPin() {
   typeset pin="${1}"

   echo "PIN:${pin}"
   exit 0
}

[ ! -t 1 ] && {
   findCommand loggerPath logger && {
      programMessage() {
         typeset message="${1}"
         typeset level="${2}"

         "${loggerPath}" -t "${programName}[${$}]" -p "daemon.${level:-warning}" -- "${message}"
      }
   }
}

defaultPinCommand=""
defaultPinsFile="/etc/bluetooth/pins"
defaultAcceptableModes="0600"

showUsage=false
pinCommand="${defaultPinCommand}"
pinsFile="${defaultPinsFile}"
acceptableModes="${defaultAcceptableModes}"
promptUser=true
pinLimit=16

while getopts ":c:f:hm:n" option
do
   case "${option}"
   in
      c) pinCommand="${OPTARG}";;
      f) pinsFile="${OPTARG}";;
      h) showUsage=true;;
      m) acceptableModes="${OPTARG}";;
      n) promptUser=false;;
     \?) syntaxError "invalid option: -${OPTARG}";;
      :) syntaxError "missing operand: -${OPTARG}";;
      *) syntaxError "unimplemented option: -${option}";;
   esac
done
shift $((OPTIND - 1))

"${showUsage}" && {
   cat <<END_USAGE
Usage: ${programName} [-option ...] direction address [name]
Parameters:
   direction  The direction of the connection request (in|out).
   address    The Bluetooth device address (xx:xx:xx:xx:xx:xx).
   name       The name of the device (optional).
Options:
   -c command  The command to prompt for a PIN not in the PINs file.${defaultPinCommand:+ [${defaultPinCommand}]}
   -f file     The PINs file. [${defaultPinsFile}]
   -h          This command usage summary.
   -m modes    The modes (in octal) that the PINs file may have. [${defaultAcceptableModes}]
   -n          Do not prompt for the PIN.
END_USAGE
   exit 0
}

[ "${#}" -eq 0 ] && syntaxError "connection direction not supplied"
direction="${1}"
shift

[ "${#}" -eq 0 ] && syntaxError "device address not supplied"
address="${1}"
shift

if [ "${#}" -gt 0 ]
then
   name="${1}"
   shift
else
   name=""
fi

shopt -s extglob
[ -z "${acceptableModes##+([0-7])}" ] || syntaxError "invalid file permission modes: ${acceptableModes}"
[ "${acceptableModes#0}" = "${acceptableModes}" ] && acceptableModes="0${acceptableModes}"

[ -e "${pinsFile}" ] && {
   if [ ! -f "${pinsFile}" ]
   then
      programMessage "not a file: ${pinsFile}"
   elif [ ! -r "${pinsFile}" ]
   then
      programMessage "file not readable: ${pinsFile}"
   else
      safeModes=false
      if findCommand statPath stat
      then
         actualModes="$("${statPath}" -c '%a' -- "${pinsFile}")"
         [ "${actualModes#0}" = "${actualModes}" ] && actualModes="0${actualModes}"
         if ((actualModes & ~acceptableModes))
         then
            programMessage "unsafe file permission modes: ${pinsFile}: ${actualModes} > ${acceptableModes}"
         else
            safeModes=true
         fi
      else
         programMessage "file permission modes not verifiable: ${pinsFile}"
      fi

      "${safeModes}" && {
         exec 3<"${pinsFile}"
         while read -u 3 -r a p x
         do
            [ "${a}" = "${address}" ] && respondWithPin "${p}"
         done
         exec 3<&-
      }
   fi
}

[ -n "${pinCommand}" ] && {
   set -- ${pinCommand} "${direction}" "${address}"
   [ -n "${name}" ] && set -- "${@}" "${name}"
   response="$("${@}" | head -1)"
   pin="${response#PIN:}"
   [ "${pin}" != "${response}" ] && respondWithPin "${pin}"
}

"${promptUser}" && {
   if [ "${direction}" = "out" ]
   then
      adjective="outgoing"
      preposition="to"
   else
      [ "${direction}" = "in" ] || programMessage "unexpected connection direction: ${direction}"
      adjective="incoming"
      preposition="from"
   fi

   title="Bluetooth PIN Prompt"
   time="$(date '+%Y-%m-%d@%H:%M:%S')"
   prompt="Enter PIN for ${adjective} Bluetooth connection ${preposition} ${name}[${address}]"

   findCommand openPath open && findCommand dialogPath dialog && {
      pin="$("${openPath}" 3>&1 -s -w -- "${dialogPath}" --output-fd 3 --clear --title "${title}" --cr-wrap --max-input "${pinLimit}" --inputbox "${time}\n\n${prompt}" 0 0 "")"
      [ -n "${pin}" ] && respondWithPin "${pin}"
   }
}

echo "ERR"
exit 0

--mxv5cy4qt+RJ9ypb--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
